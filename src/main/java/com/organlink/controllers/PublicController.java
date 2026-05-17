// com/organlink/controllers/PublicController.java
package com.organlink.controllers;

import com.organlink.dao.ContactDao;
import com.organlink.model.ContactQuery;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet({"/about", "/contact"})
public class PublicController extends HttpServlet {

    private final ContactDao contactDao = new ContactDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        if ("/about".equals(path)) {
            req.getRequestDispatcher("/WEB-INF/views/public/about.jsp").forward(req, resp);
        } else if ("/contact".equals(path)) {
            req.getRequestDispatcher("/WEB-INF/views/public/contact.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/about");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        if ("/contact".equals(path)) {
            String fullName = req.getParameter("fullName");
            String phone = req.getParameter("phone");
            String queryText = req.getParameter("query");

            ContactQuery query = new ContactQuery(fullName, phone, queryText);
            boolean success = contactDao.insertQuery(query);

            if (success) {
                resp.sendRedirect(req.getContextPath() + "/contact?success=true");
            } else {
                resp.sendRedirect(req.getContextPath() + "/contact?error=db");
            }
        } else {
            resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }
}
