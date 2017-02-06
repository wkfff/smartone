package com.siping.web.action;

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

import com.siping.web.service.FileUploadSer;
import com.siping.web.utility.JsonUtil;
import com.siping.web.utility.ObjectBindUtil;

/**
 * 上传文件
 */
@Controller
@RequestMapping(value = "/upload/fileUpload")
public class FileUploadController {
    Logger logger = Logger.getLogger(FileUploadController.class);

    @Autowired
    private FileUploadSer fileUploadSer;

    /**
	 * 
	 */
    @RequestMapping(value = "/uploadify", method = RequestMethod.GET)
    public ModelAndView uploadify(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("paraMap", this.fileUploadSer.getRequestParamData(request));
        return new ModelAndView("/web/upload/uploadify", modelMap);
    }

    /**
     * 打开上传头像的窗口
     */
    @RequestMapping(value = "/uploadPhoto", method = RequestMethod.GET)
    public ModelAndView uploadPhoto(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("paraMap", this.fileUploadSer.getRequestParamData(request));
        return new ModelAndView("/web/upload/uploadPhoto", modelMap);
    }

    /**
     * 上传头像
     */
    @RequestMapping(value = "/uploadPhoto", method = RequestMethod.POST)
    @ResponseBody
    public String uploadPhoto(@RequestParam("file") MultipartFile file, HttpServletRequest request) throws IOException, SQLException {
        String result = null;
        if (!file.isEmpty()) {
            result = this.fileUploadSer.uploadPhoto(request, file);
        } else {
            result = "File is empty.";
        }
        return result;
    }

    /**
     * 打开上传货品图片的窗口
     */
    @RequestMapping(value = "/uploadProImage", method = RequestMethod.GET)
    public ModelAndView uploadProImage(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("paraMap", this.fileUploadSer.getRequestParamData(request));
        return new ModelAndView("/web/upload/uploadProImage", modelMap);
    }

    /**
     * 打开上传货品图片的窗口
     */
    @RequestMapping(value = "/uploadMobileAdvImage", method = RequestMethod.GET)
    public ModelAndView uploadMobileAdvImage(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("paraMap", this.fileUploadSer.getRequestParamData(request));
        return new ModelAndView("/web/upload/uploadMobileAdvImage", modelMap);
    }

    /**
     * 上传货品图片
     */
    @RequestMapping(value = "/uploadProImage", method = RequestMethod.POST)
    @ResponseBody
    public String uploadProImage(@RequestParam("file") MultipartFile file, HttpServletRequest request) throws IOException, SQLException {
        String result = null;
        if (!file.isEmpty()) {
            result = this.fileUploadSer.uploadProImage(request, file);
        } else {
            result = "File is empty.";
        }
        return result;
    }

    /**
     * 上传货品图片
     */
    @RequestMapping(value = "/uploadMobileAdvImage", method = RequestMethod.POST)
    @ResponseBody
    public String uploadMobileAdvImage(@RequestParam("file") MultipartFile file, HttpServletRequest request) throws IOException, SQLException {
        String result = null;
        if (!file.isEmpty()) {
            result = this.fileUploadSer.uploadMobileAdvImage(request, file);
        } else {
            result = "File is empty.";
        }
        return result;
    }

    /**
     * 打开上传资产图片的窗口
     */
    @RequestMapping(value = "/uploadAssetPic", method = RequestMethod.GET)
    public ModelAndView uploadAssetPic(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("paraMap", this.fileUploadSer.getRequestParamData(request));
        return new ModelAndView("/web/upload/uploadAssetPic", modelMap);
    }

    /**
     * 上传资产图片
     */
    @RequestMapping(value = "/uploadAssetPic", method = RequestMethod.POST)
    @ResponseBody
    public String uploadAssetPic(@RequestParam("file") MultipartFile file, HttpServletRequest request) throws IOException, SQLException {
        String result = null;
        if (!file.isEmpty()) {
            result = this.fileUploadSer.uploadAssetPic(request, file);
        } else {
            result = "File is empty.";
        }
        return result;
    }

    /**
     * 打开上传Excel的窗口
     */
    @RequestMapping(value = "/uploadExcel", method = RequestMethod.GET)
    public ModelAndView uploadExcel(String EMPID, ModelMap modelMap) {

        modelMap.put("EMPID", EMPID);
        return new ModelAndView("/web/upload/uploadExcel", modelMap);
    }

