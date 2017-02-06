package com.siping.hrm.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface PositionMgtSer {
    /**
     * 获取职群信息
     */
    @SuppressWarnings({ "rawtypes" })
    public List getPostGroupInfo(HttpServletRequest request);

    /**
     * 获取职群信息
     */
    public int getPostGroupInfoCnt(HttpServletRequest request);

    /**
     * 修改职群信息
     */
    public int updatePostGroupInfo(HttpServletRequest request) throws Exception ;

    /**
     * 删除职群信息
     */
    public int deletePostGroupInfo(HttpServletRequest request);

    /**
     * 检查职群信息
     */
    public int checkPostGroupInfo(HttpServletRequest request);

    /**
     * 添加职群信息
     */
    public int addPostGroupInfo(HttpServletRequest request);

    /**
     * 获取职级信息
     */
    @SuppressWarnings({ "rawtypes" })
    public List getPostGradeInfo(HttpServletRequest request);

    /**
     * 获取职级信息
     */
    public int getPostGradeInfoCnt(HttpServletRequest request);

    /**
     * 修改职级信息
     */
    public int updatePostGradeInfo(HttpServletRequest request) throws Exception ;

    /**
     * 删除职级信息
     */
    public int deletePostGradeInfo(HttpServletRequest request);

    /**
     * 检查职级信息
     */
    public int checkPostGradeInfo(HttpServletRequest request);

    /**
     * 添加职级信息
     */
    public int addPostGradeInfo(HttpServletRequest request);

    /**
     * 获取职位岗位信息
     */
    @SuppressWarnings({ "rawtypes" })
    public List getPostInfo(HttpServletRequest request);

    /**
     * 获取职位岗位信息
     */
    public int getPostInfoCnt(HttpServletRequest request);

    /**
     * 修改职位岗位信息
     */
    public int updatePostInfo(HttpServletRequest request) throws Exception ;

    /**
     * 删除职位岗位信息
     */
    public int deletePostInfo(HttpServletRequest request);

    /**
     * 检查职位岗位信息
     */
    public int checkPostInfo(HttpServletRequest request);

    /**
     * 添加职位岗位信息
     */
    public int addPostInfo(HttpServletRequest request);

    /**
     * 获取职位岗位信息
     */
    @SuppressWarnings({ "rawtypes" })
    public List getPositionInfo(HttpServletRequest request);

    /**
     * 获取职位岗位信息
     */
    public int getPositionInfoCnt(HttpServletRequest request);

    /**
     * 修改职位岗位信息
     */
    public int updatePositionInfo(HttpServletRequest request) throws Exception ;

    /**
     * 删除职位岗位信息
     */
    public int deletePositionInfo(HttpServletRequest request);

    /**
     * 检查职位岗位信息
     */
    public int checkPositionInfo(HttpServletRequest request);

    /**
     * 添加职位岗位信息
     */
    public int addPositionInfo(HttpServletRequest request);

    @SuppressWarnings({ "rawtypes" })
    public List getPostLevelInfo(HttpServletRequest request);

    /**
     * 获取职级信息
     */
    public int getPostLevelInfoCnt(HttpServletRequest request);

    public int checkPostLevelInfo(HttpServletRequest request);

    /**
     * 添加职级信息
     */
    public int addPostLevelInfo(HttpServletRequest request);

    public int deletePostLevelInfo(HttpServletRequest request);

    public int updatePostLevelInfo(HttpServletRequest request) throws Exception;

    @SuppressWarnings({ "rawtypes" })
    public List getPostLevelDataInfo(HttpServletRequest request);

    /**
     * 获取职级信息
     */
    public int getPostLevelDataInfoCnt(HttpServletRequest request);

    public int addOrUpdatePostLevelDataInfo(HttpServletRequest request) throws Exception ;

    public int deletePostLevelDataInfo(HttpServletRequest request);
}
