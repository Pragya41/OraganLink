<%-- WEB-INF/views/admin/home.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>OrganLink - Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css?v=2" />
</head>
<body>
    <div class="app-wrapper">
        <jsp:include page="../common/nav.jsp" />
        <main class="main-content">
            <div class="page-header">
                <div>
                    <h1>Authority Dashboard</h1>
                    <p class="text-muted">System-wide monitoring and oversight.</p>
                </div>
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/admin/addAnnouncement" class="btn btn-primary">Post Announcement</a>
                    <a href="${pageContext.request.contextPath}/admin/requests" class="btn btn-secondary">Review Requests</a>
                </div>
            </div>

            <!-- Statistics Section -->
            <h2 class="section-title">System Oversight</h2>
            <div class="stats-grid">
                <div class="stat-card stat-blue">
                    <div class="stat-icon-wrapper">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"/><line x1="9" y1="3" x2="9" y2="21"/></svg>
                    </div>
                    <div class="stat-content">
                        <div class="stat-value"><c:out value="${stats.totalHospitals}" /></div>
                        <div class="stat-label">Hospitals</div>
                    </div>
                </div>
                <div class="stat-card stat-purple">
                    <div class="stat-icon-wrapper">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                    </div>
                    <div class="stat-content">
                        <div class="stat-value"><c:out value="${stats.totalMembers}" /></div>
                        <div class="stat-label">Total Members</div>
                    </div>
                </div>
                <div class="stat-card stat-teal">
                    <div class="stat-icon-wrapper">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z"/></svg>
                    </div>
                    <div class="stat-content">
                        <div class="stat-value"><c:out value="${stats.organsAvailable}" /></div>
                        <div class="stat-label">Live Inventory</div>
                    </div>
                </div>
                <div class="stat-card stat-orange">
                    <div class="stat-icon-wrapper">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
                    </div>
                    <div class="stat-content">
                        <div class="stat-value"><c:out value="${stats.organsReserved}" /></div>
                        <div class="stat-label">Reserved</div>
                    </div>
                </div>
            </div>
            
            <div class="stats-grid" style="margin-top: 1.5rem;">
                <div class="stat-card stat-orange">
                    <div class="stat-icon-wrapper">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                    </div>
                    <div class="stat-content">
                        <div class="stat-value"><c:out value="${stats.requestsPending}" /></div>
                        <div class="stat-label">Pending</div>
                    </div>
                </div>
                <div class="stat-card stat-green">
                    <div class="stat-icon-wrapper">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                    </div>
                    <div class="stat-content">
                        <div class="stat-value"><c:out value="${stats.requestsApproved}" /></div>
                        <div class="stat-label">Approved</div>
                    </div>
                </div>
                <div class="stat-card stat-blue">
                    <div class="stat-icon-wrapper">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M9 11l3 3L22 4"/><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"/></svg>
                    </div>
                    <div class="stat-content">
                        <div class="stat-value"><c:out value="${stats.requestsCompleted}" /></div>
                        <div class="stat-label">Completed</div>
                    </div>
                </div>
                <div class="stat-card stat-rose">
                    <div class="stat-icon-wrapper">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>
                    </div>
                    <div class="stat-content">
                        <div class="stat-value"><c:out value="${stats.requestsRejected}" /></div>
                        <div class="stat-label">Rejected</div>
                    </div>
                </div>
            </div>

            <!-- Charts Section -->
            <div class="chart-row" style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px; margin-top: 32px;">
                <div class="card">
                    <h2>Request Status Breakdown</h2>
                    <div style="height: 250px; position: relative;">
                        <canvas id="requestChart"></canvas>
                    </div>
                </div>
                <div class="card">
                    <h2>Available Organs by Type</h2>
                    <div style="height: 250px; position: relative;">
                        <canvas id="organChart"></canvas>
                    </div>
                </div>
            </div>

            <div class="dashboard-layout" style="display: grid; grid-template-columns: 2fr 1fr; gap: 24px; margin-top: 32px;">
                <div class="main-widgets">
                    <!-- Recent Requests -->
                    <section class="card mb-4">
                        <div class="card-header">
                            <h2>Recent Donation Requests</h2>
                            <a href="${pageContext.request.contextPath}/admin/requests" class="text-link">View All</a>
                        </div>
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Patient</th>
                                    <th>Organ</th>
                                    <th>Hospital</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${recentRequests}" var="r">
                                    <tr>
                                        <td><c:out value="${r.memberName}"/></td>
                                        <td><c:out value="${r.organType}"/></td>
                                        <td><c:out value="${r.hospitalName}"/></td>
                                        <td>
                                            <span class="badge ${r.status == 'COMPLETED' ? 'badge-blue' : (r.status == 'PENDING' ? 'badge-orange' : 'badge-green')}">
                                                <c:out value="${r.status}"/>
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty recentRequests}">
                                    <tr><td colspan="4" class="text-center">No recent requests.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </section>

                    <!-- Hospital Leaderboard -->
                    <section class="card mb-4">
                        <h2>Top Performing Hospitals (Transplants)</h2>
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Hospital Name</th>
                                    <th>Completed Transplants</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${hospitalLeaderboard}" var="entry">
                                    <tr>
                                        <td><c:out value="${entry.key}"/></td>
                                        <td><strong><c:out value="${entry.value}"/></strong></td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty hospitalLeaderboard}">
                                    <tr><td colspan="2" class="text-center">No transplant data recorded yet.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </section>
                </div>

                <div class="side-widgets">
                    <!-- Recently Registered -->
                    <section class="card mb-4">
                        <h2>Recently Registered</h2>
                        <h3 style="font-size: 0.9rem; margin: 12px 0 8px;">New Members</h3>
                        <ul style="list-style: none; padding: 0; font-size: 0.9rem;">
                            <c:forEach items="${recentMembers}" var="m">
                                <li style="padding: 8px 0; border-bottom: 1px solid #f1f5f9;"><c:out value="${m.fullName}"/></li>
                            </c:forEach>
                        </ul>
                        <h3 style="font-size: 0.9rem; margin: 16px 0 8px;">New Hospitals</h3>
                        <ul style="list-style: none; padding: 0; font-size: 0.9rem;">
                            <c:forEach items="${recentHospitals}" var="h">
                                <li style="padding: 8px 0; border-bottom: 1px solid #f1f5f9;"><c:out value="${h.fullName}"/></li>
                            </c:forEach>
                        </ul>
                    </section>

                    <!-- Announcements -->
                    <section class="card">
                        <h2>Latest Announcements</h2>
                        <ul style="list-style: none; padding: 0;">
                            <c:forEach items="${recentAnnouncements}" var="a">
                                <li style="padding: 12px 0; border-bottom: 1px solid #f1f5f9;">
                                    <div style="font-weight: 600; font-size: 0.95rem;"><c:out value="${a.title}"/></div>
                                    <small class="text-muted"><fmt:formatDate value="${a.createdAt}" pattern="dd MMM yyyy"/></small>
                                </li>
                            </c:forEach>
                        </ul>
                    </section>
                </div>
            </div>
        </main>
        <jsp:include page="../common/footer.jsp" />
    </div>
    <jsp:include page="../common/sidePanel.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Request Status Chart
        const reqCtx = document.getElementById('requestChart').getContext('2d');
        new Chart(reqCtx, {
            type: 'pie',
            data: {
                labels: ['Pending', 'Approved', 'Completed', 'Rejected'],
                datasets: [{
                    data: [${stats.requestsPending}, ${stats.requestsApproved}, ${stats.requestsCompleted}, ${stats.requestsRejected}],
                    backgroundColor: ['#f59e0b', '#10b981', '#3b82f6', '#ef4444']
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { position: 'bottom' }
                }
            }
        });

        // Organ Type Chart
        const organCtx = document.getElementById('organChart').getContext('2d');
        const organData = {
            labels: [<c:forEach items="${typeBreakdown}" var="e">'${e.key}',</c:forEach>],
            datasets: [{
                label: 'Available Organs',
                data: [<c:forEach items="${typeBreakdown}" var="e">${e.value},</c:forEach>],
                backgroundColor: '#6366f1'
            }]
        };
        new Chart(organCtx, {
            type: 'bar',
            data: organData,
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: { beginAtZero: true, ticks: { stepSize: 1 } }
                }
            }
        });
    </script>
</body>
</html>