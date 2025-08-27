package com.banking.dao;

import com.banking.model.Transaction;
import com.banking.util.DatabaseUtil;
import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class TransactionDAO {
    
    public boolean createTransaction(Transaction transaction) throws SQLException {
        String query = "INSERT INTO transactions (from_account_id, to_account_id, transaction_type, amount, description, status, transaction_date) VALUES (?, ?, ?, ?, ?, ?, NOW())";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, transaction.getFromAccountId());
            stmt.setInt(2, transaction.getToAccountId());
            stmt.setString(3, transaction.getTransactionType());
            stmt.setBigDecimal(4, transaction.getAmount());
            stmt.setString(5, transaction.getDescription());
            stmt.setString(6, transaction.getStatus());
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    public List<Transaction> getTransactionsByAccountId(int accountId) throws SQLException {
        List<Transaction> transactions = new ArrayList<>();
        String query = "SELECT * FROM transactions WHERE from_account_id = ? OR to_account_id = ? ORDER BY transaction_date DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, accountId);
            stmt.setInt(2, accountId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Transaction transaction = new Transaction(
                    rs.getInt("id"),
                    rs.getInt("from_account_id"),
                    rs.getInt("to_account_id"),
                    rs.getString("transaction_type"),
                    rs.getBigDecimal("amount"),
                    rs.getString("description"),
                    rs.getString("status"),
                    rs.getTimestamp("transaction_date")
                );
                transactions.add(transaction);
            }
        }
        return transactions;
    }
    
    public List<Transaction> getAllTransactions() throws SQLException {
        List<Transaction> transactions = new ArrayList<>();
        String query = "SELECT * FROM transactions ORDER BY transaction_date DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Transaction transaction = new Transaction(
                    rs.getInt("id"),
                    rs.getInt("from_account_id"),
                    rs.getInt("to_account_id"),
                    rs.getString("transaction_type"),
                    rs.getBigDecimal("amount"),
                    rs.getString("description"),
                    rs.getString("status"),
                    rs.getTimestamp("transaction_date")
                );
                transactions.add(transaction);
            }
        }
        return transactions;
    }
    
    public boolean updateTransactionStatus(int transactionId, String status) throws SQLException {
        String query = "UPDATE transactions SET status = ? WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, transactionId);
            
            return stmt.executeUpdate() > 0;
        }
    }
}
