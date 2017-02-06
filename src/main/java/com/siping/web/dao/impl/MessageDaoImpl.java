package com.siping.web.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.web.bean.Message;
import com.siping.web.dao.MessageDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class MessageDaoImpl extends SqlMapClientSupport implements MessageDao {

    @Override
    public String addMessageInfo(Object object) {
        String returnInt = "Y";
        try {
            this.insert("message.messageManage.addMessageInfo", object);
        } catch (SQLException e) {
            returnInt = e.getMessage();
            e.printStackTrace();
        } catch (Exception e) {
            returnInt = e.getMessage();
            e.printStackTrace();
        }
        return returnInt;
    }

	@SuppressWarnings("unchecked")
	@Override
	public List<Message> getMessageList(Object object) {
		List<Message> list = new ArrayList<Message>();
        try {
            list = this.queryForList("message.messageManage.getMessageList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Message> getMessageList(Object object, int currentPage, int pageSize) {
		List<Message> list = new ArrayList<Message>();
        try {
            list = this.queryForList("message.messageManage.getMessageList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}

	@Override
	public int getMessageListCnt(Object object) {
		int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("message.messageManage.getMessageListCnt", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public String addMessageEmp(List objectList) {
		String resultString = "Y";
		try {
			this.insertForList("message.messageManage.addMessageEmp", objectList) ;
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		} catch (Exception e) {	
			e.printStackTrace();
			resultString = e.getMessage();
		}
		
		return resultString ;
	}
	
	@Override
	public String addMessageEmp(Object obj) {
		String resultString = "Y";
		try {
			this.insert("message.messageManage.addMessageEmp", obj) ;
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		} catch (Exception e) {	
			e.printStackTrace();
			resultString = e.getMessage();
		}
		
		return resultString ;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Message> getMyMessageList(Object object) {
		List<Message> list = new ArrayList<Message>();
        try {
            list = this.queryForList("message.messageManage.getMyMessageList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Message> getMyMessageList(Object object, int currentPage, int pageSize) {
		List<Message> list = new ArrayList<Message>();
        try {
            list = this.queryForList("message.messageManage.getMyMessageList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}

	@Override
	public int getMyMessageListCnt(Object object) {
		int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("message.messageManage.getMyMessageListCnt", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public String addReadMessage(List objectList) {
		String result = "Y";
        try {
            this.insertForList("message.messageManage.addReadMessage",objectList);
        } catch (SQLException e) {
            e.printStackTrace();
            result = e.getMessage();
        }
        return result;
	}
	
	@Override
	public String deleteMessage(Object obj) {
		String result = "Y";
        try {
            this.delete("message.messageManage.deleteMessage",obj);
        } catch (SQLException e) {
            e.printStackTrace();
            result = e.getMessage();
        }
        return result;
	}
}
