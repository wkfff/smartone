package com.siping.att.action.attendanceMintenance;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.siping.att.service.AttCardRecordSer; 
import com.siping.att.service.AttDetailSer;

@Controller
@RequestMapping(value = "/att/attendanceMintenance")
public class AttCardRecordController {
Logger logger = Logger.getLogger(AttCardRecordController.class);
	
	@Autowired
	private AttCardRecordSer attCardRecordSer;
	
	@Autowired
	private AttDetailSer attDetailSer;
	
	@RequestMapping(value = "/viewAttCardRecord",method = RequestMethod.GET)
	public ModelAndView viewAttCardRecord(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
			modelMap.put("E_DATE",attDetailSer.getEndDateStr(request,"yyyy-MM-dd"));
			modelMap.put("S_DATE",attDetailSer.getStartDateStr(request,"yyyy-MM-dd"));
			return new ModelAndView("/att/attendanceMintenance/viewAttCardRecord",modelMap);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getAttCardRecordInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getAttCardRecordInfo(HttpServletRequest request)throws Exception{
		List infoList = this.attCardRecordSer.getAttCardRecordInfo(request);
		int infoCnt=this.attCardRecordSer.getAttCardRecordInfoCnt(request);
		Map model=new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoCnt);
		return model;
	}
	@RequestMapping(value = "/updateAttCardRecordInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updateAttCardRecordInfo(HttpServletRequest request)throws Exception{
		return this.attCardRecordSer.updateAttCardRecordInfo(request);
	}
	@RequestMapping(value = "/deleteAttCardRecordInfo",method = RequestMethod.POST)
	@ResponseBody
	public String deleteAttCardRecordInfo(HttpServletRequest request)throws Exception{
		return  this.attCardRecordSer.deleteAttCardRecordInfo(request);
	}
	@RequestMapping(value = "/addAttCardRecordInfoView",method = RequestMethod.GET)
	public ModelAndView addAttCardRecordInfoView(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		return new ModelAndView("/att/attendanceMintenance/addAttCardRecordInfoView",modelMap);
	}
	@RequestMapping(value = "/addAttCardRecordInfo",method = RequestMethod.POST)
	@ResponseBody
	public String addAttCardRecordInfo(HttpServletRequest request)throws Exception{
		return this.attCardRecordSer.addAttCardRecordInfo(request) ;
	}
	@RequestMapping(value = "/getRecordsFromAccess",method = RequestMethod.GET)
	public ModelAndView getRecordsFromAccess(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		return new ModelAndView("/att/attendanceMintenance/getRecordsFromAccess",modelMap);
	}
	@RequestMapping(value = "/uploadAttMacRecords",method = RequestMethod.GET)
	public ModelAndView uploadAttMacRecords(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		return new ModelAndView("/att/attendanceMintenance/uploadAttMacRecords",modelMap);
	}
	@RequestMapping(value = "/downloadRecordsInfoTemplate")
	public void downloadRecordsInfoTemplate(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException{
		this.attCardRecordSer.downloadAttRecordsTemplate(request, response);
	}
	/**
	 * 上传Excel并将Excel放入AR_RECORDS表中 
	 * @throws ParseException 
	 */
	@RequestMapping(value="/uploadMacRecodsByExcel",method = RequestMethod.POST)
	@ResponseBody
	public String uploadMacRecodsByExcel(@RequestParam("file") MultipartFile file, 
			HttpServletRequest request,HttpServletResponse response) {
		String resultString = null;
		try {
			resultString = this.attCardRecordSer.uploadMacRecodsByExcel(file,request,response);
		} catch (IOException e) {
			resultString = e.getMessage();
			e.printStackTrace();
		} catch (SQLException e) {
			resultString = e.getMessage();
			e.printStackTrace();
		} catch (ParseException e) {
			resultString = e.getMessage();
			e.printStackTrace();
		} catch (Exception e){
			resultString = "未知错误";
			e.printStackTrace();
		}
		return resultString;
	}
}
