package com.siping.hrm.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.hrm.dao.EmpInfoDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class EmpInfoDaoImpl extends SqlMapClientSupport implements EmpInfoDao {

    @SuppressWarnings({ "rawtypes" })
    public List getEmpList(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("hrm.empinfo.getEmpList", object, Integer.parseInt(((Map) object).get("page").toString()), Integer.parseInt(((Map) object).get("pagesize").toString()));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getEmpCnt(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("hrm.empinfo.getEmpCnt", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    public Object getBasicInfo(Object object) {
        Object object2 = null;
        try {
            object2 = this.queryForObject("hrm.empinfo.getBasicInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return object2;
    }

    public Object getPersonalInfo(Object object) {
        Object object2 = null;
        try {
            object2 = this.queryForObject("hrm.empinfo.getPersonalInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return object2;
    }

    @Override
    public String updateEmpInfo(Object object) {
        String resultString = "Y";
        try {
            this.startTransaction();
            this.update("hrm.empinfo.updateHrPersonInfo", object);
            this.update("hrm.empinfo.updateHrEmpInfo", object);
            this.update("hrm.empinfo.updateHrEmployee", object);
            this.commitTransation();
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        } finally {
            try {
                this.endTransation();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return resultString;

    }

    /**
     * 账户信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getPaEmpInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getPaEmpInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getPaEmpInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getPaEmpInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getPaEmpInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.empinfo.getPaEmpInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map getSinfoForGrid(Object object, int currentPage, int pageSize) {
        Map object2 = new LinkedHashMap();
        try {
            // object2 = this.queryForGridList("hrm.empinfo.getSinfo", object,
            // currentPage,pageSize);
            List Rows = this.queryForList("hrm.empinfo.getSinfo", object, currentPage, pageSize);
            Integer count = (Integer) this.queryForObject("hrm.empinfo.getSinfoCnt", object);
            object2.put("Rows", Rows);
            object2.put("Total", count);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return object2;
    }

    /**
     * 担当业务列表
     * @param Object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getBizInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getBizInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 担当业务列表
     * @param Object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getBizInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getBizInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 担当业务列表数量
     */
    @Override
    public int getBizInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.empinfo.getBizInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map getAppendInfoForGrid(Object object, int currentPage, int pageSize) {
        Map object2 = new LinkedHashMap();
        try {
            // object2 = this.queryForGridList("hrm.empinfo.getAppendInfo",
            // object, currentPage,pageSize);
            List Rows = this.queryForList("hrm.empinfo.getAppendInfo", object, currentPage, pageSize);
            Integer count = (Integer) this.queryForObject("hrm.empinfo.getAppendInfoCnt", object);
            object2.put("Rows", Rows);
            object2.put("Total", count);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return object2;
    }

    /**
     * 职员离职发令查看
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getResignInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getResignInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getResignInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getResignInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getResignInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.empinfo.getResignInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * IT信息
     * @param Object
     * @return
     */
    @Override
    public Object getITLevelInfo(Object object) {
        Object returnObject = null;
        try {
            returnObject = this.queryForObject("hrm.empinfo.getITLevelInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnObject;
    }

    /**
     * IT信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getITLevelInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getITLevelInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * IT信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getITLevelInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getITLevelInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * IT信息
     * @param Object
     * @return
     */
    @Override
    public int getITLevelInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.empinfo.getITLevelInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * IT信息
     * @param Object
     */
    @Override
    public String addITLevelInfo(Object object) {
        String resultString = "Y";
        try {
            this.insert("hrm.empinfo.insertITLevelInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }

        return resultString;
    }

    /**
     * IT信息
     * @param Object
     */
    @Override
    public String deleteITLevelInfo(Object object) {
        String resultString = "Y";
        try {
            this.delete("hrm.empinfo.deleteITLevelInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * IT信息
     * @param Object
     */
    @Override
    public String updateITLevelInfo(Object object) {
        String resultString = "Y";
        try {
            this.update("hrm.empinfo.updateITLevelInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * 语言信息
     * @param Object
     * @return
     */
    @Override
    public Object getLanuageInfo(Object object) {
        Object returnObject = null;
        try {
            returnObject = this.queryForObject("hrm.empinfo.getLanuageInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnObject;
    }

    /**
     * 语言信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getLanuageInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getLanuageInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 语言信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getLanuageInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getLanuageInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 语言信息
     * @param Object
     * @return
     */
    @Override
    public int getLanuageInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.empinfo.getLanuageInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 语言信息
     * @param Object
     */
    @Override
    public String addLanuageInfo(Object object) {
        String resultString = "Y";
        try {
            this.insert("hrm.empinfo.insertLanguageInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * 语言信息
     * @param Object
     */
    @Override
    public String deleteLanuageInfo(Object object) {
        String resultString = "Y";
        try {
            this.delete("hrm.empinfo.deleteLanguageInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * 语言信息
     * @param Object
     */
    @Override
    public String updateLanuageInfo(Object object) {
        String resultString = "Y";
        try {
            this.update("hrm.empinfo.updateLanguageInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;

    }

    /**
     * 证书信息
     * @param Object
     * @return
     */
    @Override
    public Object getQualificationInfo(Object object) {
        Object returnObject = null;
        try {
            returnObject = this.queryForObject("hrm.empinfo.getQualificationInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnObject;
    }

    /**
     * 证书信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getQualificationInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getQualificationInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 证书信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getQualificationInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getQualificationInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 证书信息
     * @param Object
     * @return
     */
    @Override
    public int getQualificationInfoCnt(Object object) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.empinfo.getQualificationInfoCnt", object)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 证书信息
     * @param Object
     */
    @Override
    public String addQualificationInfo(Object object) {
        String resultString = "Y";
        try {
            this.insert("hrm.empinfo.insertQualificationInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;

    }

    /**
     * 证书信息
     * @param Object
     */
    @Override
    public String deleteQualificationInfo(Object object) {
        String resultString = "Y";
        try {
            this.delete("hrm.empinfo.deleteQualificationInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * 证书信息
     * @param Object
     */
    @Override
    public String updateQualificationInfo(Object object) {
        String resultString = "Y";
        try {
            this.update("hrm.empinfo.updateQualificationInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map getEvalForGrid(Object object, int currentPage, int pageSize) {
        Map object2 = new LinkedHashMap();
        try {
            // object2 = this.queryForGridList("hrm.empinfo.getEval", object,
            // currentPage,pageSize);
            List Rows = this.queryForList("hrm.empinfo.getEval", object, currentPage, pageSize);
            Integer count = (Integer) this.queryForObject("hrm.empinfo.getEvalCnt", object);
            object2.put("Rows", Rows);
            object2.put("Total", count);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return object2;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map getEvaluateForGrid(Object object, int currentPage, int pageSize) {
        Map object2 = new LinkedHashMap();
        try {
            // object2 = this.queryForGridList("hrm.empinfo.getEvaluate",
            // object, currentPage,pageSize);
            List Rows = this.queryForList("hrm.empinfo.getEvaluate", object, currentPage, pageSize);
            Integer count = (Integer) this.queryForObject("hrm.empinfo.getEvaluateCnt", object);
            object2.put("Rows", Rows);
            object2.put("Total", count);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return object2;
    }

    /**
     * 健康信息
     * @param Object
     * @return
     */
    public Object getHealthInfo(Object object) {
        Object returnObject = null;
        try {
            returnObject = this.queryForObject("hrm.empinfo.getHealthInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnObject;
    }

    /**
     * 健康信息
     * @param Object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getHealthInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getHealthInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 健康信息
     * @param Object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getHealthInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getHealthInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 健康信息
     */
    @Override
    public int getHealthInfoCnt(Object object) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.empinfo.getHealthInfoCnt", object)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 职员调动发令查看
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getExpInsideInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getExpInside", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getExpInsideInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getExpInside", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getExpInsideInfoCnt(Object object) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.empinfo.getExpInsideCnt", object)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 家庭成员信息
     * @param Object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getFamilyInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getFamilyInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 家庭成员信息
     * @param Object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getFamilyInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getFamilyInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 家庭成员信息
     */
    @Override
    public int getFamilyInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.empinfo.getFamilyInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 紧急联系人信息
     * @param Object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getEmergencyContactInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getFamilyInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 紧急联系人信息
     * @param Object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getEmergencyContactInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getFamilyInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 紧急联系人信息
     */
    @Override
    public int getEmergencyContactInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.empinfo.getFamilyInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 惩戒信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getPunishMentInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getPunishMent", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 惩戒信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getPunishMentInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getPunishMent", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 惩戒信息
     * @param Object
     * @return
     */
    @Override
    public int getPunishMentInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.empinfo.getPunishMentCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 奖励信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getRewardInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getRewardInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 奖励信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getRewardInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getRewardInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 奖励信息
     * @param Object
     * @return
     */
    @Override
    public int getRewardInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.empinfo.getRewardInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 社外培训信息
     * @param Object
     * @return
     */
    @Override
    public Object getTrainingInfo(Object object) {
        Object returnObject = null;
        try {
            returnObject = this.queryForObject("hrm.empinfo.getTrainingInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnObject;
    }

    /**
     * 社外培训信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getTrainingInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getTrainingInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 社外培训信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getTrainingInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getTrainingInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 社外培训信息
     */
    @Override
    public int getTrainingInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.empinfo.getTrainingInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @Override
    public String addTrainingInfo(Object object) {
        String resultString = "Y";
        try {
            this.insert("hrm.empinfo.insertTrainingInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String deleteTrainingInfo(Object object) {
        String resultString = "Y";
        try {
            this.delete("hrm.empinfo.deleteTrainingInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String updateTrainingInfo(Object object) {
        String resultString = "Y";
        try {
            this.update("hrm.empinfo.updateTrainingInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * 员工派遣信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getDispatchInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getDispatchInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 员工派遣信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getDispatchInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getDispatchInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 员工派遣信息
     * @param Object
     * @return
     */
    @Override
    public int getDispatchInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.empinfo.getDispatchInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 职员兼职发令查看
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getPluralityInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getPluralityInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getPluralityInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getPluralityInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getPluralityInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.empinfo.getPluralityInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map getSuspendForGrid(Object object, int currentPage, int pageSize) {
        Map object2 = new LinkedHashMap();
        try {
            // object2 = this.queryForGridList("hrm.empinfo.getSuspend", object,
            // currentPage,pageSize);
            List Rows = this.queryForList("hrm.empinfo.getSuspend", object, currentPage, pageSize);
            Integer count = (Integer) this.queryForObject("hrm.empinfo.getSuspendCnt", object);
            object2.put("Rows", Rows);
            object2.put("Total", count);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return object2;
    }

    /**
     * 工作经历
     * @param Object
     * @return
     */
    @Override
    public Object getWorkExperienceInfo(Object object) {
        Object returnObject = null;
        try {
            returnObject = this.queryForObject("hrm.empinfo.getExperienceInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnObject;
    }

    /**
     * 工作经历
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getWorkExperienceInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getExperienceInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 工作经历
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getWorkExperienceInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getExperienceInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 工作经历
     */
    @Override
    public int getWorkExperienceInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.empinfo.getExperienceInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @Override
    public String addWorkExperienceInfo(Object object) {
        String resultString = "Y";
        try {
            this.insert("hrm.empinfo.insertExperienceInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String deleteWorkExperienceInfo(Object object) {
        String resultString = "Y";
        try {
            this.delete("hrm.empinfo.deleteExperienceInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String updateWorkExperienceInfo(Object object) {
        String resultString = "Y";
        try {
            this.update("hrm.empinfo.updateExperienceInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * 教育信息
     * @param Object
     * @return
     */
    @Override
    public Object getEduInfo(Object object) {
        Object returnObject = null;
        try {
            returnObject = this.queryForObject("hrm.empinfo.getEduInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnObject;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getEduInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getEduInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getEduInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getEduInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getEduInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.empinfo.getEduInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @Override
    public String addEduInfo(Object object) {
        String resultString = "Y";
        try {
            this.insert("hrm.empinfo.insertEduInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String deleteEduInfo(Object object) {
        String resultString = "Y";
        try {
            this.delete("hrm.empinfo.deleteEduInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String updateEduInfo(Object object) {
        String resultString = "Y";
        try {
            this.update("hrm.empinfo.updateEduInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * 证件信息
     * @param Object
     * @return
     */
    @Override
    public Object getDocInfo(Object object) {
        Object returnObject = null;
        try {
            returnObject = this.queryForObject("hrm.empinfo.getDocInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnObject;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getDocInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getDocInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getDocInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getDocInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getDocInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.empinfo.getDocInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @Override
    public String addDocInfo(Object object) {
        String resultString = "Y";
        try {
            this.insert("hrm.empinfo.insertDocInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String deleteDocInfo(Object object) {
        String resultString = "Y";
        try {
            this.delete("hrm.empinfo.deleteDocInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String updateDocInfo(Object object) {
        String resultString = "Y";
        try {
            this.update("hrm.empinfo.updateDocInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * 家人关系添加
     */
    @SuppressWarnings("rawtypes")
    @Override
    public String addFamilyInfo(List insertList) {
        String resultString = "Y";
        try {
            this.insertForList("hrm.empinfo.insertFamilyInfo", insertList);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * 家人关系删除
     */
    @Override
    public String deleteFamilyInfo(Object object) {
        String resultString = "Y";
        try {
            this.delete("hrm.empinfo.deleteFamilyInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * 家人关系更新
     */
    @SuppressWarnings("rawtypes")
    @Override
    public String updateFamilyInfo(List updateList) {
        String resultString = "Y";
        try {
            this.updateForList("hrm.empinfo.updateFamilyInfo", updateList);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * 家人关系添加
     */
    @SuppressWarnings("rawtypes")
    @Override
    public String addEmpPaInfo(List insertList) {
        String resultString = "Y";
        try {
            this.insertForList("hrm.empinfo.insertEmpPaInfo", insertList);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * 家人关系删除
     */
    @Override
    public String deleteEmpPaInfo(Object object) {
        String resultString = "Y";
        try {
            this.delete("hrm.empinfo.deleteEmpPaInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * 家人关系更新
     */
    @SuppressWarnings("rawtypes")
    @Override
    public String updateEmpPaInfo(List updateList) {
        String resultString = "Y";
        try {
            this.updateForList("hrm.empinfo.updateEmpPaInfo", updateList);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String addFappendInfo(Object object) {
        String resultString = "Y";
        try {
            this.insert("hrm.empinfo.insertAdditionalInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * 健康信息添加
     */
    @Override
    public String addHealthInfo(Object object) {
        String resultString = "Y";
        try {
            this.insert("hrm.empinfo.insertHealthInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * 紧急联系人添加
     */
    @SuppressWarnings("rawtypes")
    @Override
    public String addEmergencyContactInfo(List insertList) {
        String resultString = "Y";
        try {
            this.insertForList("hrm.empinfo.insertFamilyInfo", insertList);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String deleteFappendInfo(Object object) {
        String resultString = "Y";
        try {
            this.delete("hrm.empinfo.deleteAdditionalInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String deleteHealthInfo(Object object) {
        String resultString = "Y";
        try {
            this.delete("hrm.empinfo.deleteHealthInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * 紧急联系人删除
     */
    @Override
    public String deleteEmergencyContactInfo(Object object) {
        String resultString = "Y";
        try {
            this.delete("hrm.empinfo.deleteFamilyInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String updateFappendInfo(Object object) {
        String resultString = "Y";
        try {
            this.update("hrm.empinfo.updateAdditionalInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String updateHealthInfo(Object object) {
        String resultString = "Y";
        try {
            this.update("hrm.empinfo.updateHealthInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * 紧急联系人
     */
    @SuppressWarnings("rawtypes")
    @Override
    public String updateEmergencyContactInfo(List updateList) {
        String resultString = "Y";
        try {
            this.updateForList("hrm.empinfo.updateFamilyInfo", updateList);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public List getHrSearchEmployeeList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getHrSearchEmployee", object, currentPage, pageSize);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public List getHrSearchEmployeeList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.empinfo.getHrSearchEmployee", object);
        } catch (SQLException e) {

            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getHrSearchEmployeeCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.empinfo.getHrSearchEmployeeCnt", object)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @Override
    public int deleteEmpInfo(List list) {
        try {
            this.deleteForList("hrm.empinfo.deleteEmpInfo", list);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
	
    @Override
    public Object getEmailByEmpId(String empID) {
        Object returnObject = null;
        Map map = new LinkedHashMap();
        map.put("EMPID", empID);
        try {
            returnObject = this.queryForObject("hrm.empinfo.getEmailByEmpId", map);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnObject;
    }
}
