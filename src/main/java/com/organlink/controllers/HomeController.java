// com/organlink/controllers/HomeController.java
package com.organlink.controllers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
@WebServlet("/home")
public class HomeController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("role") != null) {
            String role = (String) session.getAttribute("role");
            switch (role) {
                case "ADMIN": resp.sendRedirect(req.getContextPath() + "/admin/home"); return;
                case "HOSPITAL": resp.sendRedirect(req.getContextPath() + "/hospital/home"); return;
                case "MEMBER": resp.sendRedirect(req.getContextPath() + "/member/home"); return;
            }
        }
        resp.sendRedirect(req.getContextPath() + "/auth?action=showLogin");
    }
}