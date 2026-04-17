<%-- WEB-INF/views/member/announcements.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>OrganLink - Announcements</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css"/>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="../common/nav.jsp"/>
    <main class="main-content">
        <div class="page-header">
            <h1>Announcements</h1>
        </div>
        <div class="card">
            <table class="data-table" id="annTable">
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${announcements}" var="a">
                        <tr>
                            <td><c:out value="${a.title}"/></td>
                            <td class="td-truncate"><c:out value="${a.description}"/></td>
                            <td><fmt:formatDate value="${a.createdAt}" pattern="dd MMM yyyy"/></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty announcements}">
                        <tr><td colspan="3" class="text-center">No announcements.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </main>
</div>
    <jsp:include page="../common/sidePanel.jsp" />
</body>
</html>