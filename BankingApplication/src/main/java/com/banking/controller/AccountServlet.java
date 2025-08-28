package com.banking.controller;

import com.banking.model.Account;
import com.banking.model.User;
import com.banking.model.Beneficiary;
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
import com.banking.service.TransactionService;
import com.banking.model.TransactionView;
import com.banking.service.BeneficiaryService;

@WebServlet("/account")
public class AccountServlet extends HttpServlet {
    private AccountService accountService;
    private TransactionService transactionService;
    
    @Override
    public void init() throws ServletException {
        accountService = new AccountService();
        transactionService = new TransactionService();
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
            // Load detailed transactions for analytics and history
            TransactionService ts = new TransactionService();
            request.setAttribute("transactionsDetailed", ts.getTransactionsDetailedByUser(userId));
            // Load beneficiaries for transfer convenience
            BeneficiaryService bs = new BeneficiaryService();
            request.setAttribute("beneficiaries", bs.getBeneficiariesByOwner(userId));
            
            // If admin, also load all accounts for management
            if ("ADMIN".equals(user.getRole())) {
                List<Account> allAccounts = accountService.getAllAccounts();
                request.setAttribute("allAccounts", allAccounts);
            }

            String view = request.getParameter("view");
            if (view == null || view.trim().isEmpty()) {
                request.getRequestDispatcher("accountManagement.jsp").forward(request, response);
            } else if ("create".equals(view)) {
                request.getRequestDispatcher("createAccount.jsp").forward(request, response);
            } else if ("deposit".equals(view)) {
                request.getRequestDispatcher("deposit.jsp").forward(request, response);
            } else if ("withdraw".equals(view)) {
                request.getRequestDispatcher("withdraw.jsp").forward(request, response);
            } else if ("transfer".equals(view)) {
                request.getRequestDispatcher("transfer.jsp").forward(request, response);
            } else if ("beneficiaries".equals(view)) {
                request.getRequestDispatcher("beneficiaries.jsp").forward(request, response);
            } else if ("history".equals(view)) {
                request.getRequestDispatcher("history.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("accountManagement.jsp").forward(request, response);
            }
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
            } else if ("deposit".equals(action)) {
                handleDeposit(request, response, user);
            } else if ("withdraw".equals(action)) {
                handleWithdraw(request, response, user);
            } else if ("addBeneficiary".equals(action)) {
                handleAddBeneficiary(request, response, user);
            } else if ("removeBeneficiary".equals(action)) {
                handleRemoveBeneficiary(request, response, user);
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
        
        // Enforce min initial balance 10000 INR
        if (initialBalance.compareTo(new BigDecimal("10000")) < 0) {
            request.setAttribute("errorMessage", "Initial balance must be at least ₹10,000.");
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
            request.setAttribute("errorMessage", "Failed to create account! You may already have this account type.");
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
            transactionService.processFundTransfer(fromAccountId, toAccountId, amount, description);
            request.getSession().setAttribute("successMessage", "Fund transfer completed successfully!");
        } else {
            // Check if it's due to minimum balance requirement
            BigDecimal newBalance = fromAccount.getBalance().subtract(amount);
            if (newBalance.compareTo(new BigDecimal("10000")) < 0) {
                request.getSession().setAttribute("errorMessage", 
                    "Transfer failed! Transferring ₹" + amount + " would leave your account below the minimum required balance of ₹10,000. " +
                    "Current balance: ₹" + fromAccount.getBalance() + ". Maximum transferable: ₹" + 
                    fromAccount.getBalance().subtract(new BigDecimal("10000")));
            } else {
                request.getSession().setAttribute("errorMessage", "Fund transfer failed! Check balance and account details.");
            }
        }
        
        response.sendRedirect("account");
    }

    private void handleDeposit(HttpServletRequest request, HttpServletResponse response, User user)
            throws Exception {
        int accountId = Integer.parseInt(request.getParameter("accountId"));
        BigDecimal amount = new BigDecimal(request.getParameter("amount"));
        String description = request.getParameter("description");

        Account account = accountService.getAccountById(accountId);
        if (account == null || account.getUserId() != user.getId()) {
            request.setAttribute("errorMessage", "Invalid account!");
            response.sendRedirect("account");
            return;
        }
        if (accountService.deposit(accountId, amount)) {
            transactionService.recordDeposit(accountId, amount, description);
            request.getSession().setAttribute("successMessage", "Deposit successful!");
        } else {
            request.getSession().setAttribute("errorMessage", "Deposit failed!");
        }
        response.sendRedirect("account");
    }

    private void handleWithdraw(HttpServletRequest request, HttpServletResponse response, User user)
            throws Exception {
        int accountId = Integer.parseInt(request.getParameter("accountId"));
        BigDecimal amount = new BigDecimal(request.getParameter("amount"));
        String description = request.getParameter("description");

        Account account = accountService.getAccountById(accountId);
        if (account == null || account.getUserId() != user.getId()) {
            request.setAttribute("errorMessage", "Invalid account!");
            response.sendRedirect("account");
            return;
        }
        
        if (accountService.withdraw(accountId, amount)) {
            transactionService.recordWithdrawal(accountId, amount, description);
            request.getSession().setAttribute("successMessage", "Withdrawal successful!");
        } else {
            // Check if it's due to minimum balance requirement
            BigDecimal newBalance = account.getBalance().subtract(amount);
            if (newBalance.compareTo(new BigDecimal("10000")) < 0) {
                request.getSession().setAttribute("errorMessage", 
                    "Withdrawal failed! Withdrawing ₹" + amount + " would leave your account below the minimum required balance of ₹10,000. " +
                    "Current balance: ₹" + account.getBalance() + ". Maximum withdrawable: ₹" + 
                    account.getBalance().subtract(new BigDecimal("10000")));
            } else {
                request.getSession().setAttribute("errorMessage", "Withdrawal failed! Check balance.");
            }
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

    private void handleAddBeneficiary(HttpServletRequest request, HttpServletResponse response, User user) 
            throws Exception {
        String beneficiaryAccountNumber = request.getParameter("beneficiaryAccountNumber");
        String nickname = request.getParameter("nickname");
        
        if (beneficiaryAccountNumber == null || beneficiaryAccountNumber.trim().isEmpty() ||
            nickname == null || nickname.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessage", "Account number and nickname are required!");
            response.sendRedirect("account");
            return;
        }
        
        // Create beneficiary object
        Beneficiary beneficiary = new Beneficiary();
        beneficiary.setOwnerUserId(user.getId());
        beneficiary.setBeneficiaryAccountNumber(beneficiaryAccountNumber);
        beneficiary.setNickname(nickname);
        
        BeneficiaryService beneficiaryService = new BeneficiaryService();
        if (beneficiaryService.addBeneficiary(beneficiary)) {
            request.getSession().setAttribute("successMessage", "Beneficiary added successfully!");
        } else {
            request.getSession().setAttribute("errorMessage", "Failed to add beneficiary. Account may not exist or already added.");
        }
        
        response.sendRedirect("account");
    }

    private void handleRemoveBeneficiary(HttpServletRequest request, HttpServletResponse response, User user) 
            throws Exception {
        String beneficiaryId = request.getParameter("beneficiaryId");
        
        if (beneficiaryId == null || beneficiaryId.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessage", "Beneficiary ID is required!");
            response.sendRedirect("account");
            return;
        }
        
        try {
            int id = Integer.parseInt(beneficiaryId);
            BeneficiaryService beneficiaryService = new BeneficiaryService();
            if (beneficiaryService.removeBeneficiary(id, user.getId())) {
                request.getSession().setAttribute("successMessage", "Beneficiary removed successfully!");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to remove beneficiary. It may not exist or you don't have permission.");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid beneficiary ID");
        }
        
        response.sendRedirect("account");
    }
}
