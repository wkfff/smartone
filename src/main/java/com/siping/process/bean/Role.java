package com.siping.process.bean;

import com.siping.doc.bean.MasterData;

public class Role extends MasterData {
    private Grant grant;

    public Grant getGrant() {
        return grant;
    }

    public void setGrant(Grant grant) {
        this.grant = grant;
    }

}
