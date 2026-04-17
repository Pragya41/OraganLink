package com.organlink.controllers;

import com.organlink.dao.*;
import com.organlink.model.*;
import com.organlink.service.DashboardService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Map;

@WebServlet("/admin/*")
public class AdminController extends HttpServlet {

    private final UserDao userDao = new UserDao();
    private final HospitalDao hospDao = new HospitalDao();
    private final MemberDao memberDao = new MemberDao();
    private final OrganDao organDao = new OrganDao();
    private final DonationRequestDao reqDao = new DonationRequestDao();
    private final AnnouncementDao annDao = new AnnouncementDao();
    private final DashboardService dash = new DashboardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getPathInfo();
        if (path == null) path = "/home";

        try {
            switch (path) {

                case "/home":
                    Map<String, Integer> stats = dash.getAdminStats();
                    req.setAttribute("stats", stats);
                    req.setAttribute("recentAnnouncements", annDao.findRecent(5));
                    forward(req, resp, "home");
                    break;

                case "/hospitals":
                    req.setAttribute("hospitals", hospDao.findAll());
                    forward(req, resp, "hospitals");
                    break;

                case "/members":
                    req.setAttribute("members", memberDao.findAll());
                    forward(req, resp, "members");
                    break;

                case "/organs":
                    req.setAttribute("organs", organDao.findAll());
                    forward(req, resp, "organs");
                    break;

                case "/requests":
                    req.setAttribute("requests", reqDao.findAll());
                    forward(req, resp, "requests");
                    break;

                case "/announcements":
                    int userId = (int) req.getSession().getAttribute("userId");
                    req.setAttribute("announcements", annDao.findAll());
                    req.setAttribute("myAnnouncements", annDao.findByAuthor(userId));
                    forward(req, resp, "announcements");
                    break;

                case "/addAnnouncement":
                    String editId = req.getParameter("editId");

                    if (editId != null) {
                        req.setAttribute(
                                "announcement",
                                annDao.findById(Integer.parseInt(editId))
                        );
                    }

                    forward(req, resp, "addAnnouncement");
                    break;

                case "/completedTransplants":
                    req.setAttribute("completed", reqDao.findByStatus("COMPLETED"));
                    forward(req, resp, "completedTransplants");
                    break;

                default:
                    resp.sendRedirect(req.getContextPath() + "/admin/home");
            }

        } catch (RuntimeException e) {
            req.setAttribute("errorMsg", e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "";

        try {
            switch (action) {

                case "addAnnouncement": {
                    Announcement a = new Announcement();
                    a.setTitle(req.getParameter("title"));
                    a.setDescription(req.getParameter("description"));
                    a.setCreatedBy((int) req.getSession().getAttribute("userId"));

                    annDao.insertAnnouncement(a);

                    resp.sendRedirect(req.getContextPath()
                            + "/admin/announcements?msg=added");
                    break;
                }

                case "updateAnnouncement": {
                    Announcement a = new Announcement();
                    a.setId(Integer.parseInt(req.getParameter("id")));
                    a.setTitle(req.getParameter("title"));
                    a.setDescription(req.getParameter("description"));

                    annDao.updateAnnouncement(a);

                    resp.sendRedirect(req.getContextPath()
                            + "/admin/announcements?msg=updated");
                    break;
                }

                case "deleteAnnouncement": {
                    annDao.deleteAnnouncement(Integer.parseInt(req.getParameter("id")));

                    resp.sendRedirect(req.getContextPath()
                            + "/admin/announcements?msg=deleted");
                    break;
                }

                case "deleteHospital": {
                    userDao.deleteUser(Integer.parseInt(req.getParameter("id")));

                    resp.sendRedirect(req.getContextPath()
                            + "/admin/hospitals?msg=deleted");
                    break;
                }

                case "removeLastHospital": {
                    userDao.removeLastByRole("HOSPITAL");

                    resp.sendRedirect(req.getContextPath()
                            + "/admin/hospitals?msg=removedLast");
                    break;
                }

                case "deleteMember": {
                    userDao.deleteUser(Integer.parseInt(req.getParameter("id")));

                    resp.sendRedirect(req.getContextPath()
                            + "/admin/members?msg=deleted");
                    break;
                }

                case "removeLastMember": {
                    userDao.removeLastByRole("MEMBER");

                    resp.sendRedirect(req.getContextPath()
                            + "/admin/members?msg=removedLast");
                    break;
                }

                default:
                    resp.sendRedirect(req.getContextPath() + "/admin/home");
            }

        } catch (RuntimeException e) {
            req.setAttribute("errorMsg", e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

    private void forward(HttpServletRequest req, HttpServletResponse resp, String view)
            throws ServletException, IOException {

        req.getRequestDispatcher("/WEB-INF/views/admin/" + view + ".jsp")
                .forward(req, resp);
    }
}