<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8" />
                <title>OrganLink - Personal Health Portal</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css?v=2" />
            </head>

            <body>
                <div class="app-wrapper">
                    <jsp:include page="../common/nav.jsp" />
                    <main class="main-content">
                        <div class="page-header">
                            <div>
                                <h1>Member Dashboard</h1>
                                <p class="text-muted">Welcome back, <strong><c:out value="${sessionScope.fullName}" /></strong>.</p>
                            </div>
                            <div class="header-actions">
                                <a href="${pageContext.request.contextPath}/member/organs" class="btn btn-primary">&#129505; Browse Organs</a>
                                <a href="${pageContext.request.contextPath}/member/myRequests" class="btn btn-secondary">&#128203; My Requests</a>
                            </div>
                        </div>

                        <!-- Statistics Section -->
                        <h2 class="section-title">Overview Statistics</h2>
                        <div class="stats-grid" style="grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));">
                            <div class="stat-card stat-blue">
                                <div class="stat-label">Total Available Organs</div>
                                <div class="stat-value"><c:out value="${stats.totalAvailable}" /></div>
                            </div>
                            <div class="stat-card stat-green">
                                <div class="stat-label">Compatible with You</div>
                                <div class="stat-value"><c:out value="${stats.compatible}" /></div>
                            </div>
                            <div class="stat-card stat-primary">
                                <div class="stat-label">Total Requests</div>
                                <div class="stat-value"><c:out value="${stats.myRequests}" /></div>
                            </div>
                            <div class="stat-card stat-orange">
                                <div class="stat-label">Pending</div>
                                <div class="stat-value"><c:out value="${stats.pending}" /></div>
                            </div>
                        </div>
                        <div class="stats-grid" style="grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); margin-top: 16px;">
                            <div class="stat-card">
                                <div class="stat-label">Approved</div>
                                <div class="stat-value text-green"><c:out value="${stats.approved}" /></div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-label">Completed</div>
                                <div class="stat-value text-blue"><c:out value="${stats.completed}" /></div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-label">Rejected</div>
                                <div class="stat-value text-red"><c:out value="${stats.rejected}" /></div>
                            </div>
                        </div>

                        <div class="dashboard-layout" style="display: grid; grid-template-columns: 2fr 1fr; gap: 24px; margin-top: 32px;">
                            <div class="main-widgets">
                                <!-- Active Requests Widget -->
                                <section class="card mb-4">
                                    <div class="card-header">
                                        <h2>Active Requests</h2>
                                        <a href="${pageContext.request.contextPath}/member/myRequests" class="text-link">View All</a>
                                    </div>
                                    <table class="data-table">
                                        <thead>
                                            <tr>
                                                <th>Organ</th>
                                                <th>Hospital</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${activeRequests}" var="r">
                                                <tr>
                                                    <td><c:out value="${r.organType}"/></td>
                                                    <td><c:out value="${r.hospitalName != null ? r.hospitalName : 'Pending'}"/></td>
                                                    <td>
                                                        <span class="badge ${r.status == 'APPROVED' ? 'badge-green' : 'badge-yellow'}">
                                                            <c:out value="${r.status}"/>
                                                        </span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty activeRequests}">
                                                <tr><td colspan="3" class="text-center">No active requests.</td></tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </section>

                                <!-- Recently Compatible Organs Widget -->
                                <section class="card mb-4">
                                    <div class="card-header">
                                        <h2>New Compatible Organs</h2>
                                        <a href="${pageContext.request.contextPath}/member/organs" class="text-link">Browse All</a>
                                    </div>
                                    <table class="data-table">
                                        <thead>
                                            <tr>
                                                <th>Organ</th>
                                                <th>Hospital</th>
                                                <th>Added On</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${recentCompatible}" var="o">
                                                <tr>
                                                    <td><c:out value="${o.organType}"/></td>
                                                    <td><c:out value="${o.hospitalName}"/></td>
                                                    <td><fmt:formatDate value="${o.registeredAt}" pattern="dd MMM"/></td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty recentCompatible}">
                                                <tr><td colspan="3" class="text-center">No compatible organs listed yet.</td></tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </section>
                            </div>

                            <div class="side-widgets">
                                <!-- Profile Summary Widget -->
                                <section class="card mb-4 profile-summary">
                                    <h2>Profile Summary</h2>
                                    <div class="summary-item">
                                        <label>Blood Type:</label>
                                        <span class="blood-badge"><c:out value="${member.bloodType != null ? member.bloodType : 'Not Set'}"/></span>
                                    </div>
                                    <div class="summary-item">
                                        <label>Status:</label>
                                        <span class="badge badge-blue">Registered Member</span>
                                    </div>
                                    <div class="summary-item" style="margin-top: 16px;">
                                        <p style="font-size: 0.85rem; color: #64748b;"><c:out value="${member.address}"/></p>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/member/profile" class="btn btn-sm btn-secondary btn-full" style="margin-top: 16px;">Update Profile</a>
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
                                    <a href="${pageContext.request.contextPath}/member/announcements" class="text-link" style="display: block; margin-top: 16px; text-align: center;">View All</a>
                                </section>
                            </div>
                        </div>
                    </main>
                    <jsp:include page="../common/footer.jsp" />
                </div>
                <jsp:include page="../common/sidePanel.jsp" />
            </body>

            </html>