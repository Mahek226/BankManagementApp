package com.banking.service;

import com.banking.dao.AccountDAO;
import com.banking.model.Account;
import java.sql.SQLException;
import java.math.BigDecimal;
import java.util.List;

public class AccountService {
    private AccountDAO accountDAO;
    
    public AccountService() {
        this.accountDAO = new AccountDAO();
    }
    
    public List<Account> getAccountsByUserId(int userId) throws SQLException {
        if (userId <= 0) {
            return null;
        }
        return accountDAO.getAccountsByUserId(userId);
    }

    public List<Account> getAllAccounts() throws SQLException {
        return accountDAO.getAllAccounts();
    }
    
    public Account getAccountById(int accountId) throws SQLException {
        if (accountId <= 0) {
            return null;
        }
        return accountDAO.getAccountById(accountId);
    }
    
    public boolean updateBalance(int accountId, BigDecimal newBalance) throws SQLException {
        if (accountId <= 0 || newBalance == null || newBalance.compareTo(BigDecimal.ZERO) < 0) {
            return false;
        }
        return accountDAO.updateBalance(accountId, newBalance);
    }
    
    public boolean createAccount(Account account) throws SQLException {
        if (account == null || account.getUserId() <= 0 || 
            account.getAccountNumber() == null || account.getAccountNumber().trim().isEmpty()) {
            return false;
        }
        // enforce one account per type per user
        if (accountDAO.existsAccountOfTypeForUser(account.getUserId(), account.getAccountType())) {
            return false;
        }
        return accountDAO.createAccount(account);
    }
    
    public String generateAccountNumber() throws SQLException {
        return accountDAO.generateAccountNumber();
    }
    
    public boolean transferFunds(int fromAccountId, int toAccountId, BigDecimal amount) throws SQLException {
        if (fromAccountId <= 0 || toAccountId <= 0 || amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
            return false;
        }
        
        Account fromAccount = accountDAO.getAccountById(fromAccountId);
        Account toAccount = accountDAO.getAccountById(toAccountId);
        
        if (fromAccount == null || toAccount == null) {
            return false;
        }
        
        if (fromAccount.getBalance().compareTo(amount) < 0) {
            return false; // Insufficient funds
        }
        
        // Check if transfer would leave fromAccount below minimum balance of ₹10,000
        BigDecimal newFromBalance = fromAccount.getBalance().subtract(amount);
        if (newFromBalance.compareTo(new BigDecimal("10000")) < 0) {
            return false; // Would violate minimum balance requirement
        }
        
        BigDecimal newToBalance = toAccount.getBalance().add(amount);
        
        boolean fromUpdated = accountDAO.updateBalance(fromAccountId, newFromBalance);
        boolean toUpdated = accountDAO.updateBalance(toAccountId, newToBalance);
        
        return fromUpdated && toUpdated;
    }

    public boolean deleteAccount(int accountId) throws SQLException {
        if (accountId <= 0) {
            return false;
        }
        return accountDAO.deleteAccount(accountId);
    }

    public boolean deposit(int accountId, BigDecimal amount) throws SQLException {
        if (accountId <= 0 || amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
            return false;
        }
        Account account = accountDAO.getAccountById(accountId);
        if (account == null) { return false; }
        BigDecimal newBalance = account.getBalance().add(amount);
        return accountDAO.updateBalance(accountId, newBalance);
    }

    public boolean withdraw(int accountId, BigDecimal amount) throws SQLException {
        if (accountId <= 0 || amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
            return false;
        }
        Account account = accountDAO.getAccountById(accountId);
        if (account == null) { return false; }
        if (account.getBalance().compareTo(amount) < 0) { return false; }
        
        // Check if withdrawal would leave account below minimum balance of ₹10,000
        BigDecimal newBalance = account.getBalance().subtract(amount);
        if (newBalance.compareTo(new BigDecimal("10000")) < 0) {
            return false; // Would violate minimum balance requirement
        }
        
        return accountDAO.updateBalance(accountId, newBalance);
    }
}
