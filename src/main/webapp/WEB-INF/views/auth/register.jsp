<%-- WEB-INF/views/auth/register.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>OrganLink Nepal - Register</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
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
                <h1>Be the Reason <br> for a Smile in Nepal.</h1>
                <p>Registration is the first step towards a legacy of life in our community. Choose your role and join our mission today.</p>
            </div>
        </div>

        <div class="auth-form-side">
            <div class="auth-card" style="max-width: 500px;">
                <div class="auth-logo">
                    <i class="fa fa-heartbeat"></i> OrganLink Nepal
                </div>

                <h2>Create Your Account</h2>
                <p class="auth-welcome-text">Start your journey with us.</p>

                <c:if test="${not empty param.error}">
                    <div id="formAlert" class="alert alert-danger" style="margin-bottom: 24px;">
                        <c:choose>
                            <c:when test="${param.error == 'fullName'}">Full name is required.</c:when>
                            <c:when test="${param.error == 'fullNameDigit'}">Full name must not contain digits.</c:when>
                            <c:when test="${param.error == 'username'}">Username is already taken.</c:when>
                            <c:when test="${param.error == 'emailDuplicate'}">Email is already registered.</c:when>
                            <c:when test="${param.error == 'phoneDuplicate'}">Phone number already exists.</c:when>
                            <c:when test="${param.error == 'phone'}">Phone must be 10 digits.</c:when>
                            <c:when test="${param.error == 'email'}">Enter valid email.</c:when>
                            <c:otherwise>Please correct the errors and try again.</c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
                <c:if test="${empty param.error}">
                    <div id="formAlert" class="alert alert-danger" style="display: none; margin-bottom: 24px;"></div>
                </c:if>
                
                <c:if test="${param.msg == 'registered'}">
                    <div class="alert alert-success" style="margin-bottom: 24px; background: #e8f5e9; color: #2e7d32;">Registration successful! Please login.</div>
                </c:if>

                <form method="post" action="${pageContext.request.contextPath}/register" id="regForm">
                    
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
                    <span>Already a member? <a href="${pageContext.request.contextPath}/login">Sign In</a></span>
                </div>
            </div>
        </div>
    </div>

    <script>
        function showToast(message, type = 'info') {
            let container = document.querySelector('.toast-container');
            if (!container) {
                container = document.createElement('div');
                container.className = 'toast-container';
                document.body.appendChild(container);
            }
            const toast = document.createElement('div');
            toast.className = `toast ${type}`;
            toast.innerHTML = `<div class="toast-message">${message}</div>`;
            container.appendChild(toast);
            setTimeout(() => {
                toast.style.opacity = '0';
                toast.style.transform = 'translateX(20px)';
                setTimeout(() => toast.remove(), 300);
            }, 4000);
        }

        window.onload = function() {
            const error = '${param.error}';
            if (error) {
                let msg = 'Please correct the errors and try again.';
                if (error === 'fullName') msg = 'Full name is required.';
                else if (error === 'fullNameDigit') msg = 'Full Name must not contain digits.';
                else if (error === 'username') msg = 'Username is already taken.';
                else if (error === 'emailDuplicate') msg = 'Email is already registered.';
                else if (error === 'phoneDuplicate') msg = 'Phone number already exists.';
                else if (error === 'phone') msg = 'Phone number must be exactly 10 digits.';
                else if (error === 'email') msg = 'Enter valid email.';
                
                showToast(msg, 'error');
            }
            
            const msgParam = '${param.msg}';
            if (msgParam === 'registered') {
                showToast('Registration successful! Please login.', 'success');
            }
        };

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

        // Form Validation
        const regForm = document.getElementById('regForm');
        regForm.addEventListener('submit', function(e) {
            const fullName = document.getElementsByName('fullName')[0].value;
            const email = document.getElementsByName('email')[0].value;
            const phone = document.getElementsByName('phone')[0].value;
            
            function showError(msg) {
                const alertDiv = document.getElementById('formAlert');
                if (alertDiv) {
                    alertDiv.style.display = 'block';
                    alertDiv.innerText = msg;
                }
            }

            // Name validation (no digits)
            if (/\d/.test(fullName)) {
                showError('Full Name must not contain digits.');
                e.preventDefault();
                return;
            }

            // Email validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                showError('Enter valid email.');
                e.preventDefault();
                return;
            }

            // Phone validation (exactly 10 digits)
            const phoneRegex = /^\d{10}$/;
            if (!phoneRegex.test(phone)) {
                showError('Phone number must be exactly 10 digits.');
                e.preventDefault();
                return;
            }
        });
    </script>
</body>
</html>