// com/organlink/controllers/AuthController.java
package com.organlink.controllers;

import com.organlink.dao.UserDao;
import com.organlink.model.User;
import com.organlink.service.AuthService;
import com.organlink.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/auth")
public class AuthController extends HttpServlet {

    private final AuthService authService = new AuthService();
    private final UserService userService = new UserService();
    private final UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null)
            action = "showLogin";

        switch (action) {

            case "showLogin":
                req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp")
                        .forward(req, resp);
                break;

            case "showRegister":
                req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
                        .forward(req, resp);
                break;

            case "showReset":
                req.getRequestDispatcher("/WEB-INF/views/auth/reset.jsp")
                        .forward(req, resp);
                break;

            case "logout":
                HttpSession session = req.getSession(false);

                if (session != null)
                    session.invalidate();

                // Delete cookie
                Cookie cookie = new Cookie("user_id", "");
                cookie.setMaxAge(0);
                cookie.setPath("/");
                resp.addCookie(cookie);

                resp.sendRedirect(req.getContextPath()
                        + "/auth?action=showLogin&msg=loggedOut");
                break;

            default:
                req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp")
                        .forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null)
            action = "";

        switch (action) {

            case "login":
                handleLogin(req, resp);
                break;

            case "register":
                handleRegister(req, resp);
                break;

            case "forgot":
                handleForgot(req, resp);
                break;

            case "reset":
                handleReset(req, resp);
                break;

            default:
                resp.sendRedirect(req.getContextPath()
                        + "/auth?action=showLogin");
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String remember = req.getParameter("remember");

        User user = authService.login(username, password);

        if (user == null) {
            resp.sendRedirect(req.getContextPath()
                    + "/auth?action=showLogin&error=invalid");
            return;
        }

        HttpSession session = req.getSession(true);
        session.setAttribute("userId", user.getId());
        session.setAttribute("role", user.getRole());
        session.setAttribute("fullName", user.getFullName());
        session.setAttribute("username", user.getUsername());

        // If member, load blood type
        if ("MEMBER".equals(user.getRole())) {
            com.organlink.dao.MemberDao memberDao = new com.organlink.dao.MemberDao();
            com.organlink.model.Member m = memberDao.findByUserId(user.getId());

            if (m != null)
                session.setAttribute("bloodType", m.getBloodType());
        }

        // Remember me cookie (24h)
        if ("on".equals(remember)) {
            Cookie cookie = new Cookie("user_id", String.valueOf(user.getId()));
            cookie.setMaxAge(86400);
            cookie.setPath("/");
            resp.addCookie(cookie);
        }

        String redirect;

        switch (user.getRole()) {
            case "ADMIN":
                redirect = "/admin/home";
                break;

            case "HOSPITAL":
                redirect = "/hospital/home";
                break;

            default:
                redirect = "/member/home";
                break;
        }

        resp.sendRedirect(req.getContextPath() + redirect);
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String fullName = req.getParameter("fullName");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String role = req.getParameter("role");
        String bloodType = req.getParameter("bloodType");

        String address = req.getParameter("address");
        String hospName = req.getParameter("hospitalName");
        String licenseNo = req.getParameter("licenseNo");

        String error = userService.register(
                username, password, fullName, email, phone,
                role, bloodType,
                address, hospName, licenseNo);

        if (error != null) {
            resp.sendRedirect(req.getContextPath()
                    + "/auth?action=showRegister&error=" + error);
            return;
        }

        resp.sendRedirect(req.getContextPath()
                + "/auth?action=showLogin&msg=registered");
    }

    private void handleForgot(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String username = req.getParameter("username");
        String phone = req.getParameter("phone");
        User user = userDao.findByUsernameAndPhone(username, phone);

        if (user == null) {
            resp.sendRedirect(req.getContextPath()
                    + "/auth?action=showReset&error=notFound");
            return;
        }

        String token = authService.generateResetToken(user.getId());

        // For this demo, we redirect to show the token in a "box" as requested
        resp.sendRedirect(req.getContextPath()
                + "/auth?action=showReset&step=newpass&token=" + token
                + "&msg=tokenGenerated");
    }

    private void handleReset(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String token = req.getParameter("token");
        String newPass = req.getParameter("newPassword");
        String confirm = req.getParameter("confirmPassword");

        if (newPass == null || !newPass.equals(confirm)) {
            resp.sendRedirect(req.getContextPath()
                    + "/auth?action=showReset&step=newpass&token=" + token
                    + "&error=mismatch");
            return;
        }

        boolean ok = authService.resetPassword(token, newPass);

        if (!ok) {
            resp.sendRedirect(req.getContextPath()
                    + "/auth?action=showReset&error=invalidToken");
            return;
        }

        resp.sendRedirect(req.getContextPath()
                + "/auth?action=showLogin&msg=passwordReset");
    }
}