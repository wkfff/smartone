package com.siping.web.utility.dao;

import java.util.List;

public interface UtilityChaInfoDao {
	@SuppressWarnings({ "rawtypes" })
	public List getChannelList(Object object);
	
	public int getChannelListCnt(Object object);	

}
