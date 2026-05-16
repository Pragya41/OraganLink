<%-- WEB-INF/views/admin/requests.jsp --%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8" />
                <title>OrganLink - All Donation Requests</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css?v=2" />
            </head>

            <body>
                <div class="app-wrapper">
                    <jsp:include page="../common/nav.jsp" />
                    <main class="main-content">
                        <div class="page-header">
                            <h1>All Donation Requests</h1>
                        </div>
                        <c:if test="${param.msg == 'deleted'}">
                            <div class="alert alert-success">Request removed successfully.</div>
                        </c:if>
                        <c:if test="${param.msg == 'updated'}">
                            <div class="alert alert-success">Request status updated successfully.</div>
                        </c:if>
                        <div class="card">
                            <table class="data-table" id="requestTable">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Member</th>
                                        <th>Organ</th>
                                        <th>Blood Type</th>
                                        <th>Hospital</th>
                                        <th>Status</th>
                                        <th>Requested</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requests}" var="r">
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
                                                <c:out value="${r.hospitalName != null ? r.hospitalName :
'Unassigned'}" />
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${r.status == 'PENDING'}"> <span class="badge
badge-yellow">PENDING</span></c:when>
                                                    <c:when test="${r.status == 'APPROVED'}"> <span class="badge
badge-green">APPROVED</span></c:when>
                                                    <c:when test="${r.status == 'COMPLETED'}"><span class="badge
badge-blue">COMPLETED</span></c:when>
                                                    <c:otherwise> <span class="badge
badge-red">REJECTED</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${r.requestedAt}" pattern="dd MMM yyyy" />
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty requests}">
                                        <tr>
                                            <td colspan="7" class="text-center">No requests found.</td>
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