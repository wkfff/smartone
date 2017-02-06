package com.siping.report.ord.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.siping.report.ord.service.OrderInfoReportSer;

@Controller
@RequestMapping(value="/report/ord")
public class OrderInfoReportCtroller {
	
	@Autowired
	private OrderInfoReportSer orderInfoReportSer;
	
	@RequestMapping(value="/exportOrderList")
	public void exportOrderList(HttpServletRequest request,HttpServletResponse response){
		this.orderInfoReportSer.exportOrderList(request, response);
		}
	
	}
