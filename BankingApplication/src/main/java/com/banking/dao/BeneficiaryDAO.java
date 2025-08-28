package com.banking.dao;

import com.banking.model.Beneficiary;
import com.banking.util.DatabaseUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BeneficiaryDAO {

    public boolean addBeneficiary(Beneficiary beneficiary) throws SQLException {
        String sql = "INSERT INTO beneficiaries (owner_user_id, beneficiary_user_id, beneficiary_account_id, nickname) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, beneficiary.getOwnerUserId());
            ps.setInt(2, beneficiary.getBeneficiaryUserId());
            ps.setInt(3, beneficiary.getBeneficiaryAccountId());
            ps.setString(4, beneficiary.getNickname());
            return ps.executeUpdate() > 0;
        }
    }

    public List<Beneficiary> getBeneficiariesByOwner(int ownerUserId) throws SQLException {
        List<Beneficiary> list = new ArrayList<>();
        String sql = "SELECT * FROM beneficiaries WHERE owner_user_id = ? ORDER BY id DESC";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ownerUserId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Beneficiary b = new Beneficiary(
                    rs.getInt("id"),
                    rs.getInt("owner_user_id"),
                    rs.getInt("beneficiary_user_id"),
                    rs.getInt("beneficiary_account_id"),
                    rs.getString("nickname")
                );
                list.add(b);
            }
        }
        return list;
    }

    public boolean deleteBeneficiary(int id, int ownerUserId) throws SQLException {
        String sql = "DELETE FROM beneficiaries WHERE id = ? AND owner_user_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setInt(2, ownerUserId);
            return ps.executeUpdate() > 0;
        }
    }
}


