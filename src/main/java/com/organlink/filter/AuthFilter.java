// com/organlink/filter/AuthFilter.java
package com.organlink.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*", "/hospital/*", "/member/*"})
public class AuthFilter implements Filter {

    private final com.organlink.dao.UserDao userDao = new com.organlink.dao.UserDao();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        // Prevent browser caching of protected pages to disable 'back' button access after logout
        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        resp.setHeader("Pragma", "no-cache");
        resp.setDateHeader("Expires", 0);

        HttpSession session = req.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;
        String path = req.getServletPath();

        if (role == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Check if user was locked by admin while logged in
        int userId = (int) session.getAttribute("userId");
        com.organlink.model.User user = userDao.findById(userId);
        
        if (user != null) {
            if (user.isLocked()) {
                session.invalidate();
                resp.sendRedirect(req.getContextPath() + "/login?error=locked");
                return;
            }
            // Refresh session info in case admin changed it (e.g. name update)
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("role", user.getRole());
        }

        boolean goingAdmin = path.startsWith("/admin");
        boolean goingHospital = path.startsWith("/hospital");
        boolean goingMember = path.startsWith("/member");

        boolean allowed = ("ADMIN".equals(role) && goingAdmin)
                       || ("HOSPITAL".equals(role) && goingHospital)
                       || ("MEMBER".equals(role) && goingMember);

        if (!allowed) {
            // If they don't have permission, show 403 error page via web.xml mapping
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig fc) throws ServletException {}

    @Override
    public void destroy() {}
}