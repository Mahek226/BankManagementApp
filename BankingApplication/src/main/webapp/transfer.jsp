<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transfer Funds - Banking App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }
        .card { border: none; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .btn-success { background: linear-gradient(45deg, #56ab2f, #a8e6cf); border: none; }
        .account-card { background: linear-gradient(45deg, #f093fb 0%, #f5576c 100%); color: white; }
        .beneficiary-card { background: linear-gradient(45deg, #4facfe 0%, #00f2fe 100%); color: white; }
        .nav-tabs .nav-link { color: #6c757d; }
        .nav-tabs .nav-link.active { color: #495057; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container py-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <h2 class="text-white mb-0">
                        <i class="fas fa-exchange-alt me-2"></i>Transfer Funds
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

        <!-- Transfer Options Tabs -->
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <ul class="nav nav-tabs card-header-tabs" id="transferTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="own-tab" data-bs-toggle="tab" data-bs-target="#own" type="button" role="tab">
                                    <i class="fas fa-exchange-alt me-2"></i>Own Accounts
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="beneficiary-tab" data-bs-toggle="tab" data-bs-target="#beneficiary" type="button" role="tab">
                                    <i class="fas fa-user-friends me-2"></i>Beneficiary Transfer
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="manage-tab" data-bs-toggle="tab" data-bs-target="#manage" type="button" role="tab">
                                    <i class="fas fa-cog me-2"></i>Manage Beneficiaries
                                </button>
                            </li>
                        </ul>
                    </div>
                    <div class="card-body">
                        <div class="tab-content" id="transferTabContent">
                            <!-- Own Accounts Transfer -->
                            <div class="tab-pane fade show active" id="own" role="tabpanel">
                                <form action="account" method="post" id="ownTransferForm">
                                    <input type="hidden" name="action" value="transfer">
                                    <input type="hidden" name="transferType" value="own">
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="fromAccountId" class="form-label">From Account</label>
                                                <select class="form-select" id="fromAccountId" name="fromAccountId" required>
                                                    <option value="">Choose source account...</option>
                                                    <c:forEach var="account" items="${accounts}">
                                                        <option value="${account.id}" data-balance="${account.balance}">
                                                            ${account.accountType} - #${account.accountNumber} (₹${account.balance})
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="toAccountId" class="form-label">To Account</label>
                                                <select class="form-select" id="toAccountId" name="toAccountId" required>
                                                    <option value="">Choose destination account...</option>
                                                    <c:forEach var="account" items="${accounts}">
                                                        <option value="${account.id}">
                                                            ${account.accountType} - #${account.accountNumber} (₹${account.balance})
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
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
                                            <strong>Maximum transferable: <span id="maxTransferable">₹0</span></strong><br>
                                            <small class="text-info">Note: Minimum balance of ₹10,000 must be maintained</small>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description (Optional)</label>
                                        <input type="text" class="form-control" id="description" name="description" 
                                               placeholder="e.g., Transfer to savings">
                                    </div>

                                    <div class="d-grid">
                                        <button type="submit" class="btn btn-success btn-lg">
                                            <i class="fas fa-exchange-alt me-2"></i>Transfer Between Own Accounts
                                        </button>
                                    </div>
                                </form>
                            </div>

                            <!-- Beneficiary Transfer -->
                            <div class="tab-pane fade" id="beneficiary" role="tabpanel">
                                <form action="account" method="post" id="beneficiaryTransferForm">
                                    <input type="hidden" name="action" value="transfer">
                                    <input type="hidden" name="transferType" value="beneficiary">
                                    
                                    <div class="mb-3">
                                        <label for="fromAccountId2" class="form-label">From Account</label>
                                        <select class="form-select" id="fromAccountId2" name="fromAccountId" required>
                                            <option value="">Choose source account...</option>
                                            <c:forEach var="account" items="${accounts}">
                                                <option value="${account.id}" data-balance="${account.balance}">
                                                    ${account.accountType} - #${account.accountNumber} (₹${account.balance})
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="beneficiaryId" class="form-label">To Beneficiary</label>
                                        <select class="form-select" id="beneficiaryId" name="beneficiaryId" required>
                                            <option value="">Choose beneficiary...</option>
                                            <c:forEach var="beneficiary" items="${beneficiaries}">
                                                <option value="${beneficiary.id}">
                                                    ${beneficiary.nickname} - #${beneficiary.beneficiaryAccountNumber}
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <div class="form-text">
                                            <c:if test="${empty beneficiaries}">
                                                <span class="text-warning">No beneficiaries added yet. Add beneficiaries in the "Manage Beneficiaries" tab.</span>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="amount2" class="form-label">Amount (₹)</label>
                                        <div class="input-group">
                                            <span class="input-group-text">₹</span>
                                            <input type="number" class="form-control" id="amount2" name="amount" 
                                                   min="1" step="0.01" required placeholder="Enter amount">
                                        </div>
                                        <div class="form-text">
                                            Available balance: <span id="availableBalance2">₹0</span><br>
                                            <strong>Maximum transferable: <span id="maxTransferable2">₹0</span></strong><br>
                                            <small class="text-info">Note: Minimum balance of ₹10,000 must be maintained</small>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="description2" class="form-label">Description (Optional)</label>
                                        <input type="text" class="form-control" id="description2" name="description" 
                                               placeholder="e.g., Payment to friend">
                                    </div>

                                    <div class="d-grid">
                                        <button type="submit" class="btn btn-success btn-lg" ${empty beneficiaries ? 'disabled' : ''}>
                                            <i class="fas fa-user-friends me-2"></i>Transfer to Beneficiary
                                        </button>
                                    </div>
                                </form>
                            </div>

                            <!-- Manage Beneficiaries -->
                            <div class="tab-pane fade" id="manage" role="tabpanel">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="card">
                                            <div class="card-header bg-primary text-white">
                                                <h6 class="mb-0">
                                                    <i class="fas fa-plus-circle me-2"></i>Add New Beneficiary
                                                </h6>
                                            </div>
                                            <div class="card-body">
                                                <form action="account" method="post" id="addBeneficiaryForm">
                                                    <input type="hidden" name="action" value="addBeneficiary">
                                                    
                                                    <div class="mb-3">
                                                        <label for="beneficiaryAccountNumber" class="form-label">Account Number</label>
                                                        <input type="text" class="form-control" id="beneficiaryAccountNumber" 
                                                               name="beneficiaryAccountNumber" required placeholder="Enter account number">
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="nickname" class="form-label">Nickname</label>
                                                        <input type="text" class="form-control" id="nickname" 
                                                               name="nickname" required placeholder="e.g., John's Account">
                                                    </div>

                                                    <div class="d-grid">
                                                        <button type="submit" class="btn btn-primary">
                                                            <i class="fas fa-plus-circle me-2"></i>Add Beneficiary
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="card">
                                            <div class="card-header bg-danger text-white">
                                                <h6 class="mb-0">
                                                    <i class="fas fa-trash me-2"></i>Remove Beneficiary
                                                </h6>
                                            </div>
                                            <div class="card-body">
                                                <form action="account" method="post" id="removeBeneficiaryForm">
                                                    <input type="hidden" name="action" value="removeBeneficiary">
                                                    
                                                    <div class="mb-3">
                                                        <label for="removeBeneficiaryId" class="form-label">Select Beneficiary</label>
                                                        <select class="form-select" id="removeBeneficiaryId" name="beneficiaryId" required>
                                                            <option value="">Choose beneficiary to remove...</option>
                                                            <c:forEach var="beneficiary" items="${beneficiaries}">
                                                                <option value="${beneficiary.id}">
                                                                    ${beneficiary.nickname} - #${beneficiary.beneficiaryAccountNumber}
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>

                                                    <div class="d-grid">
                                                        <button type="submit" class="btn btn-danger" ${empty beneficiaries ? 'disabled' : ''}>
                                                            <i class="fas fa-trash me-2"></i>Remove Beneficiary
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Current Beneficiaries List -->
                                <div class="row mt-4">
                                    <div class="col-12">
                                        <div class="card">
                                            <div class="card-header bg-info text-white">
                                                <h6 class="mb-0">
                                                    <i class="fas fa-list me-2"></i>Current Beneficiaries
                                                </h6>
                                            </div>
                                            <div class="card-body">
                                                <c:if test="${empty beneficiaries}">
                                                    <p class="text-muted text-center">No beneficiaries added yet.</p>
                                                </c:if>
                                                <c:if test="${not empty beneficiaries}">
                                                    <div class="row">
                                                        <c:forEach var="beneficiary" items="${beneficiaries}">
                                                            <div class="col-md-4 mb-3">
                                                                <div class="card beneficiary-card">
                                                                    <div class="card-body text-center">
                                                                        <h6 class="card-title">${beneficiary.nickname}</h6>
                                                                        <p class="card-text mb-1">Account #${beneficiary.beneficiaryAccountNumber}</p>
                                                                        <small>Added on ${beneficiary.createdAt}</small>
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
        function updateBalance(selectId, balanceSpanId, maxSpanId) {
            const select = document.getElementById(selectId);
            const balanceSpan = document.getElementById(balanceSpanId);
            const maxSpan = document.getElementById(maxSpanId);
            if (select && balanceSpan && maxSpan) {
                select.addEventListener('change', function() {
                    const selectedOption = this.options[this.selectedIndex];
                    const balance = parseFloat(selectedOption.getAttribute('data-balance') || 0);
                    const maxTransferable = Math.max(0, balance - 10000);
                    
                    balanceSpan.textContent = '₹' + balance.toLocaleString();
                    maxSpan.textContent = '₹' + maxTransferable.toLocaleString();
                });
            }
        }

        updateBalance('fromAccountId', 'availableBalance', 'maxTransferable');
        updateBalance('fromAccountId2', 'availableBalance2', 'maxTransferable2');

        // Form validations
        document.getElementById('ownTransferForm').addEventListener('submit', function(e) {
            const fromAccount = document.getElementById('fromAccountId').value;
            const toAccount = document.getElementById('toAccountId').value;
            const amount = parseFloat(document.getElementById('amount').value);
            const selectedOption = document.getElementById('fromAccountId').options[document.getElementById('fromAccountId').selectedIndex];
            const availableBalance = parseFloat(selectedOption.getAttribute('data-balance') || 0);
            const maxTransferable = Math.max(0, availableBalance - 10000);
            
            if (fromAccount === toAccount) {
                e.preventDefault();
                alert('Source and destination accounts cannot be the same');
                return;
            }
            
            if (!fromAccount || !toAccount) {
                e.preventDefault();
                alert('Please select both source and destination accounts');
                return;
            }
            
            if (!amount || amount <= 0) {
                e.preventDefault();
                alert('Please enter a valid amount greater than 0');
                return;
            }

            if (amount > maxTransferable) {
                e.preventDefault();
                alert('Transfer amount exceeds maximum transferable amount. Maximum: ₹' + maxTransferable.toLocaleString() + 
                      ' (to maintain minimum balance of ₹10,000)');
                return;
            }
        });

        document.getElementById('beneficiaryTransferForm').addEventListener('submit', function(e) {
            const fromAccount = document.getElementById('fromAccountId2').value;
            const beneficiary = document.getElementById('beneficiaryId').value;
            const amount = parseFloat(document.getElementById('amount2').value);
            const selectedOption = document.getElementById('fromAccountId2').options[document.getElementById('fromAccountId2').selectedIndex];
            const availableBalance = parseFloat(selectedOption.getAttribute('data-balance') || 0);
            const maxTransferable = Math.max(0, availableBalance - 10000);
            
            if (!fromAccount || !beneficiary) {
                e.preventDefault();
                alert('Please select both source account and beneficiary');
                return;
            }
            
            if (!amount || amount <= 0) {
                e.preventDefault();
                alert('Please enter a valid amount greater than 0');
                return;
            }

            if (amount > maxTransferable) {
                e.preventDefault();
                alert('Transfer amount exceeds maximum transferable amount. Maximum: ₹' + maxTransferable.toLocaleString() + 
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

