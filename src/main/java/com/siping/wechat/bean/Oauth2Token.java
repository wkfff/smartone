package com.siping.wechat.bean;

/**
 * 通过oauth的认证结果code获取oauth信息
 * @author: LHQ
 * @date: 2014年6月24日 下午2:03:12
 * @email: daysinsun@gmail.com
 * @function:
 * @version :
 */
public class Oauth2Token {
    /**
     * oauth的access_token值，与access_token代表的意思完全不一致，即有效期独立的
     */
    private String accessToken;

    /**
     * 过期秒数，单位秒
     */
    private String expiresIn;

    /**
     * 未知
     */
    private String refreshToken;

    /**
     * oauth获取的openid信息
     */
    private String openId;

    /**
     * 未知
     */
    private String scope;

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    public String getExpiresIn() {
        return expiresIn;
    }

    public void setExpiresIn(String expiresIn) {
        this.expiresIn = expiresIn;
    }

    public String getRefreshToken() {
        return refreshToken;
    }

    public void setRefreshToken(String refreshToken) {
        this.refreshToken = refreshToken;
    }

    public String getOpenId() {
        return openId;
    }

    public void setOpenId(String openId) {
        this.openId = openId;
    }

    public String getScope() {
        return scope;
    }

    public void setScope(String scope) {
        this.scope = scope;
    }

}
