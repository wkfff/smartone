package com.siping.report.hrm.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.report.hrm.dao.HrReportDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class HrReportDaoImpl extends SqlMapClientSupport implements HrReportDao {	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map viewReport(Map object){		
		
		Map object2 = new LinkedHashMap();
		object2.put("param", object);
		
		try {
			if(object.get("page")!=null){
				int currentPage = Integer.parseInt(object.get("page").toString());
				int pageSize = Integer.parseInt(object.get("pagesize").toString());
				object2.put("Rows",this.queryForList("report.hr."+object.get("reportName"), object, currentPage, pageSize));
				object2.put("Total",(Integer)this.queryForObject("report.hr."+object.get("reportName")+"Cnt", object));
			}else{
				object2.put("Rows",this.queryForList("report.hr."+object.get("reportName"), object));
			}
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return object2;
	}

	@SuppressWarnings({ "rawtypes" })
	public void calReport(Map object) {
		try {
			this.insert("report.hr."+object.get("reportName")+"Cal",object);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getDeptQuotaList(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("report.hr.getDeptQuotaList",
					object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getEmpQualificationInfoList(Object object, int currentPage,
			int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("report.hr.getEmpQualificationInfo",
					object, currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getEmpQualificationInfoList(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("report.hr.getEmpQualificationInfo",
					object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}

	@Override
	public int getEmpQualificationInfoCnt(Object object) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(
					ObjectUtils.toString(this.queryForObject(
							"report.hr.getEmpQualificationInfoCnt", object)),
					Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnInt;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getEmpQualificationDetailList(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("report.hr.getEmpQualificationDetailList",
					object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}

	@Override
	public int getEmpQualificationDetailCnt(Object object) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(
					ObjectUtils.toString(this.queryForObject(
							"report.hr.getEmpQualificationDetailCnt", object)),
					Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnInt;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getEmpQualificationDetailList(Object object, int currentPage,
			int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("report.hr.getEmpQualificationDetailList",
					object, currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}

    @Override
    public List getMenList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("report.hr.getMenList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public List getMenList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("report.hr.getMenList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public int getMenCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(
                    ObjectUtils.toString(this.queryForObject("report.hr.getMenCnt", object)),
                    Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    @Override
    public List<String> getHrTitleInfo(Object object) {
        List returnList = new ArrayList();
        try 
        {
            LinkedHashMap paramMap = (LinkedHashMap) object;
            List codeList = (List) paramMap.get("codeList");
            
            for (int i = 0; i < codeList.size(); i++) { 
                paramMap.put("ITEM_ID", codeList.get(i).toString());
                Object  titleName= this.queryForObject("report.hr.getHrTitleInfo", paramMap);
                returnList.add(titleName.toString());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return returnList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getMenTypeConstructList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("report.hr.getMenTypeConstructList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getMenEduConstructList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("report.hr.getMenEduConstructList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public List getMenAgeConstructList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("report.hr.getMenAgeConstructList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public List getMenWAgeConstructList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("report.hr.getMenWAgeConstructList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

}
