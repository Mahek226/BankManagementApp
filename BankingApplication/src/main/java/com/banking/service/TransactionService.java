package com.banking.service;

import com.banking.dao.TransactionDAO;
import com.banking.dao.AccountDAO;
import com.banking.model.Transaction;
import com.banking.model.TransactionView;
import java.sql.SQLException;
import java.math.BigDecimal;
import java.util.List;

public class TransactionService {
    private TransactionDAO transactionDAO;
    private AccountDAO accountDAO;
    
    public TransactionService() {
        this.transactionDAO = new TransactionDAO();
        this.accountDAO = new AccountDAO();
    }
    
    public boolean createTransaction(Transaction transaction) throws SQLException {
        if (transaction == null || transaction.getAmount() == null || 
            transaction.getAmount().compareTo(BigDecimal.ZERO) <= 0) {
            return false;
        }
        return transactionDAO.createTransaction(transaction);
    }
    
    public List<Transaction> getTransactionsByAccountId(int accountId) throws SQLException {
        if (accountId <= 0) {
            return null;
        }
        return transactionDAO.getTransactionsByAccountId(accountId);
    }
    
    public List<Transaction> getAllTransactions() throws SQLException {
        return transactionDAO.getAllTransactions();
    }

    public List<TransactionView> getTransactionsDetailedByUser(int userId) throws SQLException {
        if (userId <= 0) return null;
        return transactionDAO.getTransactionsDetailedByUser(userId);
    }
    
    public boolean updateTransactionStatus(int transactionId, String status) throws SQLException {
        if (transactionId <= 0 || status == null || status.trim().isEmpty()) {
            return false;
        }
        return transactionDAO.updateTransactionStatus(transactionId, status.trim());
    }
    
    public boolean processFundTransfer(int fromAccountId, int toAccountId, BigDecimal amount, String description) throws SQLException {
        if (fromAccountId <= 0 || toAccountId <= 0 || amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
            return false;
        }
        
        // Create transaction record
        Transaction transaction = new Transaction();
        transaction.setFromAccountId(fromAccountId);
        transaction.setToAccountId(toAccountId);
        transaction.setTransactionType("TRANSFER");
        transaction.setAmount(amount);
        transaction.setDescription(description);
        transaction.setStatus("COMPLETED");
        
        return transactionDAO.createTransaction(transaction);
    }

    public boolean recordDeposit(int toAccountId, BigDecimal amount, String description) throws SQLException {
        if (toAccountId <= 0 || amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) { return false; }
        Transaction t = new Transaction();
        t.setFromAccountId(toAccountId);
        t.setToAccountId(toAccountId);
        t.setTransactionType("DEPOSIT");
        t.setAmount(amount);
        t.setDescription(description);
        t.setStatus("COMPLETED");
        return transactionDAO.createTransaction(t);
    }

    public boolean recordWithdrawal(int fromAccountId, BigDecimal amount, String description) throws SQLException {
        if (fromAccountId <= 0 || amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) { return false; }
        Transaction t = new Transaction();
        t.setFromAccountId(fromAccountId);
        t.setToAccountId(fromAccountId);
        t.setTransactionType("WITHDRAWAL");
        t.setAmount(amount);
        t.setDescription(description);
        t.setStatus("COMPLETED");
        return transactionDAO.createTransaction(t);
    }
}
