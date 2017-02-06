package com.siping.process.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.siping.process.dao.ProcessManageDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class ProcessManageDaoImpl extends SqlMapClientSupport implements ProcessManageDao {

    Logger logger = Logger.getLogger(ProcessManageDaoImpl.class);

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
            paraMap.put("OBJECT_TYPE_ID", this.getObjectTypeById(paraMap));
            // returnList = this.getAffirmorListByObjectID(paraMap); //预留
            if (returnList.size() == 0) {
                returnList = this.getAffirmorListByObjectType(paraMap);
                if (returnList == null || returnList.size() == 0) {
                    // returnList = this.getAffirmorListByNormal(paraMap);
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getAffirmorResultList(Object obj) {
        List<LinkedHashMap> returnList = new ArrayList<LinkedHashMap>();
        try {
            returnList = this.queryForList("process.processManage.getAffirmorResultList", obj);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

    /**
     * 根据申请人工号获取审核人 (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#getAffirmorListByObjectID(java.lang.Object)
     * @param obj
     */
    @Override
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public List getAffirmorListByObjectID(Object obj) {
        List<LinkedHashMap> returnList = new ArrayList<LinkedHashMap>();
        try {
            returnList = this.queryForList("process.processManage.getAffirmorListByObjectID", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
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

            returnList = this.queryForList("process.processManage.getAffirmorListByNormal", obj);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    /**
     * 根据对象状态取得审核人 (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#getAffirmorListByObjectType(java.lang.Object)
     * @param obj
     */
    @Override
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public List getAffirmorListByObjectType(Object obj) {
        List<LinkedHashMap> returnList = new ArrayList<LinkedHashMap>();
        try {
            returnList = this.queryForList("process.processManage.getAffirmorListByObjectType", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    /**
     * (non-Javadoc)
     * @see com.siping.ess.dao.InfoAppDao#addObjectApp(java.lang.Object)
     * @param obj
     */
    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map addObjectApp(Object obj, boolean affirmFlag) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        returnMap.put("errcode", new Integer(0));
        try {
            this.startTransaction();

            Map paraMap = (Map) obj;
            if (affirmFlag) {
                List<Map> affirmorList = (List<Map>) paraMap.get("affirmorList");
                this.addAffirmorList(affirmorList, paraMap);
                paraMap.remove("affirmorList");
            }
            this.addLeaveEmailInfo(paraMap);
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
                    paraMap.put("OBJECT_STATUS_ID", parmers.get("OBJECT_STATUS_ID"));
                    paraMap.put("AFFIRMOR_ID", parmers.get("AFFIRMOR_ID"));
                    this.insert("process.processManage.insertObjectAffirmInfo", paraMap);
                }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public void addLeaveEmailInfo(Map objMap) {
        try {
            Map paraMap = new LinkedHashMap<String, String>();
            paraMap.put("EMAIL_TITLE", "对象申请");
            paraMap.put("EMAIL_CONTNT", "");
            paraMap.put("EMAIL_TP", "Leave");
            paraMap.put("APPLY_NO", objMap.get("APP_NO"));
            paraMap.put("APP_TYPE", objMap.get("appType"));
            this.insert("process.processManage.insertEmailInfo", paraMap);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /* **********查看并审批申请************************************** */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map getAffirmObjectInfo(Object object, int currentPage, int pageSize) {
        Map returnMap = new LinkedHashMap();
        try {
            List Rows = this.queryForList("process.processManage.getAffirmObjectInfo", object, currentPage, pageSize);
            int Total = Rows.size();
            returnMap.put("Rows", Rows);
            returnMap.put("Total", Total);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnMap;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map getAffirmObjectInfo(Object object) {
        Map returnMap = new LinkedHashMap();
        try {
            List Rows = this.queryForList("process.processManage.getAffirmObjectInfo", object);
            returnMap.put("Rows", Rows);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnMap;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map affirmObjectApp(List objectList) {
        Map resultMap = new HashMap();
        resultMap.put("flag", "Y");
        try {
            for (int i = 0; i < objectList.size(); i++) {
                Map paraMap = (Map) objectList.get(i);
                this.update("process.processManage.updateDoAffirm", paraMap);
            }
        } catch (SQLException e) {
            resultMap.put("flag", "Error: 提交审核结果失败");
            e.printStackTrace();
        }
        return resultMap;
    }

    @SuppressWarnings("rawtypes")
    public List getRejectedStatus(Object object) throws SQLException {
        return this.queryForList("process.processManage.getRejectedStatus", object);
    }

    /**
     * 检查是否是全部通过的 (non-Javadoc)
     * @see com.siping.ess.dao.AffirmAppDao#isAllAffirm(java.lang.Object)
     */
    @Override
    public boolean isAllAffirm(Object object) {
        boolean returnBoolean = false;
        try {
            int aCnt = (Integer) this.queryForObject("process.processManage.getAllAffirmorCnt", object);
            int bCnt = (Integer) this.queryForObject("process.processManage.getApproveAffirmorCnt", object);
            if (aCnt == bCnt) {
                returnBoolean = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            returnBoolean = false;
        } catch (Exception e) {
            e.printStackTrace();
            returnBoolean = false;
        }
        return returnBoolean;
    }

    /**
     * 检查是否是否决的 (non-Javadoc)
     * @see com.siping.ess.dao.AffirmAppDao#isAllAffirm(java.lang.Object)
     */
    @Override
    public boolean isAllReject(Object object) {
        boolean returnBoolean = false;
        try {

            int bCnt = (Integer) this.queryForObject("process.processManage.getRejectAffirmorCnt", object);
            if (bCnt > 0) {
                returnBoolean = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            returnBoolean = false;
        } catch (Exception e) {
            e.printStackTrace();
            returnBoolean = false;
        }
        return returnBoolean;
    }

    @Override
    public boolean updateObjectStatus(Object object) {
        boolean returnBoolean = true;
        try {
            this.update("process.processManage.updateObjectStatus", object);
        } catch (SQLException e) {
            e.printStackTrace();
            returnBoolean = false;
        }
        return returnBoolean;
    }

    @Override
    public boolean updateObjectListStatus(List list) {
        boolean returnBoolean = true;
        try {
            this.updateForList("process.processManage.updateObjectStatus", list);
        } catch (SQLException e) {
            e.printStackTrace();
            returnBoolean = false;
        }
        return returnBoolean;
    }

    /**
     * 使该对象的当前申请无效
     * @param object
     * @throws SQLException
     */
    private void invalidObjectApp(Object object) throws SQLException {
        this.update("process.processManage.invalidObjectApp", object);
    }

    private String getObjectTypeById(Object object) throws SQLException {
        return (String) this.queryForObject("process.processManage.getObjectTypeById", object);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void addObjectListApp(List list) {

    }

    public void getObjectProcessNO(Object object) {
        try {
            this.insert("process.processManage.getObjectProcessNO", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @SuppressWarnings("rawtypes")
    public String getProcessResult(Object object) {
        String processResult = "";
        try {
            processResult = ((Map) this.insert("process.processManage.getProcessResult", object)).get("PROCESS_RESULT").toString();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return processResult;
    }
}
