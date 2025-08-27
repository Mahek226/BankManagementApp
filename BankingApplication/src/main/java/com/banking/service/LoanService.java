package com.banking.service;

import com.banking.dao.LoanDAO;
import com.banking.model.Loan;
import java.sql.SQLException;
import java.math.BigDecimal;
import java.util.List;

public class LoanService {
    private LoanDAO loanDAO;
    
    public LoanService() {
        this.loanDAO = new LoanDAO();
    }
    
    public boolean createLoan(Loan loan) throws SQLException {
        if (loan == null || loan.getUserId() <= 0 || 
            loan.getAmount() == null || loan.getAmount().compareTo(BigDecimal.ZERO) <= 0 ||
            loan.getTermMonths() <= 0) {
            return false;
        }
        return loanDAO.createLoan(loan);
    }
    
    public List<Loan> getLoansByUserId(int userId) throws SQLException {
        if (userId <= 0) {
            return null;
        }
        return loanDAO.getLoansByUserId(userId);
    }
    
    public List<Loan> getPendingLoans() throws SQLException {
        return loanDAO.getPendingLoans();
    }
    
    public boolean updateLoanStatus(int loanId, String status, String approvedBy) throws SQLException {
        if (loanId <= 0 || status == null || status.trim().isEmpty()) {
            return false;
        }
        return loanDAO.updateLoanStatus(loanId, status.trim(), approvedBy);
    }
    
    public Loan getLoanById(int loanId) throws SQLException {
        if (loanId <= 0) {
            return null;
        }
        return loanDAO.getLoanById(loanId);
    }
    
    public boolean validateLoanApplication(Loan loan) {
        if (loan == null) return false;
        if (loan.getUserId() <= 0) return false;
        if (loan.getLoanType() == null || loan.getLoanType().trim().isEmpty()) return false;
        if (loan.getAmount() == null || loan.getAmount().compareTo(BigDecimal.ZERO) <= 0) return false;
        if (loan.getTermMonths() <= 0) return false;
        if (loan.getPurpose() == null || loan.getPurpose().trim().isEmpty()) return false;
        return true;
    }
}
