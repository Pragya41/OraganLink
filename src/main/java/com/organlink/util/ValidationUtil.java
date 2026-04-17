// com/organlink/util/ValidationUtil.java
package com.organlink.util;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.regex.Pattern;

public class ValidationUtil {

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

    private static final Pattern PHONE_PATTERN =
            Pattern.compile("^[0-9]{10}$");

    private static final Set<String> VALID_BLOOD_TYPES =
            new HashSet<>(Arrays.asList("A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"));

    public static boolean isNullOrEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }

    public static boolean containsDigit(String s) {
        if (s == null) return false;

        for (char c : s.toCharArray()) {
            if (Character.isDigit(c)) return true;
        }

        return false;
    }

    public static boolean isValidEmail(String email) {
        if (isNullOrEmpty(email)) return false;
        return EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    public static boolean isValidPhone(String phone) {
        if (isNullOrEmpty(phone)) return false;
        return PHONE_PATTERN.matcher(phone.trim()).matches();
    }

    public static boolean isValidBloodType(String bt) {
        if (isNullOrEmpty(bt)) return false;
        return VALID_BLOOD_TYPES.contains(bt.trim());
    }

    /**
     * Check blood type compatibility for organ donation.
     * O- is universal donor; AB+ is universal recipient.
     */
    public static boolean isCompatible(String donorBloodType, String recipientBloodType) {
        if (donorBloodType == null || recipientBloodType == null) return false;

        if (donorBloodType.equals("O-")) return true;
        if (recipientBloodType.equals("AB+")) return true;
        if (donorBloodType.equals(recipientBloodType)) return true;

        // Basic ABO compatibility
        String donorABO = donorBloodType.replace("+", "").replace("-", "");
        String recipientABO = recipientBloodType.replace("+", "").replace("-", "");

        if (donorABO.equals("O")) return true;

        if (donorABO.equals("A") &&
                (recipientABO.equals("A") || recipientABO.equals("AB"))) return true;

        if (donorABO.equals("B") &&
                (recipientABO.equals("B") || recipientABO.equals("AB"))) return true;

        return donorABO.equals(recipientABO);
    }
}