<%-- WEB-INF/views/admin/hospitals.jsp --%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8" />
            <title>OrganLink - Manage Hospitals</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css?v=2" />
        </head>

        <body>
            <div class="app-wrapper">
                <jsp:include page="../common/nav.jsp" />
                <main class="main-content">
                    <div class="page-header">
                        <h1>Manage Hospitals</h1>
                    </div>
                    <c:if test="${param.msg == 'deleted'}">
                        <div class="alert alert-success">Hospital
                            deleted.</div>
                    </c:if>

                    <div class="card">
                        <table class="data-table" id="hospitalTable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Hospital Name</th>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>License</th>
                                    <th>Address</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${hospitals}" var="h">
                                    <tr>
                                        <td>
                                            <c:out value="${h.userId}" />
                                        </td>
                                        <td>
                                            <c:out value="${h.hospitalName}" />
                                        </td>
                                        <td>
                                            <c:out value="${h.username}" />
                                        </td>
                                        <td>
                                            <c:out value="${h.email}" />
                                        </td>
                                        <td>
                                            <c:out value="${h.phone}" />
                                        </td>
                                        <td>
                                            <c:out value="${h.licenseNo}" />
                                        </td>
                                        <td>
                                            <c:out value="${h.address}" />
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty hospitals}">
                                    <tr>
                                        <td colspan="7" class="text-center">No hospitals registered.</td>
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