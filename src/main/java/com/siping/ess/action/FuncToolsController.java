package com.siping.ess.action;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.List;
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
import com.siping.ess.service.FuncToolsSer;
import com.siping.web.utility.SessionUtil;
import com.siping.websocket.room.WebSocketRoomManager;

@Controller
@RequestMapping(value="/ess/funcTools")
public class FuncToolsController {
	Logger logger = Logger.getLogger(FuncToolsController.class);
	
	@Autowired
	private FuncToolsSer funcToolsSer;

	@RequestMapping(value="/chatRoom")
	public ModelAndView enterRoom(HttpServletRequest request, ModelMap modelMap){
		modelMap.put("admin", SessionUtil.getLoginUserFromSession(request));
		InetAddress addr = null;
		try {
			addr = InetAddress.getLocalHost();
		} catch (UnknownHostException e) {
			
			e.printStackTrace();
		}
		String ip=addr.getHostAddress().toString();//获得本机IP
		modelMap.put("serverIP", ip);
		modelMap.put("deptList", funcToolsSer.getChatterDeptTree());
		return new ModelAndView("/ess/funcTools/chatRoom",modelMap);
	}
	
	@RequestMapping(value="/getAllEmpDeptTree",method=RequestMethod.POST)
	public List getAllEmpDeptTree(HttpServletRequest request, ModelMap modelMap){
		return funcToolsSer.getAllEmpDeptTree();
	}
	
	@RequestMapping(value="/setRoomID",method=RequestMethod.POST)
	@ResponseBody
	public boolean setRoomID(HttpServletResponse response,HttpServletRequest request){
		String ids = request.getParameter("ids");
		return WebSocketRoomManager.setRoom(ids);
		/*if(needCreate = true){
			try {
				response.getWriter().write("true");
			} catch (IOException e) {
				
				e.printStackTrace();
			}
		}else{
			try {
				response.getWriter().write("false");
			} catch (IOException e) {
				
				e.printStackTrace();
			}
		}*/
	}
}
