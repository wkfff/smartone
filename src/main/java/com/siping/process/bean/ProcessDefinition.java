package com.siping.process.bean;

import com.siping.doc.bean.MasterData;

public class ProcessDefinition extends MasterData{
    private String resource;
    private String key;
    private Integer version;
    private Integer deployId;
    public String getResource() {
        return resource;
    }
    public void setResource(String resource) {
        this.resource = resource;
    }
    public String getKey() {
        return key;
    }
    public void setKey(String key) {
        this.key = key;
    }
    public Integer getVersion() {
        return version;
    }
    public void setVersion(Integer version) {
        this.version = version;
    }
    public Integer getDeployId() {
        return deployId;
    }
    public void setDeployId(Integer deployId) {
        this.deployId = deployId;
    }

}
