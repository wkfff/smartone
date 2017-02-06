package com.siping.productStorage.bean;

import java.util.Date;

/**
 * Created by jj on 13-12-27.
 */
public class Employee {
    private String empNo;
    private String empId;
    private String empName;
    private Company company;
    private SYCode status;
    private Date joinDate;
    private Department dept;
    private SYCode empType;
    private SYCode eduBackground;
    private String position;

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public SYCode getStatus() {
        return status;
    }

    public void setStatus(SYCode status) {
        this.status = status;
    }

    public Date getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(Date joinDate) {
        this.joinDate = joinDate;
    }

    public Department getDept() {
        return dept;
    }

    public void setDept(Department dept) {
        this.dept = dept;
    }

    public SYCode getEmpType() {
        return empType;
    }

    public void setEmpType(SYCode empType) {
        this.empType = empType;
    }

    public SYCode getEduBackground() {
        return eduBackground;
    }

    public void setEduBackground(SYCode eduBackground) {
        this.eduBackground = eduBackground;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public String getEmpNo() {
        return empNo;
    }

    public void setEmpNo(String empNo) {
        this.empNo = empNo;
    }

    public String getEmpId() {
        return empId;
    }

    public void setEmpId(String empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }
}
