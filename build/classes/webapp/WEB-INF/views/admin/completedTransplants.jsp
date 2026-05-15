<%-- WEB-INF/views/admin/completedTransplants.jsp --%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8" />
                <title>OrganLink - Completed Transplants</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css?v=2" />
            </head>

            <body>
                <div class="app-wrapper">
                    <jsp:include page="../common/nav.jsp" />
                    <main class="main-content">
                        <div class="page-header">
                            <h1>Completed Transplants</h1>
                        </div>
                        <div class="card">
                            <table class="data-table" id="completedTable">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Member</th>
                                        <th>Organ</th>
                                        <th>Blood Type</th>
                                        <th>Hospital</th>
                                        <th>Requested</th>
                                        <th>Completed</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${completed}" var="r">
                                        <tr>
                                            <td>
                                                <c:out value="${r.id}" />
                                            </td>
                                            <td>
                                                <c:out value="${r.memberName}" />
                                            </td>
                                            <td>
                                                <c:out value="${r.organType}" />
                                            </td>
                                            <td><span class="blood-badge">
                                                    <c:out value="${r.bloodType}" />
                                                </span></td>
                                            <td>
                                                <c:out value="${r.hospitalName}" />
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${r.requestedAt}" pattern="dd MMM yyyy" />
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${r.resolvedAt}" pattern="dd MMM yyyy" />
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty completed}">
                                        <tr>
                                            <td colspan="7" class="text-center">No completed transplants yet.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </main>
                <jsp:include page="../common/footer.jsp" />
            </div>
                <jsp:include page="../common/sidePanel.jsp" />
            </body>

            </html>