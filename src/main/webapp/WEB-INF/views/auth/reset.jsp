<%-- WEB-INF/views/auth/reset.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>OrganLink Nepal - Secure Password Reset</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <style>
        .token-box {
            background: #f8fafc;
            border: 2px dashed var(--primary);
            padding: 1.5rem;
            border-radius: var(--radius-md);
            text-align: center;
            margin: 1.5rem 0;
            position: relative;
        }
        .token-value {
            font-family: monospace;
            font-size: 1.25rem;
            font-weight: 800;
            color: var(--primary);
            letter-spacing: 2px;
        }
        .token-label {
            display: block;
            font-size: 0.75rem;
            font-weight: 700;
            color: var(--text-muted);
            text-transform: uppercase;
            margin-bottom: 0.5rem;
        }
    </style>
</head>
<body class="auth-body">
    <div class="auth-wrapper">
        <div class="auth-image">
            <div class="auth-image-content">
                <h1 class="outfit">Security is <br> a Priority.</h1>
                <p>We're here to help you regain access to your account securely. Follow the multi-factor verification steps to reset your credentials.</p>
            </div>
        </div>

        <div class="auth-form-side">
            <div class="auth-card" style="max-width: 500px;">
                <div class="site-logo" style="margin-bottom: 32px;">
                    <div class="icon" style="color: var(--primary);">
                        <i class="fa fa-heartbeat fa-2x"></i>
                    </div>
                    <span>OrganLink Nepal</span>
                </div>

                <c:choose>
                    <c:when test="${param.step == 'newpass'}">
                        <h2 class="outfit">Verification Successful</h2>
                        <p class="auth-welcome-text">Please copy the token below and use it to set your new password.</p>

                        <div class="token-box">
                            <span class="token-label">Your Reset Token</span>
                            <div class="token-value"><c:out value="${param.token}"/></div>
                            <small style="display: block; margin-top: 10px; color: var(--text-muted);">Copy this code for the next step</small>
                        </div>

                        <c:if test="${param.error == 'mismatch'}">
                            <div class="badge badge-danger" style="display: block; text-align: center; margin-bottom: 20px; padding: 10px;">Passwords or token do not match.</div>
                        </c:if>

                        <form method="post" action="${pageContext.request.contextPath}/reset">
                            
                            <div class="form-group">
                                <label>Paste Reset Token *</label>
                                <input type="text" name="token" class="form-control" required placeholder="Paste the token from above" autocomplete="off"/>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label>New Password *</label>
                                    <input type="password" name="newPassword" class="form-control" required placeholder="••••••••"/>
                                </div>
                                <div class="form-group">
                                    <label>Confirm Password *</label>
                                    <input type="password" name="confirmPassword" class="form-control" required placeholder="••••••••"/>
                                </div>
                            </div>
                            
                            <button type="submit" class="btn btn-primary btn-full" style="margin-top: 12px;">Reset My Password</button>
                        </form>
                    </c:when>

                    <c:otherwise>
                        <h2 class="outfit">Identity Verification</h2>
                        <p class="auth-welcome-text">Enter your credentials to verify your ownership of the account.</p>

                        <c:if test="${param.error == 'notFound'}">
                            <div class="badge badge-danger" style="display: block; text-align: center; margin-bottom: 20px; padding: 10px;">Account details not found. Please check your entries.</div>
                        </c:if>
                        <c:if test="${param.error == 'invalidToken'}">
                            <div class="badge badge-danger" style="display: block; text-align: center; margin-bottom: 20px; padding: 10px;">The reset token provided is invalid or has expired.</div>
                        </c:if>

                        <form method="post" action="${pageContext.request.contextPath}/reset">
                            
                            <div class="form-group">
                                <label>Username *</label>
                                <input type="text" name="username" class="form-control" required placeholder="Enter your registered username"/>
                            </div>

                            <div class="form-group">
                                <label>Phone Number *</label>
                                <input type="text" name="phone" class="form-control" maxlength="10" required placeholder="Registered 10-digit mobile"/>
                            </div>
                            
                            <button type="submit" class="btn btn-primary btn-full" style="margin-top: 12px;">Verify & Generate Token</button>
                        </form>
                    </c:otherwise>
                </c:choose>

                <div class="auth-links" style="margin-top: 32px; padding-top: 24px; border-top: 1px solid var(--border); text-align: center;">
                    <a href="${pageContext.request.contextPath}/login" style="font-weight: 600; color: var(--text-muted);">Back to Sign In</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>