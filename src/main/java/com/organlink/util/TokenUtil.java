// com/organlink/util/TokenUtil.java
package com.organlink.util;
import com.organlink.config.DBConnection;
import java.sql.*;
import java.util.UUID;
public class TokenUtil {
    public static String generateResetToken(int userId) {
        String token = UUID.randomUUID().toString();
        String sql = "INSERT INTO password_reset_tokens (user_id, token, expires_at) " +
                     "VALUES (?, ?, DATE_ADD(NOW(), INTERVAL 1 HOUR)) " +
                     "ON DUPLICATE KEY UPDATE token=VALUES(token), expires_at=VALUES(expires_at), used=0";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, token);
            ps.executeUpdate();
            return token;
        } catch (SQLException e) {
            System.err.println("TokenUtil.generateResetToken: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }
    public static int validateToken(String token) {
        String sql = "SELECT user_id FROM password_reset_tokens " +
                     "WHERE token=? AND used=0 AND expires_at > NOW()";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt("user_id");
        } catch (SQLException e) {
            System.err.println("TokenUtil.validateToken: " + e.getMessage());
        }
        return -1;
    }
    public static void markTokenUsed(String token) {
        String sql = "UPDATE password_reset_tokens SET used=1 WHERE token=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("TokenUtil.markTokenUsed: " + e.getMessage());
        }
    }
}