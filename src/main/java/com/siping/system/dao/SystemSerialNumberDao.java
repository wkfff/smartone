package com.siping.system.dao;

import java.util.List;


public interface SystemSerialNumberDao {
	/**
	 * 修改serial_num并存入sy_serial_num_all
	 * @param object
	 * @return
	 */
	public String updateSerialNum(Object object) ;
	/**
	 * 获取sy_serial_num_all中所有的记录
	 * @param object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getAllSerialNum(Object object) ;
	/**
	 * 获取sy_serial_num_all中所有的记录
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getAllSerialNum(Object object,int currentPage, int pageSize);
	/**
	 * 获取sy_serial_num_all中所有的记录的条数
	 * @param object
	 * @return
	 */
	public int getAllSerialNumCnt(Object object) ;
	/**
	 * 增加流水号编号规则到sy_serial_num_all
	 * @param object
	 * @return String
	 */
	public String addSerialNum(Object object);
	/**
	 * 从sy_serial_num_all中删除流水号规则
	 * @param object
	 * @return
	 */ 
	public String deleteSerialNum(Object object);
}
