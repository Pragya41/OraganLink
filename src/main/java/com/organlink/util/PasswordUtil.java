// com/organlink/util/PasswordUtil.java
package com.organlink.util;
import org.mindrot.jbcrypt.BCrypt;
public class PasswordUtil {
    private static final int WORK_FACTOR = 10;
    public static String hashPassword(String plaintext) {
        return BCrypt.hashpw(plaintext, BCrypt.gensalt(WORK_FACTOR));
    }
    public static boolean verifyPassword(String plaintext, String hashed) {
        if (plaintext == null || hashed == null) return false;
        try {
            return BCrypt.checkpw(plaintext, hashed);
        } catch (Exception e) {
            return false;
        }
    }
}