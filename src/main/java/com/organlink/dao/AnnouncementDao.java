// com/organlink/dao/AnnouncementDao.java
package com.organlink.dao;

import com.organlink.config.DBConnection;
import com.organlink.model.Announcement;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AnnouncementDao {

    private Announcement mapRow(ResultSet rs) throws SQLException {
        Announcement a = new Announcement();
        a.setId(rs.getInt("id"));
        a.setTitle(rs.getString("title"));
        a.setDescription(rs.getString("description"));
        a.setCreatedBy(rs.getInt("created_by"));
        a.setCreatedAt(rs.getTimestamp("created_at"));
        a.setUpdatedAt(rs.getTimestamp("updated_at"));

        try {
            a.setCreatedByName(rs.getString("full_name"));
        } catch (SQLException ignored) {}

        return a;
    }

    public List<Announcement> findAll() {
        List<Announcement> list = new ArrayList<>();

        String sql =
                "SELECT a.*, u.full_name FROM announcements a JOIN users u ON a.created_by = u.id " +
                "ORDER BY a.created_at DESC";

        try (Connection conn = DBConnection.getInstance().getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            System.err.println("AnnouncementDao.findAll: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return list;
    }

    public List<Announcement> findByAuthor(int userId) {
        List<Announcement> list = new ArrayList<>();

        String sql =
                "SELECT a.*, u.full_name FROM announcements a JOIN users u ON a.created_by = u.id " +
                "WHERE a.created_by = ? ORDER BY a.created_at DESC";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            System.err.println("AnnouncementDao.findByAuthor: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return list;
    }

    public List<Announcement> findRecent(int limit) {
        List<Announcement> list = new ArrayList<>();

        String sql =
                "SELECT a.*, u.full_name FROM announcements a JOIN users u ON a.created_by = u.id " +
                "ORDER BY a.created_at DESC LIMIT ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            System.err.println("AnnouncementDao.findRecent: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return list;
    }

    public Announcement findById(int id) {
        String sql =
                "SELECT a.*, u.full_name FROM announcements a JOIN users u ON a.created_by = u.id " +
                "WHERE a.id = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return mapRow(rs);

        } catch (SQLException e) {
            System.err.println("AnnouncementDao.findById: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return null;
    }

    public boolean insertAnnouncement(Announcement a) {
        String sql =
                "INSERT INTO announcements (title, description, created_by) VALUES (?,?,?)";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, a.getTitle());
            ps.setString(2, a.getDescription());
            ps.setInt(3, a.getCreatedBy());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                ResultSet keys = ps.getGeneratedKeys();
                if (keys.next()) a.setId(keys.getInt(1));
                return true;
            }

        } catch (SQLException e) {
            System.err.println("AnnouncementDao.insertAnnouncement: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return false;
    }

    public boolean updateAnnouncement(Announcement a) {
        String sql = "UPDATE announcements SET title=?, description=? WHERE id=?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, a.getTitle());
            ps.setString(2, a.getDescription());
            ps.setInt(3, a.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("AnnouncementDao.updateAnnouncement: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public boolean deleteAnnouncement(int id) {
        String sql = "DELETE FROM announcements WHERE id = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("AnnouncementDao.deleteAnnouncement: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }
}