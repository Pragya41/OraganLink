<%-- WEB-INF/views/hospital/organs.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>OrganLink - My Organs</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css?v=2"/>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="../common/nav.jsp"/>
    <main class="main-content">
        <section class="mb-4">
            <h2 class="section-title">My Registered Organs</h2>
            <c:if test="${param.msg == 'deleted'}">
                <div class="alert alert-success">Organ record removed from your inventory.</div>
            </c:if>
            <c:if test="${param.msg == 'updated'}">
                <div class="alert alert-success">Organ details updated successfully.</div>
            </c:if>
            <div class="card">
                <table class="data-table" id="organTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Organ Type</th>
                            <th>Blood Type</th>
                            <th>Status</th>
                            <th>Registered</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${myOrgans}" var="o">
                            <tr>
                                <td><c:out value="${o.id}"/></td>
                                <td><c:out value="${o.organType}"/></td>
                                <td><span class="blood-badge"><c:out value="${o.bloodType}"/></span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${o.status == 'AVAILABLE'}"> <span class="badge badge-green">AVAILABLE</span></c:when>
                                        <c:when test="${o.status == 'RESERVED'}"> <span class="badge badge-orange">RESERVED</span></c:when>
                                        <c:otherwise> <span class="badge badge-blue">TRANSPLANTED</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td><fmt:formatDate value="${o.registeredAt}" pattern="dd MMM yyyy"/></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty myOrgans}">
                            <tr><td colspan="5" class="text-center">No organs registered by your hospital yet.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </section>

        <section>
            <h2 class="section-title">All Platform Organs</h2>
            <div class="card">
                <table class="data-table" id="allOrgansTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Organ</th>
                            <th>Blood Type</th>
                            <th>Hospital</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${allOrgans}" var="o">
                            <tr>
                                <td><c:out value="${o.id}"/></td>
                                <td><c:out value="${o.organType}"/></td>
                                <td><span class="blood-badge"><c:out value="${o.bloodType}"/></span></td>
                                <td><c:out value="${o.hospitalName}"/></td>
                                <td>
                                    <span class="badge ${o.status == 'AVAILABLE' ? 'badge-green' : (o.status == 'RESERVED' ? 'badge-orange' : 'badge-blue')}">
                                        <c:out value="${o.status}"/>
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty allOrgans}">
                            <tr><td colspan="5" class="text-center">No organs found on the platform.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </section>
        </main>
        <jsp:include page="../common/footer.jsp" />
    </div>
    <jsp:include page="../common/sidePanel.jsp" />
</body>
</html>