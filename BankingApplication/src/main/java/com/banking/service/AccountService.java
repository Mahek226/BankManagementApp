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
        
        BigDecimal newFromBalance = fromAccount.getBalance().subtract(amount);
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
}
