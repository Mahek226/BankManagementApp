<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - Banking Application</title>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background:#f5f7fa; color:#333; }
        .header { background:linear-gradient(135deg,#667eea 0%,#764ba2 100%); color:#fff; padding:20px 0; box-shadow:0 2px 10px rgba(0,0,0,0.1); }
        .header-content { max-width:1200px; margin:0 auto; display:flex; justify-content:space-between; align-items:center; padding:0 20px; }
        .logo { font-size:1.8em; font-weight:bold; }
        .nav-links { display:flex; gap:20px; }
        .nav-link { color:#fff; text-decoration:none; padding:8px 16px; border-radius:5px; transition:background 0.3s ease; }
        .nav-link:hover { background:rgba(255,255,255,0.2); }
        .container { max-width:800px; margin:20px auto; padding:20px; }
        .section { background:#fff; padding:25px; border-radius:10px; box-shadow:0 2px 10px rgba(0,0,0,0.05); }
        .section h3 { margin-bottom:20px; }
        .form-group { margin-bottom:15px; }
        .form-group label { display:block; margin-bottom:8px; font-weight:500; }
        .form-group input { width:100%; padding:12px 15px; border:2px solid #e1e5e9; border-radius:8px; font-size:16px; }
        .btn { background:linear-gradient(135deg,#667eea 0%,#764ba2 100%); color:#fff; padding:12px 24px; border:none; border-radius:8px; font-weight:600; cursor:pointer; }
        .message { padding:15px; border-radius:5px; margin: 15px 0; }
        .success-message { background:#d4edda; color:#155724; border:1px solid #c3e6cb; }
        .error-message { background:#f8d7da; color:#721c24; border:1px solid #f5c6cb; }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <div class="logo">🏦 Banking Application</div>
            <div class="nav-links">
                <a href="customerDashboard.jsp" class="nav-link">Dashboard</a>
                <a href="account" class="nav-link">Accounts</a>
                <a href="profile" class="nav-link">Profile</a>
                <a href="logout" class="nav-link">Logout</a>
            </div>
        </div>
    </div>

    <div class="container">
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="message success-message">${sessionScope.successMessage}</div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="message error-message">${sessionScope.errorMessage}</div>
            <c:remove var="errorMessage" scope="session"/>
        </c:if>

        <div class="section">
            <h3>Update Profile</h3>
            <form action="profile" method="post" onsubmit="return validateProfile()">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="fullName" id="fullName" value="${user.fullName}" required>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" id="email" value="${user.email}" required>
                </div>
                <div class="form-group">
                    <label>Phone</label>
                    <input type="tel" name="phone" id="phone" value="${user.phone}" required>
                </div>
                <div class="form-group">
                    <label>Address</label>
                    <input type="text" name="address" id="address" value="${user.address}" required>
                </div>
                <button type="submit" class="btn">Save Changes</button>
            </form>
        </div>
    </div>

    <script>
        setTimeout(function(){
            var messages=document.querySelectorAll('.message');
            messages.forEach(function(m){m.style.display='none';});
        },5000);

        function validateProfile(){
            var fullName=document.getElementById('fullName').value.trim();
            var email=document.getElementById('email').value.trim();
            var phone=document.getElementById('phone').value.trim();
            var address=document.getElementById('address').value.trim();
            if(fullName.length<2){alert('Full name must be at least 2 characters');return false;}
            if(email.indexOf('@')===-1){alert('Enter a valid email');return false;}
            if(phone.length<10){alert('Enter a valid phone');return false;}
            if(address.length<5){alert('Address must be at least 5 characters');return false;}
            return true;
        }
    </script>
</body>
</html>


