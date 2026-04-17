// com/organlink/service/DonationRequestService.java
package com.organlink.service;
import com.organlink.dao.DonationRequestDao;
import com.organlink.dao.OrganDao;
import com.organlink.model.DonationRequest;
import com.organlink.model.Organ;
public class DonationRequestService {
    private final DonationRequestDao requestDao = new DonationRequestDao();
    private final OrganDao organDao = new OrganDao();
    public boolean submitRequest(int memberUserId, int organId) {
        Organ organ = organDao.findById(organId);
        if (organ == null || !"AVAILABLE".equals(organ.getStatus())) return false;
        DonationRequest req = new DonationRequest();
        req.setMemberId(memberUserId);
        req.setOrganId(organId);
        req.setHospitalId(organ.getHospitalId());
        return requestDao.insertRequest(req);
    }
    public boolean approveRequest(int requestId, int hospitalUserId) {
        DonationRequest req = requestDao.findById(requestId);
        if (req == null) return false;
        boolean approved = requestDao.approveRequest(requestId, hospitalUserId);
        if (approved) organDao.reserveOrgan(req.getOrganId());
        return approved;
    }
    public boolean completeRequest(int requestId) {
        DonationRequest req = requestDao.findById(requestId);
        if (req == null) return false;
        boolean completed = requestDao.completeRequest(requestId);
        if (completed) organDao.markTransplanted(req.getOrganId());
        return completed;
    }
    public boolean rejectRequest(int requestId) {
        return requestDao.rejectRequest(requestId);
    }
}