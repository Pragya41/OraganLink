// com/organlink/filter/AuthFilter.java
package com.organlink.filter;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
@WebFilter(urlPatterns = {"/admin/*", "/hospital/*", "/member/*"})
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;
        String path = req.getServletPath(); // e.g. /admin, /hospital, /member
        if (role == null) {
            resp.sendRedirect(req.getContextPath() + "/auth?action=showLogin");
            return;
        }
        boolean goingAdmin = path.startsWith("/admin");
        boolean goingHospital = path.startsWith("/hospital");
        boolean goingMember = path.startsWith("/member");
        boolean allowed = ("ADMIN".equals(role) && goingAdmin)
                       || ("HOSPITAL".equals(role) && goingHospital)
                       || ("MEMBER".equals(role) && goingMember);
        if (!allowed) {
            resp.sendRedirect(req.getContextPath() + "/error.jsp?code=403");
            return;
        }
        chain.doFilter(request, response);
    }
    @Override public void init(FilterConfig fc) {}
    @Override public void destroy() {}
}