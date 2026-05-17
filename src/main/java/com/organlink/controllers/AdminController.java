package com.organlink.controllers;

import com.organlink.dao.*;
import com.organlink.model.*;
import com.organlink.service.DashboardService;
import com.organlink.service.AuthService;

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
    private final AuthService authService = new AuthService();
    private final ContactDao contactDao = new ContactDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getPathInfo();
        if (path == null) path = "/home";

        try {
            switch (path) {

                case "/":
                case "/home":
                    Map<String, Integer> stats = dash.getAdminStats();
                    req.setAttribute("stats", stats);
                    req.setAttribute("recentAnnouncements", annDao.findRecent(5));
                    
                    // Recent Activities
                    java.util.List<User> hospitals = userDao.findByRole("HOSPITAL");
                    req.setAttribute("recentHospitals", hospitals.size() > 5 ? hospitals.subList(0, 5) : hospitals);
                    
                    java.util.List<User> members = userDao.findByRole("MEMBER");
                    req.setAttribute("recentMembers", members.size() > 5 ? members.subList(0, 5) : members);
                    
                    java.util.List<com.organlink.model.DonationRequest> allReqs = reqDao.findAll();
                    req.setAttribute("recentRequests", allReqs.size() > 5 ? allReqs.subList(0, 5) : allReqs);
                    
                    java.util.List<com.organlink.model.DonationRequest> completed = new java.util.ArrayList<>();
                    for (com.organlink.model.DonationRequest r : allReqs) {
                        if ("COMPLETED".equals(r.getStatus())) completed.add(r);
                    }
                    req.setAttribute("recentCompleted", completed.size() > 5 ? completed.subList(0, 5) : completed);

                    // Breakdowns for Charts
                    java.util.List<com.organlink.model.Organ> allOrgans = organDao.findAll();
                    Map<String, Integer> typeBreakdown = new java.util.HashMap<>();
                    Map<String, Integer> bloodBreakdown = new java.util.HashMap<>();
                    for (com.organlink.model.Organ o : allOrgans) {
                        if ("AVAILABLE".equals(o.getStatus())) {
                            typeBreakdown.put(o.getOrganType(), typeBreakdown.getOrDefault(o.getOrganType(), 0) + 1);
                            bloodBreakdown.put(o.getBloodType(), bloodBreakdown.getOrDefault(o.getBloodType(), 0) + 1);
                        }
                    }
                    req.setAttribute("typeBreakdown", typeBreakdown);
                    req.setAttribute("bloodBreakdown", bloodBreakdown);

                    // Hospital Leaderboard (Completed Transplants)
                    Map<String, Integer> leaderboard = new java.util.HashMap<>();
                    for (com.organlink.model.DonationRequest r : allReqs) {
                        if ("COMPLETED".equals(r.getStatus()) && r.getHospitalName() != null) {
                            leaderboard.put(r.getHospitalName(), leaderboard.getOrDefault(r.getHospitalName(), 0) + 1);
                        }
                    }
                    req.setAttribute("hospitalLeaderboard", leaderboard);

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

                case "/queries":
                    req.setAttribute("queries", contactDao.findAll());
                    forward(req, resp, "queries");
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

                case "update": {
                    int id = Integer.parseInt(req.getParameter("id"));
                    String path = req.getPathInfo();
                    
                    if (path != null && path.contains("hospitals")) {
                        // Update Hospital & User
                        User u = userDao.findById(id);
                        if (u != null) {
                            u.setFullName(req.getParameter("hospital_name")); // Sync name
                            u.setEmail(req.getParameter("email"));
                            u.setPhone(req.getParameter("phone"));
                            userDao.updateUser(u);
                        }

                        Hospital h = new Hospital();
                        h.setUserId(id);
                        h.setHospitalName(req.getParameter("hospital_name"));
                        h.setLicenseNo(req.getParameter("license"));
                        h.setAddress(req.getParameter("address"));
                        hospDao.updateHospital(h);
                        
                        resp.sendRedirect(req.getContextPath() + "/admin/hospitals?msg=updated");
                    } 
                    else if (path != null && path.contains("members")) {
                        User u = userDao.findById(id);
                        if (u != null) {
                            u.setFullName(req.getParameter("full_name"));
                            u.setEmail(req.getParameter("email"));
                            u.setPhone(req.getParameter("phone"));
                            userDao.updateUser(u);
                        }
                        
                        resp.sendRedirect(req.getContextPath() + "/admin/members?msg=updated");
                    }
                    else if (path != null && path.contains("announcements")) {
                        Announcement a = new Announcement();
                        a.setId(id);
                        a.setTitle(req.getParameter("title"));
                        a.setDescription(req.getParameter("description"));
                        annDao.updateAnnouncement(a);
                        resp.sendRedirect(req.getContextPath() + "/admin/announcements?msg=updated");
                    }
                    else if (path != null && path.contains("requests")) {
                        // For requests, we primarily update status from the admin side
                        DonationRequest dr = reqDao.findById(id);
                        if (dr != null) {
                            String newStatus = req.getParameter("status");
                            if (newStatus != null) {
                                if ("APPROVED".equals(newStatus)) reqDao.approveRequest(id, dr.getHospitalId());
                                else if ("COMPLETED".equals(newStatus)) reqDao.completeRequest(id);
                                else if ("REJECTED".equals(newStatus)) reqDao.rejectRequest(id);
                            }
                        }
                        resp.sendRedirect(req.getContextPath() + "/admin/requests?msg=updated");
                    }
                    else {
                        resp.sendRedirect(req.getContextPath() + "/admin/home");
                    }
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

                case "lockUser": {
                    int id = Integer.parseInt(req.getParameter("id"));
                    userDao.setLockStatus(id, true);
                    String role = req.getParameter("role");
                    String redirect = "/admin/home";
                    if ("HOSPITAL".equals(role)) redirect = "/admin/hospitals";
                    else if ("MEMBER".equals(role)) redirect = "/admin/members";
                    resp.sendRedirect(req.getContextPath() + redirect + "?msg=locked");
                    break;
                }

                case "unlockUser": {
                    int id = Integer.parseInt(req.getParameter("id"));
                    userDao.setLockStatus(id, false);
                    authService.resetAttempts(id); // Clear automatic lockout
                    String role = req.getParameter("role");
                    String redirect = "/admin/home";
                    if ("HOSPITAL".equals(role)) redirect = "/admin/hospitals";
                    else if ("MEMBER".equals(role)) redirect = "/admin/members";
                    resp.sendRedirect(req.getContextPath() + redirect + "?msg=unlocked");
                    break;
                }

                case "deleteOrgan": {
                    organDao.deleteOrgan(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect(req.getContextPath() + "/admin/organs?msg=deleted");
                    break;
                }

                case "deleteQuery": {
                    contactDao.deleteQuery(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect(req.getContextPath() + "/admin/queries?msg=deleted");
                    break;
                }

                case "deleteRequest": {
                    reqDao.deleteRequest(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect(req.getContextPath() + "/admin/requests?msg=deleted");
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