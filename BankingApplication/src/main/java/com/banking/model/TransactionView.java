package com.banking.model;

import java.math.BigDecimal;
import java.util.Date;

public class TransactionView {
    private int id;
    private String transactionType;
    private BigDecimal amount;
    private String description;
    private String status;
    private Date transactionDate;
    private int fromAccountId;
    private String fromAccountNumber;
    private String fromAccountType;
    private int toAccountId;
    private String toAccountNumber;
    private String toAccountType;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTransactionType() { return transactionType; }
    public void setTransactionType(String transactionType) { this.transactionType = transactionType; }
    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Date getTransactionDate() { return transactionDate; }
    public void setTransactionDate(Date transactionDate) { this.transactionDate = transactionDate; }
    public int getFromAccountId() { return fromAccountId; }
    public void setFromAccountId(int fromAccountId) { this.fromAccountId = fromAccountId; }
    public String getFromAccountNumber() { return fromAccountNumber; }
    public void setFromAccountNumber(String fromAccountNumber) { this.fromAccountNumber = fromAccountNumber; }
    public String getFromAccountType() { return fromAccountType; }
    public void setFromAccountType(String fromAccountType) { this.fromAccountType = fromAccountType; }
    public int getToAccountId() { return toAccountId; }
    public void setToAccountId(int toAccountId) { this.toAccountId = toAccountId; }
    public String getToAccountNumber() { return toAccountNumber; }
    public void setToAccountNumber(String toAccountNumber) { this.toAccountNumber = toAccountNumber; }
    public String getToAccountType() { return toAccountType; }
    public void setToAccountType(String toAccountType) { this.toAccountType = toAccountType; }
}


