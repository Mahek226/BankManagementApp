package com.banking.controller;

import com.banking.dao.UserDAO;
import com.banking.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/registrationApproval")
public class RegistrationApprovalServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in and is admin
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
            // Get pending registrations
            List<User> pendingUsers = userDAO.getPendingUsers();
            request.setAttribute("pendingUsers", pendingUsers);
            request.getRequestDispatcher("registrationApproval.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading pending registrations");
            request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in and is admin
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
        int userId = Integer.parseInt(request.getParameter("userId"));

        try {
            if ("approve".equals(action)) {
                boolean success = userDAO.approveUser(userId);
                if (success) {
                    request.getSession().setAttribute("successMessage", "User registration approved successfully!");
                } else {
                    request.getSession().setAttribute("errorMessage", "Failed to approve user registration");
                }
            } else if ("reject".equals(action)) {
                String rejectionReason = request.getParameter("rejectionReason");
                if (rejectionReason == null || rejectionReason.trim().isEmpty()) {
                    request.getSession().setAttribute("errorMessage", "Rejection reason is required");
                } else {
                    boolean success = userDAO.rejectUser(userId, rejectionReason.trim());
                    if (success) {
                        request.getSession().setAttribute("successMessage", "User registration rejected successfully!");
                    } else {
                        request.getSession().setAttribute("errorMessage", "Failed to reject user registration");
                    }
                }
            }

            response.sendRedirect("registrationApproval");
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "System error occurred");
            response.sendRedirect("registrationApproval");
        }
    }
}
