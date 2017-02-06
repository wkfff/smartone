package com.siping.hrm.dao;

import java.util.List;
import java.util.Map;

public interface EmpInfoDao {
	 
	@SuppressWarnings({ "rawtypes" })
	public List getEmpList(Object object);

	public int getEmpCnt(Object object);

	public Object getBasicInfo(Object object);

	public Object getPersonalInfo(Object object);
	 
	public String updateEmpInfo(Object object) ;
   
	@SuppressWarnings({ "rawtypes" })
	public List getPaEmpInfoList(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getPaEmpInfoList(Object object);
	 
	public int getPaEmpInfoCnt(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public Map getSinfoForGrid(Object object, int currentPage, int pageSize);
 
	
	/**
	 * 担当业务
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getBizInfoList(Object object, int currentPage,
			int pageSize);

	@SuppressWarnings({ "rawtypes" })
	public List getBizInfoList(Object object);
	 
	public int getBizInfoCnt(Object object);
	 
	public Object getHealthInfo(Object object);
	/**
	 * 健康信息
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getHealthInfoList(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getHealthInfoList(Object object);
	 
	public int getHealthInfoCnt(Object object);
 
	public String addHealthInfo(Object object);

	public String updateHealthInfo(Object object);

	public String deleteHealthInfo(Object object);
	/**
	 * 工作经历信息
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */ 
	public Object getWorkExperienceInfo(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getWorkExperienceInfoList(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getWorkExperienceInfoList(Object object);
	 
	public int getWorkExperienceInfoCnt(Object object);
	   
	public String addWorkExperienceInfo(Object object) ;
 
	public String updateWorkExperienceInfo(Object object) ;

	public String deleteWorkExperienceInfo(Object object) ;
	/**
	 * 教育信息
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */ 
	public Object getEduInfo(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getEduInfoList(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getEduInfoList(Object object);
	 
	public int getEduInfoCnt(Object object);
	   
	public String addEduInfo(Object object) ;
 
	public String updateEduInfo(Object object) ;

	public String deleteEduInfo(Object object) ;
	/**
	 * 证件信息
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */ 
	public Object getDocInfo(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getDocInfoList(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getDocInfoList(Object object);
	 
	public int getDocInfoCnt(Object object);
	   
	public String addDocInfo(Object object) ;
 
	public String updateDocInfo(Object object) ;
	
	public String deleteDocInfo(Object object) ;
	@SuppressWarnings({ "rawtypes" })
	public Map getAppendInfoForGrid(Object object, int currentPage,
			int pageSize);
  
	@SuppressWarnings({ "rawtypes" })
	public List getResignInfoList(Object object, int currentPage, int pageSize);

	@SuppressWarnings({ "rawtypes" })
	public List getResignInfoList(Object object);

	public int getResignInfoCnt(Object object);   
	
	@SuppressWarnings({ "rawtypes" })
	public Map getEvaluateForGrid(Object object, int currentPage, int pageSize);

	@SuppressWarnings({ "rawtypes" })
	public Map getEvalForGrid(Object object, int currentPage, int pageSize);
  
	@SuppressWarnings({ "rawtypes" })
	public List getExpInsideInfoList(Object object, int currentPage, int pageSize);

	@SuppressWarnings({ "rawtypes" })
	public List getExpInsideInfoList(Object object);

	public int getExpInsideInfoCnt(Object object);
	/**
	 * 社会关系信息
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getFamilyInfoList(Object object, int currentPage,
			int pageSize);
	   
	@SuppressWarnings({ "rawtypes" })
	public List getFamilyInfoList(Object object);
	 
	public int getFamilyInfoCnt(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getEmergencyContactInfoList(Object object, int currentPage,
			int pageSize);
	   
	@SuppressWarnings({ "rawtypes" })
	public List getEmergencyContactInfoList(Object object);
	 
	public int getEmergencyContactInfoCnt(Object object);
	      
	@SuppressWarnings({ "rawtypes" })
	public List getPunishMentInfoList(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getPunishMentInfoList(Object object);
	 
	public int getPunishMentInfoCnt(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getRewardInfoList(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getRewardInfoList(Object object);
	 
	public int getRewardInfoCnt(Object object);
	/**
	 * 社外培训信息
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */ 
	public Object getTrainingInfo(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getTrainingInfoList(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getTrainingInfoList(Object object);
	 
	public int getTrainingInfoCnt(Object object);
	   
	public String addTrainingInfo(Object object) ;
 
	public String updateTrainingInfo(Object object) ;

	public String deleteTrainingInfo(Object object) ;

	/**
	 * 证书信息
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */ 
	public Object getQualificationInfo(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getQualificationInfoList(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getQualificationInfoList(Object object);
	 
	public int getQualificationInfoCnt(Object object);
	   
	public String addQualificationInfo(Object object) ;
 
	public String updateQualificationInfo(Object object) ;

	public String deleteQualificationInfo(Object object) ;
	@SuppressWarnings({ "rawtypes" })
	public Map getSuspendForGrid(Object object, int currentPage, int pageSize);


	@SuppressWarnings({ "rawtypes" })
	public List getDispatchInfoList(Object object, int currentPage, int pageSize);

	@SuppressWarnings({ "rawtypes" })
	public List getDispatchInfoList(Object object);

	public int getDispatchInfoCnt(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getPluralityInfoList(Object object, int currentPage, int pageSize);

	@SuppressWarnings({ "rawtypes" })
	public List getPluralityInfoList(Object object);

	public int getPluralityInfoCnt(Object object);
	/**
	 * 添加账户信息
	 * 
	 * @param object
	 */
	@SuppressWarnings("rawtypes")
	public String addEmpPaInfo(List insertList) ;

	/**
	 * 更新账户信息
	 * 
	 * @param object
	 */
	@SuppressWarnings("rawtypes")
	public String updateEmpPaInfo(List updateList) ;

	/**
	 * 删除账户信息
	 * 
	 * @param object
	 */
	public String deleteEmpPaInfo(Object object) ;
	/**
	 * 添加家庭关系
	 * 
	 * @param object
	 */
	@SuppressWarnings("rawtypes")
	public String addFamilyInfo(List insertList) ;

	/**
	 * 更新家庭关系
	 * 
	 * @param object
	 */
	@SuppressWarnings("rawtypes")
	public String updateFamilyInfo(List updateList) ;

	/**
	 * 删除家庭关系
	 * 
	 * @param object
	 */
	public String deleteFamilyInfo(Object object) ;
	/**
	 * 添加紧急练新人关系
	 * 
	 * @param object
	 */
	@SuppressWarnings("rawtypes")
	public String addEmergencyContactInfo(List insertList) ;
	/**
	 * 更新紧急联系人关系
	 * 
	 * @param object
	 */
	@SuppressWarnings("rawtypes")
	public String updateEmergencyContactInfo(List updateList) ;
	/**
	 * 删除家庭关系
	 * 
	 * @param object
	 */
	public String deleteEmergencyContactInfo(Object object) ;
	  
	public String addFappendInfo(Object object) ;

	public String updateFappendInfo(Object object) ;

	public String deleteFappendInfo(Object object) ;

	/**
	 * 语言信息
	 * @param object 
	 * @return
	 */ 
	public Object getLanuageInfo(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getLanuageInfoList(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getLanuageInfoList(Object object);
	 
	public int getLanuageInfoCnt(Object object);
	   
	public String addLanuageInfo(Object object) ;
 
	public String updateLanuageInfo(Object object) ;

	public String deleteLanuageInfo(Object object) ; 
	/**
	 * IT信息
	 * @param object 
	 * @return
	 */ 
	public Object getITLevelInfo(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getITLevelInfoList(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getITLevelInfoList(Object object);
	 
	public int getITLevelInfoCnt(Object object);
	   
	public String addITLevelInfo(Object object) ;
 
	public String updateITLevelInfo(Object object) ;

	public String deleteITLevelInfo(Object object) ; 
	 
	@SuppressWarnings("rawtypes")
	public List getHrSearchEmployeeList(Object object, int currentPage, int pageSize);
	
	@SuppressWarnings("rawtypes")
	public List getHrSearchEmployeeList(Object object);
	
	public int getHrSearchEmployeeCnt(Object object);
	
	@SuppressWarnings("rawtypes")
	public int deleteEmpInfo(List list);
	
	public Object getEmailByEmpId(String empID);
 
}
