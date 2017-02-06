package com.siping.report.ord.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface OrderInfoReportSer {

	void exportOrderList(HttpServletRequest request,HttpServletResponse response);

	@SuppressWarnings("rawtypes")
	List getOrderReportTitleInfo(HttpServletRequest request);

}
