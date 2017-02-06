package com.siping.process.bean;

/**
 * 分页数据访问
 * @author Mx
 */
public class PagerRequest {
    public static final String KEY_PAGE = "page";
    public static final String KEY_PAGESIZE = "pagesize";

    private Integer page;
    private Integer pagesize;

    public PagerRequest() {
    }

    public PagerRequest(Integer page, Integer pagesize) {
        this.page = page;
        this.pagesize = pagesize;
    }

    public int getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getPagesize() {
        return pagesize;
    }

    public void setPagesize(Integer pagesize) {
        this.pagesize = pagesize;
    }

    public boolean supportPager() {
        return (page != null && pagesize != null);
    }
}
