// com/organlink/model/ContactQuery.java
package com.organlink.model;

import java.sql.Timestamp;

public class ContactQuery {
    private int id;
    private String fullName;
    private String phone;
    private String query;
    private Timestamp submittedAt;

    public ContactQuery() {}

    public ContactQuery(String fullName, String phone, String query) {
        this.fullName = fullName;
        this.phone = phone;
        this.query = query;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getQuery() { return query; }
    public void setQuery(String query) { this.query = query; }

    public Timestamp getSubmittedAt() { return submittedAt; }
    public void setSubmittedAt(Timestamp submittedAt) { this.submittedAt = submittedAt; }
}
