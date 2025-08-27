<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loan Management - Banking Application</title>
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
        
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }
        
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .form-group textarea {
            resize: vertical;
            min-height: 100px;
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
        
        .loans-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .loan-card {
            background: white;
            padding: 20px;
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
            margin-bottom: 15px;
        }
        
        .loan-id {
            font-size: 1.1em;
            font-weight: bold;
            color: #667eea;
        }
        
        .loan-status {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 500;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-approved {
            background: #d4edda;
            color: #155724;
        }
        
        .status-rejected {
            background: #f8d7da;
            color: #721c24;
        }
        
        .loan-details {
            margin-bottom: 15px;
        }
        
        .loan-detail {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            padding: 5px 0;
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
        
        .loan-amount {
            font-size: 1.3em;
            font-weight: bold;
            color: #28a745;
            text-align: center;
            margin: 15px 0;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        
        .loan-purpose {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-top: 15px;
        }
        
        .purpose-label {
            font-weight: 500;
            color: #666;
            margin-bottom: 5px;
        }
        
        .purpose-text {
            color: #333;
            line-height: 1.5;
        }
        
        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .loans-grid {
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
        <h1 class="page-title">Loan Management</h1>
        
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

        <!-- Apply for New Loan Section -->
        <div class="section">
            <h3>Apply for New Loan</h3>
            <form action="loan" method="post" onsubmit="return validateLoanForm()">
                <input type="hidden" name="action" value="apply">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="loanType">Loan Type</label>
                        <select id="loanType" name="loanType" required>
                            <option value="">Select Loan Type</option>
                            <option value="PERSONAL">Personal Loan</option>
                            <option value="HOME">Home Loan</option>
                            <option value="BUSINESS">Business Loan</option>
                            <option value="EDUCATION">Education Loan</option>
                            <option value="VEHICLE">Vehicle Loan</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="amount">Loan Amount</label>
                        <input type="number" id="amount" name="amount" min="1000" step="100" required>
                    </div>
                    <div class="form-group">
                        <label for="interestRate">Interest Rate (%)</label>
                        <input type="number" id="interestRate" name="interestRate" min="1" max="25" step="0.1" value="8.5" required>
                    </div>
                    <div class="form-group">
                        <label for="termMonths">Loan Term (Months)</label>
                        <input type="number" id="termMonths" name="termMonths" min="12" max="360" step="12" value="60" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="purpose">Loan Purpose</label>
                    <textarea id="purpose" name="purpose" placeholder="Please describe the purpose of this loan..." required></textarea>
                </div>
                <button type="submit" class="btn">Submit Loan Application</button>
            </form>
        </div>

        <!-- Existing Loans Section -->
        <div class="section">
            <h3>Your Loan Applications</h3>
            <c:choose>
                <c:when test="${empty userLoans}">
                    <p>No loan applications found. Apply for your first loan above.</p>
                </c:when>
                <c:otherwise>
                    <div class="loans-grid">
                        <c:forEach var="loan" items="${userLoans}">
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
                                            <fmt:formatDate value="${loan.applicationDate}" pattern="MMM dd, yyyy"/>
                                        </span>
                                    </div>
                                    <c:if test="${not empty loan.approvalDate}">
                                        <div class="loan-detail">
                                            <span class="detail-label">Approval Date:</span>
                                            <span class="detail-value">
                                                <fmt:formatDate value="${loan.approvalDate}" pattern="MMM dd, yyyy"/>
                                            </span>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty loan.approvedBy}">
                                        <div class="loan-detail">
                                            <span class="detail-label">Approved By:</span>
                                            <span class="detail-value">${loan.approvedBy}</span>
                                        </div>
                                    </c:if>
                                </div>
                                
                                <div class="loan-purpose">
                                    <div class="purpose-label">Purpose:</div>
                                    <div class="purpose-text">${loan.purpose}</div>
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
        
        // Form validation
        function validateLoanForm() {
            var amount = document.getElementById('amount').value;
            var termMonths = document.getElementById('termMonths').value;
            var purpose = document.getElementById('purpose').value;
            
            if (parseFloat(amount) < 1000) {
                alert("Loan amount must be at least $1,000!");
                return false;
            }
            
            if (parseInt(termMonths) < 12 || parseInt(termMonths) > 360) {
                alert("Loan term must be between 12 and 360 months!");
                return false;
            }
            
            if (purpose.trim().length < 10) {
                alert("Please provide a detailed purpose (at least 10 characters)!");
                return false;
            }
            
            return true;
        }
        
        // Calculate monthly payment (for display purposes)
        function calculateMonthlyPayment() {
            var amount = parseFloat(document.getElementById('amount').value) || 0;
            var rate = parseFloat(document.getElementById('interestRate').value) || 0;
            var term = parseInt(document.getElementById('termMonths').value) || 0;
            
            if (amount > 0 && rate > 0 && term > 0) {
                var monthlyRate = rate / 100 / 12;
                var monthlyPayment = amount * (monthlyRate * Math.pow(1 + monthlyRate, term)) / (Math.pow(1 + monthlyRate, term) - 1);
                
                // You can display this somewhere if needed
                console.log("Estimated monthly payment: $" + monthlyPayment.toFixed(2));
            }
        }
        
        // Add event listeners for real-time calculation
        document.addEventListener('DOMContentLoaded', function() {
            var amountInput = document.getElementById('amount');
            var rateInput = document.getElementById('interestRate');
            var termInput = document.getElementById('termMonths');
            
            if (amountInput && rateInput && termInput) {
                amountInput.addEventListener('input', calculateMonthlyPayment);
                rateInput.addEventListener('input', calculateMonthlyPayment);
                termInput.addEventListener('input', calculateMonthlyPayment);
            }
        });
    </script>
</body>
</html>
