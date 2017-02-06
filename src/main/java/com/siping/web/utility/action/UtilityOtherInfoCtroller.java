package com.siping.web.utility.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.JsonUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.StringUtil;
import com.siping.web.utility.service.UtilityEmpInfoSer;
import com.siping.web.utility.service.UtilityOtherInfoSer;

@Controller
@RequestMapping(value = "/utility/otherInfo")
public class UtilityOtherInfoCtroller {
    Logger logger = Logger.getLogger(UtilityOtherInfoCtroller.class);

    @Autowired
    private UtilityOtherInfoSer utilityOtherInfoSer;
    
    @Autowired
    private UtilityEmpInfoSer utilityEmpInfoSer;

    /**
     * 序号列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getSyCodeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getSyCodeSelectList(HttpServletRequest request) throws Exception {
        List listMap = this.utilityOtherInfoSer.getSyCodeSelectList(request);
        return listMap;
    }

    /**
     * 序号列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getMenuModuleSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getMenuModuleSelectList(HttpServletRequest request) throws Exception {
        List listMap = this.utilityOtherInfoSer.getMenuModuleSelectList(request);
        return listMap;
    }

    /**
     * 序号列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getDataTypeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getDataTypeSelectList(HttpServletRequest request) throws Exception {
        List listMap = this.utilityOtherInfoSer.getDataTypeSelectList(request);
        return listMap;
    }

    /**
     * 部门地点列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getWorkAreaList", method = RequestMethod.POST)
    @ResponseBody
    public List getWorkAreaList(HttpServletRequest request) throws Exception {
        List listMap = this.utilityOtherInfoSer.getWorkAreaList(request);
        return listMap;
    }

    /**
     * 提成参考值列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getSalaryReferenceList", method = RequestMethod.POST)
    @ResponseBody
    public List getSalaryReferenceList(HttpServletRequest request) throws Exception {
        List listMap = this.utilityOtherInfoSer.getSalaryReferenceList(request);
        return listMap;
    }

    /**
     * 序号列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getMC1STSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getMC1STSelectList(HttpServletRequest request) throws Exception {
        /* List listMap= this.utilityOtherInfoSer.getMC1STSelectList(request) ; */
        List listMap = new ArrayList();
        Map map = new LinkedHashMap();
        map.put("MC_1ST_CODE", "DEPTID");
        map.put("MC_1ST_NAME", "部门编号");
        Map map2 = new LinkedHashMap();
        map2.put("MC_1ST_CODE", "EMPID");
        map2.put("MC_1ST_NAME", "工号");
        listMap.add(map);
        listMap.add(map2);
        return listMap;
    }

    /**
     * 序号列表
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getMCName", method = RequestMethod.POST)
    @ResponseBody
    public String getMCName(HttpServletRequest request) throws Exception {

        String str = this.utilityOtherInfoSer.getMCName(request);

        return str;
    }

    /**
     * 序号列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getMC2NDSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getMC2NDSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getMC2NDSelectList(request);

        return listMap;
    }

    /**
     * 序号列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getToolItemSelectList", method = RequestMethod.POST)
    @ResponseBody
    public Map getToolItemSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getToolItemSelectList(request);
        Map model = new HashMap();
        model.put("Rows", listMap);
        return model;
    }

    /**
     * 序号列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getMCSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getMCSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getMCSelectList(request);

        return listMap;
    }

    /**
     * 序号列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getParameterTypeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getParameterTypeSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getParameterTypeSelectList(request);

        return listMap;
    }

    /**
     * 日期类型列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getShiftAttSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getShiftAttSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getShiftAttSelectList(request);

        return listMap;
    }

    /**
     * 职位列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getPostSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getPostSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getPostSelectList(request);

        return listMap;
    }

    /**
     * 职务列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getPositionSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getPositionSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getPositionSelectList(request);

        return listMap;
    }

    /**
     * 职级列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getPostGradeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getPostGradeSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getPostGradeSelectList(request);

        return listMap;
    }

    /**
     * 职列列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getPostColumnSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getPostColumnSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getPostColumnSelectList(request);

        return listMap;
    }

    /**
     * 职群列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getPostGroupSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getPostGroupSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getPostGroupSelectList(request);

        return listMap;
    }

    /**
     * 状态列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getActivitySelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getActivitySelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getActivitySelectList(request);

        return listMap;
    }

    /**
     * 获取公司下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getCompanySelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getCompanySelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getCompanySelectList(request);

        return listMap;
    }

    /**
     * 获取银行下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getBankSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getBankSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getBankSelectList(request);

        return listMap;
    }

    /**
     * 获取项目类型下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getProTypeCodeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getProTypeCodeSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getProTypeCodeSelectList(request);

        return listMap;
    }

    /**
     * 获取调整事由下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getReasonSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getReasonSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getReasonSelectList(request);

        return listMap;
    }

    /**
     * 获取休假类型下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getLeaveTypeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getLeaveTypeSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getLeaveTypeSelectList(request);

        return listMap;
    }

    /**
     * 获取评价类型下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getEvTypeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getEvTypeSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getEvTypeSelectList(request);

        return listMap;
    }

    /**
     * 获取评价类型流程下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getEvTypeProcessSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getEvTypeProcessSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getEvTypeProcessSelectList(request);

        return listMap;
    }

    /**
     * 获取评价类型流程操作方式下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getEvTypeOperationSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getEvTypeOperationSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getEvTypeOperationSelectList(request);

        return listMap;
    }

    /**
     * 获取评价项目下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getEvTypeItemSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getEvTypeItemSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getEvTypeItemSelectList(request);

        return listMap;
    }

    /**
     * 获取考勤项目下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getItemInfoSelection", method = RequestMethod.POST)
    @ResponseBody
    public List getItemInfoSelection(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getItemInfoSelection(request);

        return listMap;
    }

    /**
     * 获取加班类型下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getUnitSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getUnitSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getUnitSelectList(request);

        return listMap;
    }

    /**
     * 获取工作内容下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getBIZSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getBIZSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getBIZSelectList(request);

        return listMap;
    }

    /**
     * 获取加班类型下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getOTTypeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getOTTypeSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getOTTypeSelectList(request);

        return listMap;
    }

    /**
     * 获取加班类型下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getBTSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getBTSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getBTSelectList(request);

        return listMap;
    }

    /**
     * 获取费用明细类型下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getExpDetailTypeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getExpDetailTypeSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getExpDetailTypeSelectList(request);

        return listMap;
    }
    
    /**
     * 获取项目下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewProSearch", method = RequestMethod.GET)
    public ModelAndView viewProSearch(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        modelMap.put("admin", admin);
        modelMap.put("EMPID", this.utilityEmpInfoSer.getRequestParamData(request).get("EMPID"));
        return new ModelAndView("/web/utility/other/viewProSearch", modelMap);
    }

    /**
     * 获取工时项目下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getProSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getProSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getProSelectList(request);

        return listMap;
    }

    /**
     * 获取离职类型下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getResignTypeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getResignTypeSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getResignTypeSelectList(request);

        return listMap;
    }

    /**
     * 获取派遣类型下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getDisTypeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getDisTypeSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getDisTypeSelectList(request);

        return listMap;
    }

    /**
     * 获取奖励类型下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getRewardTypeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getRewardTypeSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getRewardTypeSelectList(request);

        return listMap;
    }

    /**
     * 获取奖励类型下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getRewardGradeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getRewardGradeSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getRewardGradeSelectList(request);

        return listMap;
    }

    /**
     * 获取惩戒类型下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getPunishmentTypeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getPunishmentTypeSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getPunishmentTypeSelectList(request);

        return listMap;
    }

    /**
     * 获取惩戒类型下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getTaxWaySelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getTaxWaySelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getTaxWaySelectList(request);

        return listMap;
    }

    /**
     * 获取员工状态下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getStatusSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getStatusSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getStatusSelectList(request);

        return listMap;
    }

    /**
     * 获取学位下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getDegreeTypeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getDegreeTypeSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getDegreeTypeSelectList(request);

        return listMap;
    }

    /**
     * 获取学历下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getEduHisTypeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getEduHisTypeSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getEduHisTypeSelectList(request);

        return listMap;
    }

    /**
     * 获取归还状态下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getReturnTypeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getReturnTypeSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getReturnTypeSelectList(request);

        return listMap;
    }

    /**
     * 获取货币种类下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getCurrencyUnitSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getCurrencyUnitSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getCurrencyUnitSelectList(request);

        return listMap;
    }

    /**
     * 获取家庭成员关系类型下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getRelationalTypeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getRelationalTypeSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getRelationalTypeSelectList(request);

        return listMap;
    }

    /**
     * 获取紧急联系人关系类型下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getOtherRelationlTypeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getOtherRelationlTypeSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getOtherRelationlTypeSelectList(request);

        return listMap;
    }

    /**
     * 获取合同类型下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getContractTypeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getContractTypeSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getContractTypeSelectList(request);

        return listMap;
    }

    /**
     * 计算标记列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getCalcFlagSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getCalcFlagSelectList(HttpServletRequest request) throws Exception {
        Map paramMap = new LinkedHashMap();
        paramMap.put("language", Messages.getLanguage(request));
        List listMap = StringUtil.getCalcFlagSelectList(paramMap);

        return listMap;
    }

    /**
     * 序号列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getYesOrNoSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getYesOrNoSelectList(HttpServletRequest request) throws Exception {
        Map paramMap = new LinkedHashMap();
        paramMap.put("language", Messages.getLanguage(request));
        List listMap = StringUtil.getYesOrNoSelectList(paramMap);

        return listMap;
    }

    /**
     * 序号列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getOrderSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getOrderSelectList(HttpServletRequest request) throws Exception {

        List listMap = StringUtil.getOrderSelectList(20, "0");

        return listMap;
    }

    /**
     * 深度列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getDepthSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getDepthSelectList(HttpServletRequest request) throws Exception {

        List listMap = StringUtil.getDepthSelectList(2, "");

        return listMap;
    }

    /**
     * 等级列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getLevelSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getLevelSelectList(HttpServletRequest request) throws Exception {

        List listMap = StringUtil.getLevelSelectList(6, "0");

        return listMap;
    }

    /**
     * 等级列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getCardtimeReasonSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getCardtimeReasonSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getCardtimeReasonSelectList(request);

        return listMap;
    }

    /**
     * 地区类别
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getAreasByParentID", method = RequestMethod.POST)
    @ResponseBody
    public String getAreasByParentID(HttpServletRequest request) throws Exception {
        List listMap = this.utilityOtherInfoSer.getAreasByParentID(request);
        Map noneArea = new LinkedHashMap<String, String>();
        noneArea.put("ID", "");
        noneArea.put("NAME", "请选择");
        noneArea.put("PARENT_ID", "");
        listMap.add(0, noneArea);
        String string = JsonUtil.areaInfoToJson(listMap);
        return string;
    }

    /**
     * 出差区间
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getBTDurationInfo", method = RequestMethod.POST)
    @ResponseBody
    public String getBTDurationInfo(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getBTDurationInfo(request);
        // 取集合
        String string = JsonUtil.btInfoToJson(listMap);

        return string;
    }

    /**
     * 报工项目
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getProInfo", method = RequestMethod.POST)
    @ResponseBody
    public String getProInfo(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getProSelectList(request);
        // 取集合
        String string = JsonUtil.proInfoToJson(listMap);

        return string;
    }

    /**
     * 报工项目类型
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getProTypeInfo", method = RequestMethod.POST)
    @ResponseBody
    public String getProTypeInfo(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getProTypeCodeSelectList(request);
        // 取集合
        String string = JsonUtil.proTypeInfoToJson(listMap);

        return string;
    }

    /**
     * 评价期间
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getEvaPeriodInfo", method = RequestMethod.POST)
    @ResponseBody
    public String getEvaPeriodInfo(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getEvaPeriodSelectList(request);
        // 取集合
        String string = JsonUtil.listInfoToJson(listMap);

        return string;
    }

    /**
     * 评价期间类型
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getEvaPeriodTypeInfo", method = RequestMethod.POST)
    @ResponseBody
    public String getEvaPeriodTypeInfo(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getEvaPeriodTypeSelectList(request);
        // 取集合
        String string = JsonUtil.listInfoToJson(listMap);

        return string;
    }

    /**
     * 考勤项目
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getItemSelectList", method = RequestMethod.POST)
    @ResponseBody
    public String getItemSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getItemSelectList(request);
        // 取集合
        String string = JsonUtil.listInfoToJson(listMap);

        return string;
    }

    /**
     * 时间选择
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getTimeList", method = RequestMethod.POST)
    @ResponseBody
    public List getTimeList(HttpServletRequest request) throws Exception {

        Map paraMap = this.utilityOtherInfoSer.getRequestParamData(request);

        List listMap = DateUtil.getTimeList(paraMap);

        return listMap;
    }

    /**
     * 客户活动方式
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getCustActionStateList", method = RequestMethod.POST)
    @ResponseBody
    public List getCustActionStateList(HttpServletRequest request) throws Exception {
        List listMap = this.utilityOtherInfoSer.getCustActionStateList(request);
        return listMap;
    }

    /**
     * 客户活动方式
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getCustActionWayList", method = RequestMethod.POST)
    @ResponseBody
    public List getCustActionWayList(HttpServletRequest request) throws Exception {
        List listMap = this.utilityOtherInfoSer.getCustActionWayList(request);
        return listMap;
    }

    /**
     * 客户评级
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping("/getPurchaseTendList")
    @ResponseBody
    public List getPurchaseTendList(HttpServletRequest request) {
        List list = this.utilityOtherInfoSer.getPurchaseTendList(request);
        return list;
    }

    /**
     * 公告类型
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getAnnouncementTypeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getAnnouncementTypeSelectList(HttpServletRequest request) throws Exception {
        List listMap = this.utilityOtherInfoSer.getAnnouncementTypeSelectList(request);
        return listMap;
    }

    /**
     * 获取某人的SCREEN_GRANT_ID
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getScreenGrantId", method = RequestMethod.POST)
    @ResponseBody
    public Map getScreenGrantId(HttpServletRequest request) throws Exception {
        Map resultMap = this.utilityOtherInfoSer.getScreenGrantId(request);
        return resultMap;
    }

    /**
     * 报工时生产订单及图纸号下拉列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getProductionOrderInfo", method = RequestMethod.POST)
    @ResponseBody
    public String getProductionOrderInfo(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getProductionOrderSelectList(request);
        // 取集合
        String string = JsonUtil.productionOrderInfoToJson(listMap);

        return string;
    }

    /**
     * 生成流水号时应用功能下拉列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getApplyFunction", method = RequestMethod.POST)
    @ResponseBody
    public String getApplyFunction(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getApplyFunctionSelectList(request);
        // 取集合
        String string = JsonUtil.applyFunctionInfoToJson(listMap);

        return string;
    }

    /**
     * 获取应用功能下拉
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getApplyFunctionSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getApplyFunctionSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityOtherInfoSer.getApplyFunctionSelectList(request);

        return listMap;
    }

    /**
     * 付款方式下拉列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getPaymentModeInfo", method = RequestMethod.POST)
    @ResponseBody
    public String getPaymentModeInfo(HttpServletRequest request) throws Exception {
        List listMap = this.utilityOtherInfoSer.getPaymentModeInfo(request);
        // 取集合
        String string = JsonUtil.paymentModeInfoToJson(listMap);

        return string;
    }
}
