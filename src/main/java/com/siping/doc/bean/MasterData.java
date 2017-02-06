package com.siping.doc.bean;

import java.io.Serializable;

/**
 * 主数据类，包括id，名称，描述
 * @author Mx
 */
public class MasterData  implements Serializable{
    private static final long serialVersionUID = 1L;
    /**
     * 通常是主数据的数据库中的唯一字段标识，可采用序列号生成。 ！！！永远不要展示给用户查看！！！
     */
    private Long no;
    /**
     * 数据的编号，不同客户端（企业）的编号有可能重复
     */
    private String id;
    private String name;
    private String description;
    private MetaData metaData;
    private Boolean active = true;

    public Long getNo() {
        return no;
    }

    public void setNo(Long no) {
        this.no = no;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public MetaData getMetaData() {
        return metaData;
    }

    public void setMetaData(MetaData metaData) {
        this.metaData = metaData;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public String toString() {
        return "No:" + no.toString() + ",Id:" + id.toString() + ",Name:" + name;
    }
}
