<%-- WEB-INF/views/auth/reset.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>OrganLink - Password Reset</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css"/>
</head>
<body class="auth-body">
    <div class="auth-wrapper">
        <div class="auth-image">
            <div class="auth-image-content">
                <h1>Security is <br> a Priority.</h1>
                <p>We're here to help you regain access to your account securely. Follow the steps to reset your credentials.</p>
            </div>
        </div>

        <div class="auth-form-side">
            <div class="auth-card">
                <div class="auth-logo">
                    <span>&#10084;</span> OrganLink
                </div>

                <c:choose>
                    <c:when test="${param.step == 'newpass'}">
                        <h2>Set New Password</h2>
                        <p class="auth-welcome-text">Create a strong, new password for your account.</p>

                        <c:if test="${param.error == 'mismatch'}">
                            <div class="alert alert-danger">Passwords do not match.</div>
                        </c:if>
                        <c:if test="${param.msg == 'tokenGenerated'}">
                            <div class="alert alert-info">Verification token accepted. Set your new password.</div>
                        </c:if>

                        <form method="post" action="${pageContext.request.contextPath}/auth">
                            <input type="hidden" name="action" value="reset"/>
                            <input type="hidden" name="token" value="${param.token}"/>
                            
                            <div class="form-group">
                                <label>New Password</label>
                                <input type="password" name="newPassword" required placeholder="••••••••"/>
                            </div>
                            
                            <div class="form-group">
                                <label>Confirm New Password</label>
                                <input type="password" name="confirmPassword" required placeholder="••••••••"/>
                            </div>
                            
                            <button type="submit" class="btn btn-primary btn-full">Reset My Password</button>
                        </form>
                    </c:when>

                    <c:otherwise>
                        <h2>Forgot Password?</h2>
                        <p class="auth-welcome-text">Enter your username and we'll help your reset things.</p>

                        <c:if test="${param.error == 'notFound'}">
                            <div class="alert alert-danger">System could not find that username.</div>
                        </c:if>
                        <c:if test="${param.error == 'invalidToken'}">
                            <div class="alert alert-danger">The reset token provided is invalid or has expired.</div>
                        </c:if>

                        <form method="post" action="${pageContext.request.contextPath}/auth">
                            <input type="hidden" name="action" value="forgot"/>
                            
                            <div class="form-group">
                                <label>Username</label>
                                <input type="text" name="username" required placeholder="Enter your registered username"/>
                            </div>
                            
                            <button type="submit" class="btn btn-primary btn-full">Generate Reset Token</button>
                        </form>
                    </c:otherwise>
                </c:choose>

                <div class="auth-links">
                    <a href="${pageContext.request.contextPath}/auth?action=showLogin">Back to Sign In</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>