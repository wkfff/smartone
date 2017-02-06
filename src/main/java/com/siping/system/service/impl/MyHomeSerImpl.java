package com.siping.system.service.impl;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.system.bean.AdminBean;
import com.siping.system.dao.MyHomeDao;
import com.siping.system.service.MyHomeSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class MyHomeSerImpl implements MyHomeSer {

	@Autowired
	private MyHomeDao myHomeDao;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void updateModel(HttpServletRequest request) {

		List list = new ArrayList();
		Enumeration en = request.getParameterNames();

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		String empid = admin.getAdminID();
		String page = request.getParameter("page");

		while (en.hasMoreElements()) {

			String key = (String) en.nextElement();
			String mcontent = request.getParameter(key);
			if (key.endsWith("Model") && mcontent != null
					&& !mcontent.equals("")) {
				Map user = new LinkedHashMap();
				user.put("empid", empid);
				user.put("mid", key);
				user.put("mcontent", mcontent);
				user.put("page", page);

				if (request.getParameter(key).toLowerCase()
						.contains("display: none")) {
					user.put("mstate", "0");
				} else {
					user.put("mstate", "1");
				}
				list.add(user);
			}
		}

		myHomeDao.deleteModel(list);
		myHomeDao.insertModel(list);

		String shorttemp = request.getParameter("short");
		if (shorttemp != null && !shorttemp.equals("")) {
			List stlist = new ArrayList();
			String[] st = shorttemp.split(",");
			for (int a = 0; a < st.length; a++) {
				Map user = new LinkedHashMap();
				user.put("empid", empid);
				user.put("menu", st[a]);
				user.put("page", page);

				stlist.add(user);
			}

			myHomeDao.deleteShort(stlist);
			myHomeDao.insertShort(stlist);

		}

	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getModel(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("ADMINID", admin.getAdminID());
		paramMap.put("page", request.getParameter("page"));
		return myHomeDao.getModel(paramMap);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map getLoginUserAppInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = new LinkedHashMap();
		String[] sgID = admin.getScreenGrantID().split(",");
		for (int i = 0; i < sgID.length; i++) {
			if (sgID[i].trim().equals("5")){
				paramMap.put("isApp", "true");
			}
		}for (int i = 0; i < sgID.length; i++) {
			if (sgID[i].trim().equals("10")){
				paramMap.put("isHR", "true");
			}
		}for (int i = 0; i < sgID.length; i++) {
			if (sgID[i].trim().equals("11")){
				paramMap.put("isAtt", "true");
			}
		}for (int i = 0; i < sgID.length; i++) {
			if (sgID[i].trim().equals("6")){
				paramMap.put("isContract", "true");
			}
		}for (int i = 0; i < sgID.length; i++) {
			if (sgID[i].trim().equals("148")||sgID[i].trim().equals("7")){
				paramMap.put("isConffirm", "true");
			}
		}for (int i = 0; i < sgID.length; i++) {
			if (sgID[i].trim().equals("2")){
				paramMap.put("isNormal", "true");
			}
		}for (int i = 0; i < sgID.length; i++) {
			if (sgID[i].trim().equals("2")){
				paramMap.put("isNormal", "true");
			}
		}
		return paramMap;
	}
	
	/**
	 * 获取快捷方式信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getShort(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("ADMINID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.myHomeDao.getShort(paramMap, NumberUtils
					.parseNumber(ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),
					Integer.class));
		} else {
			retrunList = this.myHomeDao.getShort(paramMap);
		}
		return retrunList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getShortInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("ADMINID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("STATUS_CODE", "1");

		retrunList = this.myHomeDao.getShortInfo(paramMap);
		return retrunList;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String getShortcutsInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("ADMINID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("STATUS_CODE", "1");

		retrunList = this.myHomeDao.getShortInfo(paramMap);

		StringBuffer buffer = new StringBuffer();
		buffer.append("<table width='99.5%' cellpadding='1' cellspacing='1' style='height:25px;font-size: 12px; '>");
		buffer.append("<tr>");	
		for (int i=0;i<retrunList.size();i++) {
			Map temp = (Map) retrunList.get(i);
			
			buffer.append("<td align='center' style='font-weight: bold;cursor: pointer;'>");
			buffer.append("<img style='cursor: pointer;' alt='' src='/resources/images/menu/home.gif' onclick='spf_page("+i+","+temp.get("MENU_NO").toString()+")'/><br/>");
			buffer.append(temp.get("MENU_INTRO").toString());
			buffer.append("</td>");	
		}
		buffer.append("</tr>");	
		buffer.append("</table>");
		return buffer.toString();
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getShortCnt(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("ADMINID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		return this.myHomeDao.getShortCnt(paramMap);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int addShortcutInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("CREATED_BY", admin.getAdminID()) ;
		
		this.myHomeDao.addShortcutInfo(paramMap) ;
		
		return 0;
	} 
	@SuppressWarnings({ "rawtypes" })
	public int deleteShortcutInfo(HttpServletRequest request) { 
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		  
		this.myHomeDao.deleteShortcutInfo(paramMap) ;
		
		return 0;
	}   
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Object getHomePurview(HttpServletRequest request) {
		StringBuffer show = new StringBuffer();
		StringBuffer select = new StringBuffer();

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

		paramMap.put("ADMINID", admin.getAdminID());
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("page", request.getParameter("page"));
		List purviewList = myHomeDao.getHomePurview(paramMap);

		for (Object object : purviewList) {
			Map temp = (Map) object;
			select.append("<p style='height:25px;'><input type='checkbox' value='"
					+ temp.get("MID").toString() + "' onclick='check(this)' ");
			if (temp.get("MSTATE").toString().equals("1")) {
				select.append("checked=checked");
			}
			select.append("/>" + temp.get("MNAME").toString() + "</p>");

			show.append(temp.get("MDIV").toString());
			if (temp.get("MID").toString().equals("clockModel")) {
				show.append("<embed wmode='transparent' width='100%' height='100%' "
						+ "src='/resources/images/clock.swf'/>");
			} else if (temp.get("MID").toString().equals("shortcutModel")
					&& temp.get("MSTATE").toString().equals("1")) {

				List shortList = myHomeDao.getShort(paramMap);
				show.append(Messages.getMessage(request, "shortcutBar")
						+ "<br><p id=\"shortcutinfo\"></p><table>");
				for (int j = 0; j < shortList.size(); j++) {
					Map tp = (Map) shortList.get(j);
					show.append("<tr style='height:25px;'><td><a href=\"#\" "
							+ "onclick=\"goTab('" + tp.get("MENU") + "','"
							+ tp.get("MENU_INTRO") + "','" + tp.get("MENU_URL")
							+ "')\">" + tp.get("MENU_INTRO") + "</a></td></tr>");
				}
				show.append("</table>");

			} else if (temp.get("MID").toString().equals("birthdayModel")
					&& temp.get("MSTATE").toString().equals("1")) {
				// 生日列表

				paramMap.put("model", "birthdayModel");
				String content = ((Map) myHomeDao.getModel(paramMap).get(0))
						.get("MCONTENT").toString();

				String[] templist = content.split(";");
				float height = 0;
				float width = 0;
				for (int j = 0; j < templist.length; j++) {
					if (templist[j].toLowerCase().contains("height")) {
						height = Integer.parseInt(((templist[j].split(":"))[1])
								.split("px")[0].trim());
					}
					if (templist[j].toLowerCase().contains("width")) {
						width = Integer.parseInt(((templist[j].split(":"))[1])
								.split("px")[0].trim()) - 25;
					}
				}
				paramMap.remove("model");

				show.append("<SCRIPT type=\"text/javascript\">");
				show.append("$(function(){$(\"#birthday\").ligerGrid({"
						+ " columns: ["
						+ " 	{ display: 'No.', name: 'RN', minWidth: 30,width:"
						+ width * 5 / 100
						+ " },"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.empid")
						+ "', name: 'EMPID', minWidth: 70,width:"
						+ width * 12 / 100
						+ " },"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.name")
						+ "', name: 'CHINESENAME', minWidth: 70,width:"
						+ width * 12 / 100
						+ " },"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.dept")
						+ "', name: 'DEPARTMENT' ,minWidth: 150,width:"
						+ width * 35 / 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.position")
						+ "', name: 'POSITION' ,minWidth: 70,width:"
						+ width * 12 / 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.postGrade")
						+ "', name: 'POSTGRADE' ,minWidth: 70,width:"
						+ width
						* 12
						/ 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.birthDate")
						+ "', name: 'BIRTHDAY', minWidth: 70,width:"
						+ width
						* 12
						/ 100
						+ "}"
						+ " ],"
						+ " url: '/myhome/getapp?type=getBirthday',"
						+ " sortName: 'BIRTHDAY', "
						+ " dataAction: 'server',"
						+ " usePager: false,width: '100%',height:"
						+ height
						+ ",heightDiff:-24"
						+ "}); "
						+ "  $('.l-panel-header','#birthday').before('<div style=\"text-align:center;background-color:#E8F4F1;\">"
						+ "<font size=3 color=#4C1B6D>"
						+ Messages.getMessage(request, "birthdaylist")
						+ "	</font></div>');" + " });");
				show.append("</SCRIPT>");

			} else if (temp.get("MID").toString()
					.equals("monthExperienceModel")
					&& temp.get("MSTATE").toString().equals("1")) {
				// 月内人事令

				paramMap.put("model", "monthExperienceModel");
				String content = ((Map) myHomeDao.getModel(paramMap).get(0))
						.get("MCONTENT").toString();

				String[] templist = content.split(";");
				float height = 0;
				float width = 0;
				for (int j = 0; j < templist.length; j++) {
					if (templist[j].toLowerCase().contains("height")) {
						height = Integer.parseInt(((templist[j].split(":"))[1])
								.split("px")[0].trim());
					}
					if (templist[j].toLowerCase().contains("width")) {
						width = Integer.parseInt(((templist[j].split(":"))[1])
								.split("px")[0].trim()) - 25;
					}
				}
				paramMap.remove("model");

				show.append("<SCRIPT type=\"text/javascript\">");
				show.append("$(function(){$(\"#monthExperience\").ligerGrid({"
						+ " columns: ["
						+ " 	{ display: 'No.', name: 'RN', minWidth: 30,width:"
						+ width * 4 / 100
						+ " },"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.ccommType")
						+ "', name: 'TRANSTYPE', minWidth: 70,width:"
						+ width * 11 / 100
						+ " },"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.empid")
						+ "', name: 'EMPID', minWidth: 70,width:"
						+ width * 10 / 100
						+ " },"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.name")
						+ "', name: 'CHINESENAME', minWidth: 70,width:"
						+ width * 11 / 100
						+ " },"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.dept")
						+ "', name: 'DEPARTMENT' ,minWidth: 150,width:"
						+ width * 31 / 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.position")
						+ "', name: 'POSITION' ,minWidth: 70,width:"
						+ width
						* 11
						/ 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.postGrade")
						+ "', name: 'POSTGRADE' ,minWidth: 70,width:"
						+ width
						* 10
						/ 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.effectDate")
						+ "', name: 'STARTDATE', minWidth: 70,width:"
						+ width
						* 12
						/ 100
						+ "}"
						+ " ],"
						+ " url: '/myhome/getapp?type=getMonthExperience',"
						+ " sortName: 'STARTDATE', "
						+ " dataAction: 'server',"
						+ " usePager: false,width: '100%',height:"
						+ height
						+ ",heightDiff:-24"
						+ "}); "
						+ "  $('.l-panel-header','#monthExperience').before('<div style=\"text-align:center;background-color:#E8F4F1;\">"
						+ "<font size=3 color=#4C1B6D>"
						+ Messages.getMessage(request, "monthExperience")
						+ "	</font></div>');" + " });");
				show.append("</SCRIPT>");

			} else if (temp.get("MID").toString()
					.equals("expiredContractModel")
					&& temp.get("MSTATE").toString().equals("1")) {
				// 到期合同

				paramMap.put("model", "expiredContractModel");
				String content = ((Map) myHomeDao.getModel(paramMap).get(0))
						.get("MCONTENT").toString();

				String[] templist = content.split(";");
				float height = 0;
				float width = 0;
				for (int j = 0; j < templist.length; j++) {
					if (templist[j].toLowerCase().contains("height")) {
						height = Integer.parseInt(((templist[j].split(":"))[1])
								.split("px")[0].trim());
					}
					if (templist[j].toLowerCase().contains("width")) {
						width = Integer.parseInt(((templist[j].split(":"))[1])
								.split("px")[0].trim()) - 27;
					}
				}
				paramMap.remove("model");

				show.append("<SCRIPT type=\"text/javascript\">");
				show.append("$(function(){$(\"#expiredContract\").ligerGrid({"
						+ " columns: ["
						+ " 	{ display: 'No.', name: 'RN', minWidth: 30 ,width:"
						+ width * 4 / 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.empid")
						+ "', name: 'EMPID', minWidth: 70 ,width:"
						+ width * 9 / 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.name")
						+ "', name: 'CHINESENAME', minWidth: 70 ,width:"
						+ width * 9 / 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.dept")
						+ "', name: 'DEPARTMENT' ,minWidth: 150,width:"
						+ width * 24 / 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.position")
						+ "', name: 'POSITION' ,minWidth: 70,width:"
						+ width * 9 / 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.postGrade")
						+ "', name: 'POSTGRADE' ,minWidth: 70,width:"
						+ width
						* 9
						/ 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.endDate")
						+ "', name: 'ENDCONTRACTDATE', minWidth: 100,width:"
						+ width
						* 18
						/ 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "countdownDays")
						+ "', name: 'DAYS', minWidth: 120,width:"
						+ width
						* 18
						/ 100
						+ "}"
						+ " ],"
						+ " url: '/myhome/getapp?type=getExpiredContract',"
						+ " sortName: 'DAYS', "
						+ " dataAction: 'server',"
						+ " usePager: false,width: '100%',height:'"
						+ height
						+ "',heightDiff:-24"
						+ "}); "
						+ "  $('.l-panel-header','#expiredContract').before('<div style=\"text-align:center;background-color:#E8F4F1;\">"
						+ "<font size=3 color=#4C1B6D>"
						+ Messages.getMessage(request, "expiredContract")
						+ "	</font></div>');" + " });");
				show.append("</SCRIPT>");

			} else if (temp.get("MID").toString()
					.equals("notExistContractModel")
					&& temp.get("MSTATE").toString().equals("1")) {
				// 未签合同

				paramMap.put("model", "notExistContractModel");
				String content = ((Map) myHomeDao.getModel(paramMap).get(0))
						.get("MCONTENT").toString();

				String[] templist = content.split(";");
				float height = 0;
				float width = 0;
				for (int j = 0; j < templist.length; j++) {
					if (templist[j].toLowerCase().contains("height")) {
						height = Integer.parseInt(((templist[j].split(":"))[1])
								.split("px")[0].trim());
					}
					if (templist[j].toLowerCase().contains("width")) {
						width = Integer.parseInt(((templist[j].split(":"))[1])
								.split("px")[0].trim()) - 25;
					}
				}
				paramMap.remove("model");

				show.append("<SCRIPT type=\"text/javascript\">");
				show.append("$(function(){$(\"#notExistContract\").ligerGrid({"
						+ " columns: ["
						+ " 	{ display: 'No.', name: 'RN', minWidth: 30 ,width:"
						+ width * 5 / 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.empid")
						+ "', name: 'EMPID', minWidth: 70,width:"
						+ width * 11 / 100
						+ " },"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.name")
						+ "', name: 'CHINESENAME', minWidth: 70,width:"
						+ width * 11 / 100
						+ " },"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.dept")
						+ "', name: 'DEPARTMENT' ,minWidth: 150,width:"
						+ width * 35 / 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.position")
						+ "', name: 'POSITION' ,minWidth: 70,width:"
						+ width * 11 / 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.postGrade")
						+ "', name: 'POSTGRADE' ,minWidth: 70,width:"
						+ width
						* 11
						/ 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.hireDate")
						+ "', name: 'JOINDATE',minWidth: 100,width:"
						+ width
						* 16
						/ 100
						+ "}"
						+ " ],"
						+ " url: '/myhome/getapp?type=getNotExistContract',"
						+ " sortName: 'JOINDATE', "
						+ " dataAction: 'server',"
						+ " usePager: false,width: '100%',height:'"
						+ height
						+ "',heightDiff:-24"
						+ "}); "
						+ "  $('.l-panel-header','#notExistContract').before('<div style=\"text-align:center;background-color:#E8F4F1;\">"
						+ "<font size=3 color=#4C1B6D>"
						+ Messages.getMessage(request, "notExistContract")
						+ "	</font></div>');" + " });");
				show.append("</SCRIPT>");

			} else if (temp.get("MID").toString()
					.equals("expiredProbationModel")
					&& temp.get("MSTATE").toString().equals("1")) {
				// 转正提示

				paramMap.put("model", "expiredProbationModel");
				String content = ((Map) myHomeDao.getModel(paramMap).get(0))
						.get("MCONTENT").toString();

				String[] templist = content.split(";");
				float height = 0;
				float width = 0;
				for (int j = 0; j < templist.length; j++) {
					if (templist[j].toLowerCase().contains("height")) {
						height = Integer.parseInt(((templist[j].split(":"))[1])
								.split("px")[0].trim());
					}
					if (templist[j].toLowerCase().contains("width")) {
						width = Integer.parseInt(((templist[j].split(":"))[1])
								.split("px")[0].trim()) - 30;
					}
				}
				paramMap.remove("model");

				show.append("<SCRIPT type=\"text/javascript\">");
				show.append("$(function(){$(\"#expiredProbation\").ligerGrid({"
						+ " columns: ["
						+ " 	{ display: 'No.', name: 'RN', minWidth: 30 ,width:"
						+ width * 5 / 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.empid")
						+ "', name: 'EMPID', minWidth: 70,width:"
						+ width * 11 / 100
						+ " },"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.name")
						+ "', name: 'CHINESENAME', minWidth: 70,width:"
						+ width * 11 / 100
						+ " },"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.dept")
						+ "', name: 'DEPARTMENT' ,minWidth: 150,width:"
						+ width * 35 / 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.position")
						+ "', name: 'POSITION' ,minWidth: 70,width:"
						+ width * 11 / 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.postGrade")
						+ "', name: 'POSTGRADE' ,minWidth: 70,width:"
						+ width
						* 11
						/ 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.endProbationDate")
						+ "', name: 'ENDPROBATIONDATE',minWidth: 120,width:"
						+ width
						* 16
						/ 100
						+ "}"
						+ " ],"
						+ " url: '/myhome/getapp?type=getExpiredProbation',"
						+ " sortName: 'ENDPROBATIONDATE', "
						+ " usePager: false,width: '100%',height:'"
						+ height
						+ "',heightDiff:-24"
						+ "}); "
						+ "  $('.l-panel-header','#expiredProbation').before('<div style=\"text-align:center;background-color:#E8F4F1;\">"
						+ "<font size=3 color=#4C1B6D>"
						+ Messages.getMessage(request, "expiredProbation")
						+ "	</font></div>');" + " });");
				show.append("</SCRIPT>");

			} else if (temp.get("MID").toString().equals("dispatchModel")
					&& temp.get("MSTATE").toString().equals("1")) {
				// 派遣人员

				paramMap.put("model", "dispatchModel");
				String content = ((Map) myHomeDao.getModel(paramMap).get(0))
						.get("MCONTENT").toString();

				String[] templist = content.split(";");
				float height = 0;
				float width = 0;
				for (int j = 0; j < templist.length; j++) {
					if (templist[j].toLowerCase().contains("height")) {
						height = Integer.parseInt(((templist[j].split(":"))[1])
								.split("px")[0].trim());
					}
					if (templist[j].toLowerCase().contains("width")) {
						width = Integer.parseInt(((templist[j].split(":"))[1])
								.split("px")[0].trim()) - 30;
					}
				}
				paramMap.remove("model");

				show.append("<SCRIPT type=\"text/javascript\">");
				show.append("$(function(){$(\"#dispatch\").ligerGrid({"
						+ " columns: ["
						+ " 	{ display: 'No.', name: 'RN', minWidth: 30,width:"
						+ width * 3 / 100
						+ " },"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.empid")
						+ "', name: 'EMPID', minWidth: 70,width:"
						+ width * 8 / 100
						+ " },"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.name")
						+ "', name: 'CHINESENAME', minWidth: 70,width:"
						+ width * 8 / 100
						+ " },"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.dept")
						+ "', name: 'DEPARTMENT' ,minWidth: 150,width:"
						+ width * 17 / 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.position")
						+ "', name: 'POSITION' ,minWidth: 70,width:"
						+ width * 8 / 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.postGrade")
						+ "', name: 'POSTGRADE' ,minWidth: 70,width:"
						+ width
						* 8
						/ 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request,
								"hrms.dispatchDistinguish")
						+ "', name: 'DISDIFFENT' ,minWidth: 70,width:"
						+ width
						* 8
						/ 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.dispatchOffice")
						+ "', name: 'CONTENTS' ,minWidth: 70,width:"
						+ width
						* 12
						/ 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.startDate")
						+ "', name: 'STARTDATE' ,minWidth: 120,width:"
						+ width
						* 14
						/ 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.ProposeEndDate")
						+ "', name: 'PROPOSEENDDATE',minWidth: 120,width:"
						+ width
						* 14
						/ 100
						+ "}"
						+ " ],"
						+ " url: '/myhome/getapp?type=getDispatchInfo',"
						+ " sortName: 'STARTDATE', "
						+ " dataAction: 'server',"
						+ " usePager: false,width: '100%',height:'"
						+ height
						+ "',heightDiff:-24"
						+ "}); "
						+ "  $('.l-panel-header','#dispatch').before('<div style=\"text-align:center;background-color:#E8F4F1;\">"
						+ "<font size=3 color=#4C1B6D>"
						+ Messages.getMessage(request, "dispatch")
						+ "	</font></div>');" + " });");
				show.append("</SCRIPT>");

			} else if (temp.get("MID").toString().equals("eduOutsideModel")
					&& temp.get("MSTATE").toString().equals("1")) {
				// 行外培训

				paramMap.put("model", "eduOutsideModel");
				String content = ((Map) myHomeDao.getModel(paramMap).get(0))
						.get("MCONTENT").toString();

				String[] templist = content.split(";");
				float height = 0;
				float width = 0;
				for (int j = 0; j < templist.length; j++) {
					if (templist[j].toLowerCase().contains("height")) {
						height = Integer.parseInt(((templist[j].split(":"))[1])
								.split("px")[0].trim());
					}
					if (templist[j].toLowerCase().contains("width")) {
						width = Integer.parseInt(((templist[j].split(":"))[1])
								.split("px")[0].trim()) - 27;
					}
				}
				paramMap.remove("model");

				show.append("<SCRIPT type=\"text/javascript\">");
				show.append("$(function(){$(\"#eduOutside\").ligerGrid({"
						+ " columns: ["
						+ " 	{ display: 'No.', name: 'RN', minWidth: 30,width:"
						+ width * 4 / 100
						+ " },"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.empid")
						+ "', name: 'EMPID', minWidth: 70,width:"
						+ width * 9 / 100
						+ " },"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.name")
						+ "', name: 'CHINESENAME', minWidth: 70,width:"
						+ width * 9 / 100
						+ " },"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.dept")
						+ "', name: 'DEPARTMENT' ,minWidth: 150,width:"
						+ width * 24 / 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.position")
						+ "', name: 'POSITION' ,minWidth: 70,width:"
						+ width * 9 / 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.postGrade")
						+ "', name: 'POSTGRADE' ,minWidth: 70,width:"
						+ width
						* 9
						/ 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.startDate")
						+ "', name: 'PLANSTARTDATE' ,minWidth: 120,width:"
						+ width
						* 18
						/ 100
						+ "},"
						+ " 	{ display: '"
						+ Messages.getMessage(request, "hrms.endDate")
						+ "', name: 'PLANENDDATE',minWidth: 120,width:"
						+ width
						* 18
						/ 100
						+ "}"
						+ " ],"
						+ " url: '/myhome/getapp?type=getEduOutside',"
						+ " sortName: 'PLANSTARTDATE',sortOrder:'desc', "
						+ " dataAction: 'server',"
						+ " usePager: false,width: '100%',height:'"
						+ height
						+ "',heightDiff:-24"
						+ "}); "
						+ "  $('.l-panel-header','#eduOutside').before('<div style=\"text-align:center;background-color:#E8F4F1;\">"
						+ "<font size=3 color=#4C1B6D>"
						+ Messages.getMessage(request, "eduOutside")
						+ "	</font></div>');" + " });");
				show.append("</SCRIPT>");

			}
			show.append("</DIV>");

		}

		Map temp = new HashMap();
		temp.put("show", show.toString());
		temp.put("select", select.toString());

		return temp;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Object getHomePage(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("ADMINID", admin.getAdminID());

		return myHomeDao.getHomePage(paramMap);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void updateApp(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("ADMINID", admin.getAdminID());

		myHomeDao.updateApp(paramMap);

		String page = ObjectUtils.toString(paramMap.get("page"));
		if (page != null && page.length() > 0) {
			myHomeDao.deletePage(paramMap);
			myHomeDao.updatePage(paramMap);
		}
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getApp(HttpServletRequest request) { 
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("ADMINID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.myHomeDao.getApp(paramMap, NumberUtils
					.parseNumber(ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),
					Integer.class));
		} else {
			retrunList = this.myHomeDao.getApp(paramMap);
		}
		return retrunList;
	} 
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getAppCnt(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("ADMINID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		return this.myHomeDao.getAppCnt(paramMap);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getSystemMenu(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("ADMINID", admin.getAdminID());
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("page", request.getParameter("page"));

		return myHomeDao.getSyMenu(paramMap);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Object getTips(HttpServletRequest request) {
		Map rMap = new HashMap();

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("ADMINID", admin.getAdminID());
		paramMap.put("language", Messages.getLanguage(request));

		// 个人查看
		paramMap.put("parentCode", "ess0600");
		List pMenuList = myHomeDao.getTipsMenu(paramMap);
		if (pMenuList.size() == 0) {
			rMap.put("pview", "false");
		} else {
			rMap.put("pview", "true");

			StringBuffer buffer = new StringBuffer();
			for (Object object : pMenuList) {
				Map temp = (Map) object;
				int num = 0;
				if (temp.get("MENU_CODE").equals("ess0601")) {// 个人
					num = myHomeDao.getTipsCnt("getPersonalInfoApplyCount",
							paramMap);
				} else if (temp.get("MENU_CODE").equals("ess0607")) {// 加班
					num = myHomeDao.getTipsCnt("getPersonalApplyOtCount",
							paramMap);
				} else if (temp.get("MENU_CODE").equals("ess0608")) {// 休假
					num = myHomeDao.getTipsCnt("getPersonalApplyLeavelCount",
							paramMap);
				} else if (temp.get("MENU_CODE").equals("ess0606")) {// 出差
					num = myHomeDao.getTipsCnt(
							"getPersonalApplyErvectionCount", paramMap);
				} else if (temp.get("MENU_CODE").equals("ess0605")) {// 培训
					num = myHomeDao.getTipsCnt(
							"getPersonalApplyTrainningCount", paramMap);
				} else if (temp.get("MENU_CODE").equals("ess0614")) {// 教育
					num = myHomeDao.getTipsCnt("getPersonalApplyEduCount",
							paramMap);
				} else if (temp.get("MENU_CODE").equals("ess0613")) {// 慰问金
					num = myHomeDao.getTipsCnt("getPersonalApplyHandselCount",
							paramMap);
				}

				buffer.append("<p style='height:25px;'><a href=\"#\" onclick=\"goTab('"
						+ temp.get("MENU_CODE")
						+ "','"
						+ temp.get("MENU_INTRO")
						+ "','"
						+ temp.get("MENU_URL")
						+ "')\"> "
						+ num
						+ "&nbsp;&nbsp;"
						+ Messages.getMessage(request, "piece")
						+ Messages.getMessage(request, "judgementWaiting")
						+ temp.get("MENU_INTRO") + "</a></p>");
			}

			rMap.put("pviewinfo", buffer.toString());
		}

		// 待决裁
		paramMap.put("parentCode", "as0100");
		List jMenuList = myHomeDao.getTipsMenu(paramMap);
		if (jMenuList.size() == 0) {
			rMap.put("jview", "false");
		} else {
			rMap.put("jview", "true");

			StringBuffer buffer = new StringBuffer();
			for (Object object : jMenuList) {
				Map temp = (Map) object;
				int num = 0;
				if (temp.get("MENU_CODE").equals("ess0801")) {// 加班
					num = myHomeDao.getTipsCnt("getCountOt", paramMap);
				} else if (temp.get("MENU_CODE").equals("ess0802")) {// 休假
					num = myHomeDao.getTipsCnt("getCountLeave", paramMap);
				} else if (temp.get("MENU_CODE").equals("ess0805")) {// 出差
					num = myHomeDao.getTipsCnt("getCountEvection", paramMap);
				} else if (temp.get("MENU_CODE").equals("ess0806")) {// 培训
					num = myHomeDao.getTipsCnt("getCountTraining", paramMap);
				} else if (temp.get("MENU_CODE").equals("ess0808")) {// 教育
					num = myHomeDao.getTipsCnt("getCountEtnApply", paramMap);
				} else if (temp.get("MENU_CODE").equals("ess0807")) {// 慰问金
					num = myHomeDao
							.getTipsCnt("getCountHandselApply", paramMap);
				}

				buffer.append("<p style='height:25px;'><a href=\"#\" onclick=\"goTab('"
						+ temp.get("MENU_CODE")
						+ "','"
						+ temp.get("MENU_INTRO")
						+ "','"
						+ temp.get("MENU_URL")
						+ "')\"> "
						+ num
						+ "&nbsp;&nbsp;"
						+ Messages.getMessage(request, "piece")
						+ Messages.getMessage(request, "judgementWaiting")
						+ temp.get("MENU_INTRO") + "</a></p>");
			}

			rMap.put("jviewinfo", buffer.toString());
		}

		// 待确认
		paramMap.put("parentCode", "as0200");
		List cMenuList = myHomeDao.getTipsMenu(paramMap);
		if (cMenuList.size() == 0) {
			rMap.put("cview", "false");
		} else {
			rMap.put("cview", "true");

			StringBuffer buffer = new StringBuffer();
			for (Object object : cMenuList) {
				Map temp = (Map) object;
				int num = 0;
				if (temp.get("MENU_CODE").equals("ess0510")) {// 个人
					num = myHomeDao.getTipsCnt("getEssPersonalInfoCnt",
							paramMap);
				}

				buffer.append("<p style='height:25px;'><a href=\"#\" onclick=\"goTab('"
						+ temp.get("MENU_CODE")
						+ "','"
						+ temp.get("MENU_INTRO")
						+ "','"
						+ temp.get("MENU_URL")
						+ "')\"> "
						+ num
						+ "&nbsp;&nbsp;"
						+ Messages.getMessage(request, "piece")
						+ Messages.getMessage(request, "confirmWaiting")
						+ temp.get("MENU_INTRO") + "</a></p>");

			}

			rMap.put("cviewinfo", buffer.toString());
		}

		return rMap;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getPerViewInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("ADMINID", admin.getAdminID());
		paramMap.put("language", Messages.getLanguage(request));

		// 个人查看
		paramMap.put("parentCode", "ess0600");
		List pMenuList = myHomeDao.getTipsMenu(paramMap);
		if (pMenuList.size() == 0) {
			Map paraMap = new HashMap();
			paraMap.put("pview", "false");
			retrunList.add(paraMap);
		} else {
			for (Object object : pMenuList) {
				Map temp = (Map) object;
				Map paraMap = new HashMap();
				int num = 0;
				if (temp.get("MENU_CODE").equals("ess0601")) {// 个人
					num = myHomeDao.getTipsCnt("getPersonalInfoApplyCount",
							paramMap);
				} else if (temp.get("MENU_CODE").equals("ess0607")) {// 加班
					num = myHomeDao.getTipsCnt("getPersonalApplyOtCount",
							paramMap);
				} else if (temp.get("MENU_CODE").equals("ess0608")) {// 休假
					num = myHomeDao.getTipsCnt("getPersonalApplyLeavelCount",
							paramMap);
				} else if (temp.get("MENU_CODE").equals("ess0610")) {// 报工
					num = myHomeDao.getTipsCnt("getPersonalApplyWHCount",
							paramMap);
				} else if (temp.get("MENU_CODE").equals("ess0602")) {// 物品
					num = myHomeDao.getTipsCnt("getPersonalApplyToolCount",
							paramMap);
				} 
//				else if (temp.get("MENU_CODE").equals("ess0606")) {// 出差
//					num = myHomeDao.getTipsCnt(
//							"getPersonalApplyErvectionCount", paramMap);
//				} else if (temp.get("MENU_CODE").equals("ess0605")) {// 培训
//					num = myHomeDao.getTipsCnt(
//							"getPersonalApplyTrainningCount", paramMap);
//				} else if (temp.get("MENU_CODE").equals("ess0614")) {// 教育
//					num = myHomeDao.getTipsCnt("getPersonalApplyEduCount",
//							paramMap);
//				} else if (temp.get("MENU_CODE").equals("ess0613")) {// 慰问金
//					num = myHomeDao.getTipsCnt("getPersonalApplyHandselCount",
//							paramMap);
//				}
				paraMap.put(
						"CNT",
						num + "&nbsp;&nbsp;"
								+ Messages.getMessage(request, "piece"));
				paraMap.put("CNTS", num);
				paraMap.put("MENU_URL", temp.get("MENU_URL"));
				paraMap.put("MENU_INTRO", temp.get("MENU_INTRO"));
				paraMap.put("MENU_CODE", temp.get("MENU_CODE"));
				paraMap.put("MENU_NO", temp.get("MENU_NO"));
				paraMap.put("pview", "true");
				paraMap.put("AR_DATE", DateUtil.getSysdateString("yyyy-MM-dd"));
				retrunList.add(paraMap);
			}
		}
		return retrunList;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getAffirmInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("ADMINID", admin.getAdminID());
		paramMap.put("language", Messages.getLanguage(request));

		// 待决裁
		paramMap.put("parentCode", "as0100");
		List jMenuList = myHomeDao.getTipsMenu(paramMap);
		if (jMenuList.size() == 0) {
			Map paraMap = new HashMap();
			paraMap.put("jview", "false");
			retrunList.add(paraMap); 
		} else {   
			for (Object object : jMenuList) {
				Map temp = (Map) object;
				Map paraMap = new HashMap();
				int num = 0;
				if (temp.get("MENU_CODE").equals("as0101")) {// 加班
					num = myHomeDao.getTipsCnt("getCountOt", paramMap);
				} else if (temp.get("MENU_CODE").equals("as0102")) {// 休假
					num = myHomeDao.getTipsCnt("getCountLeave", paramMap);
				} 
//				else if (temp.get("MENU_CODE").equals("as0105")) {// 出差
//					num = myHomeDao.getTipsCnt("getCountEvection", paramMap);
//				} else if (temp.get("MENU_CODE").equals("as0106")) {// 培训
//					num = myHomeDao.getTipsCnt("getCountTraining", paramMap);
//				} else if (temp.get("MENU_CODE").equals("as0108")) {// 教育
//					num = myHomeDao.getTipsCnt("getCountEtnApply", paramMap);
//				} else if (temp.get("MENU_CODE").equals("as0107")) {// 慰问金
//					num = myHomeDao
//							.getTipsCnt("getCountHandselApply", paramMap);
//				}

				paraMap.put(
						"CNT",
						num + "&nbsp;&nbsp;"
								+ Messages.getMessage(request, "piece")
								+ "&nbsp;&nbsp;"
								+ Messages.getMessage(request, "judgementWaiting"));
				paraMap.put("CNTS", num);
				paraMap.put("MENU_URL", temp.get("MENU_URL"));
				paraMap.put("MENU_INTRO", temp.get("MENU_INTRO"));
				paraMap.put("MENU_CODE", temp.get("MENU_CODE"));
				paraMap.put("MENU_NO", temp.get("MENU_NO"));
				paraMap.put("AR_DATE", DateUtil.getSysdateString("yyyy-MM-dd"));
				paraMap.put("jview", "true");
				retrunList.add(paraMap); 
			} 
		} 
		return retrunList;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getConfirmInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("ADMINID", admin.getAdminID());
		paramMap.put("language", Messages.getLanguage(request));
 
		// 待确认
		paramMap.put("parentCode", "as0200");
		List cMenuList = myHomeDao.getTipsMenu(paramMap);
		if (cMenuList.size() == 0) {
			Map paraMap = new HashMap();
			paraMap.put("cview", "false");
		} else {  
			for (Object object : cMenuList) {
				Map temp = (Map) object;
				Map paraMap = new HashMap();
				int num = 0;
				if (temp.get("MENU_CODE").equals("as0210")) {// 个人
					num = myHomeDao.getTipsCnt("getEssPersonalInfoCnt",
							paramMap);
				} else if (temp.get("MENU_CODE").equals("as0206")) {// 加班确认
					num = myHomeDao.getTipsCnt("getEssOTInfoCnt", paramMap);
				} else if (temp.get("MENU_CODE").equals("as0207")) {// 休假确认
					num = myHomeDao.getTipsCnt("getEssLeaveInfoCnt", paramMap);
				} else if (temp.get("MENU_CODE").equals("as0205")) {// 报工确认
					num = myHomeDao.getTipsCnt("getEssWHInfoCnt", paramMap);
				} else if (temp.get("MENU_CODE").equals("as0201")) {// 物品确认
					num = myHomeDao.getTipsCnt("getEssToolInfoCnt", paramMap);
				} 
				paraMap.put(
						"CNT",
						num + "&nbsp;&nbsp;"
								+ Messages.getMessage(request, "piece")
								+ "&nbsp;&nbsp;"
								+ Messages.getMessage(request, "confirmWaiting"));
				paraMap.put("CNTS", num);
				paraMap.put("MENU_URL", temp.get("MENU_URL"));
				paraMap.put("MENU_INTRO", temp.get("MENU_INTRO"));
				paraMap.put("MENU_CODE", temp.get("MENU_CODE"));
				paraMap.put("MENU_NO", temp.get("MENU_NO"));
				paraMap.put("cview", "true");
				paraMap.put("AR_DATE", DateUtil.getSysdateString("yyyy-MM-dd"));
				retrunList.add(paraMap);  
			} 
		} 
		return retrunList;
	}
}
