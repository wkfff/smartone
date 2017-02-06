package com.siping.web.bean;

public class Pagging {
    private int currentPage;
    private int prePage;
    private int nextPage;
    private int allPages;
    private int pageCount;
    private int allCount;

    public Pagging(int currentPage, int allCount, int pageCount) {
        this.currentPage = currentPage;
        this.allCount = allCount;
        this.pageCount = pageCount;

        initAllPages();
        initPreAndNextPage();
    }

    private void initAllPages() {
        if (allCount % pageCount == 0 && allCount > 0) {
            allPages = allCount / pageCount;
        } else {
            allPages = allCount / pageCount + 1;
        }
    }

    private void initPreAndNextPage() {
        if (currentPage == 1) {
            prePage = 1;
        } else {
            prePage = currentPage - 1;
        }
        if (currentPage == allPages) {
            nextPage = allPages;
        } else {
            nextPage = currentPage + 1;
        }
    }

    public Pagging() {
        super();
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getPrePage() {
        return prePage;
    }

    public void setPrePage(int prePage) {
        this.prePage = prePage;
    }

    public int getNextPage() {
        return nextPage;
    }

    public void setNextPage(int nextPage) {
        this.nextPage = nextPage;
    }

    public int getAllPages() {
        return allPages;
    }

    public void setAllPages(int allPages) {
        this.allPages = allPages;
    }

    public int getPageCount() {
        return pageCount;
    }

    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

    public int getAllCount() {
        return allCount;
    }

    public void setAllCount(int allCount) {
        this.allCount = allCount;
    }
}
