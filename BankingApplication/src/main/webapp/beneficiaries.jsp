<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Beneficiaries - Banking Application</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; color: #333; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px 0; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .header-content { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; padding: 0 20px; }
        .logo { font-size: 1.8em; font-weight: bold; }
        .nav-links { display: flex; gap: 20px; }
        .nav-link { color: white; text-decoration: none; padding: 8px 16px; border-radius: 5px; transition: background 0.3s ease; }
        .nav-link:hover { background: rgba(255,255,255,0.2); }
        .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
        .page-title { font-size: 2em; color: #333; margin-bottom: 30px; text-align: center; }
        .section { background: white; padding: 25px; border-radius: 10px; margin-bottom: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .section h3 { color: #333; margin-bottom: 20px; font-size: 1.4em; }
        .form-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 8px; color: #333; font-weight: 500; }
        .form-group input { width: 100%; padding: 12px 15px; border: 2px solid #e1e5e9; border-radius: 8px; font-size: 16px; transition: border-color 0.3s ease; }
        .form-group input:focus { outline: none; border-color: #667eea; }
        .btn { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 12px 24px; border: none; border-radius: 8px; font-size: 16px; font-weight: 600; cursor: pointer; transition: transform 0.2s ease; }
        .btn:hover { transform: translateY(-2px); }
        .message { padding: 15px; border-radius: 5px; margin-bottom: 20px; font-weight: 500; }
        .success-message { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error-message { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .table { width: 100%; border-collapse: collapse; background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .table th, .table td { padding: 15px; text-align: left; border-bottom: 1px solid #e1e5e9; }
        .table th { background: #f8f9fa; font-weight: 600; color: #333; }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <div class="logo">🏦 Banking Application</div>
            <div class="nav-links">
                <a href="customerDashboard.jsp" class="nav-link">Dashboard</a>
                <a href="account" class="nav-link">Accounts</a>
                <a href="beneficiaries" class="nav-link">Beneficiaries</a>
                <a href="logout" class="nav-link">Logout</a>
            </div>
        </div>
    </div>

    <div class="container">
        <h1 class="page-title">Manage Beneficiaries</h1>

        <c:if test="${not empty sessionScope.successMessage}">
            <div class="message success-message">${sessionScope.successMessage}</div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="message error-message">${sessionScope.errorMessage}</div>
            <c:remove var="errorMessage" scope="session"/>
        </c:if>

        <div class="section">
            <h3>Your Beneficiaries</h3>
            <c:choose>
                <c:when test="${empty beneficiaries}">
                    <p>No beneficiaries added yet.</p>
                </c:when>
                <c:otherwise>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nickname</th>
                                <th>Beneficiary User ID</th>
                                <th>Beneficiary Account ID</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="b" items="${beneficiaries}">
                                <tr>
                                    <td>${b.id}</td>
                                    <td>${b.nickname}</td>
                                    <td>${b.beneficiaryUserId}</td>
                                    <td>${b.beneficiaryAccountId}</td>
                                    <td>
                                        <form action="beneficiaries" method="post" onsubmit="return confirm('Delete this beneficiary?')">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${b.id}">
                                            <button type="submit" class="btn" style="background:#dc3545">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="section">
            <h3>Add Beneficiary</h3>
            <form action="beneficiaries" method="post">
                <input type="hidden" name="action" value="add">
                <div class="form-grid">
                    <div class="form-group">
                        <label>Beneficiary User ID</label>
                        <input type="number" name="beneficiaryUserId" min="1" required>
                    </div>
                    <div class="form-group">
                        <label>Beneficiary Account ID</label>
                        <input type="number" name="beneficiaryAccountId" min="1" required>
                    </div>
                    <div class="form-group">
                        <label>Nickname (optional)</label>
                        <input type="text" name="nickname" placeholder="e.g., Dad, Rent, Savings">
                    </div>
                </div>
                <button type="submit" class="btn">Add Beneficiary</button>
            </form>
            <p style="margin-top:10px;color:#666">Add only existing customers and valid account IDs within this bank.</p>
        </div>
    </div>

    <script>
        setTimeout(function(){
            var messages=document.querySelectorAll('.message');
            messages.forEach(function(m){m.style.display='none';});
        },5000);
    </script>
</body>
</html>


