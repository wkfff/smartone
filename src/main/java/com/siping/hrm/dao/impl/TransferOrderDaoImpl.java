package com.siping.hrm.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.hrm.dao.TransferOrderDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class TransferOrderDaoImpl extends SqlMapClientSupport implements TransferOrderDao {

    @SuppressWarnings({ "rawtypes" })
    public Object getNextTransNo() {
        Map temp = new LinkedHashMap();
        try {
            temp = (Map) this.queryForObject("hrm.transferOrder.getNextTransNo");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    /**
     * 员工信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getEmpInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.transferOrder.getEmpInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public String getNewestEmpIDInfo(Object object) {
        String returnString = "";
        try {
            returnString = (String) this.queryForObject("hrm.transferOrder.getNewestEmpIDInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnString;
    }

    /**
     * 员工信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getEmpInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.transferOrder.getEmpInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 员工信息
     * @param Object
     * @return
     */
    @Override
    public int getEmpInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.transferOrder.getEmpInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 员工业务信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getEmpActBusinessInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.transferOrder.getActBusinessInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 员工业务信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getEmpActBusinessInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.transferOrder.getActBusinessInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 员工业务信息
     * @param Object
     * @return
     */
    @Override
    public int getEmpActBusinessInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.transferOrder.getActBusinessInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 员工业务信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getActBusinessInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.searchTransferOrder.getActBusinessInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 员工业务信息
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getActBusinessInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.searchTransferOrder.getActBusinessInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 员工业务信息
     * @param Object
     * @return
     */
    @Override
    public int getActBusinessInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.searchTransferOrder.getActBusinessInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @Override
    public String saveResign(Object obj) {
        String resultString = "Y";
        try {
            this.insert("hrm.transferOrder.saveResign", obj);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String saveExperience(Object obj) {
        String resultString = "Y";
        try {
            this.insert("hrm.transferOrder.saveExperience", obj);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String saveReward(Object obj) {
        String resultString = "Y";
        try {
            this.insert("hrm.transferOrder.saveReward", obj);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String savePunishment(Object obj) {
        String resultString = "Y";
        try {
            this.insert("hrm.transferOrder.savePunishment", obj);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String saveDispath(Object obj) {
        String resultString = "Y";
        try {
            this.insert("hrm.transferOrder.saveDispath", obj);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String saveDispathEnd(Object obj) {
        String resultString = "Y";
        try {
            this.insert("hrm.transferOrder.saveDispathEnd", obj);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String savePlurality(Object obj) {
        String resultString = "Y";
        try {
            this.insert("hrm.transferOrder.savePlurality", obj);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String savePluralityEnd(Object obj) {
        String resultString = "Y";
        try {
            this.insert("hrm.transferOrder.savePluralityEnd", obj);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String saveBusiness(Object obj) {
        String resultString = "Y";
        try {
            this.insert("hrm.transferOrder.saveBusiness", obj);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String saveHire(Object obj) {
        String resultString = "Y";
        try {
            this.insert("hrm.transferOrder.saveHire", obj);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public int checkEmpID(Object obj) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("hrm.transferOrder.checkEmpID", obj).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List checkArrayListMember(List<LinkedHashMap<String, Object>> objectList) {
        List<LinkedHashMap<String, Object>> returnList = objectList;
        try {
            Iterator it = returnList.iterator();

            while (it.hasNext()) {
                LinkedHashMap<String, Object> paraMap = (LinkedHashMap<String, Object>) it.next();
                int temp = Integer.parseInt(this.queryForObject("hrm.transferOrder.checkArrayListMember", paraMap).toString());
                if (temp == 1) {
                    it.remove();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @Override
    public void hrUpdateAuto() {
        try {
            this.update("hrm.transferOrder.hrUpdateAuto");
        } catch (SQLException e) {
            e.printStackTrace();
        }
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
            returnList = this.queryForList("hrm.searchTransferOrder.getDispatchInfo", object);
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
            returnList = this.queryForList("hrm.searchTransferOrder.getDispatchInfo", object, currentPage, pageSize);
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
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.searchTransferOrder.getDispatchInfoCnt", object)), Integer.class);

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
            returnList = this.queryForList("hrm.searchTransferOrder.getPluralityInfo", object);
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
            returnList = this.queryForList("hrm.searchTransferOrder.getPluralityInfo", object, currentPage, pageSize);
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
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.searchTransferOrder.getPluralityInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 职员奖励发令查看
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getRewardInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.searchTransferOrder.getRewardInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getRewardInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.searchTransferOrder.getRewardInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getRewardInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.searchTransferOrder.getRewardInfoCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 职员惩戒发令查看
     * @param Object
     * @return
     */
    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getPunishmentInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.searchTransferOrder.getPunishMent", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getPunishmentInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.searchTransferOrder.getPunishMent", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getPunishmentInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.searchTransferOrder.getPunishMentCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
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
            returnList = this.queryForList("hrm.searchTransferOrder.getResignInfo", object);
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
            returnList = this.queryForList("hrm.searchTransferOrder.getResignInfo", object, currentPage, pageSize);
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
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.searchTransferOrder.getResignInfoCnt", object)), Integer.class);

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
    public List getUpgradeInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.searchTransferOrder.getExpInside", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getUpgradeInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.searchTransferOrder.getExpInside", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getUpgradeInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.searchTransferOrder.getExpInsideCnt", object)), Integer.class);

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
    public List getGeneralDocInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.searchTransferOrder.getExpInside", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getGeneralDocInfoList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.searchTransferOrder.getExpInside", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getGeneralDocInfoCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.searchTransferOrder.getExpInsideCnt", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void cancelExpInsideInfo(List objectList) {
        try {
            this.updateForList("hrm.searchTransferOrder.cancelExpInsideInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void cancelExpInsideInfoRecover(List objectList) {
        try {
            this.updateForList("hrm.searchTransferOrder.cancelExpInsideInfoRecover", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void cancelActBusinessInfo(List objectList) {
        try {
            this.updateForList("hrm.searchTransferOrder.cancelActBusinessInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void cancelActBusinessInfoRecover(List objectList) {
        try {
            this.updateForList("hrm.searchTransferOrder.cancelActBusinessInfoRecover", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    @SuppressWarnings("rawtypes")
    public void cancelDispatchInfo(List objectList) {
        try {
            this.updateForList("hrm.searchTransferOrder.cancelDispatchInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    @SuppressWarnings("rawtypes")
    public void cancelDispatchInfoRecover(List objectList) {
        try {
            this.updateForList("hrm.searchTransferOrder.cancelDispatchInfoRecover", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    @SuppressWarnings("rawtypes")
    public void cancelRewardInfo(List objectList) {
        try {
            this.updateForList("hrm.searchTransferOrder.cancelRewardInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    @SuppressWarnings("rawtypes")
    public void cancelRewardInfoRecover(List objectList) {
        try {
            this.updateForList("hrm.searchTransferOrder.cancelRewardInfoRecover", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    @SuppressWarnings("rawtypes")
    public void cancelPluralityInfo(List objectList) {
        try {
            this.updateForList("hrm.searchTransferOrder.cancelPluralityInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    @SuppressWarnings("rawtypes")
    public void cancelPluralityInfoRecover(List objectList) {
        try {
            this.updateForList("hrm.searchTransferOrder.cancelPluralityInfoRecover", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    @SuppressWarnings("rawtypes")
    public void cancelPunishMentInfo(List objectList) {
        try {
            this.updateForList("hrm.searchTransferOrder.cancelPunishMentInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    @SuppressWarnings("rawtypes")
    public void cancelPunishMentInfoRecover(List objectList) {
        try {
            this.updateForList("hrm.searchTransferOrder.cancelPunishMentInfoRecover", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    @SuppressWarnings("rawtypes")
    public void cancelResignInfo(List objectList) {
        try {
            this.updateForList("hrm.searchTransferOrder.cancelResignInfo", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    @SuppressWarnings("rawtypes")
    public void cancelResignInfoRecover(List objectList) {
        try {
            this.updateForList("hrm.searchTransferOrder.cancelResignInfoRecover", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getSumRewardInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.searchTransferOrder.getSumRewardInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getSumPunishmentInfoList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.searchTransferOrder.getSumPunishmentInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

}
