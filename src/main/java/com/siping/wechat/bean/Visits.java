package com.siping.wechat.bean;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.siping.web.utility.JsonDateSerializer;

/**
 * 访问量记录
 * @author Mx
 *
 */
public class Visits {
    /**
     * 记录的日期
     */
    @JsonSerialize(using=JsonDateSerializer.class)
    private Date day = new Date();
    /**
     * 记录量，次数
     */
    private long times;
    @JsonSerialize(using=JsonDateSerializer.class)
    public Date getDay() {
        return day;
    }
    public void setDay(Date day) {
        this.day = day;
    }
    @SuppressWarnings("deprecation")
    public long getTime(){
        day.setSeconds(0);
        day.setMinutes(0);
        day.setHours(0);
        return day.getTime();
    }
    public long getTimes() {
        return times;
    }
    public void setTimes(long times) {
        this.times = times;
    }
}