<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard - Banking Application</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            color: #333;
        }
        
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }
        
        .logo {
            font-size: 1.8em;
            font-weight: bold;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .logout-btn {
            background: rgba(255,255,255,0.2);
            border: 1px solid rgba(255,255,255,0.3);
            color: white;
            padding: 8px 16px;
            border-radius: 5px;
            text-decoration: none;
            transition: background 0.3s ease;
        }
        
        .logout-btn:hover {
            background: rgba(255,255,255,0.3);
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .welcome-section {
            background: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .welcome-title {
            font-size: 2em;
            color: #667eea;
            margin-bottom: 10px;
        }
        
        .welcome-subtitle {
            color: #666;
            font-size: 1.1em;
        }
        
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .dashboard-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: transform 0.3s ease;
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
        }
        
        .card-icon {
            font-size: 3em;
            margin-bottom: 15px;
            color: #667eea;
        }
        
        .card-title {
            font-size: 1.3em;
            margin-bottom: 10px;
            color: #333;
        }
        
        .card-description {
            color: #666;
            margin-bottom: 20px;
            line-height: 1.6;
        }
        
        .card-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            transition: transform 0.2s ease;
        }
        
        .card-btn:hover {
            transform: translateY(-2px);
        }
        
        .quick-actions {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .quick-actions h3 {
            color: #333;
            margin-bottom: 20px;
            font-size: 1.4em;
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        
        .action-btn {
            background: #f8f9fa;
            border: 2px solid #e9ecef;
            color: #495057;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .action-btn:hover {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }
        
        .message {
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        
        .success-message {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .error-message {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        @media (max-width: 768px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .header-content {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <div class="logo">🏦 Banking Application</div>
            <div class="user-info">
                <span>Welcome, ${user.fullName}</span>
                <a href="logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </div>

    <div class="container">
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="message success-message">
                ${sessionScope.successMessage}
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
        
        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="message error-message">
                ${sessionScope.errorMessage}
            </div>
            <c:remove var="errorMessage" scope="session"/>
        </c:if>

        <div class="welcome-section">
            <h1 class="welcome-title">Welcome to Your Dashboard</h1>
            <p class="welcome-subtitle">Manage your accounts, apply for loans, and perform transactions all in one place.</p>
        </div>

        <div class="dashboard-grid">
            <div class="dashboard-card">
                <div class="card-icon">💳</div>
                <h3 class="card-title">Account Management</h3>
                <p class="card-description">View your account details, check balances, and manage your banking accounts.</p>
                <a href="account" class="card-btn">Manage Accounts</a>
            </div>

            <div class="dashboard-card">
                <div class="card-icon">💰</div>
                <h3 class="card-title">Fund Transfers</h3>
                <p class="card-description">Transfer funds between accounts or to other customers securely.</p>
                <a href="account" class="card-btn">Transfer Funds</a>
            </div>

            <div class="dashboard-card">
                <div class="card-icon">🏠</div>
                <h3 class="card-title">Loan Applications</h3>
                <p class="card-description">Apply for personal loans, home loans, or business loans with competitive rates.</p>
                <a href="loan" class="card-btn">Apply for Loan</a>
            </div>

            <div class="dashboard-card">
                <div class="card-icon">📊</div>
                <h3 class="card-title">Transaction History</h3>
                <p class="card-description">View detailed transaction history and statements for all your accounts.</p>
                <a href="account" class="card-btn">View History</a>
            </div>
        </div>

        <div class="quick-actions">
            <h3>Quick Actions</h3>
            <div class="action-buttons">
                <a href="account" class="action-btn">Create New Account</a>
                <a href="account" class="action-btn">Check Balance</a>
                <a href="loan" class="action-btn">Loan Status</a>
                <a href="account" class="action-btn">Update Profile</a>
            </div>
        </div>
    </div>

    <script>
        // Auto-hide messages after 5 seconds
        setTimeout(function() {
            var messages = document.querySelectorAll('.message');
            messages.forEach(function(message) {
                message.style.display = 'none';
            });
        }, 5000);
    </script>
</body>
</html>
