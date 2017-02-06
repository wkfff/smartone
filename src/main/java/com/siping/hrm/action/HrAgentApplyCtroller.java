package com.siping.hrm.action;

import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.siping.ess.service.InfoAppSer;
import com.siping.hrm.service.EmpInfoSer;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.service.UtilityEmpInfoSer;

@Controller
@RequestMapping(value = "/hrm/hrApply")
public class HrAgentApplyCtroller {
	Logger logger = Logger.getLogger(HrAgentApplyCtroller.class);
	@Autowired
	private EmpInfoSer empInfoSer;
	@Autowired
	private UtilityEmpInfoSer utilityEmpInfoSer;
	@Autowired
	private InfoAppSer infoAppSer;
	@RequestMapping(value = "/viewHrRequireApply", method = RequestMethod.GET)
	public ModelAndView getViewHrRequireApply(HttpServletRequest request,ModelMap modelMap)throws Exception {
		modelMap.put("basicInfo",this.utilityEmpInfoSer.getEmpBasicInfo(request));
		modelMap.put("appDate", DateUtil.getSysdateString("yyyy-MM-dd"));
		modelMap.put("currentDate",DateUtil.getSysdateString("yyyy-MM-dd HH:mm"));
		modelMap.put("timeStamp",DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));
		return new ModelAndView("/hrm/hrApply/viewHrRequireApply");
	}
	/**
	 * 休假申请
	 * 
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewLeaveAgent", method = RequestMethod.GET)
	public ModelAndView viewLeaveAgent(HttpServletRequest request,ModelMap modelMap) throws Exception {
		modelMap.put("basicInfo",this.utilityEmpInfoSer.getEmpBasicInfo(request));
		modelMap.put("currentDate",DateUtil.getSysdateString("yyyy-MM-dd HH:mm"));
		modelMap.put("appDate", DateUtil.getSysdateString("yyyy-MM-dd"));
		return new ModelAndView("/hrm/hrApply/viewLeaveAgent", modelMap);
	}
	/**
	 * 加班申请
	 * 
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewOtAgent", method = RequestMethod.GET)
	public ModelAndView viewOtAgent(HttpServletRequest request, ModelMap modelMap)throws Exception {
		modelMap.put("basicInfo",this.utilityEmpInfoSer.getEmpBasicInfo(request));
		modelMap.put("currentDate", DateUtil.getSysdateString("yyyy-MM-dd"));
		modelMap.put("appDate", DateUtil.getSysdateString("yyyy-MM-dd"));
		return new ModelAndView("/hrm/hrApply/viewOtAgent", modelMap);
	}
	/**
	 * 出差申请
	 * 
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewBusiTripAgent", method = RequestMethod.GET)
	public ModelAndView viewBusiTripAgent(HttpServletRequest request, ModelMap modelMap)throws Exception {
		modelMap.put("basicInfo",this.utilityEmpInfoSer.getEmpBasicInfo(request));
		modelMap.put("currentDate",DateUtil.getSysdateString("yyyy-MM-dd HH:mm"));
		modelMap.put("appDate", DateUtil.getSysdateString("yyyy-MM-dd"));
		modelMap.put("timeStamp",DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));
		return new ModelAndView("/hrm/hrApply/viewBusiTripAgent", modelMap);
	}
	/**
	 * 费用申请
	 * 
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewFeeAgent", method = RequestMethod.GET)
	public ModelAndView viewFeeAgent(HttpServletRequest request, ModelMap modelMap)throws Exception {
		modelMap.put("basicInfo",this.utilityEmpInfoSer.getEmpBasicInfo(request));
		modelMap.put("appDate", DateUtil.getSysdateString("yyyy-MM-dd"));
		modelMap.put("timeStamp",DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));
		return new ModelAndView("/hrm/hrApply/viewFeeAgent", modelMap);
	}
	/**
	 * 漏卡时间申请
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewCardAgent", method = RequestMethod.GET)
	public ModelAndView viewCardAgent(HttpServletRequest request,ModelMap modelMap) throws Exception {
		modelMap.put("basicInfo",this.utilityEmpInfoSer.getEmpBasicInfo(request));
		modelMap.put("appDate", DateUtil.getSysdateString("yyyy-MM-dd"));
		modelMap.put("currentDate",DateUtil.getSysdateString("yyyy-MM-dd HH:mm"));
		modelMap.put("timeStamp",DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));
		return new ModelAndView("/hrm/hrApply/viewCardAgent", modelMap);
	}
	/**
	 * 物品申请界面
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewAssetAgent", method = RequestMethod.GET)
	public ModelAndView viewAssetAgent(HttpServletRequest request,ModelMap modelMap) throws Exception {
		modelMap.put("basicInfo",this.utilityEmpInfoSer.getEmpBasicInfo(request));
		modelMap.put("currentDate",DateUtil.getSysdateString("yyyy-MM-dd HH:mm"));
		modelMap.put("appDate", DateUtil.getSysdateString("yyyy-MM-dd HH:mm"));
		return new ModelAndView("/hrm/hrApply/viewAssetAgent", modelMap);
	}
	
	/**
	 * 工单申请界面
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/viewWhAgent", method = RequestMethod.GET)
	public ModelAndView viewWhAgent(HttpServletRequest request,ModelMap modelMap) throws Exception {
		Map paraMap = this.empInfoSer.getRequestParamData(request);
		paraMap.put("START_DATE",DateUtil.formatDate(new Date(),"yyyy-MM-dd"));
		modelMap.put("paraMap", paraMap);
		modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
		return new ModelAndView("/hrm/hrApply/viewWhAgent", modelMap);
	}
}
