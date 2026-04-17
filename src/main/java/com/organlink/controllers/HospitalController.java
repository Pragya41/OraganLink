package com.organlink.controllers;

import com.organlink.dao.*;
import com.organlink.service.DashboardService;
import com.organlink.service.DonationRequestService;
import com.organlink.service.OrganService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Map;

@WebServlet("/hospital/*")
public class HospitalController extends HttpServlet {

    private final OrganDao organDao = new OrganDao();
    private final DonationRequestDao reqDao = new DonationRequestDao();
    private final AnnouncementDao annDao = new AnnouncementDao();
    private final DashboardService dash = new DashboardService();
    private final OrganService organSvc = new OrganService();
    private final DonationRequestService reqSvc = new DonationRequestService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int userId = (int) req.getSession().getAttribute("userId");

        String path = req.getPathInfo();
        if (path == null) path = "/home";

        try {
            switch (path) {

                case "/home":
                    Map<String, Integer> stats = dash.getHospitalStats(userId);
                    req.setAttribute("stats", stats);
                    req.setAttribute("recentAnnouncements", annDao.findRecent(5));
                    forward(req, resp, "home");
                    break;

                case "/announcements":
                    req.setAttribute("announcements", annDao.findAll());
                    req.setAttribute("myAnnouncements", annDao.findByAuthor(userId));
                    forward(req, resp, "announcements");
                    break;

                case "/organs":
                    req.setAttribute("organs", organDao.findByHospital(userId));
                    forward(req, resp, "organs");
                    break;

                case "/addOrgan":
                    forward(req, resp, "addOrgan");
                    break;

                case "/addNotice":
                    forward(req, resp, "addNotice");
                    break;

                case "/requests":
                    req.setAttribute(
                            "requests",
                            reqDao.findByHospitalAndStatus(userId, "PENDING")
                    );
                    forward(req, resp, "requests");
                    break;

                case "/approvedRequests":
                    req.setAttribute(
                            "requests",
                            reqDao.findByHospitalAndStatus(userId, "APPROVED")
                    );
                    forward(req, resp, "approvedRequests");
                    break;

                case "/completed":
                    req.setAttribute(
                            "requests",
                            reqDao.findByHospitalAndStatus(userId, "COMPLETED")
                    );
                    forward(req, resp, "completed");
                    break;

                default:
                    resp.sendRedirect(req.getContextPath() + "/hospital/home");
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
        if (action == null) action = "";

        try {
            switch (action) {

                case "addOrgan": {
                    String organType = req.getParameter("organType");
                    String bloodType = req.getParameter("bloodType");

                    organSvc.addOrgan(userId, organType, bloodType);

                    resp.sendRedirect(req.getContextPath()
                            + "/hospital/organs?msg=added");
                    break;
                }

                case "deleteOrgan": {
                    int organId = Integer.parseInt(req.getParameter("organId"));

                    organSvc.deleteOrgan(organId, userId);

                    resp.sendRedirect(req.getContextPath()
                            + "/hospital/organs?msg=deleted");
                    break;
                }

                case "approveRequest": {
                    int requestId = Integer.parseInt(req.getParameter("requestId"));

                    reqSvc.approveRequest(requestId, userId);

                    resp.sendRedirect(req.getContextPath()
                            + "/hospital/requests?msg=approved");
                    break;
                }

                case "rejectRequest": {
                    int requestId = Integer.parseInt(req.getParameter("requestId"));

                    reqSvc.rejectRequest(requestId);

                    resp.sendRedirect(req.getContextPath()
                            + "/hospital/requests?msg=rejected");
                    break;
                }

                case "completeRequest": {
                    int requestId = Integer.parseInt(req.getParameter("requestId"));

                    reqSvc.completeRequest(requestId);

                    resp.sendRedirect(req.getContextPath()
                            + "/hospital/approvedRequests?msg=completed");
                    break;
                }

                case "addNotice": {
                    com.organlink.model.Announcement a = new com.organlink.model.Announcement();
                    a.setTitle(req.getParameter("title"));
                    a.setDescription(req.getParameter("description"));
                    a.setCreatedBy(userId);

                    annDao.insertAnnouncement(a);

                    resp.sendRedirect(req.getContextPath() + "/hospital/announcements?msg=added");
                    break;
                }

                case "updateNotice": {
                    int id = Integer.parseInt(req.getParameter("id"));
                    com.organlink.model.Announcement a = annDao.findById(id);
                    if (a != null && a.getCreatedBy() == userId) {
                        a.setTitle(req.getParameter("title"));
                        a.setDescription(req.getParameter("description"));
                        annDao.updateAnnouncement(a);
                    }
                    resp.sendRedirect(req.getContextPath() + "/hospital/announcements?msg=updated");
                    break;
                }

                case "deleteNotice": {
                    int id = Integer.parseInt(req.getParameter("id"));
                    com.organlink.model.Announcement a = annDao.findById(id);
                    if (a != null && a.getCreatedBy() == userId) {
                        annDao.deleteAnnouncement(id);
                    }
                    resp.sendRedirect(req.getContextPath() + "/hospital/announcements?msg=deleted");
                    break;
                }

                default:
                    resp.sendRedirect(req.getContextPath() + "/hospital/home");
            }

        } catch (RuntimeException e) {
            req.setAttribute("errorMsg", e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

    private void forward(HttpServletRequest req, HttpServletResponse resp, String view)
            throws ServletException, IOException {

        req.getRequestDispatcher("/WEB-INF/views/hospital/" + view + ".jsp")
                .forward(req, resp);
    }
}