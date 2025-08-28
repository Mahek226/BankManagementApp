<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Withdraw Funds - Banking App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }
        .card { border: none; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .btn-danger { background: linear-gradient(45deg, #ff6b6b, #ee5a24); border: none; }
        .account-card { background: linear-gradient(45deg, #f093fb 0%, #f5576c 100%); color: white; }
        .balance-card { background: linear-gradient(45deg, #4facfe 0%, #00f2fe 100%); color: white; }
    </style>
</head>
<body>
    <div class="container py-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <h2 class="text-white mb-0">
                        <i class="fas fa-minus-circle me-2"></i>Withdraw Funds
                    </h2>
                    <div>
                        <a href="customerDashboard" class="btn btn-outline-light me-2">
                            <i class="fas fa-home me-1"></i>Dashboard
                        </a>
                        <a href="account" class="btn btn-outline-light">
                            <i class="fas fa-arrow-left me-1"></i>Back to Accounts
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Flash Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Account Summary -->
        <div class="row mb-4">
            <c:forEach var="account" items="${accounts}">
                <div class="col-md-4 mb-3">
                    <div class="card account-card h-100">
                        <div class="card-body text-center">
                            <h5 class="card-title">
                                <i class="fas fa-${account.accountType == 'SAVINGS' ? 'piggy-bank' : account.accountType == 'CURRENT' ? 'university' : 'lock'} me-2"></i>
                                ${account.accountType} Account
                            </h5>
                            <p class="card-text mb-2">Account #${account.accountNumber}</p>
                            <h4 class="mb-0">₹${account.balance}</h4>
                            <small>Available Balance</small>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Withdraw Form -->
        <div class="row">
            <div class="col-lg-8 mx-auto">
                <div class="card">
                    <div class="card-header bg-danger text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-minus-circle me-2"></i>Make a Withdrawal
                        </h5>
                    </div>
                    <div class="card-body">
                        <form action="account" method="post" id="withdrawForm">
                            <input type="hidden" name="action" value="withdraw">
                            
                            <div class="mb-3">
                                <label for="accountId" class="form-label">Select Account</label>
                                <select class="form-select" id="accountId" name="accountId" required>
                                    <option value="">Choose an account...</option>
                                    <c:forEach var="account" items="${accounts}">
                                        <option value="${account.id}" data-balance="${account.balance}">
                                            ${account.accountType} - #${account.accountNumber} (₹${account.balance})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="amount" class="form-label">Amount (₹)</label>
                                <div class="input-group">
                                    <span class="input-group-text">₹</span>
                                    <input type="number" class="form-control" id="amount" name="amount" 
                                           min="1" step="0.01" required placeholder="Enter amount">
                                </div>
                                <div class="form-text">
                                    Available balance: <span id="availableBalance">₹0</span><br>
                                    <strong>Maximum withdrawable: <span id="maxWithdrawable">₹0</span></strong><br>
                                    <small class="text-info">Note: Minimum balance of ₹10,000 must be maintained</small>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">Description (Optional)</label>
                                <input type="text" class="form-control" id="description" name="description" 
                                       placeholder="e.g., ATM withdrawal, Bill payment">
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-danger btn-lg">
                                    <i class="fas fa-minus-circle me-2"></i>Withdraw Funds
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="row mt-4">
            <div class="col-12 text-center">
                <div class="btn-group" role="group">
                    <a href="deposit.jsp" class="btn btn-outline-primary">
                        <i class="fas fa-plus-circle me-1"></i>Deposit
                    </a>
                    <a href="transfer.jsp" class="btn btn-outline-primary">
                        <i class="fas fa-exchange-alt me-1"></i>Transfer
                    </a>
                    <a href="history.jsp" class="btn btn-outline-primary">
                        <i class="fas fa-history me-1"></i>History
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Update available balance when account is selected
        document.getElementById('accountId').addEventListener('change', function() {
            const selectedOption = this.options[this.selectedIndex];
            const balance = selectedOption.getAttribute('data-balance');
            const availableBalance = parseFloat(balance || 0);
            const maxWithdrawable = Math.max(0, availableBalance - 10000);
            
            document.getElementById('availableBalance').textContent = '₹' + availableBalance.toLocaleString();
            document.getElementById('maxWithdrawable').textContent = '₹' + maxWithdrawable.toLocaleString();
        });

        // Form validation
        document.getElementById('withdrawForm').addEventListener('submit', function(e) {
            const amount = parseFloat(document.getElementById('amount').value);
            const accountId = document.getElementById('accountId').value;
            const selectedOption = document.getElementById('accountId').options[document.getElementById('accountId').selectedIndex];
            const availableBalance = parseFloat(selectedOption.getAttribute('data-balance') || 0);
            const maxWithdrawable = Math.max(0, availableBalance - 10000);
            
            if (!accountId) {
                e.preventDefault();
                alert('Please select an account');
                return;
            }
            
            if (!amount || amount <= 0) {
                e.preventDefault();
                alert('Please enter a valid amount greater than 0');
                return;
            }

            if (amount > availableBalance) {
                e.preventDefault();
                alert('Insufficient funds. Available balance: ₹' + availableBalance);
                return;
            }

            if (amount > maxWithdrawable) {
                e.preventDefault();
                alert('Withdrawal amount exceeds maximum withdrawable amount. Maximum: ₹' + maxWithdrawable.toLocaleString() + 
                      ' (to maintain minimum balance of ₹10,000)');
                return;
            }
        });

        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>
</body>
</html>

