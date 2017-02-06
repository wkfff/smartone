package com.siping.hrm.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;
import com.siping.hrm.dao.PositionMgtDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class PositionMgtDaoImpl extends SqlMapClientSupport implements PositionMgtDao {
    /**
     * 获取职群信息
     * @param List
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getPostGroupInfo(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.position.getPostGroupInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 获取职群信息
     * @param List
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getPostGroupInfo(Object obj, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.position.getPostGroupInfo", obj, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 获取职群信息
     * @param Object
     * @return
     */
    public int getPostGroupInfoCnt(Object obj) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.position.getPostGroupInfoCnt", obj)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 添加职群信息
     * @param Object
     * @return
     */
    public int addPostGroupInfo(Object obj) {
        try {
            this.insert("hrm.position.addPostGroupInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * 检查职群信息
     * @param Object
     * @return
     */
    @SuppressWarnings("rawtypes")
    public int checkPostGroupInfo(Object obj) {
        int i = 0;
        try {
            List list = this.queryForList("hrm.position.checkPostGroupInfo", obj);
            i = list.size();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return i;
    }

    /**
     * 更新职群信息
     * @param Object
     * @return
     */
    @SuppressWarnings("rawtypes")
    public int updatePostGroupInfo(List list) throws Exception {
        this.updateForList("hrm.position.updatePostGroupInfo", list);
        return 1;
    }

    /**
     * 删除职群信息
     * @param Object
     * @return
     */
    public int deletePostGroupInfo(Object obj) {
        try {
            this.delete("hrm.position.deletePostGroupInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * 获取职级信息
     * @param List
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getPostGradeInfo(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.position.getPostGradeInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 获取职级信息
     * @param List
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getPostGradeInfo(Object obj, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.position.getPostGradeInfo", obj, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 获取职级信息
     * @param Object
     * @return
     */
    public int getPostGradeInfoCnt(Object obj) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.position.getPostGradeInfoCnt", obj)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 添加职级信息
     * @param Object
     * @return
     */
    public int addPostGradeInfo(Object obj) {
        try {
            this.update("hrm.position.addPostGradeInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * 检查职级信息
     * @param Object
     * @return
     */
    @SuppressWarnings("rawtypes")
    public int checkPostGradeInfo(Object obj) {
        int i = 0;
        try {
            List list = this.queryForList("hrm.position.checkPostGradeInfo", obj);
            i = list.size();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return i;
    }

    /**
     * 更新职级信息
     * @param Object
     * @return
     * @throws Exception 
     */
    @SuppressWarnings("rawtypes")
    public int updatePostGradeInfo(List list) throws Exception {
        this.updateForList("hrm.position.updatePostGradeInfo", list);
        return 0;
    }

    /**
     * 删除职级信息
     * @param Object
     * @return
     */
    public int deletePostGradeInfo(Object obj) {
        try {
            this.delete("hrm.position.deletePostGradeInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * 职位信息
     * @param object
     * @return
     */
    @SuppressWarnings("rawtypes")
    public Map getPostInfoObj(Object obj) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        try {
            returnMap = (Map) this.queryForObject("hrm.position.getPostInfoObj", obj);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnMap;
    }

    /**
     * 获取职位岗位信息
     * @param List
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getPostInfo(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.position.getPostInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 获取职位岗位信息
     * @param List
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getPostInfo(Object obj, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.position.getPostInfo", obj, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 获取职位岗位信息
     * @param Object
     * @return
     */
    public int getPostInfoCnt(Object obj) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.position.getPostInfoCnt", obj)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 添加职位岗位信息
     * @param Object
     * @return
     */
    public int addPostInfo(Object obj) {
        try {
            this.update("hrm.position.addPostInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * 检查职位岗位信息
     * @param Object
     * @return
     */
    @SuppressWarnings("rawtypes")
    public int checkPostInfo(Object obj) {
        int i = 0;
        try {
            List list = this.queryForList("hrm.position.checkPostInfo", obj);
            i = list.size();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return i;
    }

    /**
     * 更新职位岗位信息
     * @param Object
     * @return
     */
    @SuppressWarnings("rawtypes")
    public int updatePostInfo(List list) throws Exception {
        this.updateForList("hrm.position.updatePostInfo", list);
        return 1;
    }

    /**
     * 删除职位岗位信息
     * @param Object
     * @return
     */
    public int deletePostInfo(Object obj) {
        try {
            this.delete("hrm.position.deletePostInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * 获取职务信息
     * @param List
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getPositionInfo(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.position.getPositionInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 获取职务信息
     * @param List
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getPositionInfo(Object obj, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.position.getPositionInfo", obj, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 获取职务信息
     * @param Object
     * @return
     */
    public int getPositionInfoCnt(Object obj) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.position.getPositionInfoCnt", obj)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 添加职务信息
     * @param Object
     * @return
     */
    public int addPositionInfo(Object obj) {
        try {
            this.update("hrm.position.addPositionInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * 检查职务信息
     * @param Object
     * @return
     */
    @SuppressWarnings("rawtypes")
    public int checkPositionInfo(Object obj) {
        int i = 0;
        try {
            List list = this.queryForList("hrm.position.checkPositionInfo", obj);
            i = list.size();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return i;
    }

    /**
     * 更新职务信息
     * @param Object
     * @return
     * @throws Exception 
     */
    @SuppressWarnings("rawtypes")
    public int updatePositionInfo(List list) throws Exception {
        this.updateForList("hrm.position.updatePositionInfo", list);
        return 1;
    }

    /**
     * 删除职务信息
     * @param Object
     * @return
     */
    public int deletePositionInfo(Object obj) {
        try {
            this.delete("hrm.position.deletePositionInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * 获得职级下拉列表
     */
    @SuppressWarnings({ "rawtypes" })
    public List getPostGradeSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("hrm.position.getPostGradeSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得职列下拉列表
     */
    @SuppressWarnings({ "rawtypes" })
    public List getPostColumnSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("hrm.position.getPostColumnSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得职群下拉列表
     */
    @SuppressWarnings({ "rawtypes" })
    public List getPostGroupSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("hrm.position.getPostGroupSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    /**
     * 获得职位下拉列表
     */
    @SuppressWarnings({ "rawtypes" })
    public List getPostSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("hrm.position.getPostSelectList", object);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getPostLevelInfo(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.position.getPostLevelInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getPostLevelInfo(Object obj, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.position.getPostLevelInfo", obj, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getPostLevelInfoCnt(Object obj) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.position.getPostLevelInfoCnt", obj)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnInt;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int checkPostLevelInfo(Object obj) {
        int i = 0;
        try {
            List list = this.queryForList("hrm.position.checkPostLevelInfo", obj);
            i = list.size();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return i;
    }

    @Override
    public int addPostLevelInfo(Object obj) {
        try {
            this.update("hrm.position.addPostLevelInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    @Override
    public int deletePostLevelInfo(Object obj) {
        try {
            this.delete("hrm.position.deletePostLevelInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int updatePostLevelInfo(List list) throws Exception {
        this.updateForList("hrm.position.updatePostLevelInfo", list);
        return 0;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getPostLevelDataInfo(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.position.getPostLevelDataInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getPostLevelDataInfo(Object obj, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("hrm.position.getPostLevelDataInfo", obj, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getPostLevelDataInfoCnt(Object obj) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("hrm.position.getPostLevelDataInfoCnt", obj)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnInt;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int addPostLevelDataInfo(List object) throws Exception {
        this.insertForList("hrm.position.addPostLevelDataInfo", object);
        return 1;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int updatePostLevelDataInfo(List object) throws Exception {
        this.updateForList("hrm.position.updatePostLevelDataInfo", object);
        return 1;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int deletePostLevelDataInfo(List list) {
        try {
            this.startTransaction();
            this.deleteForList("hrm.position.deletePostLevelDataInfo", list);
            this.commitTransation();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                this.endTransation();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return 0;
    }
}
