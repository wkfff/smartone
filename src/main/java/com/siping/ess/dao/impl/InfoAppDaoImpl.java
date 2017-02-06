package com.siping.ess.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.siping.ess.dao.InfoAppDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class InfoAppDaoImpl extends SqlMapClientSupport implements InfoAppDao {

    Logger logger = Logger.getLogger(InfoAppDaoImpl.class);

    /**
     * 取得审核人列表 (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#getAffirmorList(java.lang.Object)
     * @param obj
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getAffirmorList(Object obj) {
        List<LinkedHashMap> returnList = new ArrayList<LinkedHashMap>();
        try {
            Map paraMap = (Map) obj;
            if (paraMap.get("appType") != null && !paraMap.get("appType").equals("")) {
                paraMap.put("affirmLevel", this.getAffirmorLevelByParam(paraMap));

                returnList = this.getAffirmorListByEmpID(paraMap);
                if (returnList.size() == 0) {
                    returnList = this.getAffirmorListByDeptID(paraMap);
                    if (returnList.size() == 0) {
                        returnList = this.getAffirmorListByNormal(paraMap);
                    }
                }
                String transLastAffirmor = paraMap.get("transLastAffirmor").toString();
                if (transLastAffirmor != null && !transLastAffirmor.equals("") && paraMap.get("isAddLastAffirmor").equals("true")) {
                    returnList = this.setLastAffirmor(returnList, paraMap);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

    /**
     * 根据申请人工号获取审核人 (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#getAffirmorListByEmpID(java.lang.Object)
     * @param obj
     */
    @Override
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public List getAffirmorListByEmpID(Object obj) {
        List<LinkedHashMap> returnList = new ArrayList<LinkedHashMap>();
        try {
            returnList = this.queryForList("ess.infoApp.getAffirmorListByEmpID", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    /**
     * 个人信息申请 (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#addPersonalInfoApp(java.lang.Object)
     * @param obj
     */
    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map addPersonalInfoApp(Object obj) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        returnMap.put("errcode", new Integer(0));
        try {
            this.startTransaction();
            this.delete("ess.infoApp.delEssPersonalInfo", obj);
            this.insert("ess.infoApp.insertEssPersonalInfo", obj);
            this.commitTransation();
        } catch (SQLException e) {
            e.printStackTrace();
            returnMap.put("errcode", new Integer(-1));
            returnMap.put("errmsg", e.toString());
        } finally {
            try {
                this.endTransation();
            } catch (Exception e) {
                e.printStackTrace();
                returnMap.put("errcode", new Integer(-1));
                returnMap.put("errmsg", e.toString());
            }
        }
        return returnMap;
    }

    /**
     * 无特殊设置取得审批人列表 (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#getAffirmorListByNormal(java.lang.Object)
     * @param obj
     */
    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List getAffirmorListByNormal(Object obj) {
        List<LinkedHashMap> returnList = new ArrayList<LinkedHashMap>();
        try {

            returnList = this.queryForList("ess.infoApp.getAffirmorListByNormal", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    /**
     * 根据申请人部门取得审核人 (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#getAffirmorListByDeptID(java.lang.Object)
     * @param obj
     */
    @Override
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public List getAffirmorListByDeptID(Object obj) {
        List<LinkedHashMap> returnList = new ArrayList<LinkedHashMap>();
        try {
            returnList = this.queryForList("ess.infoApp.getAffirmorListByDeptID", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    /**
     * 更具参数获取审核等级
     * @param obj
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getAffirmorLevelByParam(Object obj) {
        Integer returnInt = 6;
        try {
            Map paraMap = (Map) obj;
            if (paraMap.get("appType") != null && !paraMap.get("appType").equals("")) {
                if (paraMap.get("appType").equals("OtApply")) {
                    paraMap.put("OT_LENGTH", this.getOTlength(paraMap));
                    returnInt = (Integer) this.queryForObject("ess.infoApp.getAffirmorLevelByParam_ot", paraMap);
                } else if (paraMap.get("appType").equals("LeaveApply")) {
                    paraMap.put("LEAVE_LENGTH", this.getLeavelength(paraMap));
                    returnInt = (Integer) this.queryForObject("ess.infoApp.getAffirmorLevelByParam_leave", paraMap);
                } else {
                    returnInt = (Integer) this.queryForObject("ess.infoApp.getAffirmorLevelByParam_normal", paraMap);
                }
            }
            if (returnInt == null) {
                returnInt = 6;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnInt;
    }

    /**
     * (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#addOvertimeApp(java.lang.Object)
     * @param obj
     */
    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map addOvertimeApp(Object obj) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        returnMap.put("errcode", new Integer(0));
        try {
            this.startTransaction();
            Map paraMap = (Map) obj;
            this.insert("ess.infoApp.insertOvertimeApp", obj);
            this.addOTEmailInfo(paraMap);
            this.commitTransation();
        } catch (SQLException e) {
            e.printStackTrace();
            returnMap.put("errcode", new Integer(-1));
            returnMap.put("errmsg", e.toString());
        } finally {
            try {
                this.endTransation();
            } catch (Exception e) {
                e.printStackTrace();
                returnMap.put("errcode", new Integer(-1));
                returnMap.put("errmsg", e.toString());
            }
        }
        return returnMap;
    }

    /**
     * (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#getOTAppAffirmLeve(java.lang.Object)
     * @param obj
     */
    @Override
    public int getOTAppAffirmLeve(Object obj) {
        int LeveCnt = 0;
        try {
            LeveCnt = (Integer) this.queryForObject("ess.infoApp.getOTAppAffirmLeve", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                this.endTransation();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return LeveCnt;
    }

    /**
     * 漏卡信息 (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#addCardtimeApp(java.lang.Object)
     * @param objList
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map addCardtimeApp(Object obj) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        returnMap.put("errcode", new Integer(0));
        try {
            this.insert("ess.infoApp.insertCardtimeApp", obj);
        } catch (SQLException e) {
            e.printStackTrace();
            returnMap.put("errcode", new Integer(-1));
            returnMap.put("errmsg", e.toString());
        }
        return returnMap;
    }

    /**
     * (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#addBTApp(java.lang.Object)
     * @param obj
     */
    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map addBTApp(Object obj) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        returnMap.put("errcode", new Integer(0));
        try {
            this.startTransaction();
            // Map paraMap = (Map) obj;
            // List<Map> affirmorList = (List<Map>) paraMap.get("affirmorList");
            this.insert("ess.infoApp.insertBTApp", obj);
            // paraMap.put("APP_NO", appNo);
            // this.addAffirmorList(affirmorList, paraMap);
            this.commitTransation();
        } catch (SQLException e) {
            e.printStackTrace();
            returnMap.put("errcode", new Integer(-1));
            returnMap.put("errmsg", e.toString());
        } finally {
            try {
                this.endTransation();
            } catch (Exception e) {
                e.printStackTrace();
                returnMap.put("errcode", new Integer(-1));
                returnMap.put("errmsg", e.toString());
            }
        }
        return returnMap;
    }

    /**
     * (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#addLeaveApp(java.lang.Object)
     * @param obj
     */
    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map addLeaveApp(Object obj, boolean affirmFlag) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        returnMap.put("errcode", new Integer(0));
        try {
            this.startTransaction();
            this.insert("ess.infoApp.insertLeaveApp", (Map) obj);
            this.commitTransation();
        } catch (SQLException e) {
            e.printStackTrace();
            returnMap.put("errcode", new Integer(-1));
            returnMap.put("errmsg", e.toString());
        } finally {
            try {
                this.endTransation();
            } catch (Exception e) {
                e.printStackTrace();
                returnMap.put("errcode", new Integer(-1));
                returnMap.put("errmsg", e.toString());
            }
        }
        return returnMap;
    }

    /**
     * (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#getLeaveAppAffirmLeve(java.lang.Object)
     * @param obj
     */
    @Override
    public int getLeaveAppAffirmLeve(Object obj) {
        int LeveCnt = 0;
        try {
            LeveCnt = (Integer) this.queryForObject("ess.infoApp.getLeaveAppAffirmLeve", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                this.endTransation();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return LeveCnt;
    }

    /**
     * (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#addExpApp(java.lang.Object)
     * @param obj
     */
    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map addExpApp(Object obj) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        returnMap.put("errcode", new Integer(0));
        try {
            this.startTransaction();
            // Map paraMap = (Map) obj;
            // List<Map> affirmorList = (List<Map>) paraMap.get("affirmorList");
            // List<Map> insertList = (List<Map>) paraMap.get("insertList");
            this.insert("ess.infoApp.insertExpApp", obj);
            // paraMap.put("APP_NO", appNo);
            // this.addExpDetailInfo(insertList, paraMap);
            // this.addAffirmorList(affirmorList, paraMap);
            this.commitTransation();
        } catch (SQLException e) {
            e.printStackTrace();
            returnMap.put("errcode", new Integer(-1));
            returnMap.put("errmsg", e.toString());
        } finally {
            try {
                this.endTransation();
            } catch (Exception e) {
                e.printStackTrace();
                returnMap.put("errcode", new Integer(-1));
                returnMap.put("errmsg", e.toString());
            }
        }
        return returnMap;
    }

    /**
     * 无特殊设置取得审批人列表 (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#addTrainingApp(java.lang.Object)
     * @param obj
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public boolean addTrainingApp(Object obj) {
        boolean flag = true;
        try {
            ((Map) obj).put("leaveFromTime", ((Map) obj).get("leaveFromDate") + " " + "09:00");
            ((Map) obj).put("leaveToTime", ((Map) obj).get("leaveToDate") + " " + "18:00");
            Map tempObject = null;
            List<Map> tempReviewer = null;
            tempObject = (Map) this.insert("ess.infoApp.insertEvectionAppOraddTrainingApp", obj);

            tempObject.put("OpType", "TrainingApply");
            ((Map) obj).put("appType", "LeaveApply");
            tempReviewer = this.getAffirmorList(obj);
            this.addAffirmorList(tempReviewer, tempObject);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

    /**
     * 添加审核人 (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#addAffirmorList(java.lang.Object)
     * @param tempReviewer
     * @param tempObject
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public void addAffirmorList(List<Map> affirmorList, Map paraMap) {
        try {
            if (affirmorList != null && affirmorList.size() > 0)
                for (Map parmers : affirmorList) {
                    paraMap.put("AFFIRM_LEVEL", parmers.get("AFFIRM_LEVEL"));
                    paraMap.put("AFFIRMOR_ID", parmers.get("AFFIRMOR_ID"));
                    this.insert("ess.infoApp.insertEssAffirmInfo", paraMap);
                }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public void addLeaveEmailInfo(Map objMap) {
        try {
            Map paraMap = new LinkedHashMap<String, String>();
            paraMap.put("EMAIL_TITLE", "休假申请");
            paraMap.put("EMAIL_CONTNT", "");
            paraMap.put("EMAIL_TP", "Leave");
            paraMap.put("APPLY_NO", objMap.get("APP_NO"));
            paraMap.put("APP_TYPE", objMap.get("appType"));
            this.insert("ess.infoApp.insertEmailInfo", paraMap);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public void addOTEmailInfo(Map objMap) {
        try {
            Map paraMap = new LinkedHashMap<String, String>();
            paraMap.put("EMAIL_TITLE", "加班申请");
            paraMap.put("EMAIL_CONTNT", "");
            paraMap.put("EMAIL_TP", "OT");
            paraMap.put("APP_TYPE", objMap.get("appType"));
            paraMap.put("APPLY_NO", objMap.get("APP_NO"));
            this.insert("ess.infoApp.insertEmailInfo", paraMap);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 添加审核人 (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#addExpDetailInfo(java.lang.Object)
     * @param tempReviewer
     * @param tempObject
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public void addExpDetailInfo(List<Map> insertList, Map paraMap) {
        try {
            if (insertList != null && insertList.size() > 0)
                for (Map parmers : insertList) {
                    parmers.put("EXP_NO", paraMap.get("APP_NO"));
                    this.insert("ess.infoApp.insertExpDetailInfo", parmers);
                }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#getEmpVacationRema(java.lang.Object)
     * @param obj
     */
    @Override
    public double getEmpVacationRema(Object obj) {
        double returnDouble = 0.0;
        try {
            String returnString = (String) this.queryForObject("ess.infoApp.getEmpVacationRema", obj);
            if (returnString != null && !returnString.equals("")) {
                returnDouble = Double.parseDouble(returnString);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnDouble;
    }

    /**
     * (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#getEmpVacationUsed(java.lang.Object)
     * @param obj
     */
    @Override
    public double getEmpVacationUsed(Object obj) {
        double returnDouble = 0.0;
        try {
            returnDouble = (Double) this.queryForObject("ess.infoApp.getEmpVacationUsed", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnDouble;
    }

    /**
     * (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#getEmpVacationNotConfirm(java.lang.Object)
     * @param obj
     */
    @Override
    public double getEmpVacationNotConfirm(Object obj) {
        double returnDouble = 0.0;
        try {
            returnDouble = (Double) this.queryForObject("ess.infoApp.getEmpVacationNotConfirm", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnDouble;
    }

    /**
     * 获取加班时数
     * @param obj
     * @return
     */
    @SuppressWarnings("rawtypes")
    public double getOTlength(Object obj) {
        double returnDouble = 0.0;
        try {
            Map paraMap = (Map) obj;
            if (paraMap.get("OT_DATE") != null) {
                returnDouble = (Double) this.queryForObject("ess.infoApp.getOTlength", obj);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnDouble;
    }

    /**
     * 获取工时时数
     * @param obj
     * @return
     */
    public double getEmpWhTotalInfo(Object obj) {
        double returnDouble = 0.0;
        try {
            returnDouble = (Double) this.queryForObject("ess.infoApp.getEmpWhTotalInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnDouble;
    }

    /**
     * 获取工时项目
     * @param obj
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<Map> getEmpWhItemInfo(Object obj) {
        List<Map> returnList = new ArrayList<Map>();
        try {
            returnList = (List) this.queryForList("ess.infoApp.getEmpWhItemInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    /**
     * 获取休假时数
     * @param obj
     * @return
     */
    @SuppressWarnings("rawtypes")
    public double getEmpLeavlTotalInfo(Object obj) {
        double returnDouble = 0.0;
        try {
            List infoList = this.queryForList("ess.infoApp.getEmpLeavlInfo", obj);
            for (int i = 0; i < infoList.size(); i++) {
                Map paraMap = (Map) infoList.get(i);
                double returnCnt = (Double) this.queryForObject("ess.infoApp.getLeavelength", paraMap);
                returnDouble = returnDouble + returnCnt;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnDouble;
    }

    /**
     * 获取休假时数
     * @param obj
     * @return
     */
    @SuppressWarnings("rawtypes")
    public double getLeavelength(Object obj) {
        double returnDouble = 0.0;
        try {
            Map paraMap = (Map) obj;
            if (paraMap.get("LEAVE_FROM_TIME") != null && paraMap.get("LEAVE_TO_TIME") != null && !paraMap.get("LEAVE_FROM_TIME").equals("") && !paraMap.get("LEAVE_TO_TIME").equals("")) {
                returnDouble = (Double) this.queryForObject("ess.infoApp.getLeavelength", obj);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnDouble;
    }

    /**
     * (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#getEmpShift(java.lang.Object)
     * @param obj
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getEmpShift(Object obj) {
        List returnList = new ArrayList<Object>();
        try {
            returnList = this.queryForList("ess.infoApp.getEmpShift", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    /**
     * 根据申请人工号获取审核人 (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#getAffirmorListByEmpID(java.lang.Object)
     * @param obj
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List setLastAffirmor(List objList, Map objMap) {
        try {
            Map affirmorObj = (Map) this.queryForObject("ess.infoApp.setLastAffirmor", objMap);
            if (affirmorObj == null) {
                objList.add(affirmorObj);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return objList;
    }

    /**
     * 项目信息 (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#addProInfo(java.lang.Object)
     * @param objList
     */
    @SuppressWarnings({ "rawtypes" })
    public String addProInfo(List objList) {
        String returnString = "Y";
        try {
            this.insertForList("ess.infoApp.saveProInfo", objList);

        } catch (SQLException e) {
            returnString = "N";
            e.printStackTrace();
        } catch (Exception e) {
            returnString = "N";
            e.printStackTrace();
        }
        return returnString;
    }

    @SuppressWarnings({ "rawtypes" })
    public String addProMemberInfo(List objList) {
        String returnString = "Y";
        try {
            this.insertForList("ess.infoApp.addProMemberInfo", objList);

        } catch (SQLException e) {
            returnString = e.getMessage();
            e.printStackTrace();
        } catch (Exception e) {
            returnString = e.getMessage();
            e.printStackTrace();
        }
        return returnString;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public String addProInfo(Object obj) {
        String returnString = "Y";
        try {
            Map paraMap = (Map) obj;
            List<LinkedHashMap<String, Object>> proMemberList = (List<LinkedHashMap<String, Object>>) paraMap.get("proMemberList");
            this.startTransaction();
            int proNo = (Integer) this.insert("ess.infoApp.addProInfo", obj);
            for (LinkedHashMap proMemberMap : proMemberList) {
                proMemberMap.put("PRO_NO", proNo);
                this.insert("ess.infoApp.addProMemberInfo", proMemberMap);
            }
            this.commitTransation();
        } catch (SQLException e) {
            returnString = "N";
            e.printStackTrace();
        } finally {
            try {
                this.endTransation();
            } catch (SQLException e) {
                returnString = "N";
                e.printStackTrace();
            } catch (Exception e) {
                returnString = "N";
                e.printStackTrace();
            }
        }
        return returnString;
    }

    public boolean isWhManager(Object obj) {
        boolean returnBoolean = false;
        try {
            String reString = (String) this.queryForObject("ess.infoApp.isWhManager", obj);
            if (reString.equals("true")) {
                returnBoolean = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnBoolean;
    }

    @SuppressWarnings({ "rawtypes" })
    public String updateProInfo(List objList) {
        String returnString = "Y";
        try {
            this.updateForList("ess.infoApp.updateProInfo", objList);

        } catch (SQLException e) {
            returnString = "N";
            e.printStackTrace();
        } catch (Exception e) {
            returnString = "N";
            e.printStackTrace();
        }
        return returnString;
    }

    /**
     * 工时申请 (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#saveWorkingHoursInfo(java.lang.Object)
     * @param objList
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map saveWorkingHoursInfo(List objList) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        returnMap.put("errcode", new Integer(0));
        try {
            this.insertForList("ess.infoApp.saveWorkingHoursInfo", objList);

        } catch (SQLException e) {
            returnMap.put("errcode", new Integer(-5));
            returnMap.put("errmsg", e.toString());
            e.printStackTrace();
        } catch (Exception e) {
            returnMap.put("errcode", new Integer(-1));
            returnMap.put("errmsg", e.toString());
            e.printStackTrace();
        }
        return returnMap;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map updateWorkingHoursInfo(List objList) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        returnMap.put("errcode", new Integer(0));
        try {
            this.updateForList("ess.infoApp.updateWorkingHoursInfo", objList);

        } catch (SQLException e) {
            returnMap.put("errcode", new Integer(-5));
            returnMap.put("errmsg", e.toString());
            e.printStackTrace();
        } catch (Exception e) {
            returnMap.put("errcode", new Integer(-1));
            returnMap.put("errmsg", e.toString());
            e.printStackTrace();
        }
        return returnMap;
    }

    /**
     * (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#addOvertimeApp(java.lang.Object)
     * @param obj
     */
    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map addToolApp(Object obj) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        returnMap.put("errcode", new Integer(0));
        try {
            this.startTransaction();
            this.insert("ess.infoApp.insertToolApp", obj);
            this.commitTransation();
        } catch (SQLException e) {
            e.printStackTrace();
            returnMap.put("errcode", new Integer(-1));
            returnMap.put("errmsg", e.toString());
        } finally {
            try {
                this.endTransation();
            } catch (Exception e) {
                e.printStackTrace();
                returnMap.put("errcode", new Integer(-1));
                returnMap.put("errmsg", e.toString());
            }
        }
        return returnMap;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map addToolAppAss(Object obj) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        returnMap.put("errcode", new Integer(0));
        try {
            this.startTransaction();
            this.insert("ess.infoApp.insertToolAppAss", obj);
            this.commitTransation();
        } catch (SQLException e) {
            e.printStackTrace();
            returnMap.put("errcode", new Integer(-1));
            returnMap.put("errmsg", e.toString());
        } finally {
            try {
                this.endTransation();
            } catch (Exception e) {
                e.printStackTrace();
                returnMap.put("errcode", new Integer(-1));
                returnMap.put("errmsg", e.toString());
            }
        }
        return returnMap;
    }

    /**
     * 获取物品租借信息
     */
    @SuppressWarnings("rawtypes")
    @Override
    public List getToolLoan(Object obj) {
        List returnList = new ArrayList<Object>();
        try {
            returnList = this.queryForList("ess.infoApp.getToolLoan", obj);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @SuppressWarnings({ "rawtypes" })
    public String updateProMemberInfo(List objList) {
        String returnString = "Y";
        try {
            this.updateForList("ess.infoApp.updateProMemberInfo", objList);

        } catch (SQLException e) {
            returnString = e.getMessage();
            e.printStackTrace();
        } catch (Exception e) {
            returnString = e.getMessage();
            e.printStackTrace();
        }
        return returnString;
    }

    @Override
    public double getVocationOTLength(Object obj) {
        double result = 0.0;
        try {
            result = (Double) this.queryForObject("ess.infoApp.getVocationOTLength", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getActiveCompensationLeave(Object obj) {
        List resultList = new ArrayList<HashMap>();
        try {
            resultList = this.queryForList("ess.infoApp.getActiveCompensationLeave", obj);
        } catch (SQLException e) {

            e.printStackTrace();
        }
        return resultList;
    }

    @Override
    public Map updateWorkingHoursInfoB(Object obj) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        returnMap.put("errcode", new Integer(0));
        String result = null;
        try {
        	this.update("ess.infoApp.updateWorkingHoursByWHNO", obj);
        	result = (String)this.queryForObject("ess.infoApp.getPreLegalForUpdate", obj);
        	if(result.equals("1")){
                this.insert("ess.infoApp.updateWorkingHoursInfo", obj);
        	}else{
        	    returnMap.put("errcode", new Integer(-5));     
        	}
        } catch (SQLException e) {
        	returnMap.put("errcode", new Integer(-1));
        } 
        return returnMap;
    }

    @Override
    public Map saveWorkingHoursInfoB(Object obj) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        returnMap.put("errcode", new Integer(0));
        String result = null;
        try {
        	result = (String)this.queryForObject("ess.infoApp.getPreLegalForSave", obj);
        	if(result.equals("1")){
        		this.insert("ess.infoApp.saveWorkingHoursInfo", obj);
        	}else{
        		returnMap.put("errcode", new Integer(-5));
        	}
        } catch (SQLException e) {
        	returnMap.put("errcode", new Integer(-1));
            e.printStackTrace();
        } 
        return returnMap;
    }

    @Override
    public Object getWhDetail(Object object) {
        Object object2 = null;
        try {
            object2 = this.queryForObject("ess.viewApp.getWhDetail", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return object2;
    }

    @Override
    public String getDeptLeaderId(Object obj) {
        String manager_empid = "";
        try {
            manager_empid = (String) this.queryForObject("ess.infoApp.getDeptLeaderId", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return manager_empid;
    }

    @Override
    public String getUpperDeptLeaderId(Object obj) {
        String upper_manager_empid = "";
        try {
            upper_manager_empid = (String) this.queryForObject("ess.infoApp.getUpperDeptLeaderId", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return upper_manager_empid;
    }

    @Override
    public String getChineseNameById(Object obj) {
        String chineseName = "";
        try {
            chineseName = (String) this.queryForObject("ess.infoApp.getChineseNameById", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return chineseName;
    }

    @Override
    public String getBusiTripDestination(Object obj) {
        String destination = "";
        try {
            destination = (String) this.queryForObject("ess.infoApp.getBusiTripDestination", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return destination;
    }

    @Override
    public String getToolName(Object obj) {
        String toolName = "";
        try {
            toolName = (String) this.queryForObject("ess.infoApp.getToolName", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return toolName;
    }

    @Override
    public String getCodeNameByCodeId(Object obj) {
        String codeName = "";
        try {
            codeName = (String) this.queryForObject("ess.infoApp.getCodeNameByCodeId", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return codeName;
    }

    @Override
    public String getPositionByCodeId(Object obj) {
        String position = "";
        try {
            position = (String) this.queryForObject("ess.infoApp.getPositionByCodeId", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return position;
    }

    @Override
    public String getdeptNameByCodeId(Object obj) {
        String deptName = "";
        try {
            deptName = (String) this.queryForObject("ess.infoApp.getdeptNameByCodeId", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return deptName;
    }

    @Override
    public String addProductionOrderInfo(Object object) {
        String returnString = "Y";
        try {
            this.insert("ess.infoApp.addProductionOrder", object);
        } catch (SQLException e) {
            returnString = e.getMessage();
            e.printStackTrace();
        } catch (Exception e) {
            returnString = e.getMessage();
            e.printStackTrace();
        }
        return returnString;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String updateProductionOrderInfo(List objList) {
        String returnString = "Y";
        try {
            this.updateForList("ess.infoApp.updateProductionOrderInfo", objList);

        } catch (SQLException e) {
            returnString = "N";
            e.printStackTrace();
        } catch (Exception e) {
            returnString = "N";
            e.printStackTrace();
        }
        return returnString;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String deleteProductionOrderInfo(List objList) {
        String returnString = "Y";
        try {
            this.updateForList("ess.infoApp.deleteProductionOrderInfo", objList);

        } catch (SQLException e) {
            returnString = "N";
            e.printStackTrace();
        } catch (Exception e) {
            returnString = "N";
            e.printStackTrace();
        }
        return returnString;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String addProductionOrderInfo(List objList) {
        String returnString = "Y";
        try {
            this.insertForList("ess.infoApp.addProductionOrderInfo", objList);
        } catch (SQLException e) {
            returnString = e.getMessage();
            e.printStackTrace();
        } catch (Exception e) {
            returnString = e.getMessage();
            e.printStackTrace();
        }
        return returnString;
    }

    @Override
    public String saveWorkingHoursInfoOther(Object object) {
        String resultString = "Y";
        try {
            this.insert("ess.infoApp.saveWorkingHoursInfoOther", object);
        } catch (SQLException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        }
        return resultString;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getAllEmpidList(Object object) {
        List resultList = new ArrayList();
        try {
            resultList = this.queryForList("ess.infoApp.getAllEmpidList", object);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return resultList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getPersonHwConclusionList(Object object) {
        List resultList = new ArrayList();
        try {
            resultList = this.queryForList("ess.infoApp.getPersonHwConclusionList", object);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return resultList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void addWhConclusion(List list) {
        try {
            this.insertForList("ess.infoApp.addWhConclusion", list);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getWhConclusionList(Object object) {
        List resultList = new ArrayList();
        try {
            // TODO
            resultList = this.queryForList("ess.infoApp.getWhConclusionList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultList;
    }

    @Override
    public int getWhConclusionListCnt(Object object) {
        int resultNum = 0;
        try {
            // TODO
            resultNum = (Integer) this.queryForObject("ess.infoApp.getWhConclusionListCnt", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultNum;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getWhConclusionListSum(Object object) {
        List resultList = new ArrayList();
        try {
            resultList = this.queryForList("ess.infoApp.getWhConclusionListSum", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List<LinkedHashMap<String, String>>getStartAndEndDate(Object obj) {
        List<LinkedHashMap<String, String>> resultList = new ArrayList<LinkedHashMap<String, String>>();
        try {
            resultList = this.queryForList("ess.infoApp.getStartAndEndDate", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultList;
    }

}
