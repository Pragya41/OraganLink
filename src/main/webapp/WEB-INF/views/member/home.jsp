<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8" />
                <title>OrganLink - Personal Health Portal</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css?v=2" />
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
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
                                <a href="${pageContext.request.contextPath}/member/organs" class="btn btn-primary"><i class="fa fa-heart"></i> Browse Organs</a>
                                <a href="${pageContext.request.contextPath}/member/myRequests" class="btn btn-secondary"><i class="fa fa-list-alt"></i> My Requests</a>
                            </div>
                        </div>

                        <!-- Statistics Section -->
                        <h2 class="section-title">My Health Overview</h2>
                        <div class="stats-grid">
                            <div class="stat-card stat-teal">
                                <div class="stat-icon-wrapper">
                                    <i class="fa fa-heartbeat fa-2x"></i>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value"><c:out value="${stats.totalAvailable}" /></div>
                                    <div class="stat-label">System Organs</div>
                                </div>
                            </div>
                            <div class="stat-card stat-blue">
                                <div class="stat-icon-wrapper">
                                    <i class="fa fa-search fa-2x"></i>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value"><c:out value="${stats.compatible}" /></div>
                                    <div class="stat-label">Compatible</div>
                                </div>
                            </div>
                            <div class="stat-card stat-purple">
                                <div class="stat-icon-wrapper">
                                    <i class="fa fa-file-text-o fa-2x"></i>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value"><c:out value="${stats.myRequests}" /></div>
                                    <div class="stat-label">My Requests</div>
                                </div>
                            </div>
                            <div class="stat-card stat-orange">
                                <div class="stat-icon-wrapper">
                                    <i class="fa fa-clock-o fa-2x"></i>
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
                                    <i class="fa fa-thumbs-o-up fa-2x"></i>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value"><c:out value="${stats.approved}" /></div>
                                    <div class="stat-label">Approved</div>
                                </div>
                            </div>
                            <div class="stat-card stat-blue">
                                <div class="stat-icon-wrapper">
                                    <i class="fa fa-clipboard fa-2x"></i>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value"><c:out value="${stats.completed}" /></div>
                                    <div class="stat-label">Completed</div>
                                </div>
                            </div>
                            <div class="stat-card stat-rose">
                                <div class="stat-icon-wrapper">
                                    <i class="fa fa-times-circle-o fa-2x"></i>
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