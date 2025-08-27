<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Banking Application - Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .login-container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        
        .logo {
            font-size: 2.5em;
            color: #667eea;
            margin-bottom: 20px;
            font-weight: bold;
        }
        
        .subtitle {
            color: #666;
            margin-bottom: 30px;
            font-size: 1.1em;
        }
        
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }
        
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .login-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease;
        }
        
        .login-btn:hover {
            transform: translateY(-2px);
        }
        
        .error-message {
            background: #ff6b6b;
            color: white;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        
        .success-message {
            background: #51cf66;
            color: white;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        
        .footer {
            margin-top: 30px;
            color: #666;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo">🏦</div>
        <h1>Welcome Back</h1>
        <p class="subtitle">Sign in to your banking account</p>
        
        <c:if test="${not empty errorMessage}">
            <div class="error-message">
                ${errorMessage}
            </div>
        </c:if>
        
        <c:if test="${not empty successMessage}">
            <div class="success-message">
                ${successMessage}
            </div>
        </c:if>
        
        <form name="loginForm" action="login" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <button type="submit" class="login-btn">Sign In</button>
        </form>
        
        <div class="register-link" style="margin-top: 20px; text-align: center;">
            <p style="color: #666; margin-bottom: 10px;">Don't have an account?</p>
            <a href="register.jsp" style="color: #667eea; text-decoration: none; font-weight: 500; padding: 8px 16px; border: 2px solid #667eea; border-radius: 6px; transition: all 0.3s ease;">Sign Up</a>
        </div>
        
        <div class="footer">
            <p>Secure Banking Application</p>
            <p>&copy; 2024 All rights reserved</p>
        </div>
    </div>

    <script>
        function validateForm() {
            var username = document.forms["loginForm"]["username"].value;
            var password = document.forms["loginForm"]["password"].value;
            
            if (username.trim() == "") {
                alert("Please enter username");
                return false;
            }
            
            if (password.trim() == "") {
                alert("Please enter password");
                return false;
            }
            
            return true;
        }
        
        // Auto-hide messages after 5 seconds
        setTimeout(function() {
            var errorMsg = document.querySelector('.error-message');
            var successMsg = document.querySelector('.success-message');
            
            if (errorMsg) {
                errorMsg.style.display = 'none';
            }
            
            if (successMsg) {
                successMsg.style.display = 'none';
            }
        }, 5000);
    </script>
</body>
</html>
