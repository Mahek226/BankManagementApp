package com.banking.controller;

import com.banking.model.Account;
import com.banking.model.User;
import com.banking.service.AccountService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/account")
public class AccountServlet extends HttpServlet {
    private AccountService accountService;
    
    @Override
    public void init() throws ServletException {
        accountService = new AccountService();
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
        int userId = user.getId();
        
        try {
            List<Account> accounts = accountService.getAccountsByUserId(userId);
            request.setAttribute("accounts", accounts);
            
            // If admin, also load all accounts for management
            if ("ADMIN".equals(user.getRole())) {
                List<Account> allAccounts = accountService.getAllAccounts();
                request.setAttribute("allAccounts", allAccounts);
            }
            
            request.getRequestDispatcher("accountManagement.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading accounts: " + e.getMessage());
            if ("ADMIN".equals(user.getRole())) {
                request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("customerDashboard.jsp").forward(request, response);
            }
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
        String action = request.getParameter("action");
        
        try {
            if ("create".equals(action)) {
                handleCreateAccount(request, response, user);
            } else if ("transfer".equals(action)) {
                handleFundTransfer(request, response, user);
            } else if ("delete".equals(action)) {
                handleDeleteAccount(request, response, user);
            } else {
                response.sendRedirect("account");
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect("account");
        }
    }
    
    private void handleCreateAccount(HttpServletRequest request, HttpServletResponse response, User user) 
            throws Exception {
        String accountType = request.getParameter("accountType");
        BigDecimal initialBalance = new BigDecimal(request.getParameter("initialBalance"));
        
        if (initialBalance.compareTo(BigDecimal.ZERO) < 0) {
            request.setAttribute("errorMessage", "Initial balance cannot be negative!");
            response.sendRedirect("account");
            return;
        }
        
        Account newAccount = new Account();
        newAccount.setUserId(user.getId());
        newAccount.setAccountType(accountType);
        newAccount.setBalance(initialBalance);
        newAccount.setStatus("ACTIVE");
        
        String accountNumber = accountService.generateAccountNumber();
        newAccount.setAccountNumber(accountNumber);
        
        if (accountService.createAccount(newAccount)) {
            request.setAttribute("successMessage", "Account created successfully! Account Number: " + accountNumber);
        } else {
            request.setAttribute("errorMessage", "Failed to create account!");
        }
        
        response.sendRedirect("account");
    }
    
    private void handleFundTransfer(HttpServletRequest request, HttpServletResponse response, User user) 
            throws Exception {
        int fromAccountId = Integer.parseInt(request.getParameter("fromAccountId"));
        int toAccountId = Integer.parseInt(request.getParameter("toAccountId"));
        BigDecimal amount = new BigDecimal(request.getParameter("amount"));
        String description = request.getParameter("description");
        
        if (amount.compareTo(BigDecimal.ZERO) <= 0) {
            request.setAttribute("errorMessage", "Transfer amount must be positive!");
            response.sendRedirect("account");
            return;
        }
        
        // Verify account ownership
        Account fromAccount = accountService.getAccountById(fromAccountId);
        if (fromAccount == null || fromAccount.getUserId() != user.getId()) {
            request.setAttribute("errorMessage", "Invalid account!");
            response.sendRedirect("account");
            return;
        }
        
        if (accountService.transferFunds(fromAccountId, toAccountId, amount)) {
            request.setAttribute("successMessage", "Fund transfer completed successfully!");
        } else {
            request.setAttribute("errorMessage", "Fund transfer failed! Check balance and account details.");
        }
        
        response.sendRedirect("account");
    }

    private void handleDeleteAccount(HttpServletRequest request, HttpServletResponse response, User user) 
            throws Exception {
        // Check if user is admin
        if (!"ADMIN".equals(user.getRole())) {
            request.setAttribute("errorMessage", "Access denied. Admin privileges required.");
            response.sendRedirect("account");
            return;
        }

        String accountId = request.getParameter("accountId");
        if (accountId == null) {
            request.setAttribute("errorMessage", "Account ID is required");
            response.sendRedirect("account");
            return;
        }

        try {
            int id = Integer.parseInt(accountId);
            boolean success = accountService.deleteAccount(id);
            if (success) {
                request.setAttribute("successMessage", "Account deleted successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to delete account. Account may not exist or have active transactions.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid account ID");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "System error occurred while deleting account");
        }

        response.sendRedirect("account");
    }
}
