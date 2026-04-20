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
        
        // User Stats
        stats.put("totalHospitals", userDao.countByRole("HOSPITAL"));
        stats.put("totalMembers", userDao.countByRole("MEMBER"));
        // Assuming all members can be both or we need a donor/recipient flag?
        // For now, let's just use the totals or add logic if flags exist.
        // If flags don't exist, I'll just use total members for both for now or check MemberDao.
        
        // Organ Stats
        stats.put("organsAvailable", organDao.countByStatus("AVAILABLE"));
        stats.put("organsReserved", organDao.countByStatus("RESERVED"));
        stats.put("organsTransplanted", organDao.countByStatus("TRANSPLANTED"));
        
        // Request Stats
        java.util.List<com.organlink.model.DonationRequest> allReqs = requestDao.findAll();
        int pending = 0, approved = 0, completed = 0, rejected = 0;
        for (com.organlink.model.DonationRequest r : allReqs) {
            if ("PENDING".equals(r.getStatus())) pending++;
            else if ("APPROVED".equals(r.getStatus())) approved++;
            else if ("COMPLETED".equals(r.getStatus())) completed++;
            else if ("REJECTED".equals(r.getStatus())) rejected++;
        }
        
        stats.put("totalRequests", allReqs.size());
        stats.put("requestsPending", pending);
        stats.put("requestsApproved", approved);
        stats.put("requestsCompleted", completed);
        stats.put("requestsRejected", rejected);
        
        return stats;
    }
    public Map<String, Integer> getHospitalStats(int hospitalUserId) {
        Map<String, Integer> stats = new HashMap<>();
        
        // Organ Stats
        java.util.List<com.organlink.model.Organ> myOrgans = organDao.findByHospital(hospitalUserId);
        int total = myOrgans.size();
        int available = 0;
        int reserved = 0;
        int transplanted = 0;
        
        for (com.organlink.model.Organ o : myOrgans) {
            if ("AVAILABLE".equals(o.getStatus())) available++;
            else if ("RESERVED".equals(o.getStatus())) reserved++;
            else if ("TRANSPLANTED".equals(o.getStatus())) transplanted++;
        }
        
        stats.put("totalOrgans", total);
        stats.put("availableOrgans", available);
        stats.put("reservedOrgans", reserved);
        stats.put("transplantedOrgans", transplanted);

        // Request Stats
        int pending = requestDao.findByHospitalAndStatus(hospitalUserId, "PENDING").size();
        int approved = requestDao.findByHospitalAndStatus(hospitalUserId, "APPROVED").size();
        int completed = requestDao.findByHospitalAndStatus(hospitalUserId, "COMPLETED").size();
        int totalReqs = pending + approved + completed + requestDao.findByHospitalAndStatus(hospitalUserId, "REJECTED").size();

        stats.put("totalRequests", totalReqs);
        stats.put("pendingRequests", pending);
        stats.put("approvedRequests", approved);
        stats.put("completedRequests", completed);
        
        return stats;
    }
    public Map<String, Integer> getMemberStats(int memberUserId, String bloodType) {
        Map<String, Integer> stats = new HashMap<>();
        
        // Organ stats
        java.util.List<com.organlink.model.Organ> allAvailable = organDao.findAvailable();
        int compatibleCount = 0;
        if (bloodType != null) {
            for (com.organlink.model.Organ o : allAvailable) {
                if (com.organlink.util.ValidationUtil.isCompatible(o.getBloodType(), bloodType)) {
                    compatibleCount++;
                }
            }
        }
        
        stats.put("totalAvailable", allAvailable.size());
        stats.put("compatible", compatibleCount);

        // My request stats
        stats.put("myRequests", requestDao.findByMember(memberUserId).size());
        stats.put("pending", requestDao.countByMemberAndStatus(memberUserId, "PENDING"));
        stats.put("approved", requestDao.countByMemberAndStatus(memberUserId, "APPROVED"));
        stats.put("completed", requestDao.countByMemberAndStatus(memberUserId, "COMPLETED"));
        stats.put("rejected", requestDao.countByMemberAndStatus(memberUserId, "REJECTED"));
        
        return stats;
    }
}