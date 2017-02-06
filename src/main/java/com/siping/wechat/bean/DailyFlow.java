package com.siping.wechat.bean;

import java.util.List;

/**
 * 日监测数据集合
 * @author Mx
 *
 */
public class DailyFlow {
    /**
     * 访问量
     */
    private List<Visits> visit;
    /**
     * 收藏数据量
     */
    private List<Visits> favourite;
    /**
     * 微信关注量
     */
    private List<Visits> wechat;

    public List<Visits> getVisit() {
        return visit;
    }
    public void setVisit(List<Visits> visit) {
        this.visit = visit;
    }
    public List<Visits> getFavourite() {
        return favourite;
    }
    public void setFavourite(List<Visits> favourite) {
        this.favourite = favourite;
    }
    public List<Visits> getWechat() {
        return wechat;
    }
    public void setWechat(List<Visits> wechat) {
        this.wechat = wechat;
    }
}
