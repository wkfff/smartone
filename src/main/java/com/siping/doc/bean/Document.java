package com.siping.doc.bean;

import java.util.List;

import com.siping.cust.bean.Customer;
import com.siping.system.bean.AdminBean;

public class Document extends BusinessData {
    private String part;
    private Integer version;
    private Long oriNo;
    private List<DocumentFile> storingFiles;
    private List<AdminBean> relatedUsers;
    private List<Customer> relatedCustomers;

    public String getPart() {
        return part;
    }

    public List<Customer> getRelatedCustomers() {
        return relatedCustomers;
    }

    public List<AdminBean> getRelatedUsers() {
        return relatedUsers;
    }

    public List<DocumentFile> getStoringFiles() {
        return storingFiles;
    }

    public void addStoringFile(DocumentFile file) {
        this.getStoringFiles().add(file);
        setStoringFiles(storingFiles);
    }

    public void setStoringFiles(List<DocumentFile> storingFiles) {
        this.storingFiles = storingFiles;
        for (DocumentFile file : storingFiles) {
            file.setDocument(this);
        }
    }

    public Integer getVersion() {
        return version;
    }

    public void setPart(String part) {
        this.part = part;
    }

    public Long getOriNo() {
        return oriNo;
    }

    public void setOriNo(Long oriNo) {
        this.oriNo = oriNo;
    }

    public void setRelatedCustomers(List<Customer> relatedCustomers) {
        this.relatedCustomers = relatedCustomers;
    }

    public void setRelatedUsers(List<AdminBean> relatedUsers) {
        this.relatedUsers = relatedUsers;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }
}
