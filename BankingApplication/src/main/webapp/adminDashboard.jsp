<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Banking Application</title>
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
        
        .stats-section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 20px;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }
        
        .stat-item {
            text-align: center;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
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
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <div class="logo">🏦 Banking Application - Admin</div>
            <div class="user-info">
                <span>Welcome, ${user.fullName} (Admin)</span>
                <a href="logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </div>

    <div class="container">
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

        <div class="welcome-section">
            <h1 class="welcome-title">Admin Dashboard</h1>
            <p class="welcome-subtitle">Manage customers, approve loans, and monitor banking operations.</p>
        </div>

        <div class="stats-section">
            <h3>System Overview</h3>
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-number">${totalCustomers}</div>
                    <div class="stat-label">Total Customers</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">${totalAccounts}</div>
                    <div class="stat-label">Active Accounts</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">${fn:length(transactions)}</div>
                    <div class="stat-label">Total Transactions</div>
                </div>
                <div class="stat-item">
                    <a href="reports.csv" class="card-btn">Download Transactions CSV</a>
                </div>
            </div>
        </div>

        <div class="dashboard-grid">
            <div class="dashboard-card">
                <div class="card-icon">👥</div>
                <h3 class="card-title">Customer Management</h3>
                <p class="card-description">Add, edit, and manage customer accounts. View customer details and account information.</p>
                <a href="userManagement" class="card-btn">Manage Customers</a>
            </div>

            <div class="dashboard-card">
                <div class="card-icon">📝</div>
                <h3 class="card-title">Registration Approval</h3>
                <p class="card-description">Review and approve/reject new user registrations. Manage user access to the system.</p>
                <a href="registrationApproval" class="card-btn">Review Registrations</a>
            </div>

            <div class="dashboard-card">
                <div class="card-icon">🏠</div>
                <h3 class="card-title">Loan Approval</h3>
                <p class="card-description">Review and approve/reject loan applications. Manage loan processing workflow.</p>
                <a href="loan" class="card-btn">Review Loans</a>
            </div>

            <div class="dashboard-card">
                <div class="card-icon">📊</div>
                <h3 class="card-title">Reports & Analytics</h3>
                <p class="card-description">Generate reports, view transaction analytics, and monitor system performance.</p>
                <a href="reports" class="card-btn">View Reports</a>
            </div>

            <div class="dashboard-card">
                <div class="card-icon">⚙️</div>
                <h3 class="card-title">System Settings</h3>
                <p class="card-description">Configure system parameters, manage user roles, and system maintenance.</p>
                <a href="#" class="card-btn">Settings</a>
            </div>
        </div>

        <div class="quick-actions">
            <h3>Quick Actions</h3>
            <div class="action-buttons">
                <a href="userManagement" class="action-btn">Add New Customer</a>
                <a href="loan" class="action-btn">View Pending Loans</a>
                <a href="reports" class="action-btn">View Reports</a>
                <a href="#" class="action-btn">System Backup</a>
            </div>
        </div>

        <div class="stats-section" style="margin-top:20px">
            <h3>Analytics</h3>
            <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));gap:20px;margin-top:15px">
                <div style="background:#fff;padding:20px;border-radius:10px;box-shadow:0 2px 10px rgba(0,0,0,0.05)">
                    <h4 style="margin-bottom:10px;color:#333">Transactions by Type</h4>
                    <canvas id="txByType"></canvas>
                </div>
                <div style="background:#fff;padding:20px;border-radius:10px;box-shadow:0 2px 10px rgba(0,0,0,0.05)">
                    <h4 style="margin-bottom:10px;color:#333">Transactions Over Time</h4>
                    <canvas id="txOverTime"></canvas>
                </div>
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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        (function(){
            // Build data arrays from JSTL-provided transactions
            var transactions = [
                <c:forEach var="t" items="${transactions}">
                {type:'${t.transactionType}', amount: parseFloat('${t.amount}'), date:'${t.transactionDate}'}<c:if test="${!fn:contains(t, '___end___')}">,</c:if>
                </c:forEach>
            ];

            // Aggregate by type
            var typeTotals = {};
            transactions.forEach(function(tx){
                var key = tx.type || 'OTHER';
                typeTotals[key] = (typeTotals[key]||0) + (isNaN(tx.amount)?0:tx.amount);
            });
            var typeLabels = Object.keys(typeTotals);
            var typeData = typeLabels.map(function(k){return Number(typeTotals[k].toFixed(2));});

            var ctx1 = document.getElementById('txByType');
            if (ctx1) {
                new Chart(ctx1, {
                    type: 'bar',
                    data: { labels: typeLabels, datasets: [{ label: '₹ Amount', data: typeData, backgroundColor: '#667eea' }] },
                    options: { responsive: true, plugins: { legend: { display: true } }, scales: { y: { beginAtZero: true } } }
                });
            }

            // Aggregate by month (YYYY-MM)
            var monthTotals = {};
            transactions.forEach(function(tx){
                var d = new Date(tx.date);
                if (isNaN(d)) return;
                var key = d.getFullYear() + '-' + String(d.getMonth()+1).padStart(2,'0');
                monthTotals[key] = (monthTotals[key]||0) + (isNaN(tx.amount)?0:tx.amount);
            });
            var months = Object.keys(monthTotals).sort();
            var monthData = months.map(function(k){return Number(monthTotals[k].toFixed(2));});

            var ctx2 = document.getElementById('txOverTime');
            if (ctx2) {
                new Chart(ctx2, {
                    type: 'line',
                    data: { labels: months, datasets: [{ label: '₹ Amount', data: monthData, borderColor: '#764ba2', backgroundColor: 'rgba(118,75,162,0.2)', tension: 0.3 }] },
                    options: { responsive: true, plugins: { legend: { display: true } }, scales: { y: { beginAtZero: true } } }
                });
            }
        })();
    </script>
</body>
</html>
