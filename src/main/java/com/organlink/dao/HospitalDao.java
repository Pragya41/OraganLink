// com/organlink/dao/HospitalDao.java
package com.organlink.dao;

import com.organlink.config.DBConnection;
import com.organlink.model.Hospital;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HospitalDao {

    private Hospital mapRow(ResultSet rs) throws SQLException {
        Hospital h = new Hospital();
        h.setId(rs.getInt("h.id"));
        h.setUserId(rs.getInt("h.user_id"));
        h.setHospitalName(rs.getString("h.hospital_name"));
        h.setAddress(rs.getString("h.address"));
        h.setLicenseNo(rs.getString("h.license_no"));
        h.setUsername(rs.getString("u.username"));
        h.setFullName(rs.getString("u.full_name"));
        h.setEmail(rs.getString("u.email"));
        h.setPhone(rs.getString("u.phone"));
        return h;
    }

    public List<Hospital> findAll() {
        List<Hospital> list = new ArrayList<>();

        String sql = "SELECT h.*, u.username, u.full_name, u.email, u.phone " +
                     "FROM hospitals h JOIN users u ON h.user_id = u.id ORDER BY h.id DESC";

        try (Connection conn = DBConnection.getInstance().getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Hospital h = new Hospital();
                h.setId(rs.getInt("id"));
                h.setUserId(rs.getInt("user_id"));
                h.setHospitalName(rs.getString("hospital_name"));
                h.setAddress(rs.getString("address"));
                h.setLicenseNo(rs.getString("license_no"));
                h.setUsername(rs.getString("username"));
                h.setFullName(rs.getString("full_name"));
                h.setEmail(rs.getString("email"));
                h.setPhone(rs.getString("phone"));
                list.add(h);
            }

        } catch (SQLException e) {
            System.err.println("HospitalDao.findAll: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return list;
    }

    public Hospital findByUserId(int userId) {
        String sql = "SELECT h.*, u.username, u.full_name, u.email, u.phone " +
                     "FROM hospitals h JOIN users u ON h.user_id = u.id WHERE h.user_id = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Hospital h = new Hospital();
                h.setId(rs.getInt("id"));
                h.setUserId(rs.getInt("user_id"));
                h.setHospitalName(rs.getString("hospital_name"));
                h.setAddress(rs.getString("address"));
                h.setLicenseNo(rs.getString("license_no"));
                h.setUsername(rs.getString("username"));
                h.setFullName(rs.getString("full_name"));
                h.setEmail(rs.getString("email"));
                h.setPhone(rs.getString("phone"));
                return h;
            }

        } catch (SQLException e) {
            System.err.println("HospitalDao.findByUserId: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return null;
    }

    public boolean insertHospital(Hospital hospital) {
        String sql = "INSERT INTO hospitals (user_id, hospital_name, address, license_no) VALUES (?,?,?,?)";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, hospital.getUserId());
            ps.setString(2, hospital.getHospitalName());
            ps.setString(3, hospital.getAddress());
            ps.setString(4, hospital.getLicenseNo());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("HospitalDao.insertHospital: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public boolean updateHospital(Hospital hospital) {
        String sql = "UPDATE hospitals SET hospital_name=?, address=?, license_no=? WHERE user_id=?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, hospital.getHospitalName());
            ps.setString(2, hospital.getAddress());
            ps.setString(3, hospital.getLicenseNo());
            ps.setInt(4, hospital.getUserId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("HospitalDao.updateHospital: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }
}