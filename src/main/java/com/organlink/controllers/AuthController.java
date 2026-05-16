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

@WebServlet({"/login", "/register", "/reset", "/logout", "/auth"})
public class AuthController extends HttpServlet {

    private final AuthService authService = new AuthService();
    private final UserService userService = new UserService();
    private final UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();
        
        // Handle root or /auth by redirecting to login
        if ("/auth".equals(path) || "/".equals(path) || "".equals(path)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        switch (path) {
            case "/login":
                // If already logged in, redirect to dashboard
                HttpSession session = req.getSession(false);
                if (session != null && session.getAttribute("role") != null) {
                    String role = (String) session.getAttribute("role");
                    String redirect = "/member/home";
                    if ("ADMIN".equals(role)) redirect = "/admin/home";
                    else if ("HOSPITAL".equals(role)) redirect = "/hospital/home";
                    resp.sendRedirect(req.getContextPath() + redirect);
                    return;
                }
                req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
                break;

            case "/register":
                req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
                break;

            case "/reset":
                req.getRequestDispatcher("/WEB-INF/views/auth/reset.jsp").forward(req, resp);
                break;

            case "/logout":
                HttpSession s = req.getSession(false);
                if (s != null) s.invalidate();

                // Delete 'remember me' cookie
                Cookie cookie = new Cookie("user_id", "");
                cookie.setMaxAge(0);
                cookie.setPath("/");
                resp.addCookie(cookie);

                resp.sendRedirect(req.getContextPath() + "/login?msg=loggedOut");
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        switch (path) {
            case "/login":
                handleLogin(req, resp);
                break;
            case "/register":
                handleRegister(req, resp);
                break;
            case "/reset":
                // Determine if it's the first step (forgot) or second step (reset)
                if (req.getParameter("token") != null) {
                    handleReset(req, resp);
                } else {
                    handleForgot(req, resp);
                }
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/login");
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String remember = req.getParameter("remember");

        User user = null;
        try {
            user = authService.login(username, password);
        } catch (RuntimeException e) {
            if ("LOCKED".equals(e.getMessage())) {
                resp.sendRedirect(req.getContextPath() + "/login?error=locked");
                return;
            }
        }

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login?error=invalid");
            return;
        }

        HttpSession session = req.getSession(true);
        session.setAttribute("userId", user.getId());
        session.setAttribute("role", user.getRole());
        session.setAttribute("fullName", user.getFullName());
        session.setAttribute("username", user.getUsername());

        if ("MEMBER".equals(user.getRole())) {
            com.organlink.dao.MemberDao memberDao = new com.organlink.dao.MemberDao();
            com.organlink.model.Member m = memberDao.findByUserId(user.getId());
            if (m != null) session.setAttribute("bloodType", m.getBloodType());
        }

        if ("on".equals(remember)) {
            Cookie cookie = new Cookie("user_id", String.valueOf(user.getId()));
            cookie.setMaxAge(86400);
            cookie.setPath("/");
            resp.addCookie(cookie);
        }

        String redirect = "/member/home";
        if ("ADMIN".equals(user.getRole())) redirect = "/admin/home";
        else if ("HOSPITAL".equals(user.getRole())) redirect = "/hospital/home";

        resp.sendRedirect(req.getContextPath() + redirect);
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp) throws IOException {
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

        String error = userService.register(username, password, fullName, email, phone, role, bloodType, address, hospName, licenseNo);

        if (error != null) {
            resp.sendRedirect(req.getContextPath() + "/register?error=" + error);
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/login?msg=registered");
    }

    private void handleForgot(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String username = req.getParameter("username");
        String phone = req.getParameter("phone");
        User user = userDao.findByUsernameAndPhone(username, phone);

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/reset?error=notFound");
            return;
        }

        String token = authService.generateResetToken(user.getId());
        resp.sendRedirect(req.getContextPath() + "/reset?step=newpass&token=" + token + "&msg=tokenGenerated");
    }

    private void handleReset(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String token = req.getParameter("token");
        String newPass = req.getParameter("newPassword");
        String confirm = req.getParameter("confirmPassword");

        if (newPass == null || !newPass.equals(confirm)) {
            resp.sendRedirect(req.getContextPath() + "/reset?step=newpass&token=" + token + "&error=mismatch");
            return;
        }

        boolean ok = authService.resetPassword(token, newPass);
        if (!ok) {
            resp.sendRedirect(req.getContextPath() + "/reset?error=invalidToken");
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/login?msg=passwordReset");
    }
}