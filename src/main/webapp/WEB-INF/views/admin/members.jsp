<%-- WEB-INF/views/admin/members.jsp --%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8" />
            <title>OrganLink - Manage Members</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css?v=2" />
        </head>

        <body>
            <div class="app-wrapper">
                <jsp:include page="../common/nav.jsp" />
                <main class="main-content">
                    <div class="page-header">
                        <h1>Manage Members</h1>
                    </div>
                    <c:if test="${param.msg == 'deleted'}">
                        <div class="alert alert-success">Member
                            deleted.</div>
                    </c:if>

                    <div class="card">
                        <table class="data-table" id="memberTable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Full Name</th>
                                    <th>Username</th>
                                    <th>Blood Type</th>
                                    <th>Phone</th>
                                    <th>Address</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${members}" var="m">
                                    <tr>
                                        <td>
                                            <c:out value="${m.userId}" />
                                        </td>
                                        <td>
                                            <c:out value="${m.fullName}" />
                                        </td>
                                        <td>
                                            <c:out value="${m.username}" />
                                        </td>
                                        <td><span class="blood-badge">
                                                <c:out value="${m.bloodType}" />
                                            </span></td>
                                        <td>
                                            <c:out value="${m.phone}" />
                                        </td>
                                        <td>
                                            <c:out value="${m.address}" />
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty members}">
                                    <tr>
                                        <td colspan="6" class="text-center">No members registered.</td>
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