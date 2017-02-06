package com.siping.web.utility.dao;

import java.util.List;

public interface UtilityCustInfoDao {

	int getCustomerListCnt(Object object);

	@SuppressWarnings("rawtypes")
	List getCustomerList(Object object);

}
