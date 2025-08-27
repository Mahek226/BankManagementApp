package com.banking.dao;

import com.banking.model.Loan;
import com.banking.util.DatabaseUtil;
import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class LoanDAO {
    
    public boolean createLoan(Loan loan) throws SQLException {
        String query = "INSERT INTO loans (user_id, loan_type, amount, interest_rate, term_months, status, purpose, application_date) VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, loan.getUserId());
            stmt.setString(2, loan.getLoanType());
            stmt.setBigDecimal(3, loan.getAmount());
            stmt.setBigDecimal(4, loan.getInterestRate());
            stmt.setInt(5, loan.getTermMonths());
            stmt.setString(6, loan.getStatus());
            stmt.setString(7, loan.getPurpose());
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    public List<Loan> getLoansByUserId(int userId) throws SQLException {
        List<Loan> loans = new ArrayList<>();
        String query = "SELECT * FROM loans WHERE user_id = ? ORDER BY application_date DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Loan loan = new Loan(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("loan_type"),
                    rs.getBigDecimal("amount"),
                    rs.getBigDecimal("interest_rate"),
                    rs.getInt("term_months"),
                    rs.getString("status"),
                    rs.getString("purpose"),
                    rs.getTimestamp("application_date"),
                    rs.getTimestamp("approval_date"),
                    rs.getString("approved_by")
                );
                loans.add(loan);
            }
        }
        return loans;
    }
    
    public List<Loan> getPendingLoans() throws SQLException {
        List<Loan> loans = new ArrayList<>();
        String query = "SELECT * FROM loans WHERE status = 'PENDING' ORDER BY application_date ASC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Loan loan = new Loan(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("loan_type"),
                    rs.getBigDecimal("amount"),
                    rs.getBigDecimal("interest_rate"),
                    rs.getInt("term_months"),
                    rs.getString("status"),
                    rs.getString("purpose"),
                    rs.getTimestamp("application_date"),
                    rs.getTimestamp("approval_date"),
                    rs.getString("approved_by")
                );
                loans.add(loan);
            }
        }
        return loans;
    }
    
    public boolean updateLoanStatus(int loanId, String status, String approvedBy) throws SQLException {
        String query = "UPDATE loans SET status = ?, approved_by = ?, approval_date = NOW() WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, status);
            stmt.setString(2, approvedBy);
            stmt.setInt(3, loanId);
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    public Loan getLoanById(int loanId) throws SQLException {
        String query = "SELECT * FROM loans WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, loanId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return new Loan(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("loan_type"),
                    rs.getBigDecimal("amount"),
                    rs.getBigDecimal("interest_rate"),
                    rs.getInt("term_months"),
                    rs.getString("status"),
                    rs.getString("purpose"),
                    rs.getTimestamp("application_date"),
                    rs.getTimestamp("approval_date"),
                    rs.getString("approved_by")
                );
            }
        }
        return null;
    }
}
