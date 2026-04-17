<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Error - OrganLink</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
            <style>
                .error-container {
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    justify-content: center;
                    height: 100vh;
                    text-align: center;
                }

                .error-code {
                    font-size: 120px;
                    font-weight: bold;
                    color: var(--primary-color);
                    margin: 0;
                }

                .error-msg {
                    font-size: 24px;
                    color: var(--text-muted);
                    margin-bottom: 30px;
                }
            </style>
        </head>

        <body>
            <div class="error-container">
                <h1 class="error-code">${param.code != null ? param.code : "500"}</h1>
                <p class="error-msg">
                    <c:choose>
                        <c:when test="${param.code == '403'}">Access Denied: You don't have permission to view this
                            page.</c:when>
                        <c:when test="${param.code == '404'}">Page Not Found: The requested resource doesn't exist.
                        </c:when>
                        <c:otherwise>${errorMsg != null ? errorMsg : "Oops! Something went wrong on our end."}
                        </c:otherwise>
                    </c:choose>
                </p>
                <a href="${pageContext.request.contextPath}/auth?action=showLogin" class="btn btn-primary">Go to
                    Login</a>
            </div>
        </body>

        </html>