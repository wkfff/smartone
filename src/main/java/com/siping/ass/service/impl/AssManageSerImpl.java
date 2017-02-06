package com.siping.ass.service.impl;

import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.ass.dao.AssManageDao;
import com.siping.ass.service.AssManageSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class AssManageSerImpl implements AssManageSer {

    @Autowired
    private AssManageDao assManageDao;

    /**
     * 检查资产ID是否重复
     */
    @SuppressWarnings("rawtypes")
    @Override
    public String checkAssetID(HttpServletRequest request) throws SQLException {
        String returnString = "";
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        if (this.assManageDao.checkAssetID(paramMap) == 0) {
            returnString = "<font color=\"green\">可用</font>";
        } else {
            returnString = "<font color=\"red\">不可用</font>";
        }
        return returnString;
    }

    /**
     * 检查资产名称是否重复
     */
    @SuppressWarnings("rawtypes")
    @Override
    public String checkAssetName(HttpServletRequest request) throws SQLException {
        String returnString = "";
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        if (this.assManageDao.checkAssetName(paramMap) == 0) {
            returnString = "<font color=\"green\">可用</font>";
        } else {
            returnString = "<font color=\"red\">不可用</font>";
        }
        return returnString;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public void transferAsset(HttpServletRequest request) throws SQLException {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        /*把SERVICE_LIFE值换成int
         * begin
         * */
        if(paramMap.get("SERVICE_LIFE").equals("") || paramMap.get("SERVICE_LIFE")==null){
        	paramMap.put("SERVICE_LIFE",null);
        }else{
        	int serlife = Integer.parseInt(""+paramMap.get("SERVICE_LIFE"));
        	try{
        		paramMap.put("SERVICE_LIFE",serlife);
        	}catch(Exception e){
        		paramMap.put("SERVICE_LIFE",0);
        	}
        }
        /*end*/
        if (paramMap.get("ALLOW_BORROW") != null || paramMap.get("ALLOW_BORROW").equals("yes")) {
            paramMap.put("ACTIVITY", 1);
        } else {
            paramMap.put("ACTIVITY", 0);
        }
        Object obj = paramMap.get("type");
        if (obj == null) {
            return;
        }
        if (obj.equals("add")) {
            paramMap.put("CREATED_BY", admin.getAdminID());
            Object photoPathObj = paramMap.get("PHOTOPATH");
            if (photoPathObj == null) {
                paramMap.put("PHOTOPATH", "/resources/picture/none.gif");
            }
            if (paramMap.get("ASSET_ID") == null||paramMap.get("ASSET_ID")=="") {
                
                paramMap.put("ASSET_ID", assManageDao.getAssetId().toString());
            }
            else if(paramMap.get("ID_TYPE").toString().equals("2"))
            {
            	paramMap.put("ASSET_ID", (String) paramMap.get("ASSET_ID"));
            }
            
            else if(paramMap.get("ID_TYPE").toString().equals("3")){
            	String assetId=assManageDao.getAssetId().toString();
            	int lh = assetId.length();
            	if(lh==1){assetId = "0000"+assetId;}
            	if(lh==2){assetId = "000"+assetId;}
            	if(lh==3){assetId = "00"+assetId;}
            	if(lh==4){assetId = "0"+assetId;}
            	String newAssetId=paramMap.get("ASSET_ID")+assetId;
            	paramMap.put("ASSET_ID", newAssetId);
            }
            this.assManageDao.addAsset(paramMap);
        } else if (obj.equals("update")) {
            paramMap.put("UPDATED_BY", admin.getAdminID());
            this.assManageDao.updateAsset(paramMap);
        }
    }

    /**
     * 获取parent_code为"ToolCode"的最大的code_id
     */
    @SuppressWarnings("rawtypes")
    public String getLastCodeID(Map paramMap) throws SQLException {
        return this.assManageDao.getLastCodeID(paramMap);
    }

    /**
     * 产生下一个code_id
     * @param codeID
     * @return
     */
    public String generateCodeID(String codeID) {
        String prefix = codeID.substring(0, codeID.length() - 3);
        int sequence = Integer.valueOf(codeID.replace(prefix, ""));
        sequence++;
        return prefix + String.format("%03d", sequence);

    }

    /**
     * 检查资产种类是否重复
     */
    @SuppressWarnings("rawtypes")
    @Override
    public String checkCategoryName(HttpServletRequest request) throws SQLException {
        String returnString = "";
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        if (this.assManageDao.checkCategoryName(paramMap) == 0) {
            returnString = "<font color=\"green\">可用</font>";
        } else {
            returnString = "<font color=\"red\">不可用</font>";
        }
        return returnString;
    }

    /**
     * 创建新的资产类别
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String addCategory(HttpServletRequest request) throws SQLException {
        String resultStr = "Y";
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("PARENT_CODE", "AssetCategoryCode");
        String lastCodeID = this.getLastCodeID(paramMap);
        paramMap.put("CODE_ID", this.generateCodeID(lastCodeID));
        this.assManageDao.addCategory(paramMap);
        return resultStr;
    }

    /**
     * 获取特定资产信息
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map getAssetDetail(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        if (paramMap == null || paramMap.get("ASSET_ID") == null) {
            paramMap.put("ASSET_ID", "Asset001");
        }
        Map resultMap = (Map) this.assManageDao.getAssetDetail(paramMap);
        if (resultMap == null)
            return null;
        return resultMap;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String removeAsset(HttpServletRequest request) throws SQLException {
        String resultStr = "Y";
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        this.assManageDao.removeAsset(paramMap);
        return resultStr;
    }

}
