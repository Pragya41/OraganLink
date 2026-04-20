package com.organlink.controllers;

import com.organlink.dao.*;
import com.organlink.model.Member;
import com.organlink.model.Organ;
import com.organlink.service.DashboardService;
import com.organlink.service.DonationRequestService;
import com.organlink.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Map;

@WebServlet("/member/*")
public class MemberController extends HttpServlet {

    private final OrganDao organDao = new OrganDao();
    private final DonationRequestDao reqDao = new DonationRequestDao();
    private final AnnouncementDao annDao = new AnnouncementDao();
    private final MemberDao memberDao = new MemberDao();
    private final UserDao userDao = new UserDao();
    private final DashboardService dash = new DashboardService();
    private final DonationRequestService reqSvc = new DonationRequestService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int userId = (int) req.getSession().getAttribute("userId");

        String path = req.getPathInfo();
        if (path == null)
            path = "/home";

        try {
            switch (path) {

                case "/home": {
                    String bt = (String) req.getSession().getAttribute("bloodType");
                    Map<String, Integer> stats = dash.getMemberStats(userId, bt);
                    
                    req.setAttribute("stats", stats);
                    req.setAttribute("recentAnnouncements", annDao.findRecent(5));
                    req.setAttribute("member", memberDao.findByUserId(userId));
                    
                    // Recently compatible organs (limit 5)
                    java.util.List<Organ> allAvail = organDao.findAvailable();
                    java.util.List<Organ> recentComp = new java.util.ArrayList<>();
                    if (bt != null) {
                        for (Organ o : allAvail) {
                            if (ValidationUtil.isCompatible(o.getBloodType(), bt)) {
                                recentComp.add(o);
                                if (recentComp.size() >= 5) break;
                            }
                        }
                    }
                    req.setAttribute("recentCompatible", recentComp);
                    
                    // Active requests (limit 5)
                    java.util.List<com.organlink.model.DonationRequest> myReqs = reqDao.findByMember(userId);
                    java.util.List<com.organlink.model.DonationRequest> activeReqs = new java.util.ArrayList<>();
                    for (com.organlink.model.DonationRequest r : myReqs) {
                        if (!"REJECTED".equals(r.getStatus()) && !"COMPLETED".equals(r.getStatus())) {
                            activeReqs.add(r);
                            if (activeReqs.size() >= 5) break;
                        }
                    }
                    req.setAttribute("activeRequests", activeReqs);

                    forward(req, resp, "home");
                    break;
                }

                case "/announcements":
                    req.setAttribute("announcements", annDao.findAll());
                    forward(req, resp, "announcements");
                    break;

                case "/organs": {
                    String bt = (String) req.getSession().getAttribute("bloodType");
                    java.util.List<Organ> allAvailable = organDao.findAvailable();
                    java.util.List<Organ> compatible = new java.util.ArrayList<>();

                    if (bt != null) {
                        for (Organ o : allAvailable) {
                            if (ValidationUtil.isCompatible(o.getBloodType(), bt)) {
                                compatible.add(o);
                            }
                        }
                    }

                    req.setAttribute("organs", allAvailable);
                    req.setAttribute("compatibleOrgans", compatible);
                    forward(req, resp, "organs");
                    break;
                }

                case "/myRequests":
                    req.setAttribute("requests", reqDao.findByMember(userId));
                    forward(req, resp, "myRequests");
                    break;

                case "/profile":
                    req.setAttribute("member", memberDao.findByUserId(userId));
                    forward(req, resp, "profile");
                    break;

                default:
                    resp.sendRedirect(req.getContextPath() + "/member/home");
            }

        } catch (RuntimeException e) {
            req.setAttribute("errorMsg", e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int userId = (int) req.getSession().getAttribute("userId");

        String action = req.getParameter("action");
        if (action == null)
            action = "";

        try {
            switch (action) {

                case "submitRequest": {
                    int organId = Integer.parseInt(req.getParameter("organId"));

                    boolean ok = reqSvc.submitRequest(userId, organId);
                    String msg = ok ? "submitted" : "duplicate";

                    resp.sendRedirect(req.getContextPath()
                            + "/member/myRequests?msg=" + msg);
                    break;
                }

                case "updateProfile": {
                    Member m = memberDao.findByUserId(userId);

                    if (m == null)
                        m = new Member();

                    String fullName = req.getParameter("fullName");
                    String email = req.getParameter("email");
                    String phone = req.getParameter("phone");
                    String bloodType = req.getParameter("bloodType");
                    String address = req.getParameter("address");

                    // Update User table
                    userDao.updateProfileInfo(userId, fullName, email, phone);

                    // Update Member table
                    m.setUserId(userId);
                    m.setBloodType(bloodType);
                    m.setAddress(address);
                    memberDao.updateMember(m);

                    // Update session attributes
                    HttpSession session = req.getSession();
                    session.setAttribute("fullName", fullName);
                    session.setAttribute("bloodType", bloodType);

                    resp.sendRedirect(req.getContextPath()
                            + "/member/profile?msg=updated");
                    break;
                }

                default:
                    resp.sendRedirect(req.getContextPath() + "/member/home");
            }

        } catch (RuntimeException e) {
            req.setAttribute("errorMsg", e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

    private void forward(HttpServletRequest req, HttpServletResponse resp, String view)
            throws ServletException, IOException {

        req.getRequestDispatcher("/WEB-INF/views/member/" + view + ".jsp")
                .forward(req, resp);
    }
}