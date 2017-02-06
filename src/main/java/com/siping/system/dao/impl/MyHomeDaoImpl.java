package com.siping.system.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.system.dao.MyHomeDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class MyHomeDaoImpl extends SqlMapClientSupport implements MyHomeDao{	

	@SuppressWarnings({ "rawtypes" })
	public void deleteModel(List list) {
		try {
			this.deleteForList("system.myhome.deleteModel", list);
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@SuppressWarnings({ "rawtypes" })
	public void insertModel(List list) {
		try {
			this.insertForList("system.myhome.insertModel", list);
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@SuppressWarnings({ "rawtypes" })
	public List getModel(Object object) {
		List temp=new ArrayList();
		try {
			temp = this.queryForList("system.myhome.getModel", object);
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return temp;
	}

	@SuppressWarnings({ "rawtypes" })
	public List getHomePurview(Object object) {
		List temp=new ArrayList();
		try {
			temp = this.queryForList("system.myhome.getHomePurview", object);
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return temp;
	}

	public Object getHomePage(Object object) {
		Object temp="";
		try {
			temp = this.queryForObject("system.myhome.getHomePage", object);
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return temp;
	}
	
	public void updateApp(Object object) {
		try {
			this.update("system.myhome.updateApp", object);
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}	 	
	}

	public void deletePage(Object object) {
		try {
			this.update("system.myhome.deletePage", object);
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public void updatePage(Object object) {
		try {
			this.update("system.myhome.updatePage", object);
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@SuppressWarnings({ "rawtypes" })
	public List getSyMenu(Object object) {
		List temp=new ArrayList();
		try {
			temp = this.queryForList("system.myhome.getSyMenu", object);
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return temp;
	}

	@SuppressWarnings({ "rawtypes" })
	public void deleteShort(List list) {
		try {
			this.deleteForList("system.myhome.deleteShort", list);
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@SuppressWarnings({ "rawtypes" })
	public void insertShort(List list) {
		try {
			this.deleteForList("system.myhome.insertShort", list);
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@SuppressWarnings({ "rawtypes" })
	public List getShortInfo(Object object) {
		List temp=new ArrayList();
		try {
			temp = this.queryForList("system.myhome.getShort", object);
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return temp;
	}
	@SuppressWarnings({ "rawtypes" })
	public List getShort(Object object) {
		List temp=new ArrayList();
		try {
			temp = this.queryForList("system.myhome.getShort", object);
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return temp;
	}
	@SuppressWarnings({ "rawtypes" })
	public List getShort(Object object, int currentPage, int pageSize) {
		List temp=new ArrayList();
		try {
			temp = this.queryForList("system.myhome.getShort", object, currentPage,
					pageSize);
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return temp;
	}
	@Override
	public int getShortCnt(Object obj) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("system.myhome.getShortCnt",
							obj)), Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnInt;
	}
	@Override
	public int addShortcutInfo(Object obj) {
		int returnInt = 0;
		try {
			this.update("system.myhome.insertShort", obj); 
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnInt;
	} 
	@Override
	public int deleteShortcutInfo(Object obj) {
		int returnInt = 0;
		try {
			this.delete("system.myhome.deleteShort", obj); 
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnInt;
	} 
	
	@SuppressWarnings({ "rawtypes" })
	public List getApp(Object object) {
		List temp=new ArrayList();
		LinkedHashMap paramMap = (LinkedHashMap) object;
		try {
			temp = this.queryForList("system.myhome."+paramMap.get("listType"), object);
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return temp;
	}
	@SuppressWarnings({ "rawtypes" })
	public List getApp(Object object, int currentPage, int pageSize) {
		List temp=new ArrayList();
		LinkedHashMap paramMap = (LinkedHashMap) object;
		try {
			temp = this.queryForList("system.myhome."+paramMap.get("listType"), object, currentPage,
					pageSize);
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return temp;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public int getAppCnt(Object object) {
		int returnInt = 0;
		LinkedHashMap paramMap = (LinkedHashMap) object;
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("system.myhome."+paramMap.get("cntType"),
							object)), Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnInt;
	}
	@SuppressWarnings({ "rawtypes" })
	public List getTipsMenu(Object object) {
		List temp=new ArrayList();
		try {
			temp = this.queryForList("system.myhome.getTipsMenu", object);
		} catch (SQLException e) {			
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return temp;
	}

	public int getTipsCnt(String sm,Object object) {
		int num = 0;
		try {
			num = (Integer) this.queryForObject("system.myhome."+sm, object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return num;
	}

}
