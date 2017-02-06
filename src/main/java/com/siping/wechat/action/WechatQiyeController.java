package com.siping.wechat.action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.hrm.bean.ApplyLeave;
import com.siping.wechat.service.WechatQiyeSer;

@Controller
@RequestMapping(value="/hrm")
public class WechatQiyeController {

    @Autowired
    private WechatQiyeSer wechatQiyeSer;

    @RequestMapping(value="/appOt")
    public ModelAndView applyOvertime() throws Exception{
        return new ModelAndView("/mobile/wechatQiye/applyOvertime");
    }

    @RequestMapping(value="/appBt")
    public ModelAndView applyBusiTrip() throws Exception{
        return new ModelAndView("/mobile/wechatQiye/applyBusiTrip");
    }

    @RequestMapping(value="/appLeave")
    public ModelAndView applyLeave() throws Exception{
        return new ModelAndView("/mobile/wechatQiye/applyLeave");
    }

    @RequestMapping(value="/appCost")
    public ModelAndView applyCost() throws Exception{
        return new ModelAndView("/mobile/wechatQiye/applyCost");
    }

    @RequestMapping(value="/addLeave",method=RequestMethod.POST)
    @ResponseBody
    public String addLeave(ApplyLeave applyLeave){
        String str = null;
        try {
            str = wechatQiyeSer.addLeave(applyLeave);
        } catch (Exception e) {
            str = "申请失败";
            e.printStackTrace();
        }
        return str;
    }
}
