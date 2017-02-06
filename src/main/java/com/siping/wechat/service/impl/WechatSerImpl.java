package com.siping.wechat.service.impl;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import java.security.SecureRandom;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.system.bean.AdminBean;
import com.siping.web.utility.SessionUtil;
import com.siping.wechat.bean.Button;
import com.siping.wechat.bean.ClickButton;
import com.siping.wechat.bean.ComplexButton;
import com.siping.wechat.bean.Menu;
import com.siping.wechat.bean.PagerInfo;
import com.siping.wechat.bean.PagerRequest;
import com.siping.wechat.bean.ViewButton;
import com.siping.wechat.bean.Visits;
import com.siping.wechat.bean.WechatMenu;
import com.siping.wechat.bean.WechatUser;
import com.siping.wechat.bean.WechatUserList;
import com.siping.wechat.dao.WechatDao;
import com.siping.wechat.service.WechatSer;
import com.siping.wechat.util.HandleReturnCode;
import com.siping.wechat.util.MyX509TrustManager;
import com.siping.wechat.util.WeChatConstant;
import com.siping.wechat.util.WeChatUtil;

@Service
public class WechatSerImpl implements WechatSer {

    Logger logger = Logger.getLogger(WechatSerImpl.class);
    @Autowired
    private WechatDao wechatDao;

