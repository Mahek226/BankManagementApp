package com.banking.controller;

import com.banking.model.User;
import com.banking.service.UserService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/userManagement")
public class UserManagementServlet extends HttpServlet {
    private UserService userService;
    
    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect("customerDashboard.jsp");
            return;
        }
        
        try {
            List<User> users = userService.getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("userManagement.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading users: " + e.getMessage());
            request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect("customerDashboard.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            if ("add".equals(action)) {
                handleAddUser(request, response);
            } else if ("update".equals(action)) {
                handleUpdateUser(request, response);
            } else if ("delete".equals(action)) {
                handleDeleteUser(request, response);
            } else {
                response.sendRedirect("userManagement");
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect("userManagement");
        }
    }
    
    private void handleAddUser(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        User newUser = new User();
        newUser.setUsername(request.getParameter("username"));
        newUser.setPassword(request.getParameter("password"));
        newUser.setRole(request.getParameter("role"));
        newUser.setFullName(request.getParameter("fullName"));
        newUser.setEmail(request.getParameter("email"));
        newUser.setPhone(request.getParameter("phone"));
        newUser.setAddress(request.getParameter("address"));
        newUser.setStatus("ACTIVE");
        
        if (userService.validateUserData(newUser)) {
            if (userService.addUser(newUser)) {
                request.setAttribute("successMessage", "User added successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to add user!");
            }
        } else {
            request.setAttribute("errorMessage", "Invalid user data!");
        }
        
        response.sendRedirect("userManagement");
    }
    
    private void handleUpdateUser(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        int userId = Integer.parseInt(request.getParameter("userId"));
        User existingUser = userService.getUserById(userId);
        
        if (existingUser != null) {
            existingUser.setFullName(request.getParameter("fullName"));
            existingUser.setEmail(request.getParameter("email"));
            existingUser.setPhone(request.getParameter("phone"));
            existingUser.setAddress(request.getParameter("address"));
            existingUser.setStatus(request.getParameter("status"));
            
            if (userService.updateUser(existingUser)) {
                request.setAttribute("successMessage", "User updated successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to update user!");
            }
        } else {
            request.setAttribute("errorMessage", "User not found!");
        }
        
        response.sendRedirect("userManagement");
    }
    
    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        int userId = Integer.parseInt(request.getParameter("userId"));
        
        if (userService.deleteUser(userId)) {
            request.setAttribute("successMessage", "User deleted successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to delete user!");
        }
        
        response.sendRedirect("userManagement");
    }
}
