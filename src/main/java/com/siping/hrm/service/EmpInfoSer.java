package com.siping.hrm.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface EmpInfoSer {
	@SuppressWarnings({ "rawtypes" })
	public Map getEmpList(HttpServletRequest request);
	
	public Object getBasicInfo(HttpServletRequest request);

	public Object getPersonalInfo(HttpServletRequest request); 
	
	public String updateEmpInfo(HttpServletRequest request) ;

	@SuppressWarnings({ "rawtypes" })
	public List getPaEmpInfoList(HttpServletRequest request);
	 
	public int getPaEmpInfoCnt(HttpServletRequest request) ;
	@SuppressWarnings({ "rawtypes" })
	public Map getSinfoForGrid(HttpServletRequest request);
 
	@SuppressWarnings({ "rawtypes" })
	public List getBizInfoList(HttpServletRequest request);
	 
	public int getBizInfoCnt(HttpServletRequest request) ;
	  
	public Object getHealthInfo(HttpServletRequest request);
	 
	@SuppressWarnings({ "rawtypes" })
	public List getHealthInfoList(HttpServletRequest request);
	 
	public int getHealthInfoCnt(HttpServletRequest request) ;

	public String updateHealthInfo(HttpServletRequest request) ;

	public String addHealthInfo(HttpServletRequest request) ;

	public String deleteHealthInfo(HttpServletRequest request) ;
 
	public Object getWorkExperienceInfo(HttpServletRequest request);
	
	@SuppressWarnings({ "rawtypes" })
	public List getWorkExperienceInfoList(HttpServletRequest request);
	 
	public int getWorkExperienceInfoCnt(HttpServletRequest request) ;

	public String updateWorkExperienceInfo(HttpServletRequest request) ;

	public String addWorkExperienceInfo(HttpServletRequest request) ;

	public String deleteWorkExperienceInfo(HttpServletRequest request) ;
	
    public Object getEduInfo(HttpServletRequest request);
	
	@SuppressWarnings({ "rawtypes" })
	public List getEduInfoList(HttpServletRequest request);
	 
	public int getEduInfoCnt(HttpServletRequest request) ;

	public String updateEduInfo(HttpServletRequest request) ;

	public String addEduInfo(HttpServletRequest request) ;

	public String deleteEduInfo(HttpServletRequest request) ;
	
    public Object getDocInfo(HttpServletRequest request);
	
	@SuppressWarnings({ "rawtypes" })
	public List getDocInfoList(HttpServletRequest request);
	 
	public int getDocInfoCnt(HttpServletRequest request) ;

	public String updateDocInfo(HttpServletRequest request) ;

	public String addDocInfo(HttpServletRequest request) ;

	public String deleteDocInfo(HttpServletRequest request) ;
	
	public Object getTrainingInfo(HttpServletRequest request);
	
	@SuppressWarnings({ "rawtypes" })
	public List getTrainingInfoList(HttpServletRequest request);
	 
	public int getTrainingInfoCnt(HttpServletRequest request) ;

	public String updateTrainingInfo(HttpServletRequest request) ;

	public String addTrainingInfo(HttpServletRequest request) ;

	public String deleteTrainingInfo(HttpServletRequest request);
	

	public Object getQualificationInfo(HttpServletRequest request);
	@SuppressWarnings({ "rawtypes" })
	public List getQualificationInfoList(HttpServletRequest request);
	 
	public int getQualificationInfoCnt(HttpServletRequest request) ;

	public String updateQualificationInfo(HttpServletRequest request) ;
 
	public String addQualificationInfo(HttpServletRequest request) ;

	public String deleteQualificationInfo(HttpServletRequest request);

	public String deleteEmpPaInfo(HttpServletRequest request) ;
	
	public String addEmpPaInfo(HttpServletRequest request) ;
	
	public String updateEmpPaInfo(HttpServletRequest request) ;
	
	public String deleteFamilyInfo(HttpServletRequest request) ;
	
	public String addFamilyInfo(HttpServletRequest request) ;
	
	public String updateFamilyInfo(HttpServletRequest request) ;
	
	public String addEmergencyContactInfo(HttpServletRequest request) ;
	
	public String updateEmergencyContactInfo(HttpServletRequest request) ;
	
	@SuppressWarnings({ "rawtypes" })
	public Map getAppendInfoForGrid(HttpServletRequest request);
  
	@SuppressWarnings({ "rawtypes" })
	public List getResignInfoList(HttpServletRequest request);
		 
	public int getResignInfoCnt(HttpServletRequest request) ;
  
	public Object getLanuageInfo(HttpServletRequest request);
	@SuppressWarnings({ "rawtypes" })
	public List getLanuageInfoList(HttpServletRequest request);
	 
	public int getLanuageInfoCnt(HttpServletRequest request) ;

	public String updateLanuageInfo(HttpServletRequest request) ;

	public String addLanuageInfo(HttpServletRequest request) ;

	public String deleteLanuageInfo(HttpServletRequest request);
	
	public Object getITLevelInfo(HttpServletRequest request);
	@SuppressWarnings({ "rawtypes" })
	public List getITLevelInfoList(HttpServletRequest request);
	 
	public int getITLevelInfoCnt(HttpServletRequest request) ;

	public String updateITLevelInfo(HttpServletRequest request) ;

	public String addITLevelInfo(HttpServletRequest request) ;

	public String deleteITLevelInfo(HttpServletRequest request); 
  
	@SuppressWarnings({ "rawtypes" })
	public Map getEvaluateForGrid(HttpServletRequest request);

	@SuppressWarnings({ "rawtypes" })
	public Map getEvalForGrid(HttpServletRequest request);
   
	@SuppressWarnings({ "rawtypes" })
	public List getExpInsideInfoList(HttpServletRequest request);
	 
	public int getExpInsideInfoCnt(HttpServletRequest request) ; 
	
	@SuppressWarnings({ "rawtypes" })
	public List getFamilyInfoList(HttpServletRequest request);
	 
	public int getFamilyInfoCnt(HttpServletRequest request) ;
	
	@SuppressWarnings({ "rawtypes" })
	public List getEmergencyContactInfoList(HttpServletRequest request);
	 
	public int getEmergencyContactInfoCnt(HttpServletRequest request) ;
	 
	@SuppressWarnings({ "rawtypes" })
	public List getPunishMentInfoList(HttpServletRequest request);
	 
	public int getPunishMentInfoCnt(HttpServletRequest request) ;
  
	@SuppressWarnings({ "rawtypes" })
	public List getRewardInfoList(HttpServletRequest request);
	 
	public int getRewardInfoCnt(HttpServletRequest request) ;
	
	@SuppressWarnings({ "rawtypes" })
	public Map getSuspendForGrid(HttpServletRequest request);
  
	@SuppressWarnings({ "rawtypes" })
	public List getDispatchInfoList(HttpServletRequest request);
		 
	public int getDispatchInfoCnt(HttpServletRequest request) ; 

	@SuppressWarnings({ "rawtypes" })
	public List getPluralityInfoList(HttpServletRequest request);
	 
	public int getPluralityInfoCnt(HttpServletRequest request) ; 
	
	public String updateFappendInfoGrid(List<LinkedHashMap<String, Object>> list)
			throws Exception;

	public String updateFappendInfoGrid(
			List<LinkedHashMap<String, Object>> list, HttpServletRequest request)
			throws Exception;
   
	/**
	 * 获取信息
	 * @param request
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) ;
	
	@SuppressWarnings({ "rawtypes" })
	public List getHrSearchEmployeeList(HttpServletRequest request) ;
	
	public int getHrSearchEmployeeCnt(HttpServletRequest request);
	
	public String deleteEmpInfo(HttpServletRequest request);
	
	public Object getEmailByEmpId(String empId);

}
