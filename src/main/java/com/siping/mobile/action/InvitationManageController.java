package com.siping.mobile.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.mobile.service.InvitationManageSer;
import com.siping.web.utility.service.UtilityEmpInfoSer;

@Controller
@RequestMapping(value = "/mobile/invitationManage")
public class InvitationManageController {

	@Autowired
	private UtilityEmpInfoSer utilityEmpInfoSer;
	@Autowired
	private InvitationManageSer invitationManageSer;

	/**
	 * 进入邀请码管理界面
	 * 
	 * @param request
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/viewInvitationManage", method = RequestMethod.GET)
	public ModelAndView viewInvitationManage(HttpServletRequest request,
			ModelMap modelMap) {

		return new ModelAndView(
				"/mobile/invitationManage/viewInvitationManage", modelMap);
	}

	/**
	 * 生成邀请码
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/generateInvitation", method = RequestMethod.POST)
	@ResponseBody
	public String generateInvitation() {
		String returnString = "N";
		returnString = this.invitationManageSer.generateInvitation();
		return returnString;
	}

	/**
	 * 保存邀请码：依据CUST_NO是否为空判断是否进行绑定
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addInvitation", method = RequestMethod.POST)
	@ResponseBody
	public String addInvitation(HttpServletRequest request) {
		String returnString = "N";
		try {
			returnString = this.invitationManageSer.addInvitation(request);
			returnString = "Y";
		} catch (Exception e) {
			e.printStackTrace();
			returnString = e.getMessage();
		}
		return returnString;
	}

	/**
	 * 依据不同条件（CUST_NO、INVITATION_ID）获取表中记录条数
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getCntByCondition", method = RequestMethod.POST)
	@ResponseBody
	public int getCntByCondition(HttpServletRequest request) {

		return this.invitationManageSer.getCntByCondition(request);
	}

	/**
	 * 获取mobile_invitation中的记录
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getInvitationList", method = RequestMethod.POST)
	@ResponseBody
	public Map getInvitationList(HttpServletRequest request) throws Exception {
		Map model = new HashMap();
		List invitationList = this.invitationManageSer
				.getInvitationList(request);
		int invitationCnt = this.invitationManageSer.getInvitationCnt(request);
		model.put("Rows", invitationList);
		model.put("Total", invitationCnt);
		return model;
	}

	/**
	 * 删除指定邀请码（从数据库中删除）
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteInvitation", method = RequestMethod.POST)
	@ResponseBody
	public String deleteInvitation(HttpServletRequest request) {
		String returnString = "N";
		try {
			returnString = this.invitationManageSer.deleteInvitation(request);
			returnString = "Y";
		} catch (Exception e) {
			e.printStackTrace();
			returnString = e.getMessage();
		}
		return returnString;
	}
}
