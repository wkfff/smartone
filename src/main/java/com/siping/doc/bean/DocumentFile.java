package com.siping.doc.bean;

import com.siping.system.bean.AdminBean;

/**
 * 文档的文件
 * @author Mx
 */
public class DocumentFile extends MasterData {
    private Document document;
    private Integer version = 1;
    private String path;
    private Boolean locked = false;
    private AdminBean lockUser;

    public Document getDocument() {
        return document;
    }

    public void setDocument(Document document) {
        this.document = document;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public Boolean getLocked() {
        return locked;
    }

    public void setLocked(Boolean locked) {
        this.locked = locked;
    }

    public AdminBean getLockUser() {
        return lockUser;
    }

    public void setLockUser(AdminBean lockUser) {
        this.lockUser = lockUser;
    }
    public DocumentFile clone(){
        //TODO: CREATE CLONE METHOD,ADD VERSION NUMBER
        return this;
    }
}
