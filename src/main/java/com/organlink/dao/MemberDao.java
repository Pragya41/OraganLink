// com/organlink/dao/MemberDao.java
package com.organlink.dao;

import com.organlink.config.DBConnection;
import com.organlink.model.Member;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MemberDao {

    public List<Member> findAll() {
        List<Member> list = new ArrayList<>();

        String sql = "SELECT m.*, u.username, u.full_name, u.email, u.phone " +
                     "FROM members m JOIN users u ON m.user_id = u.id ORDER BY m.id DESC";

        try (Connection conn = DBConnection.getInstance().getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                list.add(mapResultSet(rs));
            }

        } catch (SQLException e) {
            System.err.println("MemberDao.findAll: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return list;
    }

    public Member findByUserId(int userId) {
        String sql = "SELECT m.*, u.username, u.full_name, u.email, u.phone " +
                     "FROM members m JOIN users u ON m.user_id = u.id WHERE m.user_id = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return mapResultSet(rs);

        } catch (SQLException e) {
            System.err.println("MemberDao.findByUserId: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return null;
    }

    public boolean insertMember(Member member) {
        String sql = "INSERT INTO members (user_id, blood_type, address) VALUES (?,?,?)";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, member.getUserId());
            ps.setString(2, member.getBloodType());
            ps.setString(3, member.getAddress());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("MemberDao.insertMember: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public boolean updateMember(Member member) {
        String sql = "UPDATE members SET blood_type=?, address=? WHERE user_id=?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, member.getBloodType());
            ps.setString(2, member.getAddress());
            ps.setInt(3, member.getUserId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("MemberDao.updateMember: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    private Member mapResultSet(ResultSet rs) throws SQLException {
        Member m = new Member();
        m.setId(rs.getInt("id"));
        m.setUserId(rs.getInt("user_id"));
        m.setBloodType(rs.getString("blood_type"));
        m.setAddress(rs.getString("address"));
        m.setUsername(rs.getString("username"));
        m.setFullName(rs.getString("full_name"));
        m.setEmail(rs.getString("email"));
        m.setPhone(rs.getString("phone"));
        return m;
    }
}