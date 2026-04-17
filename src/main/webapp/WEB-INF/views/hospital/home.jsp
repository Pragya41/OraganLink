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
                                <h1>Hospital Medical Center</h1>
                                <p class="text-muted">Logged in as <strong>
                                        <c:out value="${sessionScope.fullName}" />
                                    </strong>. Hospital operations portal.</p>
                            </div>
                            <div class="header-actions">
                                <a href="${pageContext.request.contextPath}/hospital/addOrgan" class="btn btn-primary">
                                    <span>+</span> Register New Organ
                                </a>
                            </div>
                        </div>

                        <div class="stats-grid">
                            <div class="stat-card stat-primary">
                                <div class="stat-label">Stocked Organs</div>
                                <div class="stat-value">
                                    <c:out value="${stats.myOrgans}" />
                                </div>
                                <a href="${pageContext.request.contextPath}/hospital/organs"
                                    class="btn btn-sm btn-secondary">Inventory</a>
                            </div>
                            <div class="stat-card stat-orange">
                                <div class="stat-label">Inbox Requests</div>
                                <div class="stat-value">
                                    <c:out value="${stats.requestsPending}" />
                                </div>
                                <a href="${pageContext.request.contextPath}/hospital/requests"
                                    class="btn btn-sm btn-secondary">Review</a>
                            </div>
                            <div class="stat-card stat-blue">
                                <div class="stat-label">Approved Match</div>
                                <div class="stat-value">
                                    <c:out value="${stats.requestsApproved}" />
                                </div>
                                <a href="${pageContext.request.contextPath}/hospital/approvedRequests"
                                    class="btn btn-sm btn-secondary">Track</a>
                            </div>
                            <div class="stat-card stat-green">
                                <div class="stat-label">Total Procedures</div>
                                <div class="stat-value">
                                    <c:out value="${stats.transplantsDone}" />
                                </div>
                                <a href="${pageContext.request.contextPath}/hospital/completed"
                                    class="btn btn-sm btn-secondary">History</a>
                            </div>
                        </div>

                        <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 24px;">
                            <section class="card">
                                <h2>Clinical Bulletins</h2>
                                <table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>Topic</th>
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
                                                    <fmt:formatDate value="${a.createdAt}" pattern="dd MMM yyyy" />
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty recentAnnouncements}">
                                            <tr>
                                                <td colspan="2" class="text-center">No active bulletins for this medical
                                                    center.</td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </section>

                            <section class="card">
                                <h2>Facility Tools</h2>
                                <div style="display: flex; flex-direction: column; gap: 12px;">
                                    <a href="${pageContext.request.contextPath}/hospital/addOrgan"
                                        class="btn btn-primary btn-full">
                                        &#129505; Register Donor Organ
                                    </a>
                                    <a href="${pageContext.request.contextPath}/hospital/requests"
                                        class="btn btn-secondary btn-full">
                                        &#128101; Match Requests
                                    </a>
                                    <a href="${pageContext.request.contextPath}/hospital/organs"
                                        class="btn btn-secondary btn-full">
                                        &#128203; Facility Stock
                                    </a>
                                    <a href="${pageContext.request.contextPath}/hospital/announcements"
                                        class="btn btn-secondary btn-full">
                                        &#128227; Public Bulletins
                                    </a>
                                </div>
                            </section>
                        </div>
                    </main>
                    <jsp:include page="../common/footer.jsp" />
                </div>
                <jsp:include page="../common/sidePanel.jsp" />
            </body>

            </html>