// com/organlink/dao/DonationRequestDao.java
package com.organlink.dao;

import com.organlink.config.DBConnection;
import com.organlink.model.DonationRequest;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DonationRequestDao {

    private static final String BASE_SQL =
            "SELECT dr.*, u.full_name AS member_name, o.organ_type, o.blood_type, " +
            "h.hospital_name FROM donation_requests dr " +
            "JOIN users u ON dr.member_id = u.id " +
            "JOIN organs o ON dr.organ_id = o.id " +
            "LEFT JOIN hospitals h ON dr.hospital_id = h.user_id ";

    private DonationRequest mapRow(ResultSet rs) throws SQLException {
        DonationRequest dr = new DonationRequest();
        dr.setId(rs.getInt("id"));
        dr.setMemberId(rs.getInt("member_id"));
        dr.setOrganId(rs.getInt("organ_id"));
        dr.setHospitalId(rs.getInt("hospital_id"));
        dr.setStatus(rs.getString("status"));
        dr.setRequestedAt(rs.getTimestamp("requested_at"));
        dr.setResolvedAt(rs.getTimestamp("resolved_at"));
        dr.setMemberName(rs.getString("member_name"));
        dr.setOrganType(rs.getString("organ_type"));
        dr.setBloodType(rs.getString("blood_type"));
        dr.setHospitalName(rs.getString("hospital_name"));
        return dr;
    }

    public List<DonationRequest> findAll() {
        List<DonationRequest> list = new ArrayList<>();

        try (Connection conn = DBConnection.getInstance().getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(BASE_SQL + "ORDER BY dr.requested_at DESC")) {

            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            System.err.println("DonationRequestDao.findAll: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return list;
    }

    public List<DonationRequest> findByMember(int memberUserId) {
        List<DonationRequest> list = new ArrayList<>();

        String sql = BASE_SQL + "WHERE dr.member_id = ? ORDER BY dr.requested_at DESC";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, memberUserId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            System.err.println("DonationRequestDao.findByMember: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return list;
    }

    public List<DonationRequest> findByHospital(int hospitalUserId) {
        List<DonationRequest> list = new ArrayList<>();

        String sql = BASE_SQL + "WHERE dr.hospital_id = ? ORDER BY dr.requested_at DESC";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, hospitalUserId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            System.err.println("DonationRequestDao.findByHospital: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return list;
    }

    public List<DonationRequest> findByHospitalAndStatus(int hospitalUserId, String status) {
        List<DonationRequest> list = new ArrayList<>();

        String sql = BASE_SQL + "WHERE dr.hospital_id = ? AND dr.status = ? ORDER BY dr.requested_at DESC";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, hospitalUserId);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            System.err.println("DonationRequestDao.findByHospitalAndStatus: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return list;
    }

    public List<DonationRequest> findByStatus(String status) {
        List<DonationRequest> list = new ArrayList<>();

        String sql = BASE_SQL + "WHERE dr.status = ? ORDER BY dr.requested_at DESC";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            System.err.println("DonationRequestDao.findByStatus: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return list;
    }

    public boolean insertRequest(DonationRequest req) {

        String checkSql =
                "SELECT COUNT(*) FROM donation_requests WHERE member_id=? AND organ_id=? AND status IN ('PENDING','APPROVED')";

        String insertSql =
                "INSERT INTO donation_requests (member_id, organ_id, hospital_id, status) VALUES (?,?,?,?)";

        try (Connection conn = DBConnection.getInstance().getConnection()) {

            PreparedStatement check = conn.prepareStatement(checkSql);
            check.setInt(1, req.getMemberId());
            check.setInt(2, req.getOrganId());

            ResultSet rs = check.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) return false;

            PreparedStatement ps = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, req.getMemberId());
            ps.setInt(2, req.getOrganId());
            ps.setInt(3, req.getHospitalId());
            ps.setString(4, "PENDING");

            int rows = ps.executeUpdate();

            if (rows > 0) {
                ResultSet keys = ps.getGeneratedKeys();
                if (keys.next()) req.setId(keys.getInt(1));
                return true;
            }

        } catch (SQLException e) {
            System.err.println("DonationRequestDao.insertRequest: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return false;
    }

    public boolean approveRequest(int requestId, int hospitalUserId) {
        String sql = "UPDATE donation_requests SET status='APPROVED', hospital_id=? WHERE id=? AND status='PENDING'";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, hospitalUserId);
            ps.setInt(2, requestId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("DonationRequestDao.approveRequest: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public boolean completeRequest(int requestId) {
        String sql = "UPDATE donation_requests SET status='COMPLETED', resolved_at=NOW() WHERE id=? AND status='APPROVED'";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, requestId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("DonationRequestDao.completeRequest: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public boolean rejectRequest(int requestId) {
        String sql = "UPDATE donation_requests SET status='REJECTED', resolved_at=NOW() WHERE id=?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, requestId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("DonationRequestDao.rejectRequest: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public int countByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM donation_requests WHERE status = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return rs.getInt(1);

        } catch (SQLException e) {
            System.err.println("DonationRequestDao.countByStatus: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return 0;
    }

    public int countByMemberAndStatus(int memberId, String status) {
        String sql = "SELECT COUNT(*) FROM donation_requests WHERE member_id=? AND status=?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, memberId);
            ps.setString(2, status);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) return rs.getInt(1);

        } catch (SQLException e) {
            System.err.println("DonationRequestDao.countByMemberAndStatus: " + e.getMessage());
        }

        return 0;
    }

    public DonationRequest findById(int id) {
        String sql = BASE_SQL + "WHERE dr.id = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return mapRow(rs);

        } catch (SQLException e) {
            System.err.println("DonationRequestDao.findById: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return null;
    }

    public boolean deleteRequest(int id) {
        String sql = "DELETE FROM donation_requests WHERE id = ?";
        try (java.sql.Connection conn = com.organlink.config.DBConnection.getInstance().getConnection();
             java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (java.sql.SQLException e) {
            System.err.println("DonationRequestDao.deleteRequest: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }
}
