package com.siping.wechat.dao.impl;

import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.siping.web.utility.SqlMapClientSupport;
import com.siping.wechat.bean.PagerRequest;
import com.siping.wechat.bean.Visits;
import com.siping.wechat.bean.WechatMenu;
import com.siping.wechat.bean.WechatUser;
import com.siping.wechat.dao.WechatDao;

@Repository
public class WechatDaoImpl extends SqlMapClientSupport implements WechatDao{

    @Override
    public void addWechatMenu(WechatMenu menu) throws Exception {
        this.insert("wechat.addWechatMenu", menu);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<WechatMenu> getWechatMenuList() throws Exception {
        return this.queryForList("wechat.getWechatMenuList");
    }

    @Override
    public void deleteMenu(int id) throws Exception {
        this.delete("wechat.deleteMenu", id);
    }

    @Override
    public void updateMenu(WechatMenu menu) throws Exception {
        this.update("wechat.updateMenu", menu);
    }

    @Override
    public void updateMenuName(WechatMenu menu) throws Exception {
        this.update("wechat.updateMenuName", menu);
    }

    @Override
    public int menuKeyIsExist(Map<String,Object> map) throws Exception {
        return (Integer) this.queryForObject("wechat.menuKeyIsExist", map);
    }

    @Override
    public WechatMenu getMenuById(int id) throws Exception {
        return (WechatMenu) this.queryForObject("wechat.getMenuById", id);
    }

    @Override
    public int isMenuExistSonMenu(Integer id) throws Exception {
        return (Integer) this.queryForObject("wechat.isMenuExistSonMenu", id);
    }

    @Override
    public WechatMenu getMenuByMenuKey(String eventKey) throws Exception {
        return (WechatMenu) this.queryForObject("wechat.getMenuByMenuKey", eventKey);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<WechatUser> getRegistUserList(PagerRequest pr) {
        List<WechatUser> adminList = null;
        try {
            adminList = this.queryForList("wechat.getRegistUserList", pr.getParams(), pr.getPagerInfo().getPage(), pr.getPagerInfo().getSize());
        } catch (SQLException e) {
            logger.error("获取注册用户列表出错");
            e.printStackTrace();
        }
        return adminList;
    }

    @Override
    public int getRegistUserListCnt(LinkedHashMap<String, Object> params) {
        int cnt = 0;
        try {
            cnt = (Integer) this.queryForObject("wechat.getRegistUserListCnt", params);
        } catch (SQLException e) {
            logger.error("获取注册用户数量出错");
            e.printStackTrace();
        }
        return cnt;
    }

    @Override
    public void insertWechatUser(WechatUser user) throws SQLException {
        this.insert("wechat.insertWechatUser", user);
    }

    @Override
    public WechatUser getWechatUser(WechatUser user) {
        WechatUser info = null;
        try{
            info =(WechatUser) this.queryForObject("wechat.getWechatUser", user);
        }catch(SQLException e){
            e.printStackTrace();
        }
        return info;
    }

    @Override
    public void insertDayTimes(Visits record) throws SQLException {
        this.insert("wechat.insertDayTimes", record);
    }

    @Override
    public void updateWechatUser(WechatUser newUser) throws SQLException {
        this.update("wechat.updateWechatUser", newUser);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Visits> getDaylyVisitFlowList(int days) {
        List<Visits> visitList = null;
        try {
            visitList = (List<Visits>) this.queryForList("wechat.getDaylyFlowList",days);
        } catch (Exception e) {
            logger.error("获取访问流量出错");
            e.printStackTrace();
        }
        return visitList;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Visits> getDaylyWechatFlowList(int days) {
        List<Visits> wechatList = null;
        try {
            wechatList = (List<Visits>) this.queryForList("wechat.getDaylyWechatFlowList",days);
        } catch (SQLException e) {
            logger.error("获取微信关注人数");
            e.printStackTrace();
        }
        return wechatList;
    }

}
