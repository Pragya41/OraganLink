// com/organlink/model/Organ.java
package com.organlink.model;
import java.sql.Timestamp;
public class Organ {
    private int id;
    private String organType;
    private String bloodType;
    private int hospitalId;
    private String status; // AVAILABLE, RESERVED, TRANSPLANTED
    private Timestamp registeredAt;
    private Timestamp transplantedAt;
    // Joined
    private String hospitalName;
    public Organ() {}
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getOrganType() { return organType; }
    public void setOrganType(String organType) { this.organType = organType; }
    public String getBloodType() { return bloodType; }
    public void setBloodType(String bloodType) { this.bloodType = bloodType; }
    public int getHospitalId() { return hospitalId; }
    public void setHospitalId(int hospitalId) { this.hospitalId = hospitalId; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Timestamp getRegisteredAt() { return registeredAt; }
    public void setRegisteredAt(Timestamp registeredAt) { this.registeredAt = registeredAt; }
    public Timestamp getTransplantedAt() { return transplantedAt; }
    public void setTransplantedAt(Timestamp transplantedAt) { this.transplantedAt = transplantedAt; }
    public String getHospitalName() { return hospitalName; }
    public void setHospitalName(String hospitalName) { this.hospitalName = hospitalName; }
}