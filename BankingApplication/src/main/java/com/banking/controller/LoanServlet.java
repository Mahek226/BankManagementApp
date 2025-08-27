package com.banking.controller;

import com.banking.model.Loan;
import com.banking.model.User;
import com.banking.service.LoanService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/loan")
public class LoanServlet extends HttpServlet {
    private LoanService loanService;
    
    @Override
    public void init() throws ServletException {
        loanService = new LoanService();
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
            if ("ADMIN".equals(user.getRole())) {
                List<Loan> pendingLoans = loanService.getPendingLoans();
                request.setAttribute("pendingLoans", pendingLoans);
                request.getRequestDispatcher("loanApproval.jsp").forward(request, response);
            } else {
                List<Loan> userLoans = loanService.getLoansByUserId(userId);
                request.setAttribute("userLoans", userLoans);
                request.getRequestDispatcher("loanManagement.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading loans: " + e.getMessage());
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
            if ("apply".equals(action)) {
                handleLoanApplication(request, response, user);
            } else if ("approve".equals(action) || "reject".equals(action)) {
                handleLoanApproval(request, response, user);
            } else {
                response.sendRedirect("loan");
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect("loan");
        }
    }
    
    private void handleLoanApplication(HttpServletRequest request, HttpServletResponse response, User user) 
            throws Exception {
        String loanType = request.getParameter("loanType");
        BigDecimal amount = new BigDecimal(request.getParameter("amount"));
        BigDecimal interestRate = new BigDecimal(request.getParameter("interestRate"));
        int termMonths = Integer.parseInt(request.getParameter("termMonths"));
        String purpose = request.getParameter("purpose");
        
        if (amount.compareTo(BigDecimal.ZERO) <= 0 || termMonths <= 0) {
            request.setAttribute("errorMessage", "Invalid loan details!");
            response.sendRedirect("loan");
            return;
        }
        
        Loan newLoan = new Loan();
        newLoan.setUserId(user.getId());
        newLoan.setLoanType(loanType);
        newLoan.setAmount(amount);
        newLoan.setInterestRate(interestRate);
        newLoan.setTermMonths(termMonths);
        newLoan.setPurpose(purpose);
        newLoan.setStatus("PENDING");
        
        if (loanService.validateLoanApplication(newLoan)) {
            if (loanService.createLoan(newLoan)) {
                request.setAttribute("successMessage", "Loan application submitted successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to submit loan application!");
            }
        } else {
            request.setAttribute("errorMessage", "Invalid loan application data!");
        }
        
        response.sendRedirect("loan");
    }
    
    private void handleLoanApproval(HttpServletRequest request, HttpServletResponse response, User user) 
            throws Exception {
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect("loan");
            return;
        }
        
        int loanId = Integer.parseInt(request.getParameter("loanId"));
        String action = request.getParameter("action");
        String status = "approve".equals(action) ? "APPROVED" : "REJECTED";
        
        if (loanService.updateLoanStatus(loanId, status, user.getUsername())) {
            request.setAttribute("successMessage", "Loan " + status.toLowerCase() + " successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to " + action + " loan!");
        }
        
        response.sendRedirect("loan");
    }
}
