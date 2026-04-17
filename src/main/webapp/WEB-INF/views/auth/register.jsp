<%-- WEB-INF/views/auth/register.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>OrganLink - Register</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css"/>
    <style>
        .hidden-fields { display: none; }
        .visible-fields { display: block; animation: fadeIn 0.4s ease; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body class="auth-body">
    <div class="auth-wrapper">
        <div class="auth-image">
            <div class="auth-image-content">
                <h1>Be the Reason <br> for Someone's Smile.</h1>
                <p>Registration is the first step towards a legacy of life. Choose your role and join our mission today.</p>
            </div>
        </div>

        <div class="auth-form-side">
            <div class="auth-card" style="max-width: 500px;">
                <div class="auth-logo">
                    <span>&#10084;</span> OrganLink
                </div>

                <h2>Create Your Account</h2>
                <p class="auth-welcome-text">Start your journey with us.</p>

                <c:if test="${not empty param.error}">
                    <div class="alert alert-danger" style="margin-bottom: 24px;">
                        <c:choose>
                            <c:when test="${param.error == 'fullName'}">Full name is required.</c:when>
                            <c:when test="${param.error == 'username'}">Username is already taken.</c:when>
                            <c:when test="${param.error == 'email Duplicate'}">Email is already registered.</c:when>
                            <c:when test="${param.error == 'phone'}">Phone must be 10 digits.</c:when>
                            <c:otherwise>Please correct the errors and try again.</c:otherwise>
                        </c:choose>
                    </div>
                </c:if>

                <form method="post" action="${pageContext.request.contextPath}/auth" id="regForm">
                    <input type="hidden" name="action" value="register"/>
                    
                    <%-- Step 1: Role Selection --%>
                    <div class="form-group" id="roleStep">
                        <label for="roleSelect">What is your role? *</label>
                        <select name="role" id="roleSelect" required style="font-size: 1.1rem; height: 50px; border-width: 2px;">
                            <option value="">-- Choose Role --</option>
                            <option value="HOSPITAL">Medical Facility / Hospital</option>
                            <option value="MEMBER">Individual (Donor or Recipient)</option>
                        </select>
                    </div>

                    <div id="commonFields" class="hidden-fields">
                        <div class="form-row">
                            <div class="form-group">
                                <label>Full Name *</label>
                                <input type="text" name="fullName" placeholder="John Doe" required/>
                            </div>
                            <div class="form-group">
                                <label>Username *</label>
                                <input type="text" name="username" placeholder="johndoe123" required/>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>Password *</label>
                                <input type="password" name="password" placeholder="Password" required/>
                            </div>
                            <div class="form-group">
                                <label>Email *</label>
                                <input type="email" name="email" placeholder="john@example.com" required/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Phone Number *</label>
                            <input type="text" name="phone" maxlength="10" placeholder="10-digit mobile" required/>
                        </div>

                        <%-- Member Specific --%>
                        <div id="memberSpecific" class="hidden-fields">
                            <div class="form-group">
                                <label>Blood Group *</label>
                                <select name="bloodType" id="bloodType">
                                    <option value="">-- Select --</option>
                                    <option>A+</option><option>A-</option>
                                    <option>B+</option><option>B-</option>
                                    <option>AB+</option><option>AB-</option>
                                    <option>O+</option><option>O-</option>
                                </select>
                            </div>
                        </div>

                        <%-- Hospital Specific --%>
                        <div id="hospitalSpecific" class="hidden-fields">
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Facility Name *</label>
                                    <input type="text" name="hospitalName" placeholder="City General Hospital"/>
                                </div>
                                <div class="form-group">
                                    <label>Medical License No. *</label>
                                    <input type="text" name="licenseNo" placeholder="HOSP-12345"/>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Mailing Address</label>
                            <input type="text" name="address" placeholder="Street, City, State"/>
                        </div>

                        <button type="submit" class="btn btn-primary btn-full" style="margin-top: 12px;">Complete Registration</button>
                    </div>
                </form>

                <div class="auth-links">
                    <span>Already a member? <a href="${pageContext.request.contextPath}/auth?action=showLogin">Sign In</a></span>
                </div>
            </div>
        </div>
    </div>

    <script>
        const roleSelect = document.getElementById('roleSelect');
        const commonFields = document.getElementById('commonFields');
        const memberSpecific = document.getElementById('memberSpecific');
        const hospitalSpecific = document.getElementById('hospitalSpecific');
        
        roleSelect.addEventListener('change', function() {
            const role = this.value;
            
            if (role === '') {
                commonFields.className = 'hidden-fields';
            } else {
                commonFields.className = 'visible-fields';
                
                if (role === 'MEMBER') {
                    memberSpecific.className = 'visible-fields';
                    hospitalSpecific.className = 'hidden-fields';
                    document.getElementById('bloodType').required = true;
                    document.getElementsByName('hospitalName')[0].required = false;
                } else {
                    memberSpecific.className = 'hidden-fields';
                    hospitalSpecific.className = 'visible-fields';
                    document.getElementById('bloodType').required = false;
                    document.getElementsByName('hospitalName')[0].required = true;
                }
            }
        });
    </script>
</body>
</html>