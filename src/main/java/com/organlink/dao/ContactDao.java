// com/organlink/dao/ContactDao.java
package com.organlink.dao;

import com.organlink.model.ContactQuery;
import com.organlink.config.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ContactDao {

    public boolean insertQuery(ContactQuery query) {
        String sql = "INSERT INTO contact_queries (full_name, phone, query) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, query.getFullName());
            ps.setString(2, query.getPhone());
            ps.setString(3, query.getQuery());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public java.util.List<ContactQuery> findAll() {
        java.util.List<ContactQuery> list = new java.util.ArrayList<>();
        String sql = "SELECT * FROM contact_queries ORDER BY submitted_at DESC";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             java.sql.ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ContactQuery q = new ContactQuery();
                q.setId(rs.getInt("id"));
                q.setFullName(rs.getString("full_name"));
                q.setPhone(rs.getString("phone"));
                q.setQuery(rs.getString("query"));
                q.setSubmittedAt(rs.getTimestamp("submitted_at"));
                list.add(q);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public ContactQuery findById(int id) {
        String sql = "SELECT * FROM contact_queries WHERE id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (java.sql.ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ContactQuery q = new ContactQuery();
                    q.setId(rs.getInt("id"));
                    q.setFullName(rs.getString("full_name"));
                    q.setPhone(rs.getString("phone"));
                    q.setQuery(rs.getString("query"));
                    q.setSubmittedAt(rs.getTimestamp("submitted_at"));
                    return q;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean deleteQuery(int id) {
        String sql = "DELETE FROM contact_queries WHERE id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
