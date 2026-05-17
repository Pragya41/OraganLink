<%-- WEB-INF/views/public/contact.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>OrganLink Nepal - Contact Us</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <style>
        .contact-wrapper {
            display: flex;
            min-height: 100vh;
        }
        .contact-info-side {
            flex: 1;
            background: linear-gradient(135deg, #0f172a 0%, #1e40af 100%);
            color: white;
            padding: 80px 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .contact-form-side {
            flex: 1;
            padding: 80px 60px;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .contact-card {
            width: 100%;
            max-width: 500px;
        }
        .info-item {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 30px;
            font-size: 1.1rem;
        }
        .info-icon {
            width: 40px;
            height: 40px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            color: #60a5fa;
        }
        @media (max-width: 900px) {
            .contact-wrapper { flex-direction: column; }
            .contact-info-side { padding: 40px 24px; }
            .contact-form-side { padding: 40px 24px; }
        }
    </style>
</head>
<body class="auth-body">
    <header class="site-header">
        <div class="site-header-inner" style="max-width: 1200px;">
            <a href="${pageContext.request.contextPath}/about" class="site-logo" style="color: white; text-decoration: none;">
                <i class="fa fa-heartbeat"></i> <span>OrganLink</span> Nepal
            </a>
            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/about" class="btn btn-secondary btn-sm" style="background: transparent; color: white; border-color: rgba(255,255,255,0.3);">Home</a>
                <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-sm">Sign In</a>
            </div>
        </div>
    </header>

    <div class="contact-wrapper">
        <div class="contact-info-side">
            <h1 style="font-size: 3rem; font-weight: 800; margin-bottom: 20px;">Get in Touch.</h1>
            <p style="font-size: 1.2rem; opacity: 0.9; margin-bottom: 50px; line-height: 1.6; max-width: 500px;">
                Have questions about the donation process, platform security, or hospital integration? Our support team is here to assist you.
            </p>

            <div class="info-item">
                <div class="info-icon"><i class="fa fa-map-marker"></i></div>
                <div>Kathmandu, Nepal</div>
            </div>
            <div class="info-item">
                <div class="info-icon"><i class="fa fa-envelope"></i></div>
                <div>support@organlink.org.np</div>
            </div>
            <div class="info-item">
                <div class="info-icon"><i class="fa fa-phone"></i></div>
                <div>+977 1-4000000</div>
            </div>
        </div>

        <div class="contact-form-side">
            <div class="contact-card">
                <h2 style="font-size: 2rem; font-weight: 800; margin-bottom: 10px; color: var(--text);">Send us a Message</h2>
                <p style="color: var(--text-muted); margin-bottom: 30px;">Fill out the form below and we'll get back to you shortly.</p>

                <div id="formAlert" class="alert alert-danger" style="display: none; margin-bottom: 24px;"></div>
                
                <c:if test="${param.success == 'true'}">
                    <div class="alert alert-success" style="margin-bottom: 24px; background: #e8f5e9; color: #2e7d32; border: 1px solid #c8e6c9;">
                        <strong>Thank you!</strong> Your message has been received.
                    </div>
                </c:if>
                <c:if test="${param.error == 'db'}">
                    <div class="alert alert-danger" style="margin-bottom: 24px;">
                        Sorry, there was an issue submitting your query. Please try again.
                    </div>
                </c:if>

                <form method="post" action="${pageContext.request.contextPath}/contact" id="contactForm">
                    <div class="form-group">
                        <label>Full Name *</label>
                        <input type="text" name="fullName" placeholder="Jane Doe" required/>
                    </div>
                    <div class="form-group">
                        <label>Phone Number *</label>
                        <input type="text" name="phone" placeholder="10-digit mobile number" required/>
                    </div>
                    <div class="form-group">
                        <label>Your Query *</label>
                        <textarea name="query" rows="5" placeholder="How can we help you?" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary btn-full" style="padding: 14px; font-size: 1.05rem;">Submit Message</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        const contactForm = document.getElementById('contactForm');
        contactForm.addEventListener('submit', function(e) {
            const fullName = document.getElementsByName('fullName')[0].value.trim();
            const phone = document.getElementsByName('phone')[0].value.trim();
            
            function showError(msg) {
                const alertDiv = document.getElementById('formAlert');
                if (alertDiv) {
                    alertDiv.style.display = 'block';
                    alertDiv.innerText = msg;
                }
            }

            // Name validation (no digits)
            if (/\d/.test(fullName)) {
                showError('Full Name must not contain digits.');
                e.preventDefault();
                return;
            }

            // Phone validation (exactly 10 digits)
            const phoneRegex = /^\d{10}$/;
            if (!phoneRegex.test(phone)) {
                showError('Phone number must be exactly 10 digits.');
                e.preventDefault();
                return;
            }
        });
    </script>
</body>
</html>
