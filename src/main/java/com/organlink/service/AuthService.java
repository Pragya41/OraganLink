// com/organlink/service/AuthService.java
package com.organlink.service;

import com.organlink.config.DBConnection;
import com.organlink.dao.UserDao;
import com.organlink.model.User;
import com.organlink.util.PasswordUtil;
import com.organlink.util.TokenUtil;

import java.sql.*;

public class AuthService {

    private final UserDao userDao = new UserDao();

    public User login(String username, String password) {
        User user = userDao.findByUsername(username);

        if (user == null) return null;
        
        if (user.isLocked() || isAccountLocked(user.getId())) {
            throw new RuntimeException("LOCKED");
        }

        if (!PasswordUtil.verifyPassword(password, user.getPassword())) {
            recordFailedAttempt(user.getId());
            return null;
        }

        resetAttempts(user.getId());
        return user;
    }

    public void recordFailedAttempt(int userId) {
        String sql =
                "INSERT INTO login_attempts (user_id, attempt_count, last_attempt) VALUES " +
                "(?,1,NOW()) " +
                "ON DUPLICATE KEY UPDATE attempt_count=attempt_count+1, last_attempt=NOW()";

        String lockSql =
                "UPDATE login_attempts SET locked_until=DATE_ADD(NOW(), INTERVAL 15 MINUTE) " +
                "WHERE user_id=? AND attempt_count >= 5";

        try (Connection conn = DBConnection.getInstance().getConnection()) {

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.executeUpdate();

            PreparedStatement lock = conn.prepareStatement(lockSql);
            lock.setInt(1, userId);
            lock.executeUpdate();

        } catch (SQLException e) {
            System.err.println("AuthService.recordFailedAttempt: " + e.getMessage());
        }
    }

    public void resetAttempts(int userId) {
        String sql = "UPDATE login_attempts SET attempt_count=0, locked_until=NULL WHERE user_id=?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.executeUpdate();

        } catch (SQLException e) {
            System.err.println("AuthService.resetAttempts: " + e.getMessage());
        }
    }

    public boolean isAccountLocked(int userId) {
        String sql = "SELECT locked_until FROM login_attempts WHERE user_id=?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Timestamp lockedUntil = rs.getTimestamp("locked_until");

                if (lockedUntil != null && lockedUntil.after(new java.util.Date())) {
                    return true;
                }
            }

        } catch (SQLException e) {
            System.err.println("AuthService.isAccountLocked: " + e.getMessage());
        }

        return false;
    }

    public String generateResetToken(int userId) {
        return TokenUtil.generateResetToken(userId);
    }

    public boolean resetPassword(String token, String newPassword) {
        int userId = TokenUtil.validateToken(token);

        if (userId == -1) return false;

        String hashed = PasswordUtil.hashPassword(newPassword);
        boolean updated = userDao.updatePassword(userId, hashed);

        if (updated) TokenUtil.markTokenUsed(token);

        return updated;
    }
}