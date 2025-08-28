package com.banking.service;

import com.banking.dao.BeneficiaryDAO;
import com.banking.model.Beneficiary;
import java.sql.SQLException;
import java.util.List;

public class BeneficiaryService {
    private BeneficiaryDAO beneficiaryDAO;

    public BeneficiaryService() {
        this.beneficiaryDAO = new BeneficiaryDAO();
    }

    public boolean addBeneficiary(Beneficiary beneficiary) throws SQLException {
        if (beneficiary == null || beneficiary.getOwnerUserId() <= 0 || beneficiary.getBeneficiaryAccountId() <= 0) {
            return false;
        }
        return beneficiaryDAO.addBeneficiary(beneficiary);
    }

    public List<Beneficiary> getBeneficiariesByOwner(int ownerUserId) throws SQLException {
        if (ownerUserId <= 0) { return null; }
        return beneficiaryDAO.getBeneficiariesByOwner(ownerUserId);
    }

    public boolean deleteBeneficiary(int id, int ownerUserId) throws SQLException {
        if (id <= 0 || ownerUserId <= 0) { return false; }
        return beneficiaryDAO.deleteBeneficiary(id, ownerUserId);
    }
}


