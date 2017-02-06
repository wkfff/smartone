package com.siping.wechat.dao;

import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.siping.wechat.bean.PagerRequest;
import com.siping.wechat.bean.Visits;
import com.siping.wechat.bean.WechatMenu;
import com.siping.wechat.bean.WechatUser;

public interface WechatDao {

    void addWechatMenu(WechatMenu menu) throws Exception;

    List<WechatMenu> getWechatMenuList() throws Exception;

    void deleteMenu(int id) throws Exception;

    void updateMenu(WechatMenu menu) throws Exception;

    void updateMenuName(WechatMenu menu) throws Exception;

    int menuKeyIsExist(Map<String,Object> map) throws Exception;

    WechatMenu getMenuById(int id) throws Exception;

    int isMenuExistSonMenu(Integer id) throws Exception;

    WechatMenu getMenuByMenuKey(String eventKey) throws Exception;

    List<WechatUser> getRegistUserList(PagerRequest pr);

    int getRegistUserListCnt(LinkedHashMap<String, Object> params);

    void insertWechatUser(WechatUser user) throws SQLException;

    WechatUser getWechatUser(WechatUser user);

    void insertDayTimes(Visits record) throws SQLException;

    void updateWechatUser(WechatUser newUser) throws SQLException;

    List<Visits> getDaylyVisitFlowList(int days);

    List<Visits> getDaylyWechatFlowList(int days);
}
