package com.siping.wechat.bean;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

public class WechatMenu implements Serializable{

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private int id;
    private String menuName;
    private String menuType;
    private String menuKey;
    private String menuUrl;
    private Integer parentMenuId;
    private List<WechatMenu> sonMenus;
    private Date createdDate;
    private String createdBy;
    private Date updatedDate;
    private String updatedBy;
    private String replyText;
    /*private String replyImage;
    private String replyNews;*/

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getMenuName() {
        return menuName;
    }
    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }
    public String getMenuType() {
        return menuType;
    }
    public void setMenuType(String menuType) {
        this.menuType = menuType;
    }
    public String getMenuUrl() {
        return menuUrl;
    }
    public void setMenuUrl(String menuUrl) {
        this.menuUrl = menuUrl;
    }
    public List<WechatMenu> getSonMenus() {
        return sonMenus;
    }
    public void setSonMenus(List<WechatMenu> sonMenus) {
        this.sonMenus = sonMenus;
    }
    public Date getCreatedDate() {
        return createdDate;
    }
    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }
    public String getCreatedBy() {
        return createdBy;
    }
    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }
    public Date getUpdatedDate() {
        return updatedDate;
    }
    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }
    public String getUpdatedBy() {
        return updatedBy;
    }
    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }
    public String getMenuKey() {
        return menuKey;
    }
    public void setMenuKey(String menuKey) {
        this.menuKey = menuKey;
    }
    public Integer getParentMenuId() {
        return parentMenuId;
    }
    public void setParentMenuId(Integer parentMenuId) {
        this.parentMenuId = parentMenuId;
    }
    public String getReplyText() {
        return replyText;
    }
    public void setReplyText(String replyText) {
        this.replyText = replyText;
    }
}
