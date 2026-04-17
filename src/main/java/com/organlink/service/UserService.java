// com/organlink/service/UserService.java
package com.organlink.service;
import com.organlink.dao.HospitalDao;
import com.organlink.dao.MemberDao;
import com.organlink.dao.UserDao;
import com.organlink.model.Hospital;
import com.organlink.model.Member;
import com.organlink.model.User;
import com.organlink.util.PasswordUtil;
import com.organlink.util.ValidationUtil;
public class UserService {
    private final UserDao userDao = new UserDao();
    private final HospitalDao hospitalDao = new HospitalDao();
    private final MemberDao memberDao = new MemberDao();
    /**
     * Registers a new user. Returns null on success, or an error key string on failure.
     */
    public String register(String username, String password, String fullName,
                           String email, String phone, String role,
                           String bloodType, String address, String hospitalName, String licenseNo) {
        if (ValidationUtil.isNullOrEmpty(fullName)) return "fullName";
        if (ValidationUtil.containsDigit(fullName)) return "fullNameDigit";
        if (!userDao.isUsernameUnique(username)) return "username";
        if (!ValidationUtil.isValidEmail(email)) return "email";
        if (!userDao.isEmailUnique(email)) return "emailDuplicate";
        if (!ValidationUtil.isValidPhone(phone)) return "phone";
        if (!userDao.isPhoneUnique(phone)) return "phoneDuplicate";
        if ("MEMBER".equals(role) && !ValidationUtil.isValidBloodType(bloodType)) return "bloodType";
        User user = new User(username, PasswordUtil.hashPassword(password),
                             fullName, email, phone, role);
        if (!userDao.insertUser(user)) return "dbError";
        if ("HOSPITAL".equals(role)) {
            Hospital h = new Hospital();
            h.setUserId(user.getId());
            h.setHospitalName(ValidationUtil.isNullOrEmpty(hospitalName) ? fullName : hospitalName);
            h.setAddress(address);
            h.setLicenseNo(licenseNo);
            hospitalDao.insertHospital(h);
        } else if ("MEMBER".equals(role)) {
            Member m = new Member();
            m.setUserId(user.getId());
            m.setBloodType(bloodType);
            m.setAddress(address);
            memberDao.insertMember(m);
        }
        return null; // success
    }
}