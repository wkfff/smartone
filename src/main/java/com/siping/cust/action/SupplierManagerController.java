package com.siping.cust.action;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.testng.log4testng.Logger;

import com.siping.cust.service.SupplierManagerSer;
import com.siping.web.utility.JsonUtil;

@Controller
@RequestMapping(value = "/cust/supperlierManager")
public class SupplierManagerController {
    public static final String SUCCESS = "Y";
    // 用来捕获该类发生的异常
    Logger logger = Logger.getLogger(SupplierManagerController.class);
    @Autowired
    private SupplierManagerSer supplierManagerSer;

    // 保存一个供货商
    @RequestMapping(value = "/addOrUpdateProduct", method = RequestMethod.POST)
    @ResponseBody
    // 该注释说白了就是你可以在:前台直接当成json来接受后台发送的数据
    public String addOrUpdateProduct(HttpServletRequest request) throws Exception {
        return this.supplierManagerSer.addOrUpdateSupplierModel(request);
    }

    // 这个是跳转到
    @RequestMapping(value = "/viewProductModelList", method = RequestMethod.GET)
    public ModelAndView viewProductLit(HttpServletRequest request) {
        return new ModelAndView("/cust/supperlierManager/viewSupplierList");
    }

    // 查询供货商管理
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getSupplierModelList")
    @ResponseBody
    // 当前台要接收后台的数据格式是json或者xml时，就需要这个标识
    public Map getSupplierModelList(HttpServletRequest request) {
        // 把数据封装到map集合中去
        List supplierModelList = this.supplierManagerSer.getSupplierModelList(request);

        int supplierModelListCnt = this.supplierManagerSer.getSupplierModelCnt(request);
        Map model = new HashMap();
        model.put("Rows", supplierModelList);
        model.put("Total", supplierModelListCnt);
        return model; // 返回到view层数据
    }

    @SuppressWarnings("unused")
    @RequestMapping(value = "/deleteSupplierModel", method = RequestMethod.POST)
    @ResponseBody
    public String deleteSupplierModel(HttpServletRequest request) {
        String returnString = SUCCESS;
        return returnString = this.supplierManagerSer.deleteSupplierModel(request);
    }

    @ResponseBody
    @RequestMapping(value = "/getSupplierDetail", method = RequestMethod.GET)
    public Map<String, Object> getSupplierDetatil(HttpServletRequest request, ModelMap map) throws Exception {
        Object supplier = this.supplierManagerSer.getSupplierDetatil(request);
        Object supplierProductCount = this.supplierManagerSer.getSupplierProductCountCnt(request);
        map.put("SUPPLIER", supplier);
        map.put("supplierProductCount", supplierProductCount);
        return map;
    }

    @RequestMapping(value = "/updateSupplierBySupplier", method = RequestMethod.POST)
    @ResponseBody
    public String updateSupplierBySupplier(HttpServletRequest request) {
        String returnString = SUCCESS;
        returnString = this.supplierManagerSer.updateSupplierBySupplier(request);
        return returnString;
    }

    @RequestMapping(value = "/supperliersImport", method = RequestMethod.GET)
    public ModelAndView supperliersImport() throws Exception {
        return new ModelAndView("/cust/supperlierManager/supperliersImport");
    }

    @RequestMapping(value = "/downloadSupperliersTemp")
    public void downloadSupperliersTemp(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        this.supplierManagerSer.downloadSupperliersTemp(request, response);
    }

    /**
     * 打开上传Excel的窗口
     */
    @RequestMapping(value = "/supplierInfoFileUpload", method = RequestMethod.GET)
    public ModelAndView supplierInfoFileUpload() {
        return new ModelAndView("/cust/supperlierManager/supplierInfoFileUpload");
    }

    /**
     * 上传Excel并将Excel放入临时表中
     * @throws ParseException
     */
    @RequestMapping(value = "/uploadSupplierInfoTemplate", method = RequestMethod.POST)
    @ResponseBody
    public String uploadSupplierInfoTemplate(@RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
        String resultString = null;
        try {
            resultString = this.supplierManagerSer.uploadSupplierInfoTemplate(file, request, response);
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
    @RequestMapping(value = "/supplierInfoPreview", method = RequestMethod.GET)
    public ModelAndView supplierInfoPreview(ModelMap modelMap) {
        // 取出临时表的字段名并放到modelMap里，命名为dataColumnsList
        try {
            List dataColumnsList = this.supplierManagerSer.getSupplierColumnList();
            Map tmpMap = new HashMap();
            tmpMap.put("TITLE_NAME", "执行操作");
            tmpMap.put("TITLE_CODE", "FLAG");
            dataColumnsList.add(0, tmpMap);
            modelMap.put("dataColumnsList", JsonUtil.writeInternal(dataColumnsList));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("/cust/supperlierManager/supplierInfoPreview", modelMap);
    }

    /**
     * 获取临时表中的数据
     * @throws SQLException
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getSupplierTmpList")
    @ResponseBody
    public Map getSupplierTmpList(){
        List tmpInfoList;
        Map model = new HashMap();
        try {
            tmpInfoList = this.supplierManagerSer.getSupplierTmpList();
            model.put("Rows", tmpInfoList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return model;
    }

    /**
     * 保存上传数据，即将临时表内容写入正式表并删除临时表
     * @throws SQLException
     */
    @RequestMapping(value = "/saveSupplierTmpInfo", method = RequestMethod.POST)
    @ResponseBody
    public String saveSupplierTmpInfo(HttpServletRequest request) {
        String result = null;
        try {
            result = this.supplierManagerSer.saveSupplierTmpInfo(request);
        } catch (Exception e) {
            e.printStackTrace();
            result = "保存失败！";
        }
        return result;
    }
}
