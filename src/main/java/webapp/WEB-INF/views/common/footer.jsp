<%-- WEB-INF/views/common/footer.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<footer class="site-footer">
    <div class="footer-banner-container">
        <img src="${pageContext.request.contextPath}/images/footer-banner.png" alt="Medical Community" class="footer-banner-img">
        <div class="footer-banner-overlay">
            <h2>Building a Stronger Healthcare Community in Nepal</h2>
            <p>Every donation counts. Together, we can save more lives and provide hope to families across the Himalayas.</p>
        </div>
    </div>
    
    <div class="footer-content">
        <div class="footer-grid">
            <div class="footer-section">
                <div class="footer-logo">
                    <span>&#10084;</span> OrganLink Nepal
                </div>
                <p>OrganLink is a secure platform dedicated to bridging the gap between donors, medical facilities, and recipients within the Federal Democratic Republic of Nepal.</p>
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
                    <li><strong>Emergency:</strong> +977-1-4262543 (HEOC)</li>
                    <li><strong>Email:</strong> info@organlink.gov.np</li>
                    <li><strong>Office:</strong> MoHP HQ, Ramshah Path, Kathmandu</li>
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
            <p>&copy; 2026 OrganLink National Transplant Registry of Nepal. All rights reserved. <span class="footer-tag">Official Health Portal</span></p>
        </div>
    </div>
</footer>