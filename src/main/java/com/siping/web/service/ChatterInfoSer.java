package com.siping.web.service;

import java.util.List;

/**
 * 本接口为聊天模块提供功能
 * @author JoveQiao
 */
public interface ChatterInfoSer {
    @SuppressWarnings({ "rawtypes" })
    public List getChatterDeptTree();

    public List getAllEmpDeptTree();

}
