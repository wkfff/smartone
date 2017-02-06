package com.siping.hrm.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.hrm.dao.OrgDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class OrgDaoImpl extends SqlMapClientSupport implements OrgDao {
    /*
     * (non-Javadoc)
     * @see com.siping.hrm.dao.OrgDao#getDeptInfo(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public Map getDeptInfoObj(Object obj) {
        Map returnMap = null;
        try {
            returnMap = (Map) this.queryForObject("org.getDeptInfoObj", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnMap;
    }

    /*
     * (non-Javadoc)
     * @see com.siping.hrm.dao.OrgDao#getDeptInfo(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getDeptInfo(Object obj) {
        List returnList = null;
        try {
            returnList = this.queryForList("org.getDeptInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    /*
     * (non-Javadoc)
     * @see com.siping.hrm.dao.OrgDao#getDeptInfo(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getDeptInfo(Object obj, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("org.getDeptInfo", obj, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /*
     * (non-Javadoc)
     * @see com.siping.hrm.dao.OrgDao#getDeptInfoCnt(java.lang.Object)
     */
    @Override
    public int getDeptInfoCnt(Object object) {

        int i = 0;
        try {
            i = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("org.getDeptInfoCnt", object)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return i;
    }

    /**
     * 修改部门信息
     * @param List
     * @return
     */
    @Override
    public String updateDeptInfo(Object obj) {
        String result = "Y";
        try {
            this.update("org.updateDeptInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
            result = e.getMessage();
        }
        return result;
    }

    /**
     * 修改部门信息
     * @param List
     * @return
     */
    @Override
    public String addDeptInfo(Object obj) {
        String result = "Y";
        try {
            this.insert("org.addDeptInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
            result = e.getMessage();
        }
        return result;
    }

    /**
     * 修改部门信息
     * @param List
     * @return
     */
    @Override
    public String deleteDeptInfo(Object obj) {
        String result = "Y";
        try {
            this.update("org.deleteDeptInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
            result = e.getMessage();
        }
        return result;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getDeptInfoTree(Object object) {
        List result = null;
        try {
            result = this.queryForList("org.getDeptInfoTree", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getDeptLevel(Object object) {
        List result = null;
        try {
            result = this.queryForList("org.getDeptLevel", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 获取定编信息
     * @param Object
     * @return List 获取所有定编信息的记录数
     */
    @SuppressWarnings("rawtypes")
    @Override
    public List getDeptQuotaList(Object object) {
        List result = null;
        try {
            result = this.queryForList("org.getDeptQuotaList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 获取定制信息
     * @param Object
     * @return int
     */
    @Override
    public int getDeptQuotaListCnt(Object object) {
        int i = 0;
        try {
            i = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("org.getDeptQuotaListCnt", object)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }

    /**
     * 获取定编信息（采用分页方式）
     * @param Object
     * @return List
     */
    @SuppressWarnings("rawtypes")
    @Override
    public List getDeptQuotaList(Object obj, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("org.getDeptQuotaList", obj, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 增加定编信息
     * @param object
     * @return String
     */
    @Override
    public String addDeptQuotaInfo(Object object) {
        String result = "Y";
        try {
            this.insert("org.addDeptQuotaInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            result = e.getMessage();
        }
        return result;
    }

    /**
     * 增加定编信息
     * @param object
     * @return String
     */
    @SuppressWarnings({ "rawtypes", "unused" })
    @Override
    public String addDeptQuotaInfo(List objList) {
        String result = "Y";

        return null;
    }

    /**
     * 删除定编信息
     * @param object
     * @return String
     */
    @Override
    public String deleteDeptQuotaInfo(Object object) {
        String result = "Y";
        try {
            this.update("org.deleteDeptQuotaInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            result = e.getMessage();
        }
        return result;
    }

    /**
     * 获取定编信息中该公司的部门所包含的对应职位的个数
     * @param object
     * @return
     */
    @Override
    public int getPostIdCnt(Object object) {
        int resultNum = 0;
        try {
            resultNum = Integer.parseInt(this.queryForObject("org.getPostIdCnt", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultNum;
    }

    /**
     * 修改定编信息
     * @param object
     * @return
     */
    @Override
    public String updateDeptQuotaInfo(Object object) {
        String result = "Y";
        try {
            this.update("org.updateDeptQuotaInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            result = e.getMessage();
        }
        return result;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String updateDeptQuotaInfo(List objList) {
        String result = "Y";
        try {
            this.updateForList("org.updateDeptQuotaInfo", objList);
        } catch (SQLException e) {
            e.printStackTrace();
            result = e.getMessage();
        }
        return result;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String massTransferEmployees(List objList) {
        String returnString = "Y";
        try {
            this.updateForList("org.massTransferEmployees", objList);
        } catch (SQLException e) {
            returnString = "N";
            e.printStackTrace();
        }
        return returnString;
    }

    @Override
    public int checkDeptChildren(Object object) {
        int i = 0;
        try {
            i = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("org.checkDeptChildren", object)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }
}
