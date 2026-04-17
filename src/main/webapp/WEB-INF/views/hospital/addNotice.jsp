<%-- WEB-INF/views/hospital/addNotice.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>OrganLink - Post Announcement</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css?v=2"/>
</head>
<body>
    <div class="app-wrapper">
        <jsp:include page="../common/nav.jsp" />
        <main class="main-content">
            <div class="page-header">
                <h1>Post New Announcement</h1>
                <p class="text-muted">Share important updates, and health news with the community.</p>
            </div>

            <div class="card" style="max-width: 700px; margin: 0 auto;">
                <form method="post" action="${pageContext.request.contextPath}/hospital" class="modern-form">
                    <input type="hidden" name="action" value="addNotice"/>
                    
                    <div class="form-group">
                        <label for="title">Announcement Title *</label>
                        <input type="text" name="title" id="title" required placeholder="e.g., Blood Donation Drive at City General" class="form-control" style="font-size: 1.1rem;"/>
                    </div>

                    <div class="form-group">
                        <label for="description">Content / Description *</label>
                        <textarea name="description" id="description" rows="10" required placeholder="Provide detailed information here..." class="form-control"></textarea>
                    </div>

                    <div style="margin-top: 32px; display: flex; gap: 12px; justify-content: flex-end;">
                        <a href="${pageContext.request.contextPath}/hospital/announcements" class="btn btn-secondary">Cancel</a>
                        <button type="submit" class="btn btn-primary" style="padding-left: 40px; padding-right: 40px;">Publish Announcement</button>
                    </div>
                </form>
            </div>
        </main>
        <jsp:include page="../common/footer.jsp" />
    </div>
</body>
</html>
