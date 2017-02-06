package com.siping.hrm.action;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.siping.hrm.service.InfoStatisticsSer;
import com.siping.web.utility.JsonUtil;

@Controller
@RequestMapping(value = "/hrm/infoStatistical")
public class InfoStatisticsCtroller {
    private static final String ERROR_OCCURRED = "Error Occurred!";
    Logger logger = Logger.getLogger(InfoStatisticsCtroller.class);
    @Autowired
    private InfoStatisticsSer infoStatisticsSer;

    @RequestMapping(value = "/empInfoImport", method = RequestMethod.GET)
    public ModelAndView info(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        return new ModelAndView("/hrm/infoStatistical/empInfoImport", modelMap);
    }

    @RequestMapping(value = "/downloadEmpInfoTemplate")
    public void downloadEmpInfoTemplate(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        this.infoStatisticsSer.downloadEmpInfoTemplate(request, response);
    }

    /**
     * 打开上传Excel的窗口
     */

    @RequestMapping(value = "/empInfoFileUpload", method = RequestMethod.GET)
    public ModelAndView empInfoFileUpload() {
        return new ModelAndView("/hrm/infoStatistical/empInfoFileUpload");
    }

    /**
     * 上传Excel并将Excel放入临时表中
     * @throws ParseException
     */
    @RequestMapping(value = "/uploadEmpInfoTemplate", method = RequestMethod.POST)
    @ResponseBody
    public String uploadEmpInfoTemplate(@RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
        String resultString = null;
        try {
            resultString = this.infoStatisticsSer.uploadEmpInfoTemplate(file, request, response);
        } catch (Exception e) {
            resultString = "发生错误";
            e.printStackTrace();
        }
        return resultString;
    }

    /**
     * 查看上传表格的预览
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/empInfoPreview", method = RequestMethod.GET)
    public ModelAndView empInfoPreview(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        // 取出临时表的字段名并放到modelMap里，命名为dataColumnsList
        List dataColumnsList = this.infoStatisticsSer.getColumnList(request, response);
        Map tmpMap = new HashMap();
        tmpMap.put("TITLE_NAME", "执行操作");
        tmpMap.put("TITLE_CODE", "FLAG");
        dataColumnsList.add(0, tmpMap);
        modelMap.put("dataColumnsList", JsonUtil.writeInternal(dataColumnsList));
        return new ModelAndView("/hrm/infoStatistical/empInfoPreview", modelMap);
    }

    /**
     * 获取临时表中的数据
     * @throws SQLException
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getTmpInfoList")
    @ResponseBody
    public Map getTmpInfoList(){
        List tmpEmpInfoList;
        Map model = new HashMap();
        try {
            tmpEmpInfoList = this.infoStatisticsSer.getTmpInfoList();
            model.put("Rows", tmpEmpInfoList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return model;
    }

    /**
     * 保存上传数据，即将临时表内容写入正式表并删除临时表
     * @throws SQLException
     */
    @RequestMapping(value = "/saveEmpTmpInfo", method = RequestMethod.POST)
    @ResponseBody
    public String saveEmpTmpInfo(HttpServletRequest request) {
        String result = null;
        try {
            result = this.infoStatisticsSer.saveEmpTmpInfo(request);
        } catch (Exception e) {
            e.printStackTrace();
            result = ERROR_OCCURRED;
        }
        return result;
    }

