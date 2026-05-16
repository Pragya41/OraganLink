<%-- WEB-INF/views/auth/login.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>OrganLink Nepal - Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
</head>
<body class="auth-body">
    <div class="auth-wrapper">
        <div class="auth-image">
            <div class="auth-image-content">
                <h1>Connecting Hope <br> in Nepal.</h1>
                <p>Join our community of donors and medical professionals across the country dedicated to saving lives through organ donation.</p>
            </div>
        </div>
        
        <div class="auth-form-side">
            <div class="auth-card">
                <div class="auth-logo">
                    <i class="fa fa-heartbeat"></i> OrganLink Nepal
                </div>
                
                <h2>Welcome Back</h2>
                <p class="auth-welcome-text">Please enter your details to access your account.</p>

                <c:if test="${param.error == 'invalid'}">
                    <div class="alert alert-danger">Invalid username or password, or account is locked.</div>
                </c:if>
                <c:if test="${param.msg == 'registered'}">
                    <div class="alert alert-success">Registration successful! Please log in.</div>
                </c:if>
                <c:if test="${param.msg == 'loggedOut'}">
                    <div class="alert alert-info">You have been logged out.</div>
                </c:if>
                <c:if test="${param.msg == 'passwordReset'}">
                    <div class="alert alert-success">Password reset successfully!</div>
                </c:if>

                <form method="post" action="${pageContext.request.contextPath}/login">
                    
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" required placeholder="Enter your username"/>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" required placeholder="Enter Password"/>
                    </div>
                    
                    <div class="form-group" style="display: flex; align-items: center; gap: 8px; margin-top: -8px;">
                        <input type="checkbox" id="remember" name="remember" style="width: auto;"/>
                        <label for="remember" style="margin-bottom: 0;">Remember me</label>
                    </div>
                    
                    <button type="submit" class="btn btn-primary btn-full">Sign In</button>
                </form>

                <div class="auth-links">
                    <a href="${pageContext.request.contextPath}/register">Create Account</a>
                    <a href="${pageContext.request.contextPath}/reset">Forgot Password?</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>