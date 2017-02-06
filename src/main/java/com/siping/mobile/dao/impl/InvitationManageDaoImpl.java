package com.siping.mobile.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.mobile.dao.InvitationManageDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class InvitationManageDaoImpl extends SqlMapClientSupport implements InvitationManageDao {

	@Override
	public String addInvitationNotBind(Object object) throws Exception {
		this.insert("mobile.invitationManage.addInvitationNotBind", object);
		
		return "Y";
	}

	@Override
	public String addInvitationBind(Object object) throws Exception {
		this.insert("mobile.invitationManage.addInvitationBind", object);
		
		return "Y";
	}

	@Override
	public int getCntByCondition(Object object) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("mobile.invitationManage.getCntByCondition",
							object)), Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnInt;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getInvitationList(Object object, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"mobile.invitationManage.getInvitationList", object,
					currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}

	@Override
	public int getInvitationCnt(Object object) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("mobile.invitationManage.getInvitationCnt",
							object)), Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnInt;
	}

	@Override
	public String deleteInvitation(Object object) throws Exception {
		
		this.delete("mobile.invitationManage.deleteInvitation", object);

		return "Y";
	}
	
}
