package com.siping.system.service.impl;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.productStorage.dao.SalesModelDao;
import com.siping.system.bean.AdminBean;
import com.siping.system.dao.SystemDao;
import com.siping.system.service.SystemSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class SystemSerImpl implements SystemSer {

    Logger logger = Logger.getLogger(SystemSerImpl.class);

    @Autowired
    private SystemDao systemDao;
    @Autowired
    private SalesModelDao salesModelDao;

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public void updateModel(HttpServletRequest request) {

        List list = new ArrayList();
        Enumeration en = request.getParameterNames();
        while (en.hasMoreElements()) {

            String key = (String) en.nextElement();
            if (key.endsWith("Model")) {
                Map user = new LinkedHashMap();
                user.put("mtype", request.getParameter("mtype"));
                user.put("mjsp", request.getParameter("mjsp"));
                user.put("mname", key);
                user.put("mcontent", request.getParameter(key));

                logger.info("key:" + user.get("mname"));
                logger.info("value:" + user.get("mcontent"));

                list.add(user);
            }
        }

        systemDao.deleteModel(list);
        systemDao.insertModel(list);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getModel(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("ADMINID", admin.getAdminID());
        paramMap.put("mtype", request.getParameter("mtype"));
        paramMap.put("mjsp", request.getParameter("mjsp"));

        logger.info("mtype:" + paramMap.get("mtype"));
        logger.info("mjsp:" + paramMap.get("mjsp"));

        return systemDao.getModel(paramMap);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getMenu(Object object) {
        return systemDao.getMenu(object);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getProductID(Object object) {

        return systemDao.getProductID(object);

    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getCustID(Object object) {

        return systemDao.getCustID(object);

    }

    @Override
    public Object getPurview(Object object) {
        return systemDao.getPurview(object);
    }

    @Override
    public Object getPurviewBtn(Object object) {
        return systemDao.getPurviewBtn(object);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getSystemCode(Object object) {
        return systemDao.getSystemCode(object);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getPosition(Object object) {
        return systemDao.getPosition(object);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getPostGrade(Object object) {
        return systemDao.getPostGrade(object);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getPostGroup(Object object) {
        return systemDao.getPostGroup(object);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getPostColumn(Object object) {
        return systemDao.getPostColumn(object);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getPost(Object object) {
        return systemDao.getPost(object);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getProductUnit(Object object) {
        return systemDao.getProductUnit(object);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getMessageType(Object object) {
        return systemDao.getMessageType(object);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getTransferType(Object object) {
        return systemDao.getTransferType(object);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getPropertyValueType(Object object) {
        return systemDao.getPropertyValueType(object);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getCompany(Object object) {
        return systemDao.getCompany(object);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getStatus(Object object) {
        return systemDao.getStatus(object);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getOrderStatus(Object object) {
        return systemDao.getOrderStatus(object);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getConStatus(Object object) {
        return systemDao.getConStatus(object);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getAppStatus(Object object) {
        return systemDao.getAppStatus(object);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getShiftAttribution(Object object) {
        return systemDao.getShiftAttribution(object);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getAssetID(HttpServletRequest request) {
        List retrunList = new ArrayList();
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        /*aibi添加 begin*/
        if(paramMap.get("keyWord")== null){
        	paramMap.put("keyWord", "");
        }
        /*end*/
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.systemDao.getAssetID(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        }
        return retrunList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getObjectTypeList(Object object) {
        return systemDao.getObjectTypeList(object);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getStatusNoList(Object object) {
        return systemDao.getStatusNoList(object);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public int getAssetInfoCnt(HttpServletRequest request) {
        Map paramMap = new LinkedHashMap();
        paramMap.put("language", Messages.getLanguage(request));
        return systemDao.getAssetInfoCnt(paramMap);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getCheckTypeList(Map paramMap) throws Exception {
        return this.systemDao.getCheckTypeList(paramMap);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getCheckedListInfo(Map paramMap) throws Exception {
        List list = new ArrayList();
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            list = this.systemDao.getCheckedListInfo(paramMap,
                    NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")),Integer.class),
                    NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")),Integer.class));
        }
        return list;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public int getCheckedListInfoCnt(Map paramMap) throws Exception {
        int cnt = 0;
        cnt = this.systemDao.getCheckedListInfoCnt(paramMap);
        return cnt;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String saveOrUpdateCheckedType(HttpServletRequest request) throws Exception {
        String returnMsg = "Y";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("DID_BY", admin.getAdminID());
        String type = paramMap.get("TYPE").toString();
        if("save".equals(type)){
            int returnCnt = this.systemDao.getCheckedTypeCnt(paramMap);
            if(returnCnt>=1){
                return returnMsg ="失败！该审核类型已设置完成！";
            }
            String saveMsg = this.systemDao.saveCheckedType(paramMap);
            if(!("Y".equals(saveMsg))){
                returnMsg = "保存失败！";
            }
        }else{
            int upRow = this.systemDao.updateCheckedType(paramMap);
            if(upRow<1){
                returnMsg = "更新失败！";
            }
        }
        return returnMsg;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int deleteCheckedType(HttpServletRequest request) throws Exception {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        return this.systemDao.deleteCheckedType(paramMap);
    }

    @Override
    public LinkedHashMap<String, Object> getApproverId(String checkTypeId) throws Exception {
        return this.systemDao.getApproverId(checkTypeId);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getSalesModelList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID",admin.getCpnyId());

        return this.salesModelDao.getSalesModelList(paramMap);
    }
}
