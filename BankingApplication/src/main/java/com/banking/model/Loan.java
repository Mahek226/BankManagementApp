package com.banking.model;

import java.math.BigDecimal;
import java.util.Date;

public class Loan {
    private int id;
    private int userId;
    private String loanType;
    private BigDecimal amount;
    private BigDecimal interestRate;
    private int termMonths;
    private String status;
    private String purpose;
    private Date applicationDate;
    private Date approvalDate;
    private String approvedBy;

    public Loan() {}

    public Loan(int id, int userId, String loanType, BigDecimal amount, BigDecimal interestRate, int termMonths, String status, String purpose, Date applicationDate, Date approvalDate, String approvedBy) {
        this.id = id;
        this.userId = userId;
        this.loanType = loanType;
        this.amount = amount;
        this.interestRate = interestRate;
        this.termMonths = termMonths;
        this.status = status;
        this.purpose = purpose;
        this.applicationDate = applicationDate;
        this.approvalDate = approvalDate;
        this.approvedBy = approvedBy;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getLoanType() { return loanType; }
    public void setLoanType(String loanType) { this.loanType = loanType; }

    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }

    public BigDecimal getInterestRate() { return interestRate; }
    public void setInterestRate(BigDecimal interestRate) { this.interestRate = interestRate; }

    public int getTermMonths() { return termMonths; }
    public void setTermMonths(int termMonths) { this.termMonths = termMonths; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPurpose() { return purpose; }
    public void setPurpose(String purpose) { this.purpose = purpose; }

    public Date getApplicationDate() { return applicationDate; }
    public void setApplicationDate(Date applicationDate) { this.applicationDate = applicationDate; }

    public Date getApprovalDate() { return approvalDate; }
    public void setApprovalDate(Date approvalDate) { this.approvalDate = approvalDate; }

    public String getApprovedBy() { return approvedBy; }
    public void setApprovedBy(String approvedBy) { this.approvedBy = approvedBy; }
}
