package com.siping.system.action;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.system.bean.AdminBean;
import com.siping.system.service.SystemSer;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/system/checkSettings")
public class CheckSettingsController {
    Logger logger = Logger.getLogger(CheckSettingsController.class);
    @Autowired
    private SystemSer systemSer;

    /**
     * 跳转到审核参数设置页面
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewCheckInfo", method = RequestMethod.GET)
    public ModelAndView viewSerialNumber() throws Exception {
        return new ModelAndView("/system/checkSettings/viewCheckInfo");
    }
    /**
     * 查看已有审核人-审核类型对应关系表
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getCheckedListInfo",method = RequestMethod.POST)
    @ResponseBody
    public Map getCheckedListInfo(HttpServletRequest request) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        List List = this.systemSer.getCheckedListInfo(paramMap);
        int cnt = this.systemSer.getCheckedListInfoCnt(paramMap);
        Map model=new HashMap();
        model.put("Rows", List);
        model.put("Total", cnt);
        return model;
    }
    @RequestMapping(value = "/saveOrUpdateCheckedType",method = RequestMethod.POST)
    @ResponseBody
    public String saveOrUpdateCheckedType(HttpServletRequest request){
        String returnMsg = "";
        try {
            returnMsg=this.systemSer.saveOrUpdateCheckedType(request);
        } catch (Exception e) {
            returnMsg = "保存失败！请检查该审核类型是否已设置完成";
            e.printStackTrace();
        }
        return returnMsg;
    }
    @RequestMapping(value = "/deleteCheckedType",method = RequestMethod.POST)
    @ResponseBody
    public int deleteCheckedType(HttpServletRequest request){
        int returnMsg = 0;
        try {
            returnMsg=this.systemSer.deleteCheckedType(request);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnMsg;
    }
}