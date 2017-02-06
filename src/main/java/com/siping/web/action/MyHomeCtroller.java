package com.siping.web.action;

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

import com.siping.system.service.MyHomeSer;

@Controller
@RequestMapping(value = "/myhome")
public class MyHomeCtroller{

	Logger logger = Logger.getLogger(MyHomeCtroller.class);
		
	@Autowired
	private MyHomeSer myHomeSer;
	
	@RequestMapping(value = "/updateModel",method = RequestMethod.POST)
	@ResponseBody
	public void updateModel(HttpServletRequest request)throws Exception{
		logger.info("start......");
		this.myHomeSer.updateModel(request);		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getModel",method = RequestMethod.GET)
	@ResponseBody
	public Map getModel(HttpServletRequest request)throws Exception{
		List list = this.myHomeSer.getModel(request);
		Map model=new HashMap();
		model.put("modelList", list);
				
		return model;		
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getShort",method = RequestMethod.POST)
	@ResponseBody
	public Map getShort(HttpServletRequest request)throws Exception{ 
		
		List shortcutList = this.myHomeSer.getShort(request) ; 
		int shortcutListCnt = this.myHomeSer.getShortCnt(request) ;
		
		Map model=new HashMap();
		model.put("Rows", shortcutList);
		model.put("Total", shortcutListCnt); 
				
		return model;		
	}

	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "/getHomePurview",method = RequestMethod.GET)
	@ResponseBody
	public Map getHomePurview(HttpServletRequest request)throws Exception{
		Map model=(Map) this.myHomeSer.getHomePurview(request);				
		return model;		
	}
	
	@RequestMapping(value = "/updateapp",method = RequestMethod.POST)
	@ResponseBody
	public void updateApp(HttpServletRequest request)throws Exception{		
		this.myHomeSer.updateApp(request);
	}
	/**
	 * 主页提示信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getapp",method = RequestMethod.POST)
	@ResponseBody
	public Map getApp(HttpServletRequest request)throws Exception{	
		Map map = new HashMap();
		map.put("Rows", this.myHomeSer.getApp(request));
		map.put("Total", this.myHomeSer.getAppCnt(request));
		
		return map;
	}

	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "/getSyMenu",method = RequestMethod.GET)
	@ResponseBody
	public List getSyMenu(HttpServletRequest request)throws Exception{		
		return this.myHomeSer.getSystemMenu(request);
	}

	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "/getTips",method = RequestMethod.GET)
	@ResponseBody
	public Map getTips(HttpServletRequest request)throws Exception{		
		return (Map)this.myHomeSer.getTips(request);
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getAffirmInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getAffirmInfo(HttpServletRequest request)throws Exception{	
		Map map = new HashMap();
		
		map.put("Rows", this.myHomeSer.getAffirmInfo(request));
		
		return map;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getConfirmInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getConfirmInfo(HttpServletRequest request)throws Exception{	
		Map map = new HashMap();
		
		map.put("Rows", this.myHomeSer.getConfirmInfo(request));
		
		return map;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getPerViewInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getPerViewInfo(HttpServletRequest request)throws Exception{	
		Map map = new HashMap();
		
		map.put("Rows", this.myHomeSer.getPerViewInfo(request));
		
		return map;
	}
	
}
