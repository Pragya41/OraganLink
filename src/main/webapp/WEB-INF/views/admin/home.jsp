<%-- WEB-INF/views/admin/home.jsp --%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8" />
                <title>OrganLink - Admin Command Center</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css?v=2" />
            </head>

            <body>
                <div class="app-wrapper">
                    <jsp:include page="../common/nav.jsp" />
                    <main class="main-content">
                        <div class="page-header">
                            <div>
                                <h1>Admin Command Center</h1>
                                <p class="text-muted">Welcome back, <strong>
                                        <c:out value="${sessionScope.fullName}" />
                                    </strong>. System overview is ready.</p>
                            </div>
                            <div class="header-actions">
                                <a href="${pageContext.request.contextPath}/admin/addAnnouncement"
                                    class="btn btn-primary">
                                    <span>+</span> New Announcement
                                </a>
                            </div>
                        </div>

                        <div class="stats-grid">
                            <div class="stat-card stat-primary">
                                <div class="stat-label">Total Hospitals</div>
                                <div class="stat-value">
                                    <c:out value="${stats.totalHospitals}" />
                                </div>
                                <a href="${pageContext.request.contextPath}/admin/hospitals"
                                    class="btn btn-sm btn-secondary">Manage Registry</a>
                            </div>
                            <div class="stat-card stat-blue">
                                <div class="stat-label">System Members</div>
                                <div class="stat-value">
                                    <c:out value="${stats.totalMembers}" />
                                </div>
                                <a href="${pageContext.request.contextPath}/admin/members"
                                    class="btn btn-sm btn-secondary">User Database</a>
                            </div>
                            <div class="stat-card stat-green">
                                <div class="stat-label">Organs Available</div>
                                <div class="stat-value">
                                    <c:out value="${stats.organsAvailable}" />
                                </div>
                                <a href="${pageContext.request.contextPath}/admin/organs"
                                    class="btn btn-sm btn-secondary">Inventory</a>
                            </div>
                            <div class="stat-card stat-orange">
                                <div class="stat-label">Pending Requests</div>
                                <div class="stat-value">
                                    <c:out value="${stats.requestsPending}" />
                                </div>
                                <a href="${pageContext.request.contextPath}/admin/requests"
                                    class="btn btn-sm btn-secondary">Action Required</a>
                            </div>
                        </div>

                        <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 24px;">
                            <section class="card">
                                <h2>Recent Announcements</h2>
                                <table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>Topic</th>
                                            <th>Author</th>
                                            <th>Post Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${recentAnnouncements}" var="a">
                                            <tr>
                                                <td><strong>
                                                        <c:out value="${a.title}" />
                                                    </strong></td>
                                                <td>
                                                    <c:out value="${a.createdByName}" />
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${a.createdAt}" pattern="dd MMM yyyy" />
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty recentAnnouncements}">
                                            <tr>
                                                <td colspan="3" class="text-center">No recent bulletins posted.</td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </section>

                            <section class="card">
                                <h2>Quick Launch</h2>
                                <div style="display: flex; flex-direction: column; gap: 12px;">
                                    <a href="${pageContext.request.contextPath}/admin/completedTransplants"
                                        class="btn btn-success btn-full">
                                        &#127881; Transplant Records
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/hospitals"
                                        class="btn btn-secondary btn-full">
                                        &#127973; Hospitality Registry
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/members"
                                        class="btn btn-secondary btn-full">
                                        &#128100; Manage Users
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/organs"
                                        class="btn btn-secondary btn-full">
                                        &#129505; Organ Inventory
                                    </a>
                                </div>
                        </div>
                </div>
                    </main>
                    <jsp:include page="../common/footer.jsp" />
                </div>
                <jsp:include page="../common/sidePanel.jsp" />
            </body>

            </html>