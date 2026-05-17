<%-- WEB-INF/views/admin/queries.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>OrganLink - Contact Queries</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
</head>
<body>
    <div class="app-wrapper">
        <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
        
        <main class="main-content">
            <div class="page-header">
                <h1>Contact Queries</h1>
            </div>

            <c:if test="${param.msg == 'deleted'}">
                <div class="alert alert-success">Query successfully deleted.</div>
            </c:if>

            <div class="card">
                <h2>User Submissions</h2>
                <div style="overflow-x: auto;">
                    <table class="data-table" id="queryTable">
                        <thead>
                            <tr>
                                <th style="display: none;">ID</th>
                                <th>Name</th>
                                <th>Phone</th>
                                <th>Query</th>
                                <th>Submitted On</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="q" items="${queries}">
                                <tr>
                                    <td style="display: none;">${q.id}</td>
                                    <td style="font-weight: 600;">${q.fullName}</td>
                                    <td>${q.phone}</td>
                                    <td class="td-truncate">${q.query}</td>
                                    <td><fmt:formatDate value="${q.submittedAt}" pattern="MMM dd, yyyy HH:mm" /></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty queries}">
                                <tr>
                                    <td colspan="4" class="text-center" style="padding: 2rem;">No queries found.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
        <jsp:include page="../common/footer.jsp" />
    </div>

    <jsp:include page="/WEB-INF/views/common/sidePanel.jsp"/>
</body>
</html>
