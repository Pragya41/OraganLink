<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        
        <c:if test="${param.msg == 'submitted'}"> <div class="alert alert-success">Request submitted successfully!</div></c:if>
        <c:if test="${param.msg == 'duplicate'}"> <div class="alert alert-warning">You have already requested this organ.</div></c:if>

        <section class="mb-4">
            <h2 class="section-title">Compatible Organs</h2>
            <div class="card">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Organ</th>
                            <th>Blood Type</th>
                            <th>Hospital</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${compatibleOrgans}" var="o">
                            <tr>
                                <td><c:out value="${o.id}"/></td>
                                <td><c:out value="${o.organType}"/></td>
                                <td><span class="blood-badge"><c:out value="${o.bloodType}"/></span></td>
                                <td><c:out value="${o.hospitalName}"/></td>
                                <td><span class="badge badge-green">Compatible</span></td>
                                <td>
                                    <form method="post" action="${pageContext.request.contextPath}/member">
                                        <input type="hidden" name="action" value="submitRequest"/>
                                        <input type="hidden" name="organId" value="${o.id}"/>
                                        <button type="submit" class="btn btn-sm btn-primary">Request</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty compatibleOrgans}">
                            <tr><td colspan="6" class="text-center">No compatible organs found for your blood type (${sessionScope.bloodType != null ? sessionScope.bloodType : 'Unknown'}).</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </section>

        <section>
            <h2 class="section-title">All Available Organs</h2>
            <div class="card">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Organ</th>
                            <th>Blood Type</th>
                            <th>Hospital</th>
                            <th>Available Since</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${organs}" var="o">
                            <tr>
                                <td><c:out value="${o.id}"/></td>
                                <td><c:out value="${o.organType}"/></td>
                                <td><span class="blood-badge"><c:out value="${o.bloodType}"/></span></td>
                                <td><c:out value="${o.hospitalName}"/></td>
                                <td><fmt:formatDate value="${o.registeredAt}" pattern="dd MMM yyyy"/></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty organs}">
                            <tr><td colspan="5" class="text-center">No organs currently available.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
</div>
    <jsp:include page="../common/sidePanel.jsp" />
</body>
</html>