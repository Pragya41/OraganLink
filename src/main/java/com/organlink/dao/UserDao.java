// com/organlink/dao/UserDao.java
package com.organlink.dao;
import com.organlink.config.DBConnection;
import com.organlink.model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class UserDao {
    private User mapRow(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setUsername(rs.getString("username"));
        u.setPassword(rs.getString("password"));
        u.setFullName(rs.getString("full_name"));
        u.setEmail(rs.getString("email"));
        u.setPhone(rs.getString("phone"));
        u.setRole(rs.getString("role"));
        u.setLocked(rs.getBoolean("is_locked"));
        u.setCreatedAt(rs.getTimestamp("created_at"));
        return u;
    }
    public User findByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            System.err.println("UserDao.findByUsername: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return null;
    }
    public User findById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            System.err.println("UserDao.findById: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return null;
    }
    public List<User> findAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getInstance().getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("UserDao.findAll: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return list;
    }
    public List<User> findByRole(String role) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = ? ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, role);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
        	 System.err.println("UserDao.findByRole: " + e.getMessage());
             throw new RuntimeException(e);
         }
         return list;
     }
     public boolean insertUser(User user) {
         String sql = "INSERT INTO users (username, password, full_name, email, phone, role) VALUES (?,?,?,?,?,?)";
         try (Connection conn = DBConnection.getInstance().getConnection();
              PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
             ps.setString(1, user.getUsername());
             ps.setString(2, user.getPassword());
             ps.setString(3, user.getFullName());
             ps.setString(4, user.getEmail());
             ps.setString(5, user.getPhone());
             ps.setString(6, user.getRole());
             int rows = ps.executeUpdate();
             if (rows > 0) {
                 ResultSet keys = ps.getGeneratedKeys();
                 if (keys.next()) user.setId(keys.getInt(1));
                 return true;
             }
         } catch (SQLException e) {
             System.err.println("UserDao.insertUser: " + e.getMessage());
             throw new RuntimeException(e);
         }
         return false;
     }
     public boolean updateUser(User user) {
         String sql = "UPDATE users SET full_name=?, email=?, phone=?, is_locked=? WHERE id=?";
         try (Connection conn = DBConnection.getInstance().getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {
             ps.setString(1, user.getFullName());
             ps.setString(2, user.getEmail());
             ps.setString(3, user.getPhone());
             ps.setBoolean(4, user.isLocked());
             ps.setInt(5, user.getId());
             return ps.executeUpdate() > 0;
         } catch (SQLException e) {
             System.err.println("UserDao.updateUser: " + e.getMessage());
             throw new RuntimeException(e);
         }
     }
     public boolean updateProfileInfo(int id, String fullName, String email, String phone) {
         String sql = "UPDATE users SET full_name=?, email=?, phone=? WHERE id=?";
         try (Connection conn = DBConnection.getInstance().getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {
             ps.setString(1, fullName);
             ps.setString(2, email);
             ps.setString(3, phone);
             ps.setInt(4, id);
             return ps.executeUpdate() > 0;
         } catch (SQLException e) {
             System.err.println("UserDao.updateProfileInfo: " + e.getMessage());
             throw new RuntimeException(e);
         }
     }
     public boolean updatePassword(int userId, String hashedPassword) {
         String sql = "UPDATE users SET password=? WHERE id=?";
         try (Connection conn = DBConnection.getInstance().getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {
             ps.setString(1, hashedPassword);
             ps.setInt(2, userId);
             return ps.executeUpdate() > 0;
         } catch (SQLException e) {
             System.err.println("UserDao.updatePassword: " + e.getMessage());
             throw new RuntimeException(e);
         }
     }
     public boolean deleteUser(int id) {
         String sql = "DELETE FROM users WHERE id = ?";
         try (Connection conn = DBConnection.getInstance().getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {
             ps.setInt(1, id);
             return ps.executeUpdate() > 0;
         } catch (SQLException e) {
             System.err.println("UserDao.deleteUser: " + e.getMessage());
             throw new RuntimeException(e);
         }
     }
     public boolean removeLastByRole(String role) {
         String sql = "DELETE FROM users WHERE role = ? ORDER BY id DESC LIMIT 1";
         try (Connection conn = DBConnection.getInstance().getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {
             ps.setString(1, role);
             return ps.executeUpdate() > 0;
         } catch (SQLException e) {
             System.err.println("UserDao.removeLastByRole: " + e.getMessage());
             throw new RuntimeException(e);
         }
     }
     public int countByRole(String role) {
         String sql = "SELECT COUNT(*) FROM users WHERE role = ?";
         try (Connection conn = DBConnection.getInstance().getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {
             ps.setString(1, role);
             ResultSet rs = ps.executeQuery();
             if (rs.next()) return rs.getInt(1);
         } catch (SQLException e) {
             System.err.println("UserDao.countByRole: " + e.getMessage());
             throw new RuntimeException(e);
         }
         return 0;
     }
     public boolean isUsernameUnique(String username) {
         String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
         try (Connection conn = DBConnection.getInstance().getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {
             ps.setString(1, username);
             ResultSet rs = ps.executeQuery();
             if (rs.next()) return rs.getInt(1) == 0;
         } catch (SQLException e) {
             System.err.println("UserDao.isUsernameUnique: " + e.getMessage());
         }
         return false;
     }
     public boolean isPhoneUnique(String phone) {
         String sql = "SELECT COUNT(*) FROM users WHERE phone = ?";
         try (Connection conn = DBConnection.getInstance().getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {
             ps.setString(1, phone);
             ResultSet rs = ps.executeQuery();
             if (rs.next()) return rs.getInt(1) == 0;
         } catch (SQLException e) {
             System.err.println("UserDao.isPhoneUnique: " + e.getMessage());
         }
         return false;
     }
     public boolean isEmailUnique(String email) {
         String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
         try (Connection conn = DBConnection.getInstance().getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {
             ps.setString(1, email);
             ResultSet rs = ps.executeQuery();
             if (rs.next()) return rs.getInt(1) == 0;
         } catch (SQLException e) {
             System.err.println("UserDao.isEmailUnique: " + e.getMessage());
         }
         return false;
     }
     public boolean setLockStatus(int id, boolean locked) {
         String sql = "UPDATE users SET is_locked=? WHERE id=?";
         try (Connection conn = DBConnection.getInstance().getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {
             ps.setBoolean(1, locked);
             ps.setInt(2, id);
             return ps.executeUpdate() > 0;
         } catch (SQLException e) {
             System.err.println("UserDao.setLockStatus: " + e.getMessage());
             throw new RuntimeException(e);
         }
     }
 }