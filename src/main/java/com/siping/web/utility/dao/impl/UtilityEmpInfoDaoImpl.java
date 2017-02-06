package com.siping.web.utility.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.siping.productStorage.bean.Employee;
import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.web.utility.SqlMapClientSupport;
import com.siping.web.utility.dao.UtilityEmpInfoDao;

@Repository
public class UtilityEmpInfoDaoImpl extends SqlMapClientSupport implements UtilityEmpInfoDao {

    Logger logger = Logger.getLogger(UtilityEmpInfoDaoImpl.class);

    /**
     * (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityEmpInfoDao#getEmpBasicInfo(java.lang
     *      .Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public Map getEmpBasicInfo(Object object) {
        Map tempMap = new LinkedHashMap<Object, Object>();
        try {
            tempMap = (Map) this.queryForObject("utility.empInfo.getEmpBasicInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tempMap;
    }

    /**
     * 获取个人流程信息
     * @param obj
     * @return
     * @see com.siping.web.utility.dao.UtilityEmpInfoDao#getEmpInfoList(java.lang
     *      .Object)
     */
    @SuppressWarnings("rawtypes")
    @Override
    public List getEmpInfoList(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("utility.empInfo.getEmpInfoList", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    /**
     * 获取个人流程信息
     * @param obj
     * @param currentPage
     * @param pageSize
     * @return
     * @see com.siping.web.utility.dao.UtilityEmpInfoDao#getEmpInfoList(java.lang
     *      .Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getEmpInfoList(Object obj, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("utility.empInfo.getEmpInfoList", obj, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 获取个人流程信息
     * @param obj
     * @return
     * @see com.siping.web.utility.dao.UtilityEmpInfoDao#getEmpInfoListCnt(java.lang
     *      .Object)
     */
    @Override
    public int getEmpInfoListCnt(Object obj) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("utility.empInfo.getEmpInfoListCnt", obj)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnInt;
    }

    /**
     * 判断是否是考勤员
     * @param obj
     * @return
     * @see com.siping.web.utility.dao.UtilityEmpInfoDao#isSupervisor(java.lang
     *      .Object)
     */
    @Override
    public boolean isSupervisor(Object obj) {
        boolean returnFlag = false;
        try {
            String returnString = (String) this.queryForObject("utility.empInfo.isSupervisor", obj);
            if (returnString != null && !returnString.equals("")) {
                returnFlag = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnFlag;
    }

    /**
     * 根据考勤员权限取得人员信息列表
     * @param List
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getAttSearchEmployeeList(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("utility.empInfo.getCustAndAttAndHrSearchEmployee", obj);
        } catch (SQLException e) {

            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 根据考勤员权限取得人员信息列表
     * @param List
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getAttSearchEmployeeList(Object obj, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("utility.empInfo.getCustAndAttAndHrSearchEmployee", obj, currentPage, pageSize);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 根据考勤员权限取得人员信息人数
     * @param List
     * @return
     */
    public int getAttSearchEmployeeCnt(Object obj) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("utility.empInfo.getCustAndAttAndHrSearchEmployeeCnt", obj)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 根据考勤员权限取得人员信息列表
     * @param List
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getHrSearchEmployeeList(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("utility.empInfo.getCustAndAttAndHrSearchEmployee", obj);
        } catch (SQLException e) {

            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 根据考勤员权限取得人员信息列表
     * @param List
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getHrSearchEmployeeList(Object obj, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("utility.empInfo.getCustAndAttAndHrSearchEmployee", obj, currentPage, pageSize);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 根据考勤员权限取得人员信息人数
     * @param List
     * @return
     */
    public int getHrSearchEmployeeCnt(Object obj) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("utility.empInfo.getCustAndAttAndHrSearchEmployeeCnt", obj)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 根据考勤员权限取得人员信息列表
     * @param List
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getProSearchEmployeeInfo(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("utility.empInfo.getProSearchEmployeeInfo", obj);
        } catch (SQLException e) {

            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 根据考勤员权限取得人员信息列表
     * @param List
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getProSearchEmployeeInfo(Object obj, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("utility.empInfo.getProSearchEmployeeInfo", obj, currentPage, pageSize);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 根据考勤员权限取得人员信息人数
     * @param List
     * @return
     */
    public int getProSearchEmployeeInfoCnt(Object obj) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("utility.empInfo.getProSearchEmployeeInfoCnt", obj)), Integer.class);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 根据客户管理限取得人员信息列表
     * @param List
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getCustSearchEmployeeList(Object obj, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("utility.empInfo.getCustAndAttAndHrSearchEmployee", obj, currentPage, pageSize);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 根据客户挂历权限取得人员信息人数
     * @param List
     * @return
     */
    public int getCustSearchEmployeeCnt(Object obj) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("utility.empInfo.getCustAndAttAndHrSearchEmployeeCnt", obj)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 根据客户管理限取得人员信息列表
     * @param List
     * @return
     */
    @SuppressWarnings("rawtypes")
    @Override
    public List getCustSearchEmployeeList(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("utility.empInfo.getCustAndAttAndHrSearchEmployee", obj);
        } catch (SQLException e) {

            e.printStackTrace();
        }

        return returnList;

    }

    @SuppressWarnings("rawtypes")
    public List getHrSearchEmployeeListScore(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("utility.empInfo.getCustAndAttAndHrSearchEmployeeScore", obj);
        } catch (SQLException e) {

            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 根据考勤员权限取得人员信息列表
     * @param List
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getHrSearchEmployeeListScore(Object obj, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("utility.empInfo.getCustAndAttAndHrSearchEmployeeScore", obj, currentPage, pageSize);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public List<Employee> getAllEmployeesUsingBeanMap(Object obj) {
        List<Employee> resultList = null;
        try {
            resultList = this.queryForList("utility.empInfo.getAllEmployeesUsingBeanMap", obj);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultList;
    }

    @Override
    public Employee getEmpBasicInfoUsingBeanMap(Object obj) {
        Employee employee = null;
        try {
            employee = (Employee) this.queryForObject("utility.empInfo.getEmpBasicInfoUsingBeanMap", obj);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return employee;
    }
}
