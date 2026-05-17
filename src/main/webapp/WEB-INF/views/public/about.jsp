<%-- WEB-INF/views/public/about.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>OrganLink Nepal - About Us</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <style>
        .hero-section {
            background-image: linear-gradient(135deg, rgba(15, 23, 42, 0.9), rgba(30, 64, 175, 0.7)), url("${pageContext.request.contextPath}/images/auth-bg.png");
            background-size: cover;
            background-position: center;
            color: white;
            padding: 80px 24px;
            text-align: center;
        }
        .hero-title {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 20px;
            animation: fadeInDown 0.8s ease;
        }
        .hero-subtitle {
            font-size: 1.25rem;
            max-width: 800px;
            margin: 0 auto 40px;
            opacity: 0.9;
            line-height: 1.6;
        }
        .cta-buttons {
            display: flex;
            gap: 16px;
            justify-content: center;
            flex-wrap: wrap;
        }
        .content-section {
            max-width: 1000px;
            margin: 60px auto;
            padding: 0 24px;
        }
        .goal-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }
        .goal-card {
            background: white;
            padding: 30px;
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-md);
            text-align: center;
            border-top: 4px solid var(--primary);
            transition: transform 0.3s;
        }
        .goal-card:hover {
            transform: translateY(-5px);
        }
        .goal-icon {
            font-size: 2.5rem;
            color: var(--primary);
            margin-bottom: 20px;
        }
        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <header class="site-header">
        <div class="site-header-inner" style="max-width: 1200px;">
            <div class="site-logo">
                <i class="fa fa-heartbeat"></i> <span>OrganLink</span> Nepal
            </div>
            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary btn-sm" style="background: transparent; color: white; border-color: rgba(255,255,255,0.3);">Login</a>
                <a href="${pageContext.request.contextPath}/register" class="btn btn-primary btn-sm">Sign Up</a>
            </div>
        </div>
    </header>

    <div class="hero-section">
        <h1 class="hero-title">Connecting Lives, Inspiring Hope.</h1>
        <p class="hero-subtitle">
            OrganLink Nepal is a centralized, secure platform dedicated to revolutionizing the organ donation and transplant process across Nepal. Our mission is to bridge the critical gap between generosity and need by providing a streamlined, transparent, and highly secure digital infrastructure. We empower individuals to leave a lasting legacy while equipping medical professionals with the real-time data they need to save lives efficiently.
        </p>
        <div class="cta-buttons">
            <a href="${pageContext.request.contextPath}/register" class="btn btn-primary" style="font-size: 1.1rem; padding: 12px 24px;">Join Our Mission</a>
            <a href="${pageContext.request.contextPath}/contact" class="btn btn-secondary" style="font-size: 1.1rem; padding: 12px 24px; background: rgba(255,255,255,0.1); color: white; border: 1px solid rgba(255,255,255,0.3);">Contact Us</a>
        </div>
    </div>

    <div class="content-section">
        <div style="text-align: center; margin-bottom: 40px;">
            <h2 style="font-size: 2.25rem; color: var(--text); font-weight: 800;">Our Core Goals & Vision</h2>
            <p style="color: var(--text-muted); font-size: 1.1rem; max-width: 700px; margin: 10px auto;">We believe in a healthcare system where every organ donation is handled with the utmost respect, transparency, and urgency. Here is the foundation of what drives our platform forward.</p>
        </div>

        <div class="goal-grid">
            <div class="goal-card">
                <i class="fa fa-shield goal-icon"></i>
                <h3 style="margin-bottom: 15px;">Uncompromising Security</h3>
                <p style="color: var(--text-muted);">Trust is the cornerstone of organ donation. We employ advanced security protocols, role-based access control, and stringent data encryption to ensure that all patient medical records and donor identities remain strictly confidential and protected against any unauthorized access at all times.</p>
            </div>
            <div class="goal-card">
                <i class="fa fa-hospital-o goal-icon"></i>
                <h3 style="margin-bottom: 15px;">Seamless Hospital Integration</h3>
                <p style="color: var(--text-muted);">Time is the most critical factor in organ transplantation. By providing certified medical facilities and health authorities with a unified, real-time administrative dashboard, we eliminate bureaucratic communication delays, reduce manual paperwork, and radically streamline the entire cross-hospital coordination workflow.</p>
            </div>
            <div class="goal-card">
                <i class="fa fa-handshake-o goal-icon"></i>
                <h3 style="margin-bottom: 15px;">Empowering Everyday Heroes</h3>
                <p style="color: var(--text-muted);">We make it incredibly simple for heroic individuals to register and pledge their organs. By giving donors a transparent platform to officially record their intentions, we put them in full control of their legacy, seamlessly connecting their generosity directly with the certified facilities that facilitate life-saving procedures.</p>
            </div>
        </div>
    </div>

    <footer class="site-footer" style="margin-top: auto; padding: 40px 0; background: #0f172a; text-align: center; color: #94a3b8;">
        <div class="site-logo" style="justify-content: center; margin-bottom: 15px; color: white;">
            <i class="fa fa-heartbeat"></i> <span style="color: var(--primary);">OrganLink</span> Nepal
        </div>
        <p>&copy; 2026 OrganLink Nepal. All rights reserved.</p>
    </footer>
</body>
</html>
