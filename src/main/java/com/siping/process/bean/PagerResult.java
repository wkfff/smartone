package com.siping.process.bean;

import java.util.List;

import org.codehaus.jackson.annotate.JsonProperty;

/**
 * 分页返回数据
 * @author Mx
 *
 */
public class PagerResult<T> {
    private List<T> Rows;
    private int Total;

    @JsonProperty(value = "Rows")
    public List<T> getRows() {
        return Rows;
    }

    public void setRows(List<T> rows) {
        Rows = rows;
    }

    @JsonProperty(value = "Total")
    public int getTotal() {
        return Total;
    }

    public void setTotal(int total) {
        Total = total;
    }
}
