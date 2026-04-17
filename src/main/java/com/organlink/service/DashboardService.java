// com/organlink/service/DashboardService.java
package com.organlink.service;
import com.organlink.dao.*;
import java.util.HashMap;
import java.util.Map;
public class DashboardService {
    private final UserDao userDao = new UserDao();
    private final OrganDao organDao = new OrganDao();
    private final DonationRequestDao requestDao = new DonationRequestDao();
    public Map<String, Integer> getAdminStats() {
        Map<String, Integer> stats = new HashMap<>();
        stats.put("totalHospitals", userDao.countByRole("HOSPITAL"));
        stats.put("totalMembers", userDao.countByRole("MEMBER"));
        stats.put("organsAvailable", organDao.countByStatus("AVAILABLE"));
        stats.put("requestsPending", requestDao.countByStatus("PENDING"));
        stats.put("transplantsDone", requestDao.countByStatus("COMPLETED"));
        return stats;
    }
    public Map<String, Integer> getHospitalStats(int hospitalUserId) {
        Map<String, Integer> stats = new HashMap<>();
        long myOrgans = organDao.findByHospital(hospitalUserId).size();
        long pending = requestDao.findByHospitalAndStatus(hospitalUserId, "PENDING").size();
        long approved = requestDao.findByHospitalAndStatus(hospitalUserId, "APPROVED").size();
        long done = requestDao.findByHospitalAndStatus(hospitalUserId, "COMPLETED").size();
        stats.put("myOrgans", (int) myOrgans);
        stats.put("requestsPending", (int) pending);
        stats.put("requestsApproved",(int) approved);
        stats.put("transplantsDone", (int) done);
        return stats;
    }
    public Map<String, Integer> getMemberStats(int memberUserId) {
        Map<String, Integer> stats = new HashMap<>();
        stats.put("myRequests", requestDao.findByMember(memberUserId).size());
        stats.put("pending", requestDao.countByMemberAndStatus(memberUserId, "PENDING"));
        stats.put("approved", requestDao.countByMemberAndStatus(memberUserId, "APPROVED"));
        stats.put("completed", requestDao.countByMemberAndStatus(memberUserId, "COMPLETED"));
        return stats;
    }
}