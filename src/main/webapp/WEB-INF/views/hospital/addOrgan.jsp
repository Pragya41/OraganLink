<%-- WEB-INF/views/hospital/addOrgan.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>OrganLink - Add Organ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css"/>
</head>
<body>
<div class="app-wrapper">
    <jsp:include page="../common/nav.jsp"/>
    <main class="main-content">
        <div class="page-header"><h1>Register New Organ</h1></div>
        <div class="card form-card">
            <form method="post" action="${pageContext.request.contextPath}/hospital">
                <input type="hidden" name="action" value="addOrgan"/>
                <div class="form-group">
                    <label>Organ Type *</label>
                    <select name="organType" required>
                        <option value="">-- Select Organ --</option>
                        <option value="KIDNEY">Kidney</option>
                        <option value="LIVER">Liver</option>
                        <option value="HEART">Heart</option>
                        <option value="LUNG">Lung</option>
                        <option value="CORNEA">Cornea</option>
                        <option value="PANCREAS">Pancreas</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Blood Type *</label>
                    <select name="bloodType" required>
                        <option value="">-- Select Blood Type --</option>
                        <option value="A+">A+</option>
                        <option value="A-">A-</option>
                        <option value="B+">B+</option>
                        <option value="B-">B-</option>
                        <option value="AB+">AB+</option>
                        <option value="AB-">AB-</option>
                        <option value="O+">O+</option>
                        <option value="O-">O-</option>
                    </select>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Register Organ</button>
                    <a href="${pageContext.request.contextPath}/hospital/organs" class="btn
btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </main>
</div>
</body>
</html>