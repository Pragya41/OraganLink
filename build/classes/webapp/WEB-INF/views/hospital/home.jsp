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
                        <h2 class="section-title">Facility Command Center</h2>
                        <div class="stats-grid">
                            <div class="stat-card stat-teal">
                                <div class="stat-icon-wrapper">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z"/></svg>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value"><c:out value="${stats.totalOrgans}" /></div>
                                    <div class="stat-label">Total Registered</div>
                                </div>
                            </div>
                            <div class="stat-card stat-green">
                                <div class="stat-icon-wrapper">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value"><c:out value="${stats.availableOrgans}" /></div>
                                    <div class="stat-label">Available Now</div>
                                </div>
                            </div>
                            <div class="stat-card stat-orange">
                                <div class="stat-icon-wrapper">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value"><c:out value="${stats.reservedOrgans}" /></div>
                                    <div class="stat-label">Reserved Units</div>
                                </div>
                            </div>
                            <div class="stat-card stat-purple">
                                <div class="stat-icon-wrapper">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value"><c:out value="${stats.transplantedOrgans}" /></div>
                                    <div class="stat-label">Transplanted</div>
                                </div>
                            </div>
                        </div>

                        <div class="stats-grid" style="margin-top: 1.5rem;">
                            <div class="stat-card stat-blue">
                                <div class="stat-icon-wrapper">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/><polyline points="10 9 9 9 8 9"/></svg>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value"><c:out value="${stats.totalRequests}" /></div>
                                    <div class="stat-label">Total Requests</div>
                                </div>
                            </div>
                            <div class="stat-card stat-orange">
                                <div class="stat-icon-wrapper">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value"><c:out value="${stats.pendingRequests}" /></div>
                                    <div class="stat-label">Pending Action</div>
                                </div>
                            </div>
                            <div class="stat-card stat-green">
                                <div class="stat-icon-wrapper">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value"><c:out value="${stats.approvedRequests}" /></div>
                                    <div class="stat-label">Approved</div>
                                </div>
                            </div>
                            <div class="stat-card stat-rose">
                                <div class="stat-icon-wrapper">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M9 11l3 3L22 4"/><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"/></svg>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value"><c:out value="${stats.completedRequests}" /></div>
                                    <div class="stat-label">Success Rate</div>
                                </div>
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