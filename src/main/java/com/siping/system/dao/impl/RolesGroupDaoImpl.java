package com.siping.system.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.system.dao.RolesGroupDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class RolesGroupDaoImpl extends SqlMapClientSupport implements RolesGroupDao {
    /**
     * 取得权限信息
     * @param obj
     * @return
     */
    @SuppressWarnings("rawtypes")
    public Map getRolesGroupInfoObj(Object obj) {
        Map returnMap = null;
        try {
            returnMap = (Map) this.queryForObject("system.rolesGroup.getRolesGroupInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnMap;
    }

    /**
     * 取得权限信息
     * @param obj
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getMenuSelectList(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("system.rolesGroup.getMenuSelectList", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    /**
     * 取得权限信息
     * @param obj
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getRolesGroupInfo(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("system.rolesGroup.getRolesGroupInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    /**
     * 取得所有权限组列表
     * @param obj
     * @param currentPage
     * @param pageSize
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getRolesGroupInfo(Object obj, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("system.rolesGroup.getRolesGroupInfo", obj, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    /**
     * 取得所有权限组列表
     * @param obj
     * @return
     */
    public int getRolesGroupInfoCnt(Object obj) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("system.rolesGroup.getRolesGroupInfoCnt", obj)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnInt;
    }

    /**
     * 取得权限组ID
     * @param obj
     * @return
     */
    public int getRolesGroupID(Object obj) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("system.rolesGroup.getRolesGroupID", obj)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnInt;
    }

    /**
     * 插入权限组信息
     * @param obj
     * @return
     */
    @SuppressWarnings("rawtypes")
    public int addRolesGroupInfo(Object obj) {
        try {
            this.startTransaction();
            Map paraMap = (Map) obj;
            if (paraMap.get("MENU_NO").toString().equals("") || paraMap.get("MENU_NO").toString() == null) {
                this.insert("system.rolesGroup.addRolesGroupInfo", obj);
            } else {
                this.insert("system.rolesGroup.addRolesGroupPageInfo", obj);
                this.update("system.rolesGroup.updateRolesGroupPageInfo", obj);
            }
            this.commitTransation();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                this.endTransation();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return 0;
    }

    /**
     * 批量插入权限组信息
     * @param obj
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public int addRolesGroupInfo(List obj) {

        try {
            this.insertForList("system.rolesGroup.addRolesGroupInfo", obj);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * 更新权限组信息
     * @param obj
     * @return
     */
    public int updateRolesGroupInfo(Object obj) {
        try {
            this.startTransaction();
            /* 更新角色基本信息 */
            //this.update("system.rolesGroup.updateRolesGroupInfo", obj);

            //this.insert("system.rolesGroup.addRolesGroupPageInfo", obj);

            this.update("system.rolesGroup.updateRolesGroupPageInfo", obj);

            this.commitTransation();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                this.endTransation();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return 0;
    }

    /**
     * 批量更新权限组信息
     * @param obj
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public int updateRolesGroupInfo(List obj) {

        try {
            this.updateForList("system.rolesGroup.updateRolesGroupInfo", obj);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * 删除权限组信息
     * @param obj
     * @return
     */
    public int deleteRolesGroupInfo(Object obj) {
        try {
            this.startTransaction();

            this.delete("system.rolesGroup.deleteRolesGroupPageInfo", obj);

            this.delete("system.rolesGroup.deleteRolesGroupInfo", obj);

            this.commitTransation();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                this.endTransation();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return 0;
    }

    /**
     * 批量删除权限组信息
     * @param obj
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public int deleteRolesGroupInfo(List obj) {

        try {
            this.startTransaction();

            this.deleteForList("system.rolesGroup.deleteRolesGroupPageInfo", obj);

            this.deleteForList("system.rolesGroup.deleteRolesGroupInfo", obj);

            this.commitTransation();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                this.endTransation();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return 0;
    }

    /**
     * 取得所有页面信息列表
     * @param obj
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getRolesGroupPageInfo(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("system.rolesGroup.getRolesGroupPageInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 取得所有页面信息列表
     * @param obj
     * @param currentPage
     * @param pageSize
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getRolesGroupPageInfo(Object obj, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("system.rolesGroup.getRolesGroupPageInfo", obj, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 取得所有页面信息列表
     * @param obj
     * @return
     */
    public int getRolesGroupPageInfoCnt(Object obj) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("system.rolesGroup.getRolesGroupPageInfoCnt", obj)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnInt;
    }

    /**
     * 取得所有系统菜单列表
     * @param List
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getSystemMenuInfo(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("system.rolesGroup.getSystemMenuInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 取得所有系统菜单列表
     * @param List
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getSystemMenuInfo(Object obj, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("system.rolesGroup.getSystemMenuInfo", obj, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 取得所有系统菜单列表
     * @param List
     * @return
     */
    public int getSystemMenuInfoCnt(Object obj) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("system.rolesGroup.getSystemMenuInfoCnt", obj)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnInt;
    }
}
