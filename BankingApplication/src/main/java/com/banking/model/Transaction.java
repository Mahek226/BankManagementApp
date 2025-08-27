package com.banking.model;

import java.math.BigDecimal;
import java.util.Date;

public class Transaction {
    private int id;
    private int fromAccountId;
    private int toAccountId;
    private String transactionType;
    private BigDecimal amount;
    private String description;
    private String status;
    private Date transactionDate;

    public Transaction() {}

    public Transaction(int id, int fromAccountId, int toAccountId, String transactionType, BigDecimal amount, String description, String status, Date transactionDate) {
        this.id = id;
        this.fromAccountId = fromAccountId;
        this.toAccountId = toAccountId;
        this.transactionType = transactionType;
        this.amount = amount;
        this.description = description;
        this.status = status;
        this.transactionDate = transactionDate;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getFromAccountId() { return fromAccountId; }
    public void setFromAccountId(int fromAccountId) { this.fromAccountId = fromAccountId; }

    public int getToAccountId() { return toAccountId; }
    public void setToAccountId(int toAccountId) { this.toAccountId = toAccountId; }

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
}
