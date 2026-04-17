<%-- WEB-INF/views/member/organs.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>OrganLink - Available Organs</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css"/>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="../common/nav.jsp"/>
    <main class="main-content">
        <div class="page-header">
            <h1>Available Organs</h1>
        </div>
        <c:if test="${param.msg == 'submitted'}"> <div class="alert alert-success">Request submitted
successfully!</div></c:if>
        <c:if test="${param.msg == 'duplicate'}"> <div class="alert alert-warning">You have already
requested this organ.</div></c:if>
        <div class="card">
            <table class="data-table" id="organTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Organ</th>
                        <th>Blood Type</th>
                        <th>Hospital</th>
                        <th>Compatibility</th>
                        <th>Available Since</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${organs}" var="o">
                        <tr>
<td><c:out value="${o.id}"/></td>
                            <td><c:out value="${o.organType}"/></td>
                            <td><span class="blood-badge"><c:out value="${o.bloodType}"/></span></td>
                            <td><c:out value="${o.hospitalName}"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${sessionScope.bloodType == o.bloodType or
sessionScope.bloodType == 'AB+' or o.bloodType == 'O-'}">
                                        <span class="badge badge-green">Compatible</span>
                                    </c:when>
                                    <c:when test="${empty sessionScope.bloodType}">
                                        <span class="badge badge-yellow">Unknown</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-red">Incompatible</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><fmt:formatDate value="${o.registeredAt}" pattern="dd MMM yyyy"/></td>
                            <td>
                                <form method="post" action="${pageContext.request.contextPath}/member">
                                    <input type="hidden" name="action" value="submitRequest"/>
                                    <input type="hidden" name="organId" value="${o.id}"/>
                                    <button type="submit" class="btn btn-sm
btn-primary">Request</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty organs}">
                        <tr><td colspan="7" class="text-center">No organs currently
available.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </main>
</div>
    <jsp:include page="../common/sidePanel.jsp" />
</body>
</html>