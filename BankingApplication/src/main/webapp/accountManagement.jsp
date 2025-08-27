<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    // Check if user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get user role
    String userRole = (String) session.getAttribute("userRole");
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Management - Banking Application</title>
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
        
        .nav-links {
            display: flex;
            gap: 20px;
        }
        
        .nav-link {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 5px;
            transition: background 0.3s ease;
        }
        
        .nav-link:hover {
            background: rgba(255,255,255,0.2);
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .page-title {
            font-size: 2em;
            color: #333;
            margin-bottom: 30px;
            text-align: center;
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
        
        .section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .section h3 {
            color: #333;
            margin-bottom: 20px;
            font-size: 1.4em;
        }
        
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }
        
        .form-group input, .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }
        
        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease;
        }
        
        .btn:hover {
            transform: translateY(-2px);
        }
        
        .btn-secondary {
            background: #6c757d;
        }
        
        .accounts-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .account-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            border: 2px solid #e1e5e9;
            transition: border-color 0.3s ease;
        }
        
        .account-card:hover {
            border-color: #667eea;
        }
        
        .account-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .account-number {
            font-size: 1.2em;
            font-weight: bold;
            color: #667eea;
        }
        
        .account-type {
            background: #e9ecef;
            color: #495057;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.9em;
        }
        
        .account-balance {
            font-size: 1.5em;
            font-weight: bold;
            color: #28a745;
            margin-bottom: 10px;
        }
        
        .account-status {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 15px;
        }
        
        .transfer-form {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-top: 15px;
        }
        
        .transfer-form h4 {
            margin-bottom: 15px;
            color: #333;
        }
        
        .transfer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 15px;
        }
        
        .transfer-btn {
            background: #28a745;
            width: 100%;
        }
        
        @media (max-width: 768px) {
            .form-grid, .transfer-grid {
                grid-template-columns: 1fr;
            }
            
            .accounts-grid {
                grid-template-columns: 1fr;
            }
            
            .nav-links {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <div class="logo">🏦 Banking Application</div>
            <div class="nav-links">
                <a href="customerDashboard.jsp" class="nav-link">Dashboard</a>
                <a href="account" class="nav-link">Accounts</a>
                <a href="loan" class="nav-link">Loans</a>
                <a href="logout" class="nav-link">Logout</a>
            </div>
        </div>
    </div>

    <div class="container">
        <h1 class="page-title">Account Management</h1>
        
        <c:if test="${not empty successMessage}">
            <div class="message success-message">
                ${successMessage}
            </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="message error-message">
                ${errorMessage}
            </div>
        </c:if>

        <!-- Create New Account Section -->
        <div class="section">
            <h3>Create New Account</h3>
            <form action="account" method="post">
                <input type="hidden" name="action" value="create">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="accountType">Account Type</label>
                        <select id="accountType" name="accountType" required>
                            <option value="">Select Account Type</option>
                            <option value="SAVINGS">Savings Account</option>
                            <option value="CHECKING">Checking Account</option>
                            <option value="FIXED_DEPOSIT">Fixed Deposit</option>
                        </select>
                    </div>
                                            <div class="form-group">
                            <label for="initialBalance">Initial Balance</label>
                            <input type="number" id="initialBalance" name="initialBalance" value="10000" min="10000" step="0.01" required readonly>
                            <small style="color: #666; font-size: 0.9rem;">Fixed initial deposit amount</small>
                        </div>
                </div>
                <button type="submit" class="btn">Create Account</button>
            </form>
        </div>

        <!-- Existing Accounts Section -->
        <div class="section">
            <h3>Your Accounts</h3>
            <c:choose>
                <c:when test="${empty accounts}">
                    <p>No accounts found. Create your first account above.</p>
                </c:when>
                <c:otherwise>
                    <div class="accounts-grid">
                        <c:forEach var="account" items="${accounts}">
                            <div class="account-card">
                                <div class="account-header">
                                    <span class="account-number">${account.accountNumber}</span>
                                    <span class="account-type">${account.accountType}</span>
                                </div>
                                <div class="account-balance">
                                    $<fmt:formatNumber value="${account.balance}" pattern="#,##0.00"/>
                                </div>
                                <div class="account-status">
                                    Status: ${account.status}
                                </div>
                                
                                <!-- Transfer Form -->
                                <div class="transfer-form">
                                    <h4>Transfer Funds</h4>
                                    <form action="account" method="post">
                                        <input type="hidden" name="action" value="transfer">
                                        <input type="hidden" name="fromAccountId" value="${account.id}">
                                        <div class="transfer-grid">
                                            <div class="form-group">
                                                <label for="toAccountId">To Account ID</label>
                                                <input type="number" name="toAccountId" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="amount">Amount</label>
                                                <input type="number" name="amount" min="0.01" step="0.01" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="description">Description</label>
                                                <input type="text" name="description" placeholder="Transfer purpose">
                                            </div>
                                        </div>
                                        <button type="submit" class="btn transfer-btn">Transfer Funds</button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Admin Account Management Section -->
        <% if ("ADMIN".equals(userRole)) { %>
        <div class="section">
            <h3>Admin: Manage All Accounts</h3>
            <c:choose>
                <c:when test="${empty allAccounts}">
                    <p>No accounts found in the system.</p>
                </c:when>
                <c:otherwise>
                    <div class="accounts-grid">
                        <c:forEach var="account" items="${allAccounts}">
                            <div class="account-card">
                                <div class="account-header">
                                    <span class="account-number">${account.accountNumber}</span>
                                    <span class="account-type">${account.accountType}</span>
                                </div>
                                <div class="account-balance">
                                    $<fmt:formatNumber value="${account.balance}" pattern="#,##0.00"/>
                                </div>
                                <div class="account-status">
                                    Status: ${account.status}
                                </div>
                                <div class="account-owner">
                                    Owner ID: ${account.userId}
                                </div>
                                
                                <!-- Delete Account Form -->
                                <form action="account" method="post" style="margin-top: 15px;" onsubmit="return confirmDelete()">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="accountId" value="${account.id}">
                                    <button type="submit" class="btn btn-danger" style="background: #dc3545; width: 100%;">
                                        🗑️ Delete Account
                                    </button>
                                </form>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <% } %>
    </div>

    <script>
        function confirmDelete() {
            return confirm('Are you sure you want to delete this account? This action cannot be undone.');
        }
        
        // Auto-hide messages after 5 seconds
        // Auto-hide messages after 5 seconds
        setTimeout(function() {
            var messages = document.querySelectorAll('.message');
            messages.forEach(function(message) {
                message.style.display = 'none';
            });
        }, 5000);
        
        // Form validation
        function validateTransferForm(form) {
            var amount = form.querySelector('input[name="amount"]').value;
            var toAccountId = form.querySelector('input[name="toAccountId"]').value;
            
            if (parseFloat(amount) <= 0) {
                alert("Transfer amount must be positive!");
                return false;
            }
            
            if (toAccountId.trim() === "") {
                alert("Please enter destination account ID!");
                return false;
            }
            
            return true;
        }
        
        // Add validation to all transfer forms
        document.addEventListener('DOMContentLoaded', function() {
            var transferForms = document.querySelectorAll('form[action="account"]');
            transferForms.forEach(function(form) {
                if (form.querySelector('input[name="action"]').value === 'transfer') {
                    form.onsubmit = function() {
                        return validateTransferForm(this);
                    };
                }
            });
        });
    </script>
</body>
</html>
