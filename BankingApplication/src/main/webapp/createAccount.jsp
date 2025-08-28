<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account - Banking App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }
        .card { border: none; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .btn-warning { background: linear-gradient(45deg, #ffa726, #ff9800); border: none; }
        .account-card { background: linear-gradient(45deg, #f093fb 0%, #f5576c 100%); color: white; }
        .account-type-disabled { opacity: 0.6; }
        .account-type-available { opacity: 1; }
    </style>
</head>
<body>
    <div class="container py-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <h2 class="text-white mb-0">
                        <i class="fas fa-plus-circle me-2"></i>Create New Account
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

        <!-- Current Accounts Summary -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-list me-2"></i>Your Current Accounts
                        </h5>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty accounts}">
                            <p class="text-muted text-center">No accounts found. Create your first account below.</p>
                        </c:if>
                        <c:if test="${not empty accounts}">
                            <div class="row">
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
                                                <small>Current Balance</small>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- Account Creation Form -->
        <div class="row">
            <div class="col-lg-8 mx-auto">
                <div class="card">
                    <div class="card-header bg-warning text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-plus-circle me-2"></i>Create New Account
                        </h5>
                    </div>
                    <div class="card-body">
                        <form action="account" method="post" id="createAccountForm">
                            <input type="hidden" name="action" value="createAccount">
                            
                            <div class="mb-3">
                                <label class="form-label">Select Account Type</label>
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <div class="card account-type-${accounts.stream().anyMatch(a -> a.accountType == 'SAVINGS') ? 'disabled' : 'available'} h-100">
                                            <div class="card-body text-center">
                                                <input type="radio" class="form-check-input" id="savings" name="accountType" value="SAVINGS" 
                                                       ${accounts.stream().anyMatch(a -> a.accountType == 'SAVINGS') ? 'disabled' : ''} required>
                                                <label for="savings" class="form-check-label">
                                                    <i class="fas fa-piggy-bank fa-2x text-primary mb-2"></i>
                                                    <h6>Savings Account</h6>
                                                    <small class="text-muted">Earn interest on your savings</small>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-4 mb-3">
                                        <div class="card account-type-${accounts.stream().anyMatch(a -> a.accountType == 'CURRENT') ? 'disabled' : 'available'} h-100">
                                            <div class="card-body text-center">
                                                <input type="radio" class="form-check-input" id="current" name="accountType" value="CURRENT" 
                                                       ${accounts.stream().anyMatch(a -> a.accountType == 'CURRENT') ? 'disabled' : ''} required>
                                                <label for="current" class="form-check-label">
                                                    <i class="fas fa-university fa-2x text-success mb-2"></i>
                                                    <h6>Current Account</h6>
                                                    <small class="text-muted">Unlimited transactions</small>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-4 mb-3">
                                        <div class="card account-type-${accounts.stream().anyMatch(a -> a.accountType == 'FIXED_DEPOSIT') ? 'disabled' : 'available'} h-100">
                                            <div class="card-body text-center">
                                                <input type="radio" class="form-check-input" id="fixedDeposit" name="accountType" value="FIXED_DEPOSIT" 
                                                       ${accounts.stream().anyMatch(a -> a.accountType == 'FIXED_DEPOSIT') ? 'disabled' : ''} required>
                                                <label for="fixedDeposit" class="form-check-label">
                                                    <i class="fas fa-lock fa-2x text-warning mb-2"></i>
                                                    <h6>Fixed Deposit</h6>
                                                    <small class="text-muted">Higher interest rates</small>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <c:if test="${accounts.stream().anyMatch(a -> a.accountType == 'SAVINGS') && 
                                             accounts.stream().anyMatch(a -> a.accountType == 'CURRENT') && 
                                             accounts.stream().anyMatch(a -> a.accountType == 'FIXED_DEPOSIT')}">
                                    <div class="alert alert-info">
                                        <i class="fas fa-info-circle me-2"></i>
                                        You already have all three account types. No more accounts can be created.
                                    </div>
                                </c:if>
                            </div>

                            <div class="mb-3">
                                <label for="initialBalance" class="form-label">Initial Balance (₹)</label>
                                <div class="input-group">
                                    <span class="input-group-text">₹</span>
                                    <input type="number" class="form-control" id="initialBalance" name="initialBalance" 
                                           min="10000" step="100" value="10000" required>
                                </div>
                                <div class="form-text">
                                    Minimum initial balance: ₹10,000<br>
                                    <small class="text-info">Note: All accounts must maintain a minimum balance of ₹10,000</small>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">Description (Optional)</label>
                                <input type="text" class="form-control" id="description" name="description" 
                                       placeholder="e.g., Emergency fund, Business account">
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-warning btn-lg" 
                                        ${accounts.stream().anyMatch(a -> a.accountType == 'SAVINGS') && 
                                          accounts.stream().anyMatch(a -> a.accountType == 'CURRENT') && 
                                          accounts.stream().anyMatch(a -> a.accountType == 'FIXED_DEPOSIT') ? 'disabled' : ''}>
                                    <i class="fas fa-plus-circle me-2"></i>Create Account
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Account Type Information -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-secondary text-white">
                        <h6 class="mb-0">
                            <i class="fas fa-info-circle me-2"></i>Account Types Information
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4">
                                <h6><i class="fas fa-piggy-bank text-primary me-2"></i>Savings Account</h6>
                                <ul class="list-unstyled">
                                    <li><i class="fas fa-check text-success me-1"></i>Interest earning</li>
                                    <li><i class="fas fa-check text-success me-1"></i>Limited withdrawals</li>
                                    <li><i class="fas fa-check text-success me-1"></i>Minimum balance required</li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <h6><i class="fas fa-university text-success me-2"></i>Current Account</h6>
                                <ul class="list-unstyled">
                                    <li><i class="fas fa-check text-success me-1"></i>Unlimited transactions</li>
                                    <li><i class="fas fa-check text-success me-1"></i>No interest</li>
                                    <li><i class="fas fa-check text-success me-1"></i>Business friendly</li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <h6><i class="fas fa-lock text-warning me-2"></i>Fixed Deposit</h6>
                                <ul class="list-unstyled">
                                    <li><i class="fas fa-check text-success me-1"></i>Highest interest rates</li>
                                    <li><i class="fas fa-check text-success me-1"></i>Locked period</li>
                                    <li><i class="fas fa-check text-success me-1"></i>No withdrawals until maturity</li>
                                </ul>
                            </div>
                        </div>
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
                    <a href="withdraw.jsp" class="btn btn-outline-primary">
                        <i class="fas fa-minus-circle me-1"></i>Withdraw
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
        // Form validation
        document.getElementById('createAccountForm').addEventListener('submit', function(e) {
            const accountType = document.querySelector('input[name="accountType"]:checked');
            const initialBalance = parseFloat(document.getElementById('initialBalance').value);
            
            if (!accountType) {
                e.preventDefault();
                alert('Please select an account type');
                return;
            }
            
            if (!initialBalance || initialBalance < 10000) {
                e.preventDefault();
                alert('Initial balance must be at least ₹10,000');
                return;
            }
        });

        // Update form based on available account types
        function updateFormState() {
            const savingsExists = ${accounts.stream().anyMatch(a -> a.accountType == 'SAVINGS')};
            const currentExists = ${accounts.stream().anyMatch(a -> a.accountType == 'CURRENT')};
            const fixedDepositExists = ${accounts.stream().anyMatch(a -> a.accountType == 'FIXED_DEPOSIT')};
            
            if (savingsExists && currentExists && fixedDepositExists) {
                document.getElementById('createAccountForm').style.display = 'none';
            }
        }

        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);

        // Initialize form state
        updateFormState();
    </script>
</body>
</html>


