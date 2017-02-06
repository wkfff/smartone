package com.siping.process.bean;

import com.siping.doc.bean.MasterData;

/**
 * 角色权限描述
 * @author Mx
 */
public class Grant extends MasterData{
    private Type type;
    private Role role;
    private Boolean createable = false;
    private Boolean readable = false;
    private Boolean writeable = false;
    private Boolean deleteable = false;

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Boolean getCreateable() {
        return createable;
    }

    public void setCreateable(Boolean isCreateable) {
        this.createable = isCreateable;
    }

    public Boolean getReadable() {
        return readable;
    }

    public void setReadable(Boolean isReadable) {
        this.readable = isReadable;
    }

    public Boolean getWriteable() {
        return writeable;
    }

    public void setWriteable(Boolean isWritable) {
        this.writeable = isWritable;
    }

    public Boolean getDeleteable() {
        return deleteable;
    }

    public void setDeleteable(Boolean isDeleteable) {
        this.deleteable = isDeleteable;
    }

}
