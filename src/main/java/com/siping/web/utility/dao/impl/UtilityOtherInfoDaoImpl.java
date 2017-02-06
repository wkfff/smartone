package com.siping.web.utility.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.siping.process.bean.Type;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.SqlMapClientSupport;
import com.siping.web.utility.dao.UtilityOtherInfoDao;

@Repository
public class UtilityOtherInfoDaoImpl extends SqlMapClientSupport implements UtilityOtherInfoDao {

    Logger logger = Logger.getLogger(UtilityOtherInfoDaoImpl.class);

    /**
     * (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getMenuModuleSelectList(java.lang
     *      .Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getMenuModuleSelectList(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("utility.otherInfo.getMenuModuleSelectList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    /**
     * (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getDataTypeSelectList(java.lang
     *      .Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getDataTypeSelectList(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("utility.otherInfo.getDataTypeSelectList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getWorkAreaList(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("utility.otherInfo.getWorkAreaList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Map defaultValue = new HashMap();
        defaultValue.put("ID", "WorkArea000");
        defaultValue.put("NAME", "默认");
        temp.add(defaultValue);
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getSalaryReferenceList(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("utility.otherInfo.getSalaryReferenceList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return temp;
    }

    /**
     * (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getMCSelectList(java.lang
     *      .Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getMCSelectList(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("utility.otherInfo.getMCSelectList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    /**
     * (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getToolItemSelectList(java.lang
     *      .Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getToolItemSelectList(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("utility.otherInfo.getToolItemSelectList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    /**
     * (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getMC1STSelectList(java.lang
     *      .Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getMC1STSelectList(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("utility.otherInfo.getMC1STSelectList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    /**
     * (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getMCName(java.lang
     *      .Object)
     */
    @Override
    public String getMCName(Object object) {
        String returnString = "";
        try {
            returnString = (String) this.queryForObject("utility.otherInfo.getMCName", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnString;
    }

    /**
     * (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getMC2NDSelectList(java.lang
     *      .Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getMC2NDSelectList(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("utility.otherInfo.getMC2NDSelectList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    /**
     * (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getParameterTypeSelectList(java.lang
     *      .Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getParameterTypeSelectList(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("utility.otherInfo.getParameterTypeSelectList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    /**
     * (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getDataTypeSelectList(java.lang
     *      .Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getShiftAttSelectList(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("utility.otherInfo.getShiftAttSelectList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    /**
     * 获得职级下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getPostGradeSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getPostGradeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getPostGradeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得职列下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getPostColumnSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getPostColumnSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getPostColumnSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得职群下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getPostGroupSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getPostGroupSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getPostGroupSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得职位下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getPostSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getPostSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getPostSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得职位下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getPositionSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getPositionSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getPositionSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getActivitySelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getActivitySelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getActivitySelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getCompanySelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getCompanySelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getCompanySelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getBankSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getBankSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getBankSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getEvaPeriodSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getEvaPeriodSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getEvaPeriodSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getEvaPeriodTypeSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getEvaPeriodTypeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getEvaPeriodTypeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getProTypeCodeSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getProTypeCodeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getProTypeCodeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getReasonSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getReasonSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getReasonSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getLeaveTypeSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getLeaveTypeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getLeaveTypeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getEvTypeSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getEvTypeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getEvTypeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getEvTypeProcessSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getEvTypeProcessSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getEvTypeProcessSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getEvTypeOperationSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getEvTypeOperationSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getEvTypeOperationSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getEvTypeItemSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getEvTypeItemSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getEvTypeItemSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getOTTypeSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getOTTypeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getOTTypeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getBTSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getBTSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getBTSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getExpDetailTypeSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getExpDetailTypeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getExpDetailTypeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getProSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getProSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getProSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getResignTypeSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getResignTypeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getResignTypeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getDisTypeSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getDisTypeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getDisTypeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getPunishmentTypeSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getPunishmentTypeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getPunishmentTypeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getTaxWaySelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getTaxWaySelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getTaxWaySelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getRewardTypeSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getRewardTypeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getRewardTypeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getRewardGradeSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getRewardGradeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getRewardGradeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getBIZSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getBIZSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getBIZSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getStatusSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getStatusSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getStatusSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getOtherRelationlTypeSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getOtherRelationlTypeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getOtherRelationlTypeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getRelationalTypeSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getRelationalTypeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getRelationalTypeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getDegreeTypeSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getDegreeTypeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getDegreeTypeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getEduHisTypeSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getEduHisTypeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getEduHisTypeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getEduHisTypeSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getReturnTypeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getReturnTypeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getCurrencyUnitSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getCurrencyUnitSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getCurrencyUnitSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getContractTypeSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getContractTypeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getContractTypeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 考勤项目下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getItemInfoSelection(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getItemInfoSelection(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getItemInfoSelection", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 考勤项目下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getUnitSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getUnitSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getUnitSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 漏卡理由下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getCardtimeReasonSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getCardtimeReasonSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getCardtimeReasonSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 加班申请是否执行始末时间先后检查
     * @param obj
     * @return (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getModuleParameter(java.lang.Object)
     */
    @Override
    public String getModuleParameter(Object obj) {
        String returnString = "";
        try {
            returnString = (String) this.queryForObject("utility.otherInfo.getModuleParameter", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnString;
    }

    /**
     * 获取考勤月开始日期信息
     * @param obj
     * @return (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getStartDateStr(java.lang.Object)
     */
    @Override
    public String getStartDateStr(Object obj) {
        String returnString = "";
        try {
            returnString = (String) this.queryForObject("utility.otherInfo.getStartDateStr", obj);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnString;
    }

    /**
     * 获取考勤月结束日期信息
     * @param obj
     * @return (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getEndDateStr(java.lang.Object)
     */
    @Override
    public String getEndDateStr(Object obj) {
        String returnString = "";
        try {
            returnString = (String) this.queryForObject("utility.otherInfo.getEndDateStr", obj);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnString;
    }

    /**
     * 地区下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getAreasByParentID(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getAreasByParentID(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getAreasByParentID", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 出差区间下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getBTDurationInfo(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getBTDurationInfo(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getBTDurationInfo", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 考勤项目下拉列表 (non-Javadoc)
     * @see com.siping.web.utility.dao.UtilityOtherInfoDao#getItemSelectList(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getItemSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getAttItemInfo", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getCustActionStateList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getCustActionStateList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getCustActionWayList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getCustActionWayList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getAnnouncementTypeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getAnnouncementTypeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    @Override
    public Object getScreenGrantId(AdminBean admin, Type type) {
        Object obj = null;
        try {
            obj = this.queryForObject("utility.otherInfo.getScreenGrantId", admin);
        } catch (SQLException e) {

            e.printStackTrace();
        }
        return obj;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getSyCodeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getSyCodeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获取报工时生产订单及图纸号下拉列表
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getProductionOrderSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getProductionOrderSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getApplyFunctionSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getApplyFunctionSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getPaymentModeInfo(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("utility.otherInfo.getPaymentModeInfo", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }
/**
 * 获取客户评级下拉菜单
 * */
    @SuppressWarnings("rawtypes")
    @Override
    public List getPurchaseTendList(Object object) {
        List list=new ArrayList();
        try {
            list=this.queryForList("utility.otherInfo.getPurchaseTendList", object);
        } catch (SQLException e) {
             
            e.printStackTrace();
        }
        return list;
    }
}
