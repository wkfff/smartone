package com.siping.wechat.action;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
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
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;

import com.siping.wechat.bean.DailyFlow;
import com.siping.wechat.bean.PagerInfo;
import com.siping.wechat.bean.PagerStruct;
import com.siping.wechat.bean.RequestResult;
import com.siping.wechat.bean.WeChatMessage;
import com.siping.wechat.bean.WechatMenu;
import com.siping.wechat.bean.WechatUser;
import com.siping.wechat.service.WechatSer;
import com.siping.wechat.util.WeChatConstant;
import com.siping.wechat.util.WeChatUtil;

@Controller
@RequestMapping(value = "/wechat")
public class WeChatController {

    @Autowired
    private WechatSer wechatSer;

    private final Logger logger = Logger.getLogger(WeChatController.class);

    @RequestMapping(value = "/interface", method = RequestMethod.GET)
    @ResponseBody
    public String applyInterface(HttpServletRequest request, @RequestParam("signature") String signature, @RequestParam("timestamp") String timestamp, @RequestParam("nonce") String nonce,
                                 @RequestParam("echostr") String echostr) {
        return echostr;
    }

    @RequestMapping(value = "/interface", method = RequestMethod.POST)
    @ResponseBody
    public String doReplayToWeChat(HttpServletRequest request) throws Exception {
        logger.error("wechat server send message here!");
        WeChatMessage wechatMessage = null;
        Map<String, String> weChatMessageMap = WeChatUtil.parseXml(request);
        logger.error(weChatMessageMap.toString());
        wechatSer.processRequest(weChatMessageMap);//新关注用户添加到数据库
        wechatMessage = WeChatMessage.getBeanFromSpringContainter(WebApplicationContextUtils.getWebApplicationContext(request.getServletContext()), weChatMessageMap);
        logger.error(wechatMessage.getClass().toString());
        wechatMessage.initParam(weChatMessageMap);
        InetAddress addr = null;
        try {
            addr = InetAddress.getLocalHost();
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
        wechatMessage.setWebDomain(addr.getHostAddress().toString() + ":"+ request.getServerPort());
        String reMsg = wechatMessage.getReturnMessage();
        logger.error(reMsg);
        return reMsg;
    }

    /**
     * 获取所有关注者，并存入数据库
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/initWechatUser")
    @ResponseBody
    public RequestResult loadUserInfoFromWeChatServer(HttpServletRequest request, HttpServletResponse response) {
        RequestResult result = new RequestResult();
        try {
            wechatSer.initWechatUsers();
        } catch (Exception e) {
            result.setCode(10);
            result.setMessage("False" + e.getMessage());
        }
        return result;
    }

    @RequestMapping(value="/wechatSetting")
    public ModelAndView wechatSetting(ModelMap modelMap) throws Exception{
        List<WechatMenu> menus = wechatSer.getWechatMenuList();
        modelMap.put("menus", menus);
        modelMap.put("menuSize", menus.size());
        return new ModelAndView("/mobile/wechatPublic/wechatSettings",modelMap);
    }

    @RequestMapping(value="/addWechatMenu",method=RequestMethod.POST)
    @ResponseBody
    public String addWechatMenu(HttpServletRequest request,WechatMenu menu){
        String str = "";
        try {
            if(menu.getId()==0){
                wechatSer.addWechatMenu(request, menu);
                if(menu.getId()>0){
                    str = "Y";
                }else{
                    str = "保存失败";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            str = "保存失败";
        }
        return str;
    }

    @RequestMapping(value="/deleteMenu",method=RequestMethod.POST)
    @ResponseBody
    public String deleteMenu(@RequestParam Integer id){
        String str = "未删除";
        try {
            if(id!=null&&id!=0){
                if(wechatSer.isMenuExistSonMenu(id)){
                    str = "请先删除该菜单下的子菜单";
                }else{
                    wechatSer.deleteMenu(id);
                    str = "Y";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            str = "保存失败";
        }
        return str;
    }

    @RequestMapping(value="/updateMenu",method=RequestMethod.POST)
    @ResponseBody
    public String updateMenu(HttpServletRequest request,WechatMenu menu){
        String str = "未修改";
        try {
            if(menu.getId()!=0){
                wechatSer.updateMenu(request,menu);
                str = "Y";
            }
        } catch (Exception e) {
            e.printStackTrace();
            str = "保存失败";
        }
        return str;
    }

    @RequestMapping(value="/updateMenuName",method=RequestMethod.POST)
    @ResponseBody
    public String updateMenuName(HttpServletRequest request,WechatMenu menu){
        String str = "未修改";
        try {
            if(menu.getId()>0){
                wechatSer.updateMenuName(request,menu);
                str = "Y";
            }
        } catch (Exception e) {
            e.printStackTrace();
            str = "保存失败";
        }
        return str;
    }

    @RequestMapping(value="/checkMenuKey",method=RequestMethod.POST)
    @ResponseBody
    public boolean menuKeyIsExist(@RequestParam("menuKey") String menuKey,@RequestParam("id") int id){
        boolean flag = false;
        try {
            flag = wechatSer.menuKeyIsExist(menuKey,id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

    @RequestMapping(value="getMenuById",method=RequestMethod.POST)
    @ResponseBody
    public WechatMenu getMenuById(@RequestParam("id") int id){
        WechatMenu menu =null;
        try {
            if(id!=0){
                menu = wechatSer.getMenuById(id);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return menu;
    }

    @RequestMapping(value="/createMenu",method=RequestMethod.POST)
    @ResponseBody
    public String createMenu(){
        String resultStr = "";
        try {
            resultStr = wechatSer.createMenu(WeChatConstant.ACCESS_TOKEN);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultStr;
    }

    @RequestMapping(value="/attentionList")
    public ModelAndView attentionList(){
        return new ModelAndView("/mobile/wechatPublic/viewAttentionList");
    }

    /**
     * 获取注册用户列表（当前为微信关注用户列表）
     * @param request
     * @param size
     * @param page
     * @param keyWord
     * @return
     */
    @RequestMapping(value = "/getRegistUserList", method = RequestMethod.POST)
    @ResponseBody
    public PagerStruct<WechatUser> getRegistUserList(HttpServletRequest request, @RequestParam("rp") String size, @RequestParam("page") String page, @RequestParam("keyWord") String keyWord) {
        PagerStruct<WechatUser> result = new PagerStruct<WechatUser>();
        PagerInfo pagerParam = new PagerInfo();
        pagerParam.setPage(Integer.parseInt(page));
        pagerParam.setSize(Integer.parseInt(size));
        result.setPage(Integer.parseInt(page));
        try {
            result.setRows(wechatSer.getRegistUserList(keyWord, pagerParam));
            result.setTotal(wechatSer.getRegistUserListCnt(keyWord));
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("获取注册关注用户分页数据出错");
        }
        return result;
    }

    @RequestMapping(value="/viewDailyFlow")
    public ModelAndView viewDailyFlow(){
        return new ModelAndView("/mobile/wechatPublic/viewDailyFlow");
    }

    /**
     * 每日访问流量数据接口，包括访问量、新保存数据量、日微信关注量
     * @param request
     * @return
     */
    @RequestMapping(value = "/getVisitDailyFlow", method = RequestMethod.POST)
    @ResponseBody
    public DailyFlow getVisitDailyFlow(@RequestParam("days") int days) {
        DailyFlow flow = new DailyFlow();
        try {
            //日访问量，从微信入口登陆
            flow.setVisit(wechatSer.getDaylyVisitFlowList(days));
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("获取访问量出错");
        }
        return flow;
    }

    /**
     * 每日访问流量数据接口，包括访问量、新保存数据量、日微信关注量
     * @param request
     * @return
     */
    @RequestMapping(value = "/getWechatDailyFlow", method = RequestMethod.POST)
    @ResponseBody
    public DailyFlow getWechatDailyFlow(@RequestParam("days") int days) {
        DailyFlow flow = new DailyFlow();
        try {
            //日微信关注量
            flow.setWechat(wechatSer.getDaylyWechatFlowList(days));
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("获取访问量出错");
        }
        return flow;
    }
}
