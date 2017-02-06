package com.siping.mobile.dao;

import java.util.List;

public interface InvitationManageDao {
	/**
	 * 添加邀请码，但不绑定客户
	 * @param object
	 * @return
	 * @throws Exception
	 */
	public String addInvitationNotBind(Object object) throws Exception;
	/**
	 * 添加邀请码并绑定客户
	 * @param object
	 * @return
	 * @throws Exception
	 */
	public String addInvitationBind(Object object) throws Exception;
	/**
	 * 依据不同条件(CUST_NO,INVITATION_ID)，获取记录数
	 * @param object
	 * @return
	 */
	public int getCntByCondition(Object object);
	/**
	 * 依据不同条件查询mobile_invitation，并分页
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getInvitationList(Object object, int currentPage,int pageSize);
	/**
	 * 依据不同条件查询mobile_invitation，获取记录数
	 * @param object
	 * @return
	 */
	public int getInvitationCnt(Object object);
	/**
	 * 删除指定的邀请码
	 * @param object
	 * @return
	 * @throws Exception
	 */
	public String deleteInvitation(Object object) throws Exception;
}
