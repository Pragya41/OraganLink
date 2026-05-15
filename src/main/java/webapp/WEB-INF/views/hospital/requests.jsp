<%-- WEB-INF/views/hospital/requests.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>OrganLink - Pending Requests</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css?v=2"/>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="../common/nav.jsp"/>
    <main class="main-content">
        <div class="page-header">
            <h1>Pending Donation Requests</h1>
        </div>
        <c:if test="${param.msg == 'approved'}"><div class="alert alert-success">Request approved and
organ reserved.</div></c:if>
        <c:if test="${param.msg == 'rejected'}"><div class="alert alert-success">Request
rejected.</div></c:if>
        <div class="card">
            <table class="data-table" id="reqTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Member</th>
                        <th>Organ</th>
                        <th>Blood Type</th>
                        <th>Requested</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${requests}" var="r">
                        <tr>
                            <td><c:out value="${r.id}"/></td>
<td><c:out value="${r.memberName}"/></td>
                            <td><c:out value="${r.organType}"/></td>
                            <td><span class="blood-badge"><c:out value="${r.bloodType}"/></span></td>
                            <td><fmt:formatDate value="${r.requestedAt}" pattern="dd MMM yyyy"/></td>
                            <td>
                                <form method="post"
action="${pageContext.request.contextPath}/hospital" style="display:inline">
                                    <input type="hidden" name="action" value="approveRequest"/>
                                    <input type="hidden" name="requestId" value="${r.id}"/>
                                    <button type="submit" class="btn btn-sm
btn-success">Approve</button>
                                </form>
                                <form method="post"
action="${pageContext.request.contextPath}/hospital" style="display:inline">
                                    <input type="hidden" name="action" value="rejectRequest"/>
                                    <input type="hidden" name="requestId" value="${r.id}"/>
                                    <button type="submit" class="btn btn-sm btn-danger"
                                            onclick="return confirm('Reject this
request?')">Reject</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty requests}">
                        <tr><td colspan="6" class="text-center">No pending requests.</td></tr>
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