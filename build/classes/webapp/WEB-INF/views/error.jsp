<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error - OrganLink Nepal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <style>
        .error-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            text-align: center;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: 'Outfit', sans-serif;
        }
        .error-card {
            background: rgba(255, 255, 255, 0.9);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
            max-width: 500px;
            width: 90%;
        }
        .error-code {
            font-size: 80px;
            font-weight: 800;
            background: linear-gradient(45deg, #2c3e50, #00d2ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin: 0;
        }
        .error-msg {
            font-size: 20px;
            color: #555;
            margin: 20px 0 30px;
        }
        .btn-home {
            background: #2c3e50;
            color: white;
            padding: 12px 30px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-block;
        }
        .btn-home:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            background: #1a252f;
        }
        .debug-info {
            margin-top: 20px;
            font-size: 11px;
            color: #888;
            text-align: left;
            border-top: 1px solid #eee;
            padding-top: 15px;
        }
    </style>
</head>
<body>
    <c:set var="status" value="${requestScope['jakarta.servlet.error.status_code']}" />
    <c:if test="${empty status}"><c:set var="status" value="${param.code}" /></c:if>
    <c:if test="${empty status}"><c:set var="status" value="500" /></c:if>

    <div class="error-container">
        <div class="error-card">
            <h1 class="error-code">${status}</h1>
            <p class="error-msg">
                <c:choose>
                    <c:when test="${status == 404}">
                        The page you are looking for does not exist.
                    </c:when>
                    <c:when test="${status == 403}">
                        You do not have permission to access this resource.
                    </c:when>
                    <c:otherwise>
                        An internal server error occurred. Please try again later.
                    </c:otherwise>
                </c:choose>
            </p>
            <a href="${pageContext.request.contextPath}/" class="btn-home">Return to Safety</a>
            
            <div class="debug-info">
                <strong>Reference:</strong> ${requestScope['jakarta.servlet.error.request_uri']}<br>
                <c:if test="${not empty requestScope['jakarta.servlet.error.message']}">
                    <strong>Note:</strong> ${requestScope['jakarta.servlet.error.message']}
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>