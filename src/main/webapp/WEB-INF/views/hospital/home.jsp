<%-- WEB-INF/views/hospital/home.jsp --%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8" />
                <title>OrganLink - Hospital Medical Center</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css?v=2" />
            </head>

            <body>
                <div class="app-wrapper">
                    <jsp:include page="../common/nav.jsp" />
                    <main class="main-content">
                        <div class="page-header">
                            <div>
                                <h1>Hospital Dashboard</h1>
                                <p class="text-muted">Welcome, <strong><c:out value="${sessionScope.fullName}" /></strong>. Manage your facility's operations.</p>
                            </div>
                            <div class="header-actions">
                                <a href="${pageContext.request.contextPath}/hospital/addOrgan" class="btn btn-primary">+ Register Organ</a>
                                <a href="${pageContext.request.contextPath}/hospital/requests" class="btn btn-secondary">Pending Requests</a>
                            </div>
                        </div>

                        <!-- Statistics Section -->
                        <h2 class="section-title">Facility Statistics</h2>
                        <div class="stats-grid" style="grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));">
                            <div class="stat-card stat-blue">
                                <div class="stat-label">Total Registered</div>
                                <div class="stat-value"><c:out value="${stats.totalOrgans}" /></div>
                            </div>
                            <div class="stat-card stat-green">
                                <div class="stat-label">Currently Available</div>
                                <div class="stat-value"><c:out value="${stats.availableOrgans}" /></div>
                            </div>
                            <div class="stat-card stat-orange">
                                <div class="stat-label">Reserved</div>
                                <div class="stat-value"><c:out value="${stats.reservedOrgans}" /></div>
                            </div>
                            <div class="stat-card stat-primary">
                                <div class="stat-label">Total Transplants</div>
                                <div class="stat-value"><c:out value="${stats.transplantedOrgans}" /></div>
                            </div>
                        </div>
                        <div class="stats-grid" style="grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); margin-top: 16px;">
                            <div class="stat-card">
                                <div class="stat-label">Total Requests</div>
                                <div class="stat-value"><c:out value="${stats.totalRequests}" /></div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-label">Pending Review</div>
                                <div class="stat-value text-orange"><c:out value="${stats.pendingRequests}" /></div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-label">Approved</div>
                                <div class="stat-value text-green"><c:out value="${stats.approvedRequests}" /></div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-label">Completed</div>
                                <div class="stat-value text-blue"><c:out value="${stats.completedRequests}" /></div>
                            </div>
                        </div>

                        <div class="dashboard-layout" style="display: grid; grid-template-columns: 2fr 1fr; gap: 24px; margin-top: 32px;">
                            <div class="main-widgets">
                                <!-- Urgent Pending Requests -->
                                <section class="card mb-4">
                                    <div class="card-header">
                                        <h2>Urgent: Pending Requests</h2>
                                        <a href="${pageContext.request.contextPath}/hospital/requests" class="text-link">Review All</a>
                                    </div>
                                    <table class="data-table">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Organ</th>
                                                <th>Patient Name</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${pendingRequests}" var="r">
                                                <tr>
                                                    <td>#<c:out value="${r.id}"/></td>
                                                    <td><c:out value="${r.organType}"/></td>
                                                    <td><c:out value="${r.memberName}"/></td>
                                                    <td><a href="${pageContext.request.contextPath}/hospital/requests" class="btn btn-sm btn-primary">Review</a></td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty pendingRequests}">
                                                <tr><td colspan="4" class="text-center">No pending requests at this time.</td></tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </section>

                                <!-- Approved Requests Awaiting Completion -->
                                <section class="card mb-4">
                                    <div class="card-header">
                                        <h2>Approved: Awaiting Transplant</h2>
                                        <a href="${pageContext.request.contextPath}/hospital/approvedRequests" class="text-link">View All</a>
                                    </div>
                                    <table class="data-table">
                                        <thead>
                                            <tr>
                                                <th>Organ</th>
                                                <th>Patient</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${approvedRequests}" var="r">
                                                <tr>
                                                    <td><c:out value="${r.organType}"/></td>
                                                    <td><c:out value="${r.memberName}"/></td>
                                                    <td><span class="badge badge-orange">Reserved</span></td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty approvedRequests}">
                                                <tr><td colspan="3" class="text-center">No approved requests awaiting completion.</td></tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </section>
                            </div>

                            <div class="side-widgets">
                                <!-- Inventory Breakdown -->
                                <section class="card mb-4">
                                    <h2>Inventory Breakdown</h2>
                                    <div class="type-list">
                                        <c:forEach items="${organTypeBreakdown}" var="entry">
                                            <div style="display: flex; justify-content: space-between; padding: 8px 0; border-bottom: 1px solid #f1f5f9;">
                                                <span><c:out value="${entry.key}"/></span>
                                                <span class="badge badge-blue"><c:out value="${entry.value}"/></span>
                                            </div>
                                        </c:forEach>
                                        <c:if test="${empty organTypeBreakdown}">
                                            <p class="text-center text-muted">No available organs.</p>
                                        </c:if>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/hospital/organs" class="btn btn-sm btn-secondary btn-full" style="margin-top: 16px;">Manage Inventory</a>
                                </section>

                                <!-- Announcements Widget -->
                                <section class="card">
                                    <h2>Latest Announcements</h2>
                                    <ul class="announcement-list" style="list-style: none; padding: 0;">
                                        <c:forEach items="${recentAnnouncements}" var="a">
                                            <li style="padding: 12px 0; border-bottom: 1px solid #f1f5f9;">
                                                <div style="font-weight: 600; font-size: 0.95rem;"><c:out value="${a.title}"/></div>
                                                <small class="text-muted"><fmt:formatDate value="${a.createdAt}" pattern="dd MMM yyyy"/></small>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                    <a href="${pageContext.request.contextPath}/hospital/announcements" class="text-link" style="display: block; margin-top: 16px; text-align: center;">View All</a>
                                </section>
                            </div>
                        </div>
                    </main>
                    <jsp:include page="../common/footer.jsp" />
                </div>
                <jsp:include page="../common/sidePanel.jsp" />
            </body>

            </html>