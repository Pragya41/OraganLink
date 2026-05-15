<%-- WEB-INF/views/admin/announcements.jsp --%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8" />
                <title>OrganLink - Announcements</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css?v=2" />
            </head>

            <body>
                <div class="app-wrapper">
                    <jsp:include page="../common/nav.jsp" />
                    <main class="main-content">
                        <div class="page-header">
                            <h1>Announcements</h1>
                            <div class="header-actions">
                                <a href="${pageContext.request.contextPath}/admin/addAnnouncement" class="btn
btn-primary">+ New Announcement</a>
                            </div>
                        </div>
                        <c:if test="${param.msg == 'added'}">
                            <div class="alert alert-success">Announcement
                                added.</div>
                        </c:if>
                        <c:if test="${param.msg == 'updated'}">
                            <div class="alert alert-success">Announcement
                                updated.</div>
                        </c:if>
                        <c:if test="${param.msg == 'deleted'}">
                            <div class="alert alert-success">Announcement
                                deleted.</div>
                        </c:if>
                        <div class="card" style="margin-bottom: 32px;">
                            <div class="card-header">
                                <h2 style="margin: 0; font-size: 1.25rem;">My Announcements</h2>
                            </div>
                            <table class="data-table" id="myAnnTable">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Title</th>
                                        <th>Description</th>
                                        <th>Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${myAnnouncements}" var="a">
                                        <tr>
                                            <td><c:out value="${a.id}" /></td>
                                            <td><strong><c:out value="${a.title}" /></strong></td>
                                            <td class="td-truncate"><c:out value="${a.description}" /></td>
                                            <td><fmt:formatDate value="${a.createdAt}" pattern="dd MMM yyyy" /></td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty myAnnouncements}">
                                        <tr><td colspan="4" class="text-center">You haven't posted any announcements yet.</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>

                        <div class="card">
                            <div class="card-header">
                                <h2 style="margin: 0; font-size: 1.25rem;">Communication Stream (All)</h2>
                            </div>
                            <table class="data-table" id="annTable">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Title</th>
                                        <th>Description</th>
                                        <th>Posted By</th>
                                        <th>Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${announcements}" var="a">
                                        <tr>
                                            <td><c:out value="${a.id}" /></td>
                                            <td><c:out value="${a.title}" /></td>
                                            <td class="td-truncate"><c:out value="${a.description}" /></td>
                                            <td><c:out value="${a.createdByName}" /></td>
                                            <td><fmt:formatDate value="${a.createdAt}" pattern="dd MMM yyyy" /></td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty announcements}">
                                        <tr><td colspan="5" class="text-center">No community announcements yet.</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </main>
                <jsp:include page="../common/footer.jsp" />
            </div>
                <jsp:include page="../common/sidePanel.jsp" />
            </body>

            </html>