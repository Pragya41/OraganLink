// com/organlink/config/DBConnection.java
package com.organlink.config;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class DBConnection {
    private static final String URL = 
"jdbc:mysql://localhost:3306/organlink_db?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private static DBConnection instance;
    private DBConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = getConnection()) {
                initializeDatabase(conn);
            } catch (SQLException e) {
                System.err.println("DBConnection: failed to run auto-migrations: " + e.getMessage());
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL Driver not found", e);
        }
    }
    public static synchronized DBConnection getInstance() {
        if (instance == null) {
            instance = new DBConnection();
        }
        return instance;
    }
    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
    private void initializeDatabase(Connection conn) throws SQLException {
        try (java.sql.Statement stmt = conn.createStatement()) {
            stmt.execute("CREATE TABLE IF NOT EXISTS contact_queries (" +
                         "id INT AUTO_INCREMENT PRIMARY KEY, " +
                         "full_name VARCHAR(100) NOT NULL, " +
                         "phone VARCHAR(15) NOT NULL, " +
                         "query TEXT NOT NULL, " +
                         "submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                         ")");
            
            stmt.execute("CREATE TABLE IF NOT EXISTS password_reset_tokens (" +
                         "user_id INT PRIMARY KEY, " +
                         "token VARCHAR(255) NOT NULL, " +
                         "expires_at TIMESTAMP NOT NULL, " +
                         "used TINYINT DEFAULT 0, " +
                         "FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE" +
                         ")");
        }
    }
}