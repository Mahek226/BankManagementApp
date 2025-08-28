<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction History - Banking App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }
        .card { border: none; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .btn-info { background: linear-gradient(45deg, #4facfe, #00f2fe); border: none; }
        .account-card { background: linear-gradient(45deg, #f093fb 0%, #f5576c 100%); color: white; }
        .transaction-row:hover { background-color: #f8f9fa; }
        .amount-positive { color: #28a745; font-weight: bold; }
        .amount-negative { color: #dc3545; font-weight: bold; }
        .chart-container { position: relative; height: 300px; }
    </style>
</head>
<body>
    <div class="container py-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <h2 class="text-white mb-0">
                        <i class="fas fa-history me-2"></i>Transaction History
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
                            <small>Current Balance</small>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Transaction Analytics -->
        <div class="row mb-4">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header bg-info text-white">
                        <h6 class="mb-0">
                            <i class="fas fa-chart-pie me-2"></i>Transaction Types Distribution
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="chart-container">
                            <canvas id="transactionTypeChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h6 class="mb-0">
                            <i class="fas fa-chart-line me-2"></i>Monthly Transaction Summary
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="chart-container">
                            <canvas id="monthlyChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Transaction History Table -->
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-list me-2"></i>Transaction History
                        </h5>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty transactionsDetailed}">
                            <p class="text-muted text-center">No transactions found.</p>
                        </c:if>
                        <c:if test="${not empty transactionsDetailed}">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>Date</th>
                                            <th>Type</th>
                                            <th>Amount</th>
                                            <th>Status</th>
                                            <th>Description</th>
                                            <th>From Account</th>
                                            <th>To Account</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="transaction" items="${transactionsDetailed}">
                                            <tr class="transaction-row">
                                                <td>
                                                    <i class="fas fa-calendar me-1"></i>
                                                    ${transaction.transactionDate}
                                                </td>
                                                <td>
                                                    <span class="badge bg-${transaction.transactionType == 'DEPOSIT' ? 'success' : 
                                                                         transaction.transactionType == 'WITHDRAWAL' ? 'danger' : 'info'}">
                                                        ${transaction.transactionType}
                                                    </span>
                                                </td>
                                                <td class="${transaction.transactionType == 'DEPOSIT' ? 'amount-positive' : 'amount-negative'}">
                                                    <c:if test="${transaction.transactionType == 'WITHDRAWAL'}">-</c:if>
                                                    ₹${transaction.amount}
                                                </td>
                                                <td>
                                                    <span class="badge bg-${transaction.status == 'COMPLETED' ? 'success' : 
                                                                         transaction.status == 'PENDING' ? 'warning' : 'danger'}">
                                                        ${transaction.status}
                                                    </span>
                                                </td>
                                                <td>
                                                    <i class="fas fa-info-circle me-1"></i>
                                                    ${transaction.description}
                                                </td>
                                                <td>
                                                    <c:if test="${not empty transaction.fromAccountNumber}">
                                                        <div>
                                                            <strong>#${transaction.fromAccountNumber}</strong>
                                                            <br>
                                                            <small class="text-muted">${transaction.fromAccountType}</small>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${empty transaction.fromAccountNumber}">
                                                        <span class="text-muted">-</span>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${not empty transaction.toAccountNumber}">
                                                        <div>
                                                            <strong>#${transaction.toAccountNumber}</strong>
                                                            <br>
                                                            <small class="text-muted">${transaction.toAccountType}</small>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${empty transaction.toAccountNumber}">
                                                        <span class="text-muted">-</span>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>
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
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Transaction Type Distribution Chart
        const transactionTypeCtx = document.getElementById('transactionTypeChart').getContext('2d');
        const transactionTypeChart = new Chart(transactionTypeCtx, {
            type: 'doughnut',
            data: {
                labels: ['Deposits', 'Withdrawals', 'Transfers'],
                datasets: [{
                    data: [
                        ${transactionsDetailed.stream().filter(t -> t.transactionType == 'DEPOSIT').count()},
                        ${transactionsDetailed.stream().filter(t -> t.transactionType == 'WITHDRAWAL').count()},
                        ${transactionsDetailed.stream().filter(t -> t.transactionType == 'TRANSFER').count()}
                    ],
                    backgroundColor: [
                        '#28a745',
                        '#dc3545',
                        '#17a2b8'
                    ],
                    borderWidth: 2,
                    borderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            color: '#495057',
                            font: {
                                size: 12
                            }
                        }
                    }
                }
            }
        });

        // Monthly Transaction Chart
        const monthlyCtx = document.getElementById('monthlyChart').getContext('2d');
        
        // Group transactions by month
        const monthlyData = {};
        <c:forEach var="transaction" items="${transactionsDetailed}">
            const month = '${transaction.transactionDate}'.substring(0, 7); // YYYY-MM
            if (!monthlyData[month]) {
                monthlyData[month] = { deposits: 0, withdrawals: 0, transfers: 0 };
            }
            if ('${transaction.transactionType}' === 'DEPOSIT') {
                monthlyData[month].deposits += ${transaction.amount};
            } else if ('${transaction.transactionType}' === 'WITHDRAWAL') {
                monthlyData[month].withdrawals += ${transaction.amount};
            } else if ('${transaction.transactionType}' === 'TRANSFER') {
                monthlyData[month].transfers += ${transaction.amount};
            }
        </c:forEach>

        const months = Object.keys(monthlyData).sort();
        const monthlyChart = new Chart(monthlyCtx, {
            type: 'bar',
            data: {
                labels: months.map(m => {
                    const date = new Date(m + '-01');
                    return date.toLocaleDateString('en-US', { month: 'short', year: 'numeric' });
                }),
                datasets: [{
                    label: 'Deposits',
                    data: months.map(m => monthlyData[m].deposits),
                    backgroundColor: '#28a745',
                    borderColor: '#28a745',
                    borderWidth: 1
                }, {
                    label: 'Withdrawals',
                    data: months.map(m => monthlyData[m].withdrawals),
                    backgroundColor: '#dc3545',
                    borderColor: '#dc3545',
                    borderWidth: 1
                }, {
                    label: 'Transfers',
                    data: months.map(m => monthlyData[m].transfers),
                    backgroundColor: '#17a2b8',
                    borderColor: '#17a2b8',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return '₹' + value.toLocaleString();
                            }
                        }
                    }
                },
                plugins: {
                    legend: {
                        position: 'top',
                        labels: {
                            color: '#495057'
                        }
                    }
                }
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

