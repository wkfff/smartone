package com.siping.wechat.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.siping.wechat.bean.PagerInfo;
import com.siping.wechat.bean.Visits;
import com.siping.wechat.bean.WechatMenu;
import com.siping.wechat.bean.WechatUser;

public interface WechatSer {

    void addWechatMenu(HttpServletRequest request,WechatMenu menu) throws Exception;

    List<WechatMenu> getWechatMenuList() throws Exception;

    void deleteMenu(int id) throws Exception;

    void updateMenu(HttpServletRequest request,WechatMenu menu) throws Exception;

    void updateMenuName(HttpServletRequest request, WechatMenu menu) throws Exception;

    boolean menuKeyIsExist(String menuKey,int id) throws Exception;

    WechatMenu getMenuById(int id) throws Exception;

    String getJsonMenu() throws Exception;

    String createMenu(String accessToken) throws Exception;

    boolean isMenuExistSonMenu(Integer id) throws Exception;

    WechatMenu getMenuByMenuKey(String eventKey) throws Exception;

    List<WechatUser> getRegistUserList(String keyWord, PagerInfo pagerParam);

    int getRegistUserListCnt(String keyWord);

    void initWechatUsers() throws SQLException;

    void saveVisitTimes(Visits record) throws SQLException;

    void processRequest(Map<String, String> map);

    List<Visits> getDaylyVisitFlowList(int days);

    List<Visits> getDaylyWechatFlowList(int days);
}
