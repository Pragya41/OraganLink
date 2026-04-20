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
            <h2 class="section-title">System Overview</h2>
            <div class="stats-grid" style="grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));">
                <div class="stat-card stat-blue">
                    <div class="stat-label">Hospitals</div>
                    <div class="stat-value"><c:out value="${stats.totalHospitals}" /></div>
                </div>
                <div class="stat-card stat-primary">
                    <div class="stat-label">Members</div>
                    <div class="stat-value"><c:out value="${stats.totalMembers}" /></div>
                </div>
                <div class="stat-card stat-green">
                    <div class="stat-label">Organs Available</div>
                    <div class="stat-value"><c:out value="${stats.organsAvailable}" /></div>
                </div>
                <div class="stat-card stat-orange">
                    <div class="stat-label">Reserved</div>
                    <div class="stat-value"><c:out value="${stats.organsReserved}" /></div>
                </div>
            </div>
            
            <div class="stats-grid" style="grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); margin-top: 16px;">
                <div class="stat-card"><div class="stat-label">Pending</div><div class="stat-value text-orange"><c:out value="${stats.requestsPending}" /></div></div>
                <div class="stat-card"><div class="stat-label">Approved</div><div class="stat-value text-green"><c:out value="${stats.requestsApproved}" /></div></div>
                <div class="stat-card"><div class="stat-label">Completed</div><div class="stat-value text-blue"><c:out value="${stats.requestsCompleted}" /></div></div>
                <div class="stat-card"><div class="stat-label">Rejected</div><div class="stat-value text-red"><c:out value="${stats.requestsRejected}" /></div></div>
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