    /**
     * 上传Excel并将Excel放入临时表中
     * @throws ParseException
     */
    @RequestMapping(value = "/uploadExcel", method = RequestMethod.POST)
    @ResponseBody
    public String uploadExcel(@RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
        String resultString = null;
        try {
            resultString = this.fileUploadSer.uploadExcel(file, request, response);
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

    /**
     * 打开上传合同附件的窗口
     */
    @RequestMapping(value = "/uploadContractAppendix", method = RequestMethod.GET)
    public ModelAndView uploadContractAppendix(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("paraMap", this.fileUploadSer.getRequestParamData(request));
        return new ModelAndView("/web/upload/uploadContractAppendix", modelMap);
    }

    /**
     * 上传合同的附件
     */
    @RequestMapping(value = "/uploadContractAppendix", method = RequestMethod.POST)
    @ResponseBody
    public String uploadContractAppendix(@RequestParam("file") MultipartFile file, HttpServletRequest request) throws IOException, SQLException {
        String result = null;
        if (!file.isEmpty()) {
            result = this.fileUploadSer.uploadContractAppendix(request, file);
        } else {
            result = "File is empty.";
        }
        return result;
    }

    /**
     * 查看上传表格的预览
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/showPreview", method = RequestMethod.GET)
    public ModelAndView showPreview(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        // 取出临时表的字段名并放到modelMap里，命名为dataColumnsList
        List dataColumnsList = this.fileUploadSer.getColumnList(request, response);
        Map tmpMap = new HashMap();
        tmpMap.put("TITLE_NAME", "执行操作");
        tmpMap.put("TITLE_CODE", "FLAG");
        dataColumnsList.add(0, tmpMap);
        modelMap.put("dataColumnsList", JsonUtil.writeInternal(dataColumnsList));
        return new ModelAndView("/web/upload/showPreview", modelMap);
    }

    /**
     * 获取临时表中的数据
     * @throws SQLException
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getTmpInfoList")
    @ResponseBody
    public Map getTmpInfoList(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        List tmpInfoList = this.fileUploadSer.getTmpInfoList(request);
        Map model = new HashMap();
        model.put("Rows", tmpInfoList);
        return model;
    }

    /**
     * 保存上传数据，即将临时表内容写入正式表并删除临时表
     * @throws SQLException
     */
    @RequestMapping(value = "/saveUploadExcel", method = RequestMethod.POST)
    @ResponseBody
    public String saveUploadExcel(HttpServletRequest request) {
        String result = null;
        try {
            result = this.fileUploadSer.saveUploadExcel(request);
        } catch (SQLException e) {
            e.printStackTrace();
            result = e.getMessage();
        }
        return result;
    }

    /**
     * 打开上传产品附件的窗口
     */
    @RequestMapping(value = "/uploadProductAppendix", method = RequestMethod.GET)
    public ModelAndView uploadProductAppendix(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("paraMap", ObjectBindUtil.getRequestParamData(request));
        return new ModelAndView("/web/upload/uploadProductAppendix", modelMap);
    }

    /**
     * 上传产品的附件
     */
    @RequestMapping(value = "/uploadProductAppendix", method = RequestMethod.POST)
    @ResponseBody
    public String uploadProductAppendix(@RequestParam("file") MultipartFile file, HttpServletRequest request) throws IOException, SQLException {
        String result = null;
        if (!file.isEmpty()) {
            result = this.fileUploadSer.uploadProductAppendix(request, file);
        } else {
            result = "File is empty.";
        }
        return result;
    }

    /**
     * 打开上传产品附件的窗口
     */
    @RequestMapping(value = "/uploadCustAppendix", method = RequestMethod.GET)
    public ModelAndView uploadCustAppendix(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("paraMap", ObjectBindUtil.getRequestParamData(request));
        return new ModelAndView("/web/upload/uploadCustAppendix", modelMap);
    }

    /**
     * 上传产品的附件
     */
    @RequestMapping(value = "/uploadCustAppendix", method = RequestMethod.POST)
    @ResponseBody
    public String uploadCustAppendix(@RequestParam("file") MultipartFile file, HttpServletRequest request) throws IOException, SQLException {
        String result = null;
        if (!file.isEmpty()) {
            result = this.fileUploadSer.uploadCustAppendix(request, file);
        } else {
            result = "File is empty.";
        }
        return result;
    }

    /**
     * 打开上传产品图片的窗口
     */
    @RequestMapping(value = "/uploadProductPic", method = RequestMethod.GET)
    public ModelAndView uploadProductPic(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("paraMap", ObjectBindUtil.getRequestParamData(request));
        return new ModelAndView("/web/upload/uploadProductPic", modelMap);
    }

    /**
     * 上传产品的图片
     */
    @RequestMapping(value = "/uploadProductPic", method = RequestMethod.POST)
    @ResponseBody
    public String uploadProductPic(@RequestParam("file") MultipartFile file, HttpServletRequest request) throws IOException, SQLException {
        String result = null;
        if (!file.isEmpty()) {
            result = this.fileUploadSer.uploadProductPic(request, file);
        } else {
            result = "File is empty.";
        }
        return result;
    }

    /**
     * 打开上传材料图片的窗口
     */
    @RequestMapping(value = "/uploadMaterialPic", method = RequestMethod.GET)
    public ModelAndView uploadMaterialPic(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("paraMap", ObjectBindUtil.getRequestParamData(request));
        return new ModelAndView("/web/upload/uploadMaterialPic", modelMap);
    }

    /**
     * 上传材料的图片
     */
    @RequestMapping(value = "/uploadMaterialPic", method = RequestMethod.POST)
    @ResponseBody
    public String uploadMaterialPic(@RequestParam("file") MultipartFile file, HttpServletRequest request) throws IOException, SQLException {
        String result = null;
        if (!file.isEmpty()) {
            result = this.fileUploadSer.uploadMaterialPic(request, file);
        } else {
            result = "File is empty.";
        }
        return result;
    }

}
