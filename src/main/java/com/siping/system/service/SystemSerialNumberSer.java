package com.siping.system.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface SystemSerialNumberSer {
	/**
	 * 所有sy_serial_num_all中的记录
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getAllSerialNum(HttpServletRequest request);
	/**
	 * 所有sy_serial_num_all中的记录条数
	 * @param request
	 * @return
	 */ 
	public int getAllSerialNumCnt(HttpServletRequest request);
	/**
	 * 增加编号规则信息到sy_serial_num_all中
	 * @param request
	 * @return
	 */
	public String addSerialNum(HttpServletRequest request) ;
	/**
	 * 从sy_serial_num_all中删除编号规则信息
	 * @param request
	 * @return
	 */
	public String deleteSerialNum(HttpServletRequest request) ;
	/**
	 * 修改serial_num并存入sy_serial_num_all中
	 * @param request
	 * @return
	 */
	public String updateSerialNum(HttpServletRequest request);
}
