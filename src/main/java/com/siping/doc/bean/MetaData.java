package com.siping.doc.bean;

import java.io.Serializable;
import java.util.Date;

import com.siping.productStorage.bean.Company;
import com.siping.system.bean.AdminBean;

/**
 * 所有主数据的元数据，包括创建、更新时间、创建用户、更新用户、所属企业客户端
 * @author Mx
 */
public class MetaData implements Serializable {
    private static final long serialVersionUID = 1L;

    public static final String KEY = "metaData";
    protected Date createDate = new Date();
    protected Date lastUpdateDate = new Date();
    protected AdminBean createUser;
    protected AdminBean lastUpdateUser;
    protected Company company;

    public MetaData() {
    }

    public MetaData(Date createDate) {
        this.createDate = createDate;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getLastUpdateDate() {
        return lastUpdateDate;
    }

    public void setLastUpdateDate(Date lastUpdateDate) {
        this.lastUpdateDate = lastUpdateDate;
    }

    public AdminBean getCreateUser() {
        return createUser;
    }

    public void setCreateUser(AdminBean createUser) {
        this.createUser = createUser;
    }

    public AdminBean getLastUpdateUser() {
        return lastUpdateUser;
    }

    public void setLastUpdateUser(AdminBean lastUpdateUser) {
        this.lastUpdateUser = lastUpdateUser;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

}
