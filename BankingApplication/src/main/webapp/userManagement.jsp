<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - Banking Application</title>
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
        
        .btn-danger {
            background: #dc3545;
        }
        
        .btn-success {
            background: #28a745;
        }
        
        .users-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .users-table th,
        .users-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #e1e5e9;
        }
        
        .users-table th {
            background: #f8f9fa;
            font-weight: 600;
            color: #333;
        }
        
        .users-table tr:hover {
            background: #f8f9fa;
        }
        
        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 500;
        }
        
        .status-active {
            background: #d4edda;
            color: #155724;
        }
        
        .status-inactive {
            background: #f8d7da;
            color: #721c24;
        }
        
        .role-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 500;
        }
        
        .role-admin {
            background: #cce5ff;
            color: #004085;
        }
        
        .role-customer {
            background: #d1ecf1;
            color: #0c5460;
        }
        
        .action-buttons {
            display: flex;
            gap: 8px;
        }
        
        .btn-small {
            padding: 6px 12px;
            font-size: 14px;
        }
        
        .search-section {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            align-items: end;
        }
        
        .search-input {
            flex: 1;
            max-width: 300px;
        }
        
        .add-user-btn {
            background: #28a745;
            margin-bottom: 20px;
        }
        
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }
        
        .modal-content {
            background-color: white;
            margin: 5% auto;
            padding: 30px;
            border-radius: 10px;
            width: 90%;
            max-width: 600px;
            max-height: 80vh;
            overflow-y: auto;
        }
        
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .modal-title {
            font-size: 1.5em;
            color: #333;
        }
        
        .close {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        
        .close:hover {
            color: #000;
        }
        
        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .search-section {
                flex-direction: column;
                align-items: stretch;
            }
            
            .search-input {
                max-width: none;
            }
            
            .users-table {
                font-size: 14px;
            }
            
            .users-table th,
            .users-table td {
                padding: 10px 8px;
            }
            
            .action-buttons {
                flex-direction: column;
                gap: 5px;
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
        <h1 class="page-title">User Management</h1>
        
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

        <!-- Add New User Section -->
        <div class="section">
            <h3>Add New User</h3>
            <form action="userManagement" method="post" onsubmit="return validateUserForm()">
                <input type="hidden" name="action" value="add">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    <div class="form-group">
                        <label for="role">Role</label>
                        <select id="role" name="role" required>
                            <option value="">Select Role</option>
                            <option value="CUSTOMER">Customer</option>
                            <option value="ADMIN">Admin</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="fullName">Full Name</label>
                        <input type="text" id="fullName" name="fullName" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone</label>
                        <input type="tel" id="phone" name="phone" required>
                    </div>
                    <div class="form-group">
                        <label for="address">Address</label>
                        <input type="text" id="address" name="address" required>
                    </div>
                </div>
                <button type="submit" class="btn add-user-btn">Add New User</button>
            </form>
        </div>

        <!-- Users List Section -->
        <div class="section">
            <h3>Manage Users</h3>
            
            <div class="search-section">
                <div class="form-group search-input">
                    <label for="searchInput">Search Users</label>
                    <input type="text" id="searchInput" placeholder="Search by name, email, or username...">
                </div>
                <button class="btn btn-secondary" onclick="clearSearch()">Clear Search</button>
            </div>
            
            <c:choose>
                <c:when test="${empty users}">
                    <p>No users found.</p>
                </c:when>
                <c:otherwise>
                    <table class="users-table" id="usersTable">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr data-search="${user.username} ${user.fullName} ${user.email}">
                                    <td>${user.id}</td>
                                    <td>${user.username}</td>
                                    <td>${user.fullName}</td>
                                    <td>${user.email}</td>
                                    <td>${user.phone}</td>
                                    <td>
                                        <span class="role-badge role-${user.role.toLowerCase()}">
                                            ${user.role}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="status-badge status-${user.status.toLowerCase()}">
                                            ${user.status}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn btn-small btn-success" onclick="editUser(${user.id})">
                                                Edit
                                            </button>
                                            <button class="btn btn-small btn-danger" onclick="deleteUser(${user.id})">
                                                Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Edit User Modal -->
    <div id="editUserModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Edit User</h3>
                <span class="close" onclick="closeEditModal()">&times;</span>
            </div>
            <form action="userManagement" method="post" onsubmit="return validateEditForm()">
                <input type="hidden" name="action" value="update">
                <input type="hidden" id="editUserId" name="userId">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="editFullName">Full Name</label>
                        <input type="text" id="editFullName" name="fullName" required>
                    </div>
                    <div class="form-group">
                        <label for="editEmail">Email</label>
                        <input type="email" id="editEmail" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="editPhone">Phone</label>
                        <input type="tel" id="editPhone" name="phone" required>
                    </div>
                    <div class="form-group">
                        <label for="editAddress">Address</label>
                        <input type="text" id="editAddress" name="address" required>
                    </div>
                    <div class="form-group">
                        <label for="editStatus">Status</label>
                        <select id="editStatus" name="status" required>
                            <option value="ACTIVE">Active</option>
                            <option value="INACTIVE">Inactive</option>
                        </select>
                    </div>
                </div>
                <div style="margin-top: 20px;">
                    <button type="submit" class="btn btn-success">Update User</button>
                    <button type="button" class="btn btn-secondary" onclick="closeEditModal()">Cancel</button>
                </div>
            </form>
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
        
        // Search functionality
        document.getElementById('searchInput').addEventListener('input', function() {
            var searchTerm = this.value.toLowerCase();
            var rows = document.querySelectorAll('#usersTable tbody tr');
            
            rows.forEach(function(row) {
                var searchText = row.getAttribute('data-search').toLowerCase();
                if (searchText.includes(searchTerm)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
        
        function clearSearch() {
            document.getElementById('searchInput').value = '';
            var rows = document.querySelectorAll('#usersTable tbody tr');
            rows.forEach(function(row) {
                row.style.display = '';
            });
        }
        
        // Edit user functionality
        function editUser(userId) {
            // In a real application, you would fetch user data via AJAX
            // For now, we'll show the modal with placeholder data
            document.getElementById('editUserId').value = userId;
            document.getElementById('editUserModal').style.display = 'block';
        }
        
        function closeEditModal() {
            document.getElementById('editUserModal').style.display = 'none';
        }
        
        // Delete user functionality
        function deleteUser(userId) {
            if (confirm('Are you sure you want to delete this user? This action cannot be undone.')) {
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = 'userManagement';
                
                var actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';
                
                var userIdInput = document.createElement('input');
                userIdInput.type = 'hidden';
                userIdInput.name = 'userId';
                userIdInput.value = userId;
                
                form.appendChild(actionInput);
                form.appendChild(userIdInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        // Close modal when clicking outside
        window.onclick = function(event) {
            var modal = document.getElementById('editUserModal');
            if (event.target == modal) {
                closeEditModal();
            }
        }
        
        // Form validation
        function validateUserForm() {
            var username = document.getElementById('username').value;
            var password = document.getElementById('password').value;
            var fullName = document.getElementById('fullName').value;
            var email = document.getElementById('email').value;
            var phone = document.getElementById('phone').value;
            var address = document.getElementById('address').value;
            
            if (username.trim().length < 3) {
                alert("Username must be at least 3 characters long!");
                return false;
            }
            
            if (password.trim().length < 6) {
                alert("Password must be at least 6 characters long!");
                return false;
            }
            
            if (fullName.trim().length < 2) {
                alert("Full name must be at least 2 characters long!");
                return false;
            }
            
            if (!email.includes('@')) {
                alert("Please enter a valid email address!");
                return false;
            }
            
            if (phone.trim().length < 10) {
                alert("Please enter a valid phone number!");
                return false;
            }
            
            if (address.trim().length < 5) {
                alert("Address must be at least 5 characters long!");
                return false;
            }
            
            return true;
        }
        
        function validateEditForm() {
            var fullName = document.getElementById('editFullName').value;
            var email = document.getElementById('editEmail').value;
            var phone = document.getElementById('editPhone').value;
            var address = document.getElementById('editAddress').value;
            
            if (fullName.trim().length < 2) {
                alert("Full name must be at least 2 characters long!");
                return false;
            }
            
            if (!email.includes('@')) {
                alert("Please enter a valid email address!");
                return false;
            }
            
            if (phone.trim().length < 10) {
                alert("Please enter a valid phone number!");
                return false;
            }
            
            if (address.trim().length < 5) {
                alert("Address must be at least 5 characters long!");
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>
