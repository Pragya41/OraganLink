// com/organlink/model/DonationRequest.java
package com.organlink.model;
import java.sql.Timestamp;
public class DonationRequest {
    private int id;
    private int memberId;
    private int organId;
    private int hospitalId;
    private String status; // PENDING, APPROVED, COMPLETED, REJECTED
    private Timestamp requestedAt;
    private Timestamp resolvedAt;
    // Joined fields
    private String memberName;
    private String organType;
    private String bloodType;
    private String hospitalName;
    public DonationRequest() {}
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getMemberId() { return memberId; }
    public void setMemberId(int memberId) { this.memberId = memberId; }
    public int getOrganId() { return organId; }
    public void setOrganId(int organId) { this.organId = organId; }
    public int getHospitalId() { return hospitalId; }
    public void setHospitalId(int hospitalId) { this.hospitalId = hospitalId; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Timestamp getRequestedAt() { return requestedAt; }
    public void setRequestedAt(Timestamp requestedAt) { this.requestedAt = requestedAt; }
    public Timestamp getResolvedAt() { return resolvedAt; }
    public void setResolvedAt(Timestamp resolvedAt) { this.resolvedAt = resolvedAt; }
    public String getMemberName() { return memberName; }
    public void setMemberName(String memberName) { this.memberName = memberName; }
    public String getOrganType() { return organType; }
    public void setOrganType(String organType) { this.organType = organType; }
    public String getBloodType() { return bloodType; }
    public void setBloodType(String bloodType) { this.bloodType = bloodType; }
    public String getHospitalName() { return hospitalName; }
    public void setHospitalName(String hospitalName) { this.hospitalName = hospitalName; }
}