package com.siping.report.pa.dao.imp.salary;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;

import com.siping.report.pa.dao.salary.PaResultReportDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class PaResultReportDaoImpl extends SqlMapClientSupport implements
        PaResultReportDao {
    /**
     *
     * @param List
     * @return
     */
    @Override
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public List<LinkedHashMap> getDatasource(List<String> codeList, Object object) {
        List returnList = new ArrayList();
        try {
            LinkedHashMap paramMap = (LinkedHashMap) object;
            String sqlPiece = "";
            for (int i = 0; i < codeList.size(); i++) {
                if (i == codeList.size() - 1) {
                    sqlPiece += codeList.get(i).toString();
                } else {
                    sqlPiece += codeList.get(i).toString() + ",";
                }
            }
            paramMap.put("sqlPiece", sqlPiece);
            returnList = this.queryForList("pa.paReport.getDataInfo", paramMap);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public List<String> getPaTitleInfo(Object object) {
        List returnList = new ArrayList();
        try {
            LinkedHashMap paramMap = (LinkedHashMap) object;
            List codeList = (List) paramMap.get("codeList");
            for (int i = 0; i < codeList.size(); i++) {
                paramMap.put("ITEM_ID", codeList.get(i).toString());
                Object titleName = this.queryForObject("pa.paReport.getPaTitleInfo", paramMap);
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
            this.insertForList("pa.paReport.addComputerInfo", list);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    @Override
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public List<String> getPaWhTitleInfo(Object object) {
        List returnList = new ArrayList();
        try {
            LinkedHashMap paramMap = (LinkedHashMap) object;
            List codeList = (List) paramMap.get("codeList");
            for (int i = 0; i < codeList.size(); i++) {
                paramMap.put("ITEM_ID", codeList.get(i).toString());
                Object titleName = this.queryForObject("pa.paReport.getPaWhTitleInfo", paramMap);
                returnList.add(titleName.toString());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 工单信息
     *
     * @param List
     * @return
     */
    @Override
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public List<LinkedHashMap> getWhDatasource(List<String> codeList, Object object) {
        List returnList = new ArrayList();
        try {
            LinkedHashMap paramMap = (LinkedHashMap) object;
            String sqlPiece = "";
            for (int i = 0; i < codeList.size(); i++) {
                if (i == codeList.size() - 1) {
                    sqlPiece += codeList.get(i).toString();
                } else {
                    sqlPiece += codeList.get(i).toString() + ",";
                }
            }
            paramMap.put("sqlPiece", sqlPiece);
            returnList = this.queryForList("pa.paReport.getWhDataInfo", paramMap);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 工单信息
     *
     * @param List
     * @return
     */
    @Override
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public List<LinkedHashMap> getWhSumDatasource(List<String> codeList, Object object) {
        List returnList = new ArrayList();
        try {
            LinkedHashMap paramMap = (LinkedHashMap) object;
            String sqlPiece = "";
            for (int i = 0; i < codeList.size(); i++) {
                if (i == codeList.size() - 1) {
                    sqlPiece += codeList.get(i).toString();
                } else {
                    sqlPiece += codeList.get(i).toString() + ",";
                }
            }
            paramMap.put("sqlPiece", sqlPiece);
            returnList = this.queryForList("pa.paReport.getWhSumDataInfo", paramMap);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getPaColumns(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("pa.paReport.getPaColumns", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getPaReportSta(LinkedHashMap object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("pa.paReport.getPaReportSta", object,
                    Integer.parseInt(((Map) object).get("page").toString()),
                    Integer.parseInt(((Map) object).get("pagesize") .toString()));
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int getPaReportStaCnt(LinkedHashMap paramMap) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("pa.paReport.getPaReportStaCnt", paramMap).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return temp;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getPaItem() {
        List list = new ArrayList();
        try {
            list = this.queryForList("pa.paReport.getPaItem");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List<LinkedHashMap> getDatasourceSta(List<String> codeList, Object object) {
        List returnList = new ArrayList();
        try {
            LinkedHashMap paramMap = (LinkedHashMap) object;
            String sqlPiece = "";
            for (int i = 0; i < codeList.size(); i++) {
                if (i == codeList.size() - 1) {
                    sqlPiece += codeList.get(i).toString();
                } else {
                    sqlPiece += codeList.get(i).toString() + ",";
                }
            }
            paramMap.put("sqlPiece", sqlPiece);
            returnList = this.queryForList("pa.paReport.getPaReportSta", paramMap);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public List<LinkedHashMap> getPaProjectDatasource(List<String> codeList, Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("pa.paReport.getPaProjectSum", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public List<LinkedHashMap> getPaProductionDatasource(List<String> codeList,
            Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("pa.paReport.getPaProductionSum",
                    object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public List<LinkedHashMap> getPaManageDatasource(List<String> codeList, Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("pa.paReport.getPaManageSum", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public Map getPaProductionTotalDatasource(List<String> codeList, Object object) {
        Map returnObject = new LinkedHashMap();
        try {
            returnObject = (Map) this.queryForObject("pa.paReport.getPaProductionTotal", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnObject;
    }

    @Override
    public List getPaProjectAverageDatasource(List<String> codeList, Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("pa.paReport.getPaProjectAverage", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    @Override
    public List getPaStaDetailList(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("pa.paReport.getPaStaDetailList", object,
                    Integer.parseInt(((Map) object).get("page").toString()),
                    Integer.parseInt(((Map) object).get("pagesize").toString()));
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public int getPaStaDetailCnt(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("pa.paReport.getPaStaDetailCnt", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return temp;
    }
}