    @Override
    public void addWechatMenu(HttpServletRequest request,WechatMenu menu) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        menu.setCreatedBy(admin.getAdminID());
        wechatDao.addWechatMenu(menu);
    }

    @Override
    public List<WechatMenu> getWechatMenuList() throws Exception {
        return wechatDao.getWechatMenuList();
    }

    @Override
    public void deleteMenu(int id) throws Exception {
        wechatDao.deleteMenu(id);
    }

    @Override
    public void updateMenu(HttpServletRequest request, WechatMenu menu) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        menu.setUpdatedBy(admin.getAdminID());
        wechatDao.updateMenu(menu);
    }

    @Override
    public void updateMenuName(HttpServletRequest request, WechatMenu menu) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        menu.setUpdatedBy(admin.getAdminID());
        wechatDao.updateMenuName(menu);
    }

    @Override
    public boolean menuKeyIsExist(String menuKey,int id) throws Exception {
        Map<String,Object> map = new LinkedHashMap<String,Object>();
        map.put("menuKey", menuKey.trim());
        map.put("id", id);
        int cnt = wechatDao.menuKeyIsExist(map);
        if(cnt==0){
            return true;
        }
        return false;
    }

    @Override
    public WechatMenu getMenuById(int id) throws Exception {
        return wechatDao.getMenuById(id);
    }

    @Override
    public String getJsonMenu() throws Exception {
        List<WechatMenu> menus = getWechatMenuList();
        Menu m = new Menu();
        Button[] buttonArray = new Button[menus.size()];
        for(int i=0;i<menus.size();i++){
            List<WechatMenu> sonMenus = menus.get(i).getSonMenus();
            if(sonMenus.size()==0){
                WechatMenu me = menus.get(i);
                String type = me.getMenuType();
                if(type!=null&&type.equals("click")){
                    ClickButton cb = new ClickButton();
                    cb.setKey(me.getMenuKey());
                    cb.setName(me.getMenuName());
                    cb.setType(type);
                    buttonArray[i] = cb;
                }
                if(type!=null&&type.equals("view")){
                    ViewButton vb = new ViewButton();
                    vb.setName(me.getMenuName());
                    vb.setType(type);
                    vb.setUrl(me.getMenuUrl());
                    buttonArray[i] = vb;
                }
            }else{
                ComplexButton complexButton = new ComplexButton();
                Button[] subButton = new Button[sonMenus.size()];
                for(int j=0;j<sonMenus.size();j++){
                    WechatMenu menu = sonMenus.get(j);
                    String type = menu.getMenuType();
                    if(type!=null&&type.equals("click")){
                        ClickButton cb = new ClickButton();
                        cb.setKey(menu.getMenuKey());
                        cb.setName(menu.getMenuName());
                        cb.setType(type);
                        subButton[j] = cb;
                    }
                    if(type!=null&&type.equals("view")){
                        ViewButton vb = new ViewButton();
                        vb.setName(menu.getMenuName());
                        vb.setType(type);
                        vb.setUrl(menu.getMenuUrl());
                        subButton[j] = vb;
                    }
                }
                complexButton.setName(menus.get(i).getMenuName());
                complexButton.setSub_button(subButton);
                buttonArray[i] = complexButton;
            }
        }
        m.setButton(buttonArray);
        String jsonMenu = JSONObject.fromObject(m).toString();
        return jsonMenu;
    }

    @Override
    public String createMenu(String accessToken) throws Exception {
        String jsonMenu = getJsonMenu();
        String menuCreateUrl = WeChatConstant.GET_MENU_CREATE_URL.replace("ACCESS_TOKEN", accessToken);
        //建立连接
        URL url = new URL(menuCreateUrl);
        HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
        //使用自定义的信任管理器
        TrustManager[] tm = {new MyX509TrustManager()};
        SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
        sslContext.init(null, tm, new SecureRandom());
        SSLSocketFactory ssf = sslContext.getSocketFactory();
        conn.setSSLSocketFactory(ssf);
        conn.setDoOutput(true);
        conn.setDoInput(true);
        //设置请求方式
        conn.setRequestMethod("POST");
        //向输出流写菜单结构
        OutputStream outputStream = conn.getOutputStream();
        outputStream.write(jsonMenu.getBytes("UTF-8"));
        outputStream.close();
        //取得输入流
        InputStream inputStream = conn.getInputStream();
        InputStreamReader inputStreamReader = new InputStreamReader(inputStream,"utf-8");
        BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
        //读取响应内容
        StringBuffer buffer = new StringBuffer();
        String str = null;
        while ((str = bufferedReader.readLine()) != null) {
            buffer.append(str);
        }
      //转化json处理
        JSONObject jsonObject = JSONObject.fromObject(buffer.toString());
        int errcode = Integer.parseInt(jsonObject.getString("errcode"));
        //关闭、释放资源
        bufferedReader.close();
        inputStreamReader.close();
        inputStream.close();
        conn.disconnect();
        return HandleReturnCode.handle(errcode);
    }

    @Override
    public boolean isMenuExistSonMenu(Integer id) throws Exception {
        int sonMenuCnt = wechatDao.isMenuExistSonMenu(id);
        if(sonMenuCnt==0){
            return false;
        }else{
            return true;
        }
    }

    @Override
    public WechatMenu getMenuByMenuKey(String eventKey) throws Exception {
        return wechatDao.getMenuByMenuKey(eventKey);
    }

    @Override
    public List<WechatUser> getRegistUserList(String keyWord, PagerInfo pagerParam) {
        PagerRequest pr = new PagerRequest();
        LinkedHashMap<String,Object> params = new LinkedHashMap<String, Object>();
        params.put("keyWord", keyWord);
        pr.setParams(params);
        pr.setPagerInfo(pagerParam);
        return wechatDao.getRegistUserList(pr);
    }

    @Override
    public int getRegistUserListCnt(String keyWord) {
        LinkedHashMap<String,Object> params = new LinkedHashMap<String, Object>();
        params.put("keyWord", keyWord);
        return wechatDao.getRegistUserListCnt(params);
    }

    @Override
    public void initWechatUsers() throws SQLException {
        WechatUserList list = WeChatUtil.getUserList(WeChatConstant.ACCESS_TOKEN, null);
        if (list == null || list.getOpenidList() == null) {
            return;
        }
        List<String> openidList = list.getOpenidList();
        for (String openid : openidList) {
            WechatUser user = WeChatUtil.getUserInfo(WeChatConstant.ACCESS_TOKEN, openid);
            if (user != null && wechatDao.getWechatUser(user) == null) {
                wechatDao.insertWechatUser(user);
            }
        }
    }

    @Override
    public void saveVisitTimes(Visits record) throws SQLException {
        wechatDao.insertDayTimes(record);
    }

    @Override
    public void processRequest(Map<String, String> requestMap) {
        String msgType = requestMap.get("MsgType");
        if (msgType.equals(WeChatConstant.REQ_MESSAGE_TYPE_EVENT)) {
            String eventType = requestMap.get("Event");
            // 关注事件则保存用户
            if (eventType.equals(WeChatConstant.EVENT_TYPE_SUBSCRIBE)) {
                String openid = requestMap.get("FromUserName");
                WechatUser newUser = WeChatUtil.getUserInfo(WeChatConstant.ACCESS_TOKEN, openid);
                if (newUser == null) {
                    logger.error("%%%%%%%%%%%%%%%User: " + openid + " info get failed");
                } else {
                    WechatUser tempUser = new WechatUser();
                    tempUser.setOpenid(openid);
                    if (this.wechatDao.getWechatUser(tempUser) != null) {
                        try {
                            logger.error("%%%%%%%%%%%%%%%User: " + openid + " exists");
                            this.wechatDao.updateWechatUser(newUser);
                            logger.error("%%%%%%%%%%%%%%%User: " + openid + " updated ok");
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    } else {
                        try {
                            logger.error("%%%%%%%%%%%%%%%User: " + openid + " does not exists");
                            this.wechatDao.insertWechatUser(newUser);
                            logger.error("%%%%%%%%%%%%%%%User: " + openid + " insert ok");
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
    }

    @Override
    public List<Visits> getDaylyVisitFlowList(int days) {
        return wechatDao.getDaylyVisitFlowList(days);
    }

    @Override
    public List<Visits> getDaylyWechatFlowList(int days) {
        return wechatDao.getDaylyWechatFlowList(days);
    }

}