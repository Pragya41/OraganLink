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
                        <h2 class="section-title">My Health Overview</h2>
                        <div class="stats-grid">
                            <div class="stat-card stat-teal">
                                <div class="stat-icon-wrapper">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z"/></svg>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value"><c:out value="${stats.totalAvailable}" /></div>
                                    <div class="stat-label">System Organs</div>
                                </div>
                            </div>
                            <div class="stat-card stat-blue">
                                <div class="stat-icon-wrapper">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value"><c:out value="${stats.compatible}" /></div>
                                    <div class="stat-label">Compatible</div>
                                </div>
                            </div>
                            <div class="stat-card stat-purple">
                                <div class="stat-icon-wrapper">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/><polyline points="10 9 9 9 8 9"/></svg>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value"><c:out value="${stats.myRequests}" /></div>
                                    <div class="stat-label">My Requests</div>
                                </div>
                            </div>
                            <div class="stat-card stat-orange">
                                <div class="stat-icon-wrapper">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value"><c:out value="${stats.pending}" /></div>
                                    <div class="stat-label">Pending</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="stats-grid" style="margin-top: 1.5rem;">
                            <div class="stat-card stat-green">
                                <div class="stat-icon-wrapper">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value"><c:out value="${stats.approved}" /></div>
                                    <div class="stat-label">Approved</div>
                                </div>
                            </div>
                            <div class="stat-card stat-blue">
                                <div class="stat-icon-wrapper">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value"><c:out value="${stats.completed}" /></div>
                                    <div class="stat-label">Completed</div>
                                </div>
                            </div>
                            <div class="stat-card stat-rose">
                                <div class="stat-icon-wrapper">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value"><c:out value="${stats.rejected}" /></div>
                                    <div class="stat-label">Rejected</div>
                                </div>
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