package com.banking.controller;

import com.banking.model.User;
import com.banking.service.UserService;
import com.banking.util.DatabaseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to registration page
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Server-side validation
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty() ||
            fullName == null || fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            address == null || address.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "All fields are required");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Check if username already exists
        if (isUsernameExists(username)) {
            request.setAttribute("errorMessage", "Username already exists. Please choose a different username");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Check if email already exists
        if (isEmailExists(email)) {
            request.setAttribute("errorMessage", "Email already exists. Please use a different email address");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        try {
            // Create new user with PENDING status
            User newUser = new User();
            newUser.setUsername(username.trim());
            newUser.setPassword(password); // In production, this should be hashed
            newUser.setRole("CUSTOMER");
            newUser.setFullName(fullName.trim());
            newUser.setEmail(email.trim());
            newUser.setPhone(phone.trim());
            newUser.setAddress(address.trim());
            newUser.setStatus("PENDING");

            // Add user to database
            boolean success = userService.addUser(newUser);

            if (success) {
                // Redirect to login with success message
                request.getSession().setAttribute("successMessage", 
                    "Registration successful! Your account is pending admin approval. You will be able to login once approved.");
                response.sendRedirect("login.jsp");
            } else {
                request.setAttribute("errorMessage", "Registration failed. Please try again.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "System error occurred. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    private boolean isUsernameExists(String username) {
        String query = "SELECT COUNT(*) FROM users WHERE username = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private boolean isEmailExists(String email) {
        String query = "SELECT COUNT(*) FROM users WHERE email = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
