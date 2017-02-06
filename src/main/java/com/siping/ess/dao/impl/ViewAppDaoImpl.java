package com.siping.ess.dao.impl;

import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.ess.dao.ViewAppDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class ViewAppDaoImpl extends SqlMapClientSupport implements ViewAppDao {

    @Override
    public Object getPersonalInfo(Object object) {
        Object returnObject = null;
        try {
            returnObject = this.queryForObject("ess.viewApp.getEssPersonalInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnObject;
    }

    @Override
    public Object getOldPersonalInfo(Object object) {
        Object returnObject = null;
        try {
            returnObject = this.queryForObject("ess.viewApp.getOldPersonalInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnObject;
    }

    /**
     * 账户信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getPersonalInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getEssPersonalInfoList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getPersonalInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getEssPersonalInfoList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getPersonalInfoListCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.viewApp.getEssPersonalInfoListCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 项目信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getProInfo(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getProInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getProInfoByReim(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getProInfoByReim", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }
    
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getProInfo(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getProInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getProInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.viewApp.getProInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }
    
    @Override
    public int getProInfoCntByReim(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.viewApp.getProInfoCntByReim", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }
    
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getProMemberInfo(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getProMemberInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getProMemberInfo(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getProMemberInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getProMemberInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.viewApp.getProMemberInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 项目信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getWhInfo(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getWhInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getWhInfo(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getWhInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getWhInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.viewApp.getWhInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getWorkingHoursInfo(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getWorkingHoursInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getWorkingHoursInfo(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getWorkingHoursInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getWorkingHoursInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.viewApp.getWorkingHoursInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getOtInfo(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getOtInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getOtInfo(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getOtInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getOtInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.viewApp.getOtInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 物品信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getToolInfo(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getToolInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getToolInfo(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getToolInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getToolInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.viewApp.getToolInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map getEmpEtnAppView(Object object, int currentPage, int pageSize) {
        Map object2 = new LinkedHashMap();
        try {
            List Rows = this.queryForList("ess.viewApp.getEssviewEtnviewList", object, currentPage, pageSize);
            Integer count = (Integer) this.queryForObject("ess.viewApp.getEssviewEtnviewListCnt", object);
            object2.put("Rows", Rows);
            object2.put("Total", count);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return object2;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getExpInfo(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getExpInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getExpInfo(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getExpInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @Override
    public int getExpInfoCnt(Object object) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.viewApp.getExpInfoCnt", object)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getBTInfo(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getBTInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getBTInfo(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getBTInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getBTInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.viewApp.getBTInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getLeaveInfo(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getLeaveInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getLeaveInfo(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getLeaveInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getLeaveInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.viewApp.getLeaveInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getCardtimeInfo(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getCardtimeInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getCardtimeInfo(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getCardtimeInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getCardtimeInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.viewApp.getCardtimeInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getCardtimeAttInfo(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getCardtimeAttInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getCardtimeAttInfo(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getCardtimeAttInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getCardtimeAttInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.viewApp.getCardtimeAttInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getExpDetailInfo(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getExpDetailInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getExpDetailInfo(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getExpDetailInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getExpDetailInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.viewApp.getExpDetailInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map getEmpTrainingAppView(Object object, int currentPage, int pageSize) {
        Map object2 = new LinkedHashMap();
        try {
            List Rows = this.queryForList("ess.viewApp.getEssviewTrainingviewList", object, currentPage, pageSize);
            Integer count = (Integer) this.queryForObject("ess.viewApp.getEssviewTrainingviewListCnt", object);
            object2.put("Rows", Rows);
            object2.put("Total", count);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return object2;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String cancelPerInfo(List objectList) {
        String returnString = "Y";
        try {
            this.updateForList("ess.viewApp.cancelPersonInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
            returnString = "N";
        } catch (Exception e) {
            e.printStackTrace();
            returnString = "N";
        }
        return returnString;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String cancelWhInfo(List objectList) {
        String returnString = "Y";
        try {
            this.updateForList("ess.viewApp.cancelWhInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
            returnString = e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            returnString = e.getMessage();
        }
        return returnString;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map getAffirmorList(Object object) {
        Map returnMap = new LinkedHashMap();
        List Rows = new ArrayList<Object>();
        try {
            Rows = this.queryForList("ess.viewApp.getAffirmorList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        returnMap.put("Rows", Rows);
        return returnMap;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public String cancelOtInfo(List objectList) {
        String returnString = "Y";
        try {
            // this.deleteForList("ess.infoConfirm.delArDetail", objectList);
            // this.deleteForList("ess.infoConfirm.delArAppResult", objectList);
            this.updateForList("ess.viewApp.cancelOtInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
            returnString = "N";
        } catch (Exception e) {
            e.printStackTrace();
            returnString = "N";
        }
        return returnString;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public String cancelLeaveInfo(List objectList) {
        String returnString = "Y";
        try {
            // this.deleteForList("ess.infoConfirm.delArDetail", objectList);
            // this.deleteForList("ess.infoConfirm.delArAppResult", objectList);
            this.updateForList("ess.viewApp.cancelLeaveInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
            returnString = "N";
        } catch (Exception e) {
            e.printStackTrace();
            returnString = "N";
        }
        return returnString;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public String cancelBizInfo(List objectList) {
        String returnString = "Y";
        try {
            // this.deleteForList("ess.infoConfirm.delArDetail", objectList);
            // this.deleteForList("ess.infoConfirm.delArAppResult", objectList);
            this.updateForList("ess.viewApp.cancelBTInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
            returnString = "N";
        } catch (Exception e) {
            e.printStackTrace();
            returnString = "N";
        }
        return returnString;
    }

    @Override
    @SuppressWarnings("rawtypes")
    public String cancelTrainingInfo(List objectList) {
        String returnString = "Y";
        try {
            this.deleteForList("ess.infoConfirm.delArDetail", objectList);
            this.deleteForList("ess.infoConfirm.delArAppResult", objectList);
            this.updateForList("ess.viewApp.cancelLeaveInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
            returnString = "N";
        } catch (Exception e) {
            e.printStackTrace();
            returnString = "N";
        }
        return returnString;
    }

    @Override
    @SuppressWarnings("rawtypes")
    public String cancelExpInfo(List objectList) {
        String returnString = "Y";
        try {
            this.updateForList("ess.viewApp.cancelExpInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
            returnString = "N";
        } catch (Exception e) {
            e.printStackTrace();
            returnString = "N";
        }
        return returnString;
    }

    @Override
    @SuppressWarnings("rawtypes")
    public String cancelCardtimeInfo(List objectList) {
        String returnString = "Y";
        try {
            this.updateForList("ess.viewApp.cancelCardtimeInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
            returnString = "N";
        } catch (Exception e) {
            e.printStackTrace();
            returnString = "N";
        }
        return returnString;
    }

    /**
     * 获取个人休假信息
     * @param obj
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getEmpLeaveDetailInfo(Object obj) {
        List returnList = new ArrayList();
        try {
            List infoList = this.queryForList("ess.viewApp.getLeaveInfo", obj);
            for (int i = 0; i < infoList.size(); i++) {
                LinkedHashMap<String, String> paraMap = (LinkedHashMap<String, String>) infoList.get(i);
                double cnt = (Double) this.queryForObject("ess.infoApp.getLeavelength", paraMap);
                paraMap.put("LEAVE_LENGTH", cnt + "");
                returnList.add(paraMap);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    /**
     * 获取个人休假信息
     * @param obj
     * @param currentPage
     * @param pageSize
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getEmpLeaveDetailInfo(Object obj, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        DecimalFormat df = new DecimalFormat("#.0");
        try {
            List infoList = this.queryForList("ess.viewApp.getLeaveInfo", obj);
            for (int i = 0; i < infoList.size(); i++) {
                LinkedHashMap<String, String> paraMap = (LinkedHashMap<String, String>) infoList.get(i);
                double cnt = Double.parseDouble(df.format((Double) this.queryForObject("ess.infoApp.getLeavelength", paraMap)));
                paraMap.put("LEAVE_LENGTH", cnt + "");
                returnList.add(paraMap);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    /**
     * 获取个人休假信息
     * @param obj
     * @return
     */
    @Override
    public int getEmpLeaveDetailInfoCnt(Object obj) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.viewApp.getLeaveInfoCnt", obj)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnInt;
    }

    @Override
    public String delWorkingHoursInfo(Object object) {
        String returnString = "Y";
        try {
            this.delete("ess.viewApp.delWorkingHoursInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            returnString = "N";
        } catch (Exception e) {
            e.printStackTrace();
            returnString = "N";
        }
        return returnString;
    }

    @Override
    public String delProInfo(Object object) {
        String returnString = "Y";
        try {
            this.delete("ess.viewApp.delProInfo", object);
            this.delete("ess.viewApp.delProductionOrderInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            returnString = e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            returnString = e.getMessage();
        }
        return returnString;
    }

    @Override
    public String delProMemberInfo(Object object) {
        String returnString = "Y";
        try {
            this.delete("ess.viewApp.delProMemberInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            returnString = "N";
        } catch (Exception e) {
            e.printStackTrace();
            returnString = "N";
        }
        return returnString;
    }

    @Override
    public String delExpDetailInfo(Object object) {
        String returnString = "Y";
        try {
            this.delete("ess.viewApp.delExpDetailInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
            returnString = "N";
        } catch (Exception e) {
            e.printStackTrace();
            returnString = "N";
        }
        return returnString;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String cancelToolInfo(List objectList) {
        String returnString = "Y";
        try {
            this.updateForList("ess.viewApp.cancelToolInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
            returnString = "N";
        } catch (Exception e) {
            e.printStackTrace();
            returnString = "N";
        }
        return returnString;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String delProMemberInfo(List objectList) {
        String returnString = "Y";
        try {
            this.deleteForList("ess.viewApp.delProMemberInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
            returnString = "N";
        } catch (Exception e) {
            e.printStackTrace();
            returnString = "N";
        }
        return returnString;
    }

    @Override
    public List getLeave_noByEmpid(String id) {
        List list = new ArrayList();
        try {
            list = this.queryForList("ess.viewApp.getLeave_noByEmpid", id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public void updateLeaveAffirmflag_agree(String processInstanceId) {
        Map<String, Object> map = new LinkedHashMap<String, Object>();
        map.put("PROCESSID", processInstanceId);
        try {
            this.update("ess.viewApp.updateLeaveAffirmflag_agree", map);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateLeaveAffirmflag_veto(String processInstanceId) {
        Map<String, Object> map = new LinkedHashMap<String, Object>();
        map.put("PROCESSID", processInstanceId);
        try {
            this.update("ess.viewApp.updateLeaveAffirmflag_veto", map);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public String RecoverCancelPerInfo(List objectList) {

        return null;
    }

    @Override
    public String RecoverCancelWhInfo(List objectList) {
        try {
            this.updateForList("ess.viewApp.recoverCancelWhInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @Override
    public String RecoverCancelOtInfo(List objectList) {
        try {
            this.updateForList("ess.viewApp.recoverCancelOtInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @Override
    public String RecoverCancelLeaveInfo(List objectList) {
        try {
            this.updateForList("ess.viewApp.recoverCancelLeaveInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @Override
    public String RecoverCancelBizInfo(List objectList) {
        try {
            this.updateForList("ess.viewApp.recoverCancelBTInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @Override
    public String RecoverCancelTrainingInfo(List objectList) {
        return "";
    }

    @Override
    public String RecoverCancelExpInfo(List objectList) {
        try {
            this.updateForList("ess.viewApp.recoverCancelExpInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @Override
    public String RecoverCancelCardtimeInfo(List objectList) {
        try {
            this.updateForList("ess.viewApp.recoverCancelCardtimeInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @Override
    public String RecoverCancelToolInfo(List objectList) {
        try {
            this.updateForList("ess.viewApp.recoverCancelToolInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getProductionOrderInfo(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getProductionOrderInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getProductionOrderInfo(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ess.viewApp.getProductionOrderInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getProductionOrderInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.viewApp.getProductionOrderInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }
}
