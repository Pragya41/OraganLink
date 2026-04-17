<%-- WEB-INF/views/admin/addAnnouncement.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>OrganLink - <c:choose><c:when test="${announcement !=
null}">Edit</c:when><c:otherwise>Add</c:otherwise></c:choose> Announcement</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css"/>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="../common/nav.jsp"/>
    <main class="main-content">
        <div class="page-header">
            <h1><c:choose><c:when test="${announcement !=
null}">Edit</c:when><c:otherwise>New</c:otherwise></c:choose> Announcement</h1>
        </div>
        <div class="card form-card">
            <form method="post" action="${pageContext.request.contextPath}/admin">
                <c:choose>
                    <c:when test="${announcement != null}">
                        <input type="hidden" name="action" value="updateAnnouncement"/>
                        <input type="hidden" name="id" value="${announcement.id}"/>
                    </c:when>
                    <c:otherwise>
                        <input type="hidden" name="action" value="addAnnouncement"/>
                    </c:otherwise>
                </c:choose>
                <div class="form-group">
                    <label>Title *</label>
                    <input type="text" name="title" required
                           value="<c:out value='${announcement.title}'/>"/>
                </div>
                <div class="form-group">
                    <label>Description *</label>
                    <textarea name="description" rows="6" required><c:out
value="${announcement.description}"/></textarea>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <c:choose><c:when test="${announcement !=
null}">Update</c:when><c:otherwise>Publish</c:otherwise></c:choose>
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/announcements" class="btn
btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </main>
</div>
</body>
</html>