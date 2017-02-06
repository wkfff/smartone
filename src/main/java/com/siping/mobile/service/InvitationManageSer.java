package com.siping.mobile.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;


public interface InvitationManageSer {
	/**
	 * 生成邀请码
	 * @return
	 */
	public String generateInvitation();
	/**
	 * 添加邀请码入数据库
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public String addInvitation(HttpServletRequest request) throws Exception;
	/**
	 * 依据条件（CUST_NO、INVITATION_ID）获取表中记录条数
	 * @param request
	 * @return
	 */
	public int getCntByCondition(HttpServletRequest request);
	/**
	 * 依据条件获取mobile_invitation表中记录
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getInvitationList(HttpServletRequest request);
	/**
	 * 依据条件获取mobile_invitation表中记录条数
	 * @param request
	 * @return
	 */
	public int getInvitationCnt(HttpServletRequest request) ;
	/**
	 * 删除指定的邀请码
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public String deleteInvitation(HttpServletRequest request) throws Exception;
}
