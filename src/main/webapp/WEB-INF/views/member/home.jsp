<%-- WEB-INF/views/member/home.jsp --%>
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
                                <h1>Personal Health Portal</h1>
                                <p class="text-muted">Welcome, <strong>
                                        <c:out value="${sessionScope.fullName}" />
                                    </strong>. Manage your donation journey here.</p>
                            </div>
                            <div class="header-actions">
                                <c:if test="${not empty sessionScope.bloodType}">
                                    <span class="blood-badge" style="font-size: 1rem; padding: 8px 16px;">
                                        Blood Group:
                                        <c:out value="${sessionScope.bloodType}" />
                                    </span>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/member/profile" class="btn btn-secondary">
                                    &#128100; My Profile
                                </a>
                            </div>
                        </div>

                        <div class="stats-grid">
                            <div class="stat-card stat-blue">
                                <div class="stat-label">Request History</div>
                                <div class="stat-value">
                                    <c:out value="${stats.myRequests}" />
                                </div>
                                <a href="${pageContext.request.contextPath}/member/myRequests"
                                    class="btn btn-sm btn-secondary">View Records</a>
                            </div>
                            <div class="stat-card stat-orange">
                                <div class="stat-label">Awaiting Review</div>
                                <div class="stat-value">
                                    <c:out value="${stats.pending}" />
                                </div>
                                <a href="${pageContext.request.contextPath}/member/myRequests"
                                    class="btn btn-sm btn-secondary">Track Status</a>
                            </div>
                            <div class="stat-card stat-primary">
                                <div class="stat-label">Confirmed Matches</div>
                                <div class="stat-value">
                                    <c:out value="${stats.approved}" />
                                </div>
                                <a href="${pageContext.request.contextPath}/member/myRequests"
                                    class="btn btn-sm btn-secondary">Next Steps</a>
                            </div>
                            <div class="stat-card stat-green">
                                <div class="stat-label">Life Saved</div>
                                <div class="stat-value">
                                    <c:out value="${stats.completed}" />
                                </div>
                                <span class="badge badge-green" style="margin-top: 8px;">Success History</span>
                            </div>
                        </div>

                        <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 24px;">
                            <section class="card">
                                <h2>Public Bulletins</h2>
                                <table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>Topic</th>
                                            <th>Publication Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${recentAnnouncements}" var="a">
                                            <tr>
                                                <td><strong>
                                                        <c:out value="${a.title}" />
                                                    </strong></td>
                                                <td>
                                                    <fmt:formatDate value="${a.createdAt}" pattern="dd MMM yyyy" />
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty recentAnnouncements}">
                                            <tr>
                                                <td colspan="2" class="text-center">No community announcements at this
                                                    time.</td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </section>

                            <section class="card">
                                <h2>Portal Actions</h2>
                                <div style="display: flex; flex-direction: column; gap: 12px;">
                                    <a href="${pageContext.request.contextPath}/member/organs"
                                        class="btn btn-primary btn-full">
                                        &#129505; Browse Organs
                                    </a>
                                    <a href="${pageContext.request.contextPath}/member/myRequests"
                                        class="btn btn-secondary btn-full">
                                        &#128203; Track My Applications
                                    </a>
                                    <a href="${pageContext.request.contextPath}/member/profile"
                                        class="btn btn-secondary btn-full">
                                        &#128221; Account Settings
                                    </a>
                                    <a href="${pageContext.request.contextPath}/member/announcements"
                                        class="btn btn-secondary btn-full">
                                        &#128227; Latest News
                                    </a>
                                </div>
                                <div style="margin-top: 24px; padding: 16px; background: #eff6ff; border-radius: 8px;">
                                    <p style="color: #1e40af; font-size: 0.85rem; font-weight: 500;">
                                        <strong>Did you know?</strong> One organ donor can save up to eight lives and
                                        improve the lives of as many as 75 more.
                                    </p>
                                </div>
                            </section>
                        </div>
                    </main>
                    <jsp:include page="../common/footer.jsp" />
                </div>
                <jsp:include page="../common/sidePanel.jsp" />
            </body>

            </html>