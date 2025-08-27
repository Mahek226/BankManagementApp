<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Approval</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            color: #333;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            font-size: 1.5rem;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 1rem;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .nav-links a:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .page-title {
            text-align: center;
            margin-bottom: 2rem;
            color: #333;
        }

        .message {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
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

        .pending-users {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .user-card {
            border: 1px solid #e1e5e9;
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            background: white;
        }

        .user-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .info-group {
            display: flex;
            flex-direction: column;
        }

        .info-label {
            font-weight: 600;
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 0.25rem;
        }

        .info-value {
            color: #333;
            font-size: 1rem;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.9rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-approve {
            background: #28a745;
            color: white;
        }

        .btn-approve:hover {
            background: #218838;
        }

        .btn-reject {
            background: #dc3545;
            color: white;
        }

        .btn-reject:hover {
            background: #c82333;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        .rejection-modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            background-color: white;
            margin: 15% auto;
            padding: 2rem;
            border-radius: 10px;
            width: 90%;
            max-width: 500px;
            position: relative;
        }

        .close {
            position: absolute;
            right: 1rem;
            top: 1rem;
            font-size: 1.5rem;
            cursor: pointer;
            color: #666;
        }

        .close:hover {
            color: #333;
        }

        .modal-title {
            margin-bottom: 1rem;
            color: #333;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }

        .form-group textarea {
            width: 100%;
            padding: 0.75rem;
            border: 2px solid #e1e5e9;
            border-radius: 6px;
            resize: vertical;
            min-height: 100px;
        }

        .modal-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 1.5rem;
        }

        .no-pending {
            text-align: center;
            padding: 3rem;
            color: #666;
            font-size: 1.1rem;
        }

        @media (max-width: 768px) {
            .user-info {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>🏦 Banking Application</h1>
        <div class="nav-links">
            <a href="adminDashboard.jsp">Dashboard</a>
            <a href="userManagement.jsp">User Management</a>
            <a href="loanApproval.jsp">Loan Approval</a>
            <a href="logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <h2 class="page-title">Pending Registration Approvals</h2>

        <c:if test="${not empty successMessage}">
            <div class="message success-message">${successMessage}</div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="message error-message">${errorMessage}</div>
        </c:if>

        <div class="pending-users">
            <c:choose>
                <c:when test="${empty pendingUsers}">
                    <div class="no-pending">
                        <h3>No pending registrations</h3>
                        <p>All user registrations have been processed.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="pendingUser" items="${pendingUsers}">
                        <div class="user-card">
                            <div class="user-info">
                                <div class="info-group">
                                    <span class="info-label">Username</span>
                                    <span class="info-value">${pendingUser.username}</span>
                                </div>
                                <div class="info-group">
                                    <span class="info-label">Full Name</span>
                                    <span class="info-value">${pendingUser.fullName}</span>
                                </div>
                                <div class="info-group">
                                    <span class="info-label">Email</span>
                                    <span class="info-value">${pendingUser.email}</span>
                                </div>
                                <div class="info-group">
                                    <span class="info-label">Phone</span>
                                    <span class="info-value">${pendingUser.phone}</span>
                                </div>
                                <div class="info-group">
                                    <span class="info-label">Address</span>
                                    <span class="info-value">${pendingUser.address}</span>
                                </div>
                                <div class="info-group">
                                    <span class="info-label">Registration Date</span>
                                    <span class="info-value">Pending</span>
                                </div>
                            </div>
                            
                            <div class="action-buttons">
                                <button class="btn btn-approve" onclick="approveUser(${pendingUser.id})">
                                    ✓ Approve
                                </button>
                                <button class="btn btn-reject" onclick="showRejectionModal(${pendingUser.id})">
                                    ✗ Reject
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Rejection Modal -->
    <div id="rejectionModal" class="rejection-modal">
        <div class="modal-content">
            <span class="close" onclick="closeRejectionModal()">&times;</span>
            <h3 class="modal-title">Reject Registration</h3>
            <form id="rejectionForm" method="post" action="registrationApproval">
                <input type="hidden" name="action" value="reject">
                <input type="hidden" id="rejectUserId" name="userId">
                
                <div class="form-group">
                    <label for="rejectionReason">Rejection Reason *</label>
                    <textarea id="rejectionReason" name="rejectionReason" required 
                              placeholder="Please provide a reason for rejecting this registration..."></textarea>
                </div>
                
                <div class="modal-actions">
                    <button type="button" class="btn btn-secondary" onclick="closeRejectionModal()">Cancel</button>
                    <button type="submit" class="btn btn-reject">Reject Registration</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function approveUser(userId) {
            if (confirm('Are you sure you want to approve this user registration?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'registrationApproval';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'approve';
                
                const userIdInput = document.createElement('input');
                userIdInput.type = 'hidden';
                userIdInput.name = 'userId';
                userIdInput.value = userId;
                
                form.appendChild(actionInput);
                form.appendChild(userIdInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        function showRejectionModal(userId) {
            document.getElementById('rejectUserId').value = userId;
            document.getElementById('rejectionModal').style.display = 'block';
        }

        function closeRejectionModal() {
            document.getElementById('rejectionModal').style.display = 'none';
            document.getElementById('rejectionReason').value = '';
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('rejectionModal');
            if (event.target === modal) {
                closeRejectionModal();
            }
        }

        // Auto-hide messages after 5 seconds
        setTimeout(function() {
            const messages = document.querySelectorAll('.message');
            messages.forEach(function(message) {
                message.style.display = 'none';
            });
        }, 5000);
    </script>
</body>
</html>
