// com/organlink/dao/OrganDao.java
package com.organlink.dao;

import com.organlink.config.DBConnection;
import com.organlink.model.Organ;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrganDao {

    private static final String BASE_SQL =
            "SELECT o.*, h.hospital_name FROM organs o " +
            "LEFT JOIN hospitals h ON o.hospital_id = h.user_id ";

    private Organ mapRow(ResultSet rs) throws SQLException {
        Organ o = new Organ();
        o.setId(rs.getInt("id"));
        o.setOrganType(rs.getString("organ_type"));
        o.setBloodType(rs.getString("blood_type"));
        o.setHospitalId(rs.getInt("hospital_id"));
        o.setStatus(rs.getString("status"));
        o.setRegisteredAt(rs.getTimestamp("registered_at"));
        o.setTransplantedAt(rs.getTimestamp("transplanted_at"));
        o.setHospitalName(rs.getString("hospital_name"));
        return o;
    }

    public List<Organ> findAll() {
        List<Organ> list = new ArrayList<>();

        try (Connection conn = DBConnection.getInstance().getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(BASE_SQL + "ORDER BY o.registered_at DESC")) {

            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            System.err.println("OrganDao.findAll: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return list;
    }

    public List<Organ> findAvailable() {
        List<Organ> list = new ArrayList<>();

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     BASE_SQL + "WHERE o.status = 'AVAILABLE' ORDER BY o.registered_at DESC")) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            System.err.println("OrganDao.findAvailable: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return list;
    }

    public List<Organ> findByHospital(int hospitalUserId) {
        List<Organ> list = new ArrayList<>();

        String sql = BASE_SQL + "WHERE o.hospital_id = ? ORDER BY o.registered_at DESC";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, hospitalUserId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            System.err.println("OrganDao.findByHospital: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return list;
    }

    public List<Organ> findAvailableByBloodType(String bloodType) {
        List<Organ> list = new ArrayList<>();

        String sql = BASE_SQL + "WHERE o.status = 'AVAILABLE' AND o.blood_type = ? ORDER BY o.registered_at DESC";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, bloodType);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            System.err.println("OrganDao.findAvailableByBloodType: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return list;
    }

    public Organ findById(int id) {
        String sql = BASE_SQL + "WHERE o.id = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return mapRow(rs);

        } catch (SQLException e) {
            System.err.println("OrganDao.findById: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return null;
    }

    public boolean insertOrgan(Organ organ) {
        String sql = "INSERT INTO organs (organ_type, blood_type, hospital_id) VALUES (?,?,?)";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, organ.getOrganType());
            ps.setString(2, organ.getBloodType());
            ps.setInt(3, organ.getHospitalId());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                ResultSet keys = ps.getGeneratedKeys();
                if (keys.next()) organ.setId(keys.getInt(1));
                return true;
            }

        } catch (SQLException e) {
            System.err.println("OrganDao.insertOrgan: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return false;
    }

    public boolean deleteOrgan(int id) {
        String sql = "DELETE FROM organs WHERE id = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("OrganDao.deleteOrgan: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public boolean reserveOrgan(int organId) {
        String sql = "UPDATE organs SET status = 'RESERVED' WHERE id = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, organId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("OrganDao.reserveOrgan: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public boolean markTransplanted(int organId) {
        String sql = "UPDATE organs SET status = 'TRANSPLANTED', transplanted_at = NOW() WHERE id = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, organId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("OrganDao.markTransplanted: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public int countByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM organs WHERE status = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return rs.getInt(1);

        } catch (SQLException e) {
            System.err.println("OrganDao.countByStatus: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return 0;
    }
}