package com.banking.dao;

import com.banking.model.Account;
import com.banking.util.DatabaseUtil;
import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class AccountDAO {
    
    public List<Account> getAccountsByUserId(int userId) throws SQLException {
        List<Account> accounts = new ArrayList<>();
        String query = "SELECT * FROM accounts WHERE user_id = ? AND status = 'ACTIVE'";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Account account = new Account(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("account_number"),
                    rs.getString("account_type"),
                    rs.getBigDecimal("balance"),
                    rs.getString("status"),
                    rs.getTimestamp("created_at"),
                    rs.getTimestamp("updated_at")
                );
                accounts.add(account);
            }
        }
        return accounts;
    }

    public List<Account> getAllAccounts() throws SQLException {
        List<Account> accounts = new ArrayList<>();
        String query = "SELECT * FROM accounts ORDER BY id";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Account account = new Account(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("account_number"),
                    rs.getString("account_type"),
                    rs.getBigDecimal("balance"),
                    rs.getString("status"),
                    rs.getTimestamp("created_at"),
                    rs.getTimestamp("updated_at")
                );
                accounts.add(account);
            }
        }
        return accounts;
    }
    
    public Account getAccountById(int accountId) throws SQLException {
        String query = "SELECT * FROM accounts WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, accountId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return new Account(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("account_number"),
                    rs.getString("account_type"),
                    rs.getBigDecimal("balance"),
                    rs.getString("status"),
                    rs.getTimestamp("created_at"),
                    rs.getTimestamp("updated_at")
                );
            }
        }
        return null;
    }
    
    public boolean updateBalance(int accountId, BigDecimal newBalance) throws SQLException {
        String query = "UPDATE accounts SET balance = ?, updated_at = NOW() WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setBigDecimal(1, newBalance);
            stmt.setInt(2, accountId);
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean createAccount(Account account) throws SQLException {
        String query = "INSERT INTO accounts (user_id, account_number, account_type, balance, status, created_at, updated_at) VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, account.getUserId());
            stmt.setString(2, account.getAccountNumber());
            stmt.setString(3, account.getAccountType());
            stmt.setBigDecimal(4, account.getBalance());
            stmt.setString(5, account.getStatus());
            
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean existsAccountOfTypeForUser(int userId, String accountType) throws SQLException {
        String query = "SELECT 1 FROM accounts WHERE user_id = ? AND account_type = ? LIMIT 1";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setString(2, accountType);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }
    
    public String generateAccountNumber() throws SQLException {
        String query = "SELECT COUNT(*) as count FROM accounts";
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            if (rs.next()) {
                int count = rs.getInt("count");
                return String.format("ACC%06d", count + 1);
            }
        }
        return "ACC000001";
    }

    public boolean deleteAccount(int accountId) throws SQLException {
        String query = "DELETE FROM accounts WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, accountId);
            return stmt.executeUpdate() > 0;
        }
    }
}
