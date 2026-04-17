<%-- WEB-INF/views/member/profile.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>OrganLink - My Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css"/>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="../common/nav.jsp"/>
    <main class="main-content">
        <div class="page-header"><h1>My Profile</h1></div>
        <c:if test="${param.msg == 'updated'}"><div class="alert alert-success">Profile updated
successfully!</div></c:if>
        <div class="card form-card">
            <form method="post" action="${pageContext.request.contextPath}/member">
                <input type="hidden" name="action" value="updateProfile"/>
                <div class="form-group">
                    <label>Blood Type *</label>
                    <select name="bloodType" required>
                        <option value="">-- Select --</option>
                        <c:forEach var="bt" items="${fn:split('A+,A-,B+,B-,AB+,AB-,O+,O-', ',')}">
                            <option value="${bt}" ${member.bloodType == bt ? 'selected' : ''}>
                                <c:out value="${bt}"/>
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>Address</label>
                    <input type="text" name="address" value="<c:out value='${member.address}'/>"/>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
        </div>
    </main>
</div>
</body>
</html>