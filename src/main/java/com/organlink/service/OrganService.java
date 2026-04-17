// com/organlink/service/OrganService.java
package com.organlink.service;
import com.organlink.dao.OrganDao;
import com.organlink.model.Organ;
public class OrganService {
    private final OrganDao organDao = new OrganDao();
    public boolean addOrgan(int hospitalUserId, String organType, String bloodType) {
        Organ organ = new Organ();
        organ.setOrganType(organType);
        organ.setBloodType(bloodType);
        organ.setHospitalId(hospitalUserId);
        organ.setStatus("AVAILABLE");
        return organDao.insertOrgan(organ);
    }
    public boolean deleteOrgan(int organId, int hospitalUserId) {
        Organ organ = organDao.findById(organId);
        if (organ == null || organ.getHospitalId() != hospitalUserId) return false;
        return organDao.deleteOrgan(organId);
    }
}