    @RequestMapping(value = "/certificateInfoImport", method = RequestMethod.GET)
    public ModelAndView certificateInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        return new ModelAndView("/hrm/infoStatistical/certificateInfoImport", modelMap);
    }

    @RequestMapping(value = "/downloadCertificateInfoTemplate")
    public void downloadCertificateInfoTemplate(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        this.infoStatisticsSer.downloadCertificateInfoTemplate(request, response);
    }

    @RequestMapping(value = "/uploadCertificateInfo", method = RequestMethod.GET)
    public ModelAndView uploadCertificateInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
        return new ModelAndView("/hrm/infoStatistical/uploadCertificateInfo", modelMap);
    }

    /**
     * 将证件信息表中的信息插入表中
     * @param file
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/uploadCertificateInfo", method = RequestMethod.POST)
    @ResponseBody
    public String uploadCertificateInfo(@RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
        String resultString = "Y";
        try {
            resultString = this.infoStatisticsSer.uploadCertificateExcel(file, request, response);
        } catch (IOException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        } catch (SQLException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        } catch (ParseException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        } catch (Exception e) {
            resultString = "未知错误";
            e.printStackTrace();
        }
        return resultString;

    }

    @RequestMapping(value = "/trainingInfoImport", method = RequestMethod.GET)
    public ModelAndView trainingInfoImport(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        return new ModelAndView("/hrm/infoStatistical/trainingInfoImport", modelMap);
    }

    @RequestMapping(value = "/downloadTrainingInfoTemplate")
    public void downloadTrainingInfoTemplate(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        this.infoStatisticsSer.downloadTrainingInfoTemplate(request, response);
    }

    @RequestMapping(value = "/uploadTrainingInfo", method = RequestMethod.GET)
    public ModelAndView uploadTrainingInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
        return new ModelAndView("/hrm/infoStatistical/uploadTrainingInfo", modelMap);
    }

    /**
     * 将证件信息表中的信息插入表中
     * @param file
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/uploadTrainingInfo", method = RequestMethod.POST)
    @ResponseBody
    public String uploadTrainingInfo(@RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
        String resultString = "Y";
        try {
            resultString = this.infoStatisticsSer.uploadTrainingExcel(file, request, response);
        } catch (IOException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        } catch (SQLException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        } catch (ParseException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        } catch (Exception e) {
            resultString = "未知错误";
            e.printStackTrace();
        }
        return resultString;

    }

    /********************************************** info statistical **********************************************/
    @RequestMapping(value = "/empInfo", method = RequestMethod.GET)
    public ModelAndView empInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        return new ModelAndView("/hrm/infoStatistical/empInfo", modelMap);
    }

    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/viewDataInfo", method = RequestMethod.GET)
    public ModelAndView getDataInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        List infoList = this.infoStatisticsSer.getFieldInfo(request);
        modelMap.put("dataColumnsList", JsonUtil.writeInternal(infoList));
        return new ModelAndView("/hrm/infoStatistical/viewDataInfo", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getDataInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getDataInfo(HttpServletRequest request) throws Exception {

        List infoList = this.infoStatisticsSer.getDataInfo(request);
        int infoCnt = this.infoStatisticsSer.getDataInfoCnt(request);
        Map model = new HashMap();
        model.put("Rows", infoList);
        model.put("Total", infoCnt);
        return model;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getInfoTableList", method = RequestMethod.POST)
    @ResponseBody
    public Map getInfoTableList(HttpServletRequest request) throws Exception {

        List listMap = this.infoStatisticsSer.getInfoTableList(request);
        Map model = new HashMap();
        model.put("Rows", listMap);
        return model;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getInfoFieldList", method = RequestMethod.POST)
    @ResponseBody
    public Map getInfoFieldList(HttpServletRequest request) throws Exception {

        List listMap = this.infoStatisticsSer.getInfoFieldList(request);
        Map model = new HashMap();
        model.put("Rows", listMap);
        return model;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getFieldInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getFieldInfo(HttpServletRequest request) throws Exception {

        List infoList = this.infoStatisticsSer.getFieldInfo(request);
        int infoCnt = this.infoStatisticsSer.getFieldInfoCnt(request);
        Map model = new HashMap();
        model.put("Rows", infoList);
        model.put("Total", infoCnt);
        return model;
    }

    @RequestMapping(value = "/deleteFieldInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deleteFieldInfo(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        int infoCnt = this.infoStatisticsSer.deleteFieldInfo(request);
        if (infoCnt == 0) {
            returnString = "N";
        }
        return returnString;
    }

    @RequestMapping(value = "/addFieldInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addFieldInfo(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        int infoCnt = this.infoStatisticsSer.addFieldInfo(request);
        if (infoCnt == 0) {
            returnString = "N";
        }
        return returnString;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getInfoTableJson", method = RequestMethod.POST)
    @ResponseBody
    public Map getInfoTableJson(HttpServletRequest request) throws Exception {

        List listTMap = this.infoStatisticsSer.getInfoTypeList(request);
        List listFMap = this.infoStatisticsSer.getInfoTableList(request);
        String tJson = JsonUtil.listInfoToIdTextJson(listTMap);
        String fJson = JsonUtil.listInfoToIdTextPidJson(listFMap);
        Map model = new HashMap();
        model.put("TRows", tJson);
        model.put("FRows", fJson);
        return model;
    }

}
