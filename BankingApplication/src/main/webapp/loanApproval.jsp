<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loan Approval - Banking Application</title>
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
        
        .loans-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .loan-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            border: 2px solid #e1e5e9;
            transition: border-color 0.3s ease;
        }
        
        .loan-card:hover {
            border-color: #667eea;
        }
        
        .loan-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .loan-id {
            font-size: 1.3em;
            font-weight: bold;
            color: #667eea;
        }
        
        .loan-status {
            padding: 6px 16px;
            border-radius: 25px;
            font-size: 0.9em;
            font-weight: 600;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }
        
        .loan-amount {
            font-size: 1.8em;
            font-weight: bold;
            color: #28a745;
            text-align: center;
            margin: 20px 0;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 10px;
        }
        
        .loan-details {
            margin-bottom: 20px;
        }
        
        .loan-detail {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
            padding: 8px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .loan-detail:last-child {
            border-bottom: none;
        }
        
        .detail-label {
            font-weight: 500;
            color: #666;
        }
        
        .detail-value {
            color: #333;
            font-weight: 600;
        }
        
        .loan-purpose {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin: 20px 0;
        }
        
        .purpose-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
            font-size: 1.1em;
        }
        
        .purpose-text {
            color: #555;
            line-height: 1.6;
            font-size: 1em;
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        
        .btn-approve {
            background: #28a745;
            color: white;
        }
        
        .btn-reject {
            background: #dc3545;
            color: white;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        
        .no-loans {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 1.1em;
        }
        
        .stats-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .stat-number {
            font-size: 2em;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: #666;
            font-size: 0.9em;
        }
        
        @media (max-width: 768px) {
            .loans-grid {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .nav-links {
                flex-direction: column;
                gap: 10px;
            }
            
            .stats-summary {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <div class="logo">🏦 Banking Application - Admin</div>
            <div class="nav-links">
                <a href="adminDashboard.jsp" class="nav-link">Dashboard</a>
                <a href="userManagement" class="nav-link">Users</a>
                <a href="loan" class="nav-link">Loans</a>
                <a href="logout" class="nav-link">Logout</a>
            </div>
        </div>
    </div>

    <div class="container">
        <h1 class="page-title">Loan Approval Management</h1>
        
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

        <!-- Statistics Summary -->
        <div class="stats-summary">
            <div class="stat-card">
                <div class="stat-number">${not empty pendingLoans ? pendingLoans.size() : 0}</div>
                <div class="stat-label">Pending Loans</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">25</div>
                <div class="stat-label">Total Applications</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">18</div>
                <div class="stat-label">Approved Today</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">3</div>
                <div class="stat-label">Rejected Today</div>
            </div>
        </div>

        <!-- Pending Loans Section -->
        <div class="section">
            <h3>Pending Loan Applications</h3>
            <c:choose>
                <c:when test="${empty pendingLoans}">
                    <div class="no-loans">
                        <p>🎉 No pending loan applications at the moment!</p>
                        <p>All loan applications have been processed.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="loans-grid">
                        <c:forEach var="loan" items="${pendingLoans}">
                            <div class="loan-card">
                                <div class="loan-header">
                                    <span class="loan-id">Loan #${loan.id}</span>
                                    <span class="loan-status status-${loan.status.toLowerCase()}">${loan.status}</span>
                                </div>
                                
                                <div class="loan-amount">
                                    $<fmt:formatNumber value="${loan.amount}" pattern="#,##0.00"/>
                                </div>
                                
                                <div class="loan-details">
                                    <div class="loan-detail">
                                        <span class="detail-label">Loan Type:</span>
                                        <span class="detail-value">${loan.loanType}</span>
                                    </div>
                                    <div class="loan-detail">
                                        <span class="detail-label">Interest Rate:</span>
                                        <span class="detail-value">${loan.interestRate}%</span>
                                    </div>
                                    <div class="loan-detail">
                                        <span class="detail-label">Term:</span>
                                        <span class="detail-value">${loan.termMonths} months</span>
                                    </div>
                                    <div class="loan-detail">
                                        <span class="detail-label">Application Date:</span>
                                        <span class="detail-value">
                                            <fmt:formatDate value="${loan.applicationDate}" pattern="MMM dd, yyyy 'at' HH:mm"/>
                                        </span>
                                    </div>
                                    <div class="loan-detail">
                                        <span class="detail-label">Customer ID:</span>
                                        <span class="detail-value">${loan.userId}</span>
                                    </div>
                                </div>
                                
                                <div class="loan-purpose">
                                    <div class="purpose-label">Loan Purpose:</div>
                                    <div class="purpose-text">${loan.purpose}</div>
                                </div>
                                
                                <div class="action-buttons">
                                    <form action="loan" method="post" style="flex: 1;">
                                        <input type="hidden" name="action" value="approve">
                                        <input type="hidden" name="loanId" value="${loan.id}">
                                        <button type="submit" class="btn btn-approve" onclick="return confirm('Are you sure you want to approve this loan?')">
                                            ✅ Approve Loan
                                        </button>
                                    </form>
                                    
                                    <form action="loan" method="post" style="flex: 1;">
                                        <input type="hidden" name="action" value="reject">
                                        <input type="hidden" name="loanId" value="${loan.id}">
                                        <button type="submit" class="btn btn-reject" onclick="return confirm('Are you sure you want to reject this loan?')">
                                            ❌ Reject Loan
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
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
        
        // Confirmation for loan actions
        function confirmAction(action) {
            var message = action === 'approve' ? 
                'Are you sure you want to approve this loan application?' : 
                'Are you sure you want to reject this loan application?';
            
            return confirm(message);
        }
        
        // Add confirmation to all action buttons
        document.addEventListener('DOMContentLoaded', function() {
            var approveButtons = document.querySelectorAll('button[type="submit"]');
            approveButtons.forEach(function(button) {
                if (button.classList.contains('btn-approve')) {
                    button.onclick = function() {
                        return confirmAction('approve');
                    };
                } else if (button.classList.contains('btn-reject')) {
                    button.onclick = function() {
                        return confirmAction('reject');
                    };
                }
            });
        });
    </script>
</body>
</html>
