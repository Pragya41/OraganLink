<%-- WEB-INF/views/common/nav.jsp --%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

            <div class="topbar">
                <div class="site-header">
                    <div class="site-header-inner">
                        <div class="site-logo">
                            <span><i class="fa fa-heartbeat"></i></span> OrganLink Nepal
                        </div>
                        <div class="site-tagline">
                            Linking Donors, Saving Lives
                        </div>
                        <div class="site-user-info">
                            <small>Logged in as:</small>
                            <strong>
                                <c:out value="${sessionScope.fullName}" />
                            </strong>
                            <span class="role-badge role-${sessionScope.role}">
                                <c:choose>
                                    <c:when test="${sessionScope.role == 'ADMIN'}">Health Authority</c:when>
                                    <c:when test="${sessionScope.role == 'HOSPITAL'}">Hospital</c:when>
                                    <c:when test="${sessionScope.role == 'MEMBER'}">Member</c:when>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="navbar">
                    <div class="navbar-inner">
                        <nav class="nav-links">
                            <c:choose>
                                <c:when test="${sessionScope.role == 'ADMIN'}">
                                    <a href="${pageContext.request.contextPath}/admin/home"
                                        class="${fn:contains(pageContext.request.servletPath, 'home') ? 'active' : ''}">Dashboard</a>
                                    <a href="${pageContext.request.contextPath}/admin/hospitals"
                                        class="${fn:contains(pageContext.request.servletPath, 'hospital') ? 'active' : ''}">Hospitals</a>
                                    <a href="${pageContext.request.contextPath}/admin/members"
                                        class="${fn:contains(pageContext.request.servletPath, 'member') ? 'active' : ''}">Members</a>
                                    <a href="${pageContext.request.contextPath}/admin/organs"
                                        class="${fn:contains(pageContext.request.servletPath, 'organ') ? 'active' : ''}">Organs</a>
                                    <a href="${pageContext.request.contextPath}/admin/requests"
                                        class="${fn:contains(pageContext.request.servletPath, 'request') ? 'active' : ''}">Requests</a>
                                    <a href="${pageContext.request.contextPath}/admin/announcements"
                                        class="${fn:contains(pageContext.request.servletPath, 'announcements') ? 'active' : ''}">Announcements</a>
                                    <a href="${pageContext.request.contextPath}/admin/completedTransplants"
                                        class="${fn:contains(pageContext.request.servletPath, 'completedTransplants') ? 'active' : ''}">Completed</a>
                                </c:when>

                                <c:when test="${sessionScope.role == 'HOSPITAL'}">
                                    <a href="${pageContext.request.contextPath}/hospital/home"
                                        class="${fn:contains(pageContext.request.servletPath, 'home') ? 'active' : ''}">Dashboard</a>
                                    <a href="${pageContext.request.contextPath}/hospital/announcements"
                                        class="${fn:contains(pageContext.request.servletPath, 'announcements') ? 'active' : ''}">Announcements</a>
                                    <a href="${pageContext.request.contextPath}/hospital/organs"
                                        class="${fn:contains(pageContext.request.servletPath, 'organ') ? 'active' : ''}">My
                                        Organs</a>
                                    <a href="${pageContext.request.contextPath}/hospital/addOrgan"
                                        class="${fn:contains(pageContext.request.servletPath, 'addOrgan') ? 'active' : ''}">Add
                                        Organ</a>
                                    <a href="${pageContext.request.contextPath}/hospital/requests"
                                        class="${fn:contains(pageContext.request.servletPath, 'request') ? 'active' : ''}">Pending
                                        Requests</a>
                                    <a href="${pageContext.request.contextPath}/hospital/approvedRequests"
                                        class="${fn:contains(pageContext.request.servletPath, 'approvedRequests') ? 'active' : ''}">Approved</a>
                                    <a href="${pageContext.request.contextPath}/hospital/completed"
                                        class="${fn:contains(pageContext.request.servletPath, 'completed') ? 'active' : ''}">Completed</a>
                                </c:when>

                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/member/home"
                                        class="${fn:contains(pageContext.request.servletPath, 'home') ? 'active' : ''}">Dashboard</a>
                                    <a href="${pageContext.request.contextPath}/member/announcements"
                                        class="${fn:contains(pageContext.request.servletPath, 'announcements') ? 'active' : ''}">Announcements</a>
                                    <a href="${pageContext.request.contextPath}/member/organs"
                                        class="${fn:contains(pageContext.request.servletPath, 'organ') ? 'active' : ''}">Available
                                        Organs</a>
                                    <a href="${pageContext.request.contextPath}/member/myRequests"
                                        class="${fn:contains(pageContext.request.servletPath, 'myRequests') ? 'active' : ''}">My
                                        Requests</a>
                                    <a href="${pageContext.request.contextPath}/member/profile"
                                        class="${fn:contains(pageContext.request.servletPath, 'profile') ? 'active' : ''}">Profile</a>
                                </c:otherwise>
                            </c:choose>
                        </nav>

                        <a href="${pageContext.request.contextPath}/auth?action=logout" class="nav-logout">
                            Logout <i class="fa fa-sign-out"></i>
                        </a>
                    </div>
                </div>
            </div>