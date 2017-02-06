package com.siping.att.action.attendanceSettings;

import java.util.HashMap;
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

import com.siping.att.service.AttendanceKeeperSer;
import com.siping.web.utility.JsonUtil;
import com.siping.web.utility.service.UtilityDeptInfoSer;

@Controller
@RequestMapping(value = "/att/attendanceSettings")
public class AttendanceKeeperController {
	Logger logger = Logger.getLogger(AttendanceKeeperController.class);

	@Autowired
	private AttendanceKeeperSer attendanceKeeperSer;
	@Autowired
	private UtilityDeptInfoSer utilityDeptInfoSer;

	@RequestMapping(value = "/viewAttendanceKeeper", method = RequestMethod.GET)
	public ModelAndView viewAttendanceKeeper(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return new ModelAndView("/att/attendanceSettings/viewAttendanceKeeper",
				modelMap);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getAttendanceKeeperInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getAttendanceKeeperInfo(HttpServletRequest request)
			throws Exception {

		List attendanceKeeperList = this.attendanceKeeperSer
				.getAttendanceKeeperInfo(request);

		int attendanceKeeperCnt = this.attendanceKeeperSer
				.getAttendanceKeeperInfoCnt(request);

		Map model = new HashMap();
		model.put("Rows", attendanceKeeperList);
		model.put("Total", attendanceKeeperCnt);

		return model;
	}

	@RequestMapping(value = "/deleteAttendanceKeeperInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteAttendanceKeeperInfo(HttpServletRequest request)
			throws Exception {

		this.attendanceKeeperSer.deleteAttendanceKeeperInfo(request);

		return "Y";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/updateAttendanceKeeperInfo", method = RequestMethod.GET)
	public ModelAndView updateAttendanceKeeperInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		String string = JsonUtil.deptInfoToJson(this.attendanceKeeperSer
				.getAttendanceKeeperDeptInfo(request));
		modelMap.put("attendanceKeeperInfo",
				attendanceKeeperSer.getAttendanceKeeper(request));
		modelMap.put("dataJson", string);
		return new ModelAndView(
				"/att/attendanceSettings/updateAttendanceKeeperInfo", modelMap);
	}

	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "/getAttendanceKeeperDeptInfo", method = RequestMethod.POST)
	@ResponseBody
	public List getAttendanceKeeperDeptInfo(HttpServletRequest request)
			throws Exception {

		List attendanceKeeperDeptList = this.attendanceKeeperSer
				.getAttendanceKeeperDeptInfo(request);

		return attendanceKeeperDeptList;
	}

	@RequestMapping(value = "/updateAttendanceKeeperInfo", method = RequestMethod.POST)
	@ResponseBody
	public String updateAttendanceKeeperInfo(HttpServletRequest request)
			throws Exception {

		attendanceKeeperSer.updateAttendanceKeeperInfo(request);

		return "Y";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/addAttendanceKeeperInfo", method = RequestMethod.GET)
	public ModelAndView addAttendanceKeeperInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		String string = JsonUtil.deptInfoToJson(this.utilityDeptInfoSer
				.getDeptTreeInfo(request));
		modelMap.put("dataJson", string);
		return new ModelAndView(
				"/att/attendanceSettings/addAttendanceKeeperInfo", modelMap);
	}

	@RequestMapping(value = "/addAttendanceKeeperInfo", method = RequestMethod.POST)
	@ResponseBody
	public String addAttendanceKeeperInfo(HttpServletRequest request)
			throws Exception {

		attendanceKeeperSer.addAttendanceKeeperInfo(request);

		return "Y";
	}
}
