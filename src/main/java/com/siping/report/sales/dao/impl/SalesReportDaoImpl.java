package com.siping.report.sales.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.report.sales.dao.SalesReportDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class SalesReportDaoImpl extends SqlMapClientSupport implements SalesReportDao {

	@Override
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<LinkedHashMap> getDatasource(List<String> codeList,
			Object obj) {
		List returnList = new ArrayList();
		try {
			LinkedHashMap paramMap = (LinkedHashMap) obj;
			String sqlPiece = "";
			for (int i = 0; i < codeList.size(); i++) {
				 
				if(i==codeList.size()-1){ 
					sqlPiece += "SRHM."+codeList.get(i).toString();
				}else{
					sqlPiece += "SRHM."+codeList.get(i).toString() + ",";
				}
				 
			}
			paramMap.put("sqlPiece", sqlPiece);
			returnList = this.queryForList(
					"sales.salesReport.getDataInfo", paramMap);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}
	@Override
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<String> getSalesMonthTitleInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			LinkedHashMap paramMap = (LinkedHashMap) obj;
			List codeList = (List) paramMap.get("codeList");
			 
			for (int i = 0; i < codeList.size(); i++) { 
				paramMap.put("ITEM_ID", codeList.get(i).toString());
				Object  titleName= this.queryForObject   (
						"sales.salesReport.getSalesMonthTitleInfo", paramMap);
				returnList.add(titleName.toString());
			}   
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}
	
	@Override
	@SuppressWarnings("rawtypes")
	public int insertComputer(List<Map> list) {
		try {
			this.insertForList("sales.salesReport.addComputerInfo", list);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String getSalesMonthColumnInfo(Object obj) {
		 String returnString = "";
		try {
			List<LinkedHashMap> returnList = this.queryForList("sales.salesReport.getSalesMonthColumnInfo", obj);
			for(LinkedHashMap paraMap : returnList){
				returnString += paraMap.get("COLUMN_NAME").toString() + ",";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnString;
	}
	
    @SuppressWarnings("rawtypes")
    @Override
    public List getCustomerMonthlySalesList(Object object, Integer currentPage, Integer pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("report.sales.getCustomerMonthlySalesList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }
    
    @SuppressWarnings("rawtypes")
    @Override
    public List getCustomerMonthlySalesList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("report.sales.getCustomerMonthlySalesList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }
    
    @SuppressWarnings("rawtypes")
    @Override
    public int getCustomerMonthlySalesCnt(Object object) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(
                    ObjectUtils.toString(this.queryForObject("report.sales.getCustomerMonthlySalesCnt", object)),
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
    public List getCustomerYearlySalesList(Object object, Integer currentPage, Integer pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("report.sales.getCustomerYearlySalesList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }
    
    @SuppressWarnings("rawtypes")
    @Override
    public List getCustomerYearlySalesList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("report.sales.getCustomerYearlySalesList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }
    
    @SuppressWarnings("rawtypes")
    @Override
    public int getCustomerYearlySalesCnt(Object object) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(
                    ObjectUtils.toString(this.queryForObject("report.sales.getCustomerYearlySalesCnt", object)),
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
    public List getProductMonthlySalesList(Object object, Integer currentPage, Integer pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("report.sales.getProductMonthlySalesList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }
    
    @SuppressWarnings("rawtypes")
    @Override
    public List getProductMonthlySalesList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("report.sales.getProductMonthlySalesList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }
    
    @Override
    public int getProductMonthlySalesCnt(Object object) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(
                    ObjectUtils.toString(this.queryForObject("report.sales.getProductMonthlySalesCnt", object)),
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
    public List getProductYearlySalesList(Object object, Integer currentPage, Integer pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("report.sales.getProductYearlySalesList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }
    
    @SuppressWarnings("rawtypes")
    @Override
    public List getProductYearlySalesList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("report.sales.getProductYearlySalesList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }
    
    @Override
    public int getProductYearlySalesCnt(Object object) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(
                    ObjectUtils.toString(this.queryForObject("report.sales.getProductYearlySalesCnt", object)),
                    Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }
}
