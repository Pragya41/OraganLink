package com.organlink.controllers;

import com.organlink.dao.*;
import com.organlink.model.Member;
import com.organlink.service.DashboardService;
import com.organlink.service.DonationRequestService;

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

                case "/home":
                    Map<String, Integer> stats = dash.getMemberStats(userId);
                    req.setAttribute("stats", stats);
                    req.setAttribute("recentAnnouncements", annDao.findRecent(5));
                    forward(req, resp, "home");
                    break;

                case "/announcements":
                    req.setAttribute("announcements", annDao.findAll());
                    forward(req, resp, "announcements");
                    break;

                case "/organs":
                    req.setAttribute("organs", organDao.findAvailable());
                    forward(req, resp, "organs");
                    break;

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

                    m.setUserId(userId);
                    m.setBloodType(req.getParameter("bloodType"));
                    m.setAddress(req.getParameter("address"));

                    memberDao.updateMember(m);

                    // Update session blood type
                    req.getSession().setAttribute("bloodType", m.getBloodType());

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