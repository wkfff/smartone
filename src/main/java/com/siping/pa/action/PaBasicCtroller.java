package com.siping.pa.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siping.pa.service.PaBasicSer;

@Controller
@RequestMapping(value = "/pa/basic")
public class PaBasicCtroller {
	Logger logger = Logger.getLogger(PaBasicCtroller.class);
	
	@Autowired
	private PaBasicSer paBasicSer ;
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getPaSearchEmployeeList",method = RequestMethod.POST)
	@ResponseBody
	public Map getPaSearchEmployeeList(HttpServletRequest request)throws Exception{
		
		List prSearchEmployeeList = this.paBasicSer.getPaSearchEmployeeList(request) ;
		
		int prSearchEmployeeCnt = this.paBasicSer.getPaSearchEmployeeCnt(request) ;
		
		Map model=new HashMap();
		model.put("Rows", prSearchEmployeeList) ;
		model.put("Total", prSearchEmployeeCnt) ;
	
		return model ;	
	}
	
}
