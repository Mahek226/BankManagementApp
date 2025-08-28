package com.banking.model;

public class Beneficiary {
    private int id;
    private int ownerUserId;
    private int beneficiaryUserId;
    private int beneficiaryAccountId;
    private String nickname;

    public Beneficiary() {}

    public Beneficiary(int id, int ownerUserId, int beneficiaryUserId, int beneficiaryAccountId, String nickname) {
        this.id = id;
        this.ownerUserId = ownerUserId;
        this.beneficiaryUserId = beneficiaryUserId;
        this.beneficiaryAccountId = beneficiaryAccountId;
        this.nickname = nickname;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getOwnerUserId() { return ownerUserId; }
    public void setOwnerUserId(int ownerUserId) { this.ownerUserId = ownerUserId; }

    public int getBeneficiaryUserId() { return beneficiaryUserId; }
    public void setBeneficiaryUserId(int beneficiaryUserId) { this.beneficiaryUserId = beneficiaryUserId; }

    public int getBeneficiaryAccountId() { return beneficiaryAccountId; }
    public void setBeneficiaryAccountId(int beneficiaryAccountId) { this.beneficiaryAccountId = beneficiaryAccountId; }

    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }
}


