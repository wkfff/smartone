package com.siping.cust.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.siping.cust.bean.Action;
import com.siping.cust.dao.CustActionDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class CustActionDaoImpl extends SqlMapClientSupport implements CustActionDao {

	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getCustomerActionList(Object object) {
		List list = new ArrayList();		
		try {
			list = this.queryForList("cust.custAction.getCustomerActionList",object,
					Integer.parseInt(((Map)object).get("page").toString()),
					Integer.parseInt(((Map)object).get("pagesize").toString()));
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int getCustomerActionListCnt(Object object) {
		int temp = 0;		
		try {
			temp = Integer.parseInt(this.queryForObject("cust.custAction.getCustomerActionListCnt",object).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}
	
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getSimpleCustomerActionList(Object object) {
		List list = new ArrayList();		
		try {
			list = this.queryForList("cust.custAction.getSimpleCustomerActionList",Integer.parseInt( ((Map)object).get("CUST_ID").toString()),
					Integer.parseInt(((Map)object).get("page").toString()),
					Integer.parseInt(((Map)object).get("pagesize").toString()));
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int getSimpleCustomerActionListCnt(Object object) {
		int temp = 0;		
		try {
			temp = Integer.parseInt(this.queryForObject("cust.custAction.getSimpleCustomerActionListCnt",object).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public void addCustomerAction(List object) throws SQLException {
		this.updateForList("cust.custAction.addCustomerAction", object);
	}

	@Override
	public void addCustomerAction(Object object) throws SQLException {
		this.update("cust.custAction.addCustomerAction", object);
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public void updateCustomerAction(List object) throws SQLException {
		this.updateForList("cust.custAction.updateCustomerAction", object);
	}

	@Override
	public void removeCustomerAction(Object object) throws SQLException {
		this.update("cust.custAction.removeCustomerAction", object);
	}

    @Override
    public void saveAction(Action action) throws SQLException {
        try {
            this.insert("cust.custAction.saveAction", action);
        } catch (Exception e) {
             
            e.printStackTrace();
        }
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List<Action> getActionByCustId(Object object) throws SQLException {
        List actionList=new ArrayList();
        actionList = this.queryForList("cust.custAction.getActionByCustId",object,
                Integer.parseInt(((Map)object).get("page").toString()),
                Integer.parseInt(((Map)object).get("pagesize").toString()));
        return actionList;
    }

    @Override
    public void updateAction(Action action) throws SQLException {
            this.update("cust.custAction.updateAction",action);
    }

    @Override
    public void deleteAction(String custActionNo) throws SQLException {
        try {
            this.delete("cust.custAction.deleteAction", custActionNo);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void changeActionState(Action action) throws SQLException {
        try {
            this.update("cust.custAction.changeActionState", action);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public int getCountByCustId(Object object) throws SQLException {
        return (Integer) this.queryForObject("cust.custAction.getCountByCustId", object);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List<Action> getCustActionByCondition(Object object) throws SQLException {
        List<Action> actionList=new ArrayList();;
        try {
            actionList = this.queryForList("cust.custAction.getCustActionByCondition",object);
        } catch (Exception e) {
             
            e.printStackTrace();
        }
        return actionList;
    }

    @Override
    public Action getActionById(int custActionNo) throws SQLException {
        Action action=(Action) this.queryForObject("cust.custAction.getActionById", custActionNo);
        return action;
    }
	
}
