package com.siping.hrm.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.hrm.dao.InfoStatisticsDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class InfoStatisticsDaoImpl extends SqlMapClientSupport implements InfoStatisticsDao {
    /**
     * 根据传入的parentCode查询出约束条件
     */
    @SuppressWarnings("rawtypes")
    @Override
    public String[] getOptions(Object object) {
        List list = null;
        try {
            list = this.queryForList("hrm.searchinfo.queryCellOptions", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        String[] resultList = this.list2StringArray(list);
        return resultList;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getTitles(Object obj) {
        List resultList = null;
        try {
            resultList = this.queryForList("hrm.searchinfo.queryColumnTitles", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultList;
    }

    @SuppressWarnings("rawtypes")
    public String[] list2StringArray(List list) {
        if (list == null || list.size() == 0)
            return null;
        Object[] objects = list.toArray();
        String[] resultArray = new String[list.size()];
        // Cast Object[] to String[]
        for (int i = 0, j = 0; i < objects.length; i++) {
            if (objects[i] != null) {
                resultArray[j] = (String) objects[i];
                j++;
            }
        }
        return resultArray;
    }

    @Override
    public boolean createTmpPersonalInfo(Object object) throws SQLException {
        boolean result = false;
        this.update("hrm.searchinfo.createTmpPersonalInfo", object);
        result = true;
        return result;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getColumnList(Object object) throws SQLException {
        return this.queryForList("hrm.searchinfo.getColumnList");
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getTmpInfoList() throws Exception {
        List tmpList = this.queryForList("hrm.searchinfo.getEmpTmpInfoList");
        return tmpList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void updateTmpPersonalTitles(List list) throws SQLException {
        this.insertForList("hrm.searchinfo.updateTmpPersonalTitles", list);

    }

    @SuppressWarnings("rawtypes")
    @Override
    public void updateTmpPersonalInfo(List list) throws SQLException {
        this.updateForList("hrm.searchinfo.updateTmpPersonalInfo", list);
    }

    @Override
    public void modifyTmpTable() throws SQLException {
        this.update("hrm.searchinfo.modifyTmpTable");
    }

    /**
     * 获取老员工信息
     */
    @SuppressWarnings("rawtypes")
    @Override
    public List getUpdateList(Object obj) throws SQLException {
        return this.queryForList("hrm.searchinfo.getUpdateList", obj);
    }

    /**
     * 获取新员工信息
     */
    @SuppressWarnings("rawtypes")
    @Override
    public List getEmpInsertList(Object obj) throws SQLException {
        return this.queryForList("hrm.searchinfo.getEmpInsertList", obj);
    }

    /**
     * 保存新员工
     */
    @SuppressWarnings("rawtypes")
    @Override
    public void insertHire(List list) throws SQLException {
        this.insertForList("hrm.searchinfo.insertHire", list);
    }

    /**
     * 更新老员工
     */
    @SuppressWarnings("rawtypes")
    @Override
    public void updateHire(List list) throws SQLException {
        this.updateForList("hrm.searchinfo.updateHire", list);
    }

    /* info static */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getInfoTypeList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.searchinfo.getInfoTypeList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getInfoTableList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.searchinfo.getInfoTableList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getInfoFieldList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.searchinfo.getInfoFieldList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 字段信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getFieldInfo(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.searchinfo.getFieldInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getFieldTableInfo(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.searchinfo.getFieldTableInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getFieldInfo(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.searchinfo.getFieldInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getFieldInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.searchinfo.getFieldInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getDataInfo(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.searchinfo.getDataInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getDataInfo(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.searchinfo.getDataInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getDataInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.searchinfo.getDataInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @Override
    public int deleteFieldInfo(Object object) {
        int returnInt = 1;
        try {
            this.delete("hrm.searchinfo.deleteFieldInfo", object);
        } catch (SQLException e) {
            returnInt = 0;
            e.printStackTrace();
        } catch (Exception e) {
            returnInt = 0;
            e.printStackTrace();
        }

        return returnInt;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int deleteFieldInfo(List delList) {
        int returnInt = 1;
        try {
            this.deleteForList("hrm.searchinfo.deleteFieldInfo", delList);
        } catch (SQLException e) {
            returnInt = 0;
            e.printStackTrace();
        } catch (Exception e) {
            returnInt = 0;
            e.printStackTrace();
        }

        return returnInt;
    }

    @Override
    public int addFieldInfo(Object object) {
        int returnInt = 1;
        try {
            this.insert("hrm.searchinfo.addFieldInfo", object);
        } catch (SQLException e) {
            returnInt = 0;
            e.printStackTrace();
        } catch (Exception e) {
            returnInt = 0;
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 插入证书信息
     */
    @SuppressWarnings("rawtypes")
    @Override
    public String addCertificateInfo(List insertList) {
        String resultString = "Y";
        try {
            this.updateForList("hrm.searchinfo.addCertificateInfo", insertList);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String addTrainingInfo(List insertList) {
        String resultString = "Y";
        try {
            this.updateForList("hrm.searchinfo.addTrainingInfo", insertList);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }
}
