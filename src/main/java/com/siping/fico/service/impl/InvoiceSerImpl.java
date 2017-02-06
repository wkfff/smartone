package com.siping.fico.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.fico.dao.InvoiceDao;
import com.siping.fico.service.InvoiceSer;
import com.siping.web.utility.bean.ParamSearchBean;
import com.siping.web.utility.bean.ParamTransferListBean;
import com.siping.web.utility.bean.ParamTransferObjectBean;

@Service
public class InvoiceSerImpl implements InvoiceSer {

	@Autowired
	private InvoiceDao invoiceDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	public List getInvoiceList(HttpServletRequest request) {
		ParamSearchBean param = new ParamSearchBean(request);		
		try {
			return this.invoiceDao.getInvoiceList(param.getParamMap());
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getPositionList(HttpServletRequest request) {
		ParamSearchBean param = new ParamSearchBean(request);
		try {
			return this.invoiceDao.getPositionList(param.getParamMap());
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public Object getInvoiceDetail(HttpServletRequest request) {
		ParamSearchBean param = new ParamSearchBean(request);
		try {
			return this.invoiceDao.getInvoiceDetail(param.getParamMap());
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map transferInvoice(HttpServletRequest request) {
		Map resultMap = new HashMap();
		resultMap.put("RESULT", "Y");
		ParamTransferObjectBean param = new ParamTransferObjectBean(request);
		try{
			if(param.getAction() == ParamTransferObjectBean.ACTION_ADD){
				resultMap.put("INVOICE_NO", this.invoiceDao.addInvoice(param.getParamMap()));
			}
			if(param.getAction() == ParamTransferObjectBean.ACTION_UPDATE){
				this.invoiceDao.updateInvoice(param.getParamMap());
				resultMap.put("INVOICE_NO", param.getParamMap().get("INVOICE_NO"));
			}
		}catch(SQLException e){
			resultMap.put("RESULT", "N");
			resultMap.put("REASON", "未知错误");
			e.printStackTrace();
		}
		return resultMap;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map transferPositions(HttpServletRequest request) {
		Map resultMap = new HashMap();
		resultMap.put("RESULT", "Y");
		ParamTransferListBean param = new ParamTransferListBean(request);
		param.generateList();		
		try{
			if(param.hasInsertList()){
				this.invoiceDao.addPositions(param.getInsertList());
			}
			if(param.hasUpdateList()){
				this.invoiceDao.updatePositions(param.getUpdateList());
			}
		}catch(SQLException e){
			resultMap.put("RESULT", "N");
			resultMap.put("REASON", "未知错误");
			e.printStackTrace();
		}
		return resultMap;
	}

}
