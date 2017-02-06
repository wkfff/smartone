package com.siping.ess.service;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List; 
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

public interface InfoAppSer {

	@SuppressWarnings("rawtypes")
	public Map addPersonalInfoApp(HttpServletRequest request);
	/**
	 * 加班申请
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map addOvertimeApp(HttpServletRequest request);
	/**
	 * 加班申请
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map addBTApp(HttpServletRequest request);
	/**
	 * 加班申请
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map addCardtimeApp(HttpServletRequest request);
	/**
	 * 添加休假
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map addLeaveApp(HttpServletRequest request);
	/**
	 * 添加费用
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map addExpApp(HttpServletRequest request);
	/**
	 * 添加培训
	 * @param request
	 * @return
	 */
	public boolean addTrainingApp(HttpServletRequest request);
	/**
	 * 添加培训
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getAffirmorList(HttpServletRequest request); 
	/**
	 * 班次信息
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getEmpShift(HttpServletRequest request);
	/**
	 * 剩余年假
	 * @param request
	 * @param modelMap
	 * @return
	 */
	public double getEmpVacationRema10(HttpServletRequest request);
	/**
	 * 剩余福利年假
	 * @param request
	 * @param modelMap
	 * @return
	 */
	public double getEmpVacationRema30(HttpServletRequest request);
	
	public String updateProInfo(HttpServletRequest request);
	
	public String addProInfo(HttpServletRequest request);
	
	public String addProMemberInfo(HttpServletRequest request);
	
	public boolean isWhManager(HttpServletRequest request);
	
	@SuppressWarnings("rawtypes")
	public Map saveWorkingHoursInfo(HttpServletRequest request);
	
	@SuppressWarnings("rawtypes")
	public Map updateWorkingHoursInfo(HttpServletRequest request);

	public String getWhCalendarInfoHtml(HttpServletRequest request) ;
	
	@SuppressWarnings("rawtypes")
	public Map addToolApp(HttpServletRequest request);
	
	@SuppressWarnings("rawtypes")
	public Map addToolAppAss(HttpServletRequest request);
	
	@SuppressWarnings("rawtypes")
	public List getToolLoan(HttpServletRequest request);
	
	@SuppressWarnings("rawtypes")
	public List getCompanyCalendarInfo(HttpServletRequest request);
	/**
	 * 电焊、装配工人报工
	 * @param request
	 * @return
	 */
	public Map transferWorkingHoursInfo(HttpServletRequest request);
	/**
	 * 下料工人报工
	 * @param request
	 * @return
	 */
	public String transferWorkingHoursInfoOther(HttpServletRequest request);
	
	public Object getWhDetail(HttpServletRequest request);
	/**
	 * 增加生产订单
	 * @param request
	 * @return
	 */
	public String addProductionOrderInfo(HttpServletRequest request) ;
	/**
	 * 修改项目下生产订单
	 * @param request
	 * @return
	 */
	public String updateProductionOrderInfo(HttpServletRequest request);
	/**
	 * 删除项目下生产订单
	 * @param request
	 * @return
	 */
	public String deleteProductionOrderInfo(HttpServletRequest request);

	/**
	 * 导入生产订单Excel
	 * @param file
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 * @throws ParseException
	 */
	public String uploadProductionOrder(MultipartFile file,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, ParseException;
	/**
	 * 下载生产订单模板
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	public void downloadProductionOrderTemplate(HttpServletRequest request, HttpServletResponse response) throws IOException;
	public void calculateWhConclusion(HttpServletRequest request) throws SQLException;
    @SuppressWarnings("rawtypes")
    public List getWhConclusionList(HttpServletRequest request);

    public int getWhConclusionListCnt(HttpServletRequest request);
}
