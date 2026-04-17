<%-- WEB-INF/views/common/footer.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<footer class="site-footer">
    <div class="footer-banner-container">
        <img src="${pageContext.request.contextPath}/images/footer-banner.png" alt="Medical Community" class="footer-banner-img">
        <div class="footer-banner-overlay">
            <h2>Building a Stronger Healthcare Community</h2>
            <p>Every donation counts. Together, we can save more lives and provide hope to families across the nation.</p>
        </div>
    </div>
    
    <div class="footer-content">
        <div class="footer-grid">
            <div class="footer-section">
                <div class="footer-logo">
                    <span>&#10084;</span> OrganLink
                </div>
                <p>OrganLink is a secure, state-of-the-art platform dedicated to bridging the gap between donors, medical facilities, and recipients. We prioritize transparency, speed, and security.</p>
            </div>
            
            <div class="footer-section">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/admin/home">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/announcements">Public Notices</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/hospitals">Network Hospitals</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/organs">Organ Registry</a></li>
                </ul>
            </div>
            
            <div class="footer-section">
                <h3>Contact & Support</h3>
                <ul>
                    <li><strong>Emergency:</strong> 1-800-ORGAN-HELP</li>
                    <li><strong>Email:</strong> support@organlink.gov</li>
                    <li><strong>Office:</strong> Health Authority HQ, Block 4</li>
                    <li><strong>Hours:</strong> 24/7 Priority Support</li>
                </ul>
            </div>
            
            <div class="footer-section">
                <h3>Legal</h3>
                <ul>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Terms of Service</a></li>
                    <li><a href="#">Donation Ethics</a></li>
                    <li><a href="#">Compliance</a></li>
                </ul>
            </div>
        </div>
        
        <div class="footer-bottom">
            <p>&copy; 2026 OrganLink National Transplant Registry. All rights reserved. <span class="footer-tag">Official Health Portal</span></p>
        </div>
    </div>
</footer>