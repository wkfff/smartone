package com.siping.cust.action;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.siping.cust.bean.Customer;
import com.siping.cust.service.*;
import com.siping.system.bean.AdminBean;
import com.siping.web.bean.ReturnResult;
import com.siping.web.utility.JsonUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/cust/custManage")
public class CustManageCtroller {
    Logger logger = Logger.getLogger(CustManageCtroller.class);

    @Autowired
    private CustManageSer custManageSer;

    @Autowired
    private SalesSettingSer salesSettingSer;

    @RequestMapping(value = "/addCustomer", method = RequestMethod.GET)
    public ModelAndView addCustomer(HttpServletRequest request, ModelMap modelMap) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        modelMap.put("isSupervisor", salesSettingSer.isSupervisor(request));
        modelMap.put("admin", admin);
        modelMap.put("type", "add");
        return new ModelAndView("/cust/custManage/addCustomer", modelMap);
    }

    @RequestMapping(value = "/updateCustomer", method = RequestMethod.GET)
    public ModelAndView updateCustomer(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("isSupervisor", salesSettingSer.isSupervisor(request));
        modelMap.put("customerDetail", this.custManageSer.getCustomerDetail(request));
        modelMap.put("type", "update");
        return new ModelAndView("/cust/custManage/updateCustomer", modelMap);
    }

    @RequestMapping(value = "/addCustomer", method = RequestMethod.POST)
    @ResponseBody
    public ReturnResult addCustomer(HttpServletRequest request, @RequestBody Customer customer) {
        ReturnResult resultResult = new ReturnResult();
        if (customer.getCustomerId() == null || customer.getCustomerId() == "") {
            try {
                resultResult.setCode(0);
                resultResult.setMessage(this.custManageSer.addCustomer(request, customer));
            } catch (SQLException e) {
                resultResult.setCode(-2);
                resultResult.setMessage(e.getMessage());
            }
        } else {
            resultResult.setCode(-1);
            resultResult.setMessage("数据存在主键，无法保存");
        }
        return resultResult;
    }

    @RequestMapping(value = "/updateCustomer", method = RequestMethod.POST)
    @ResponseBody
    public ReturnResult updateCustomer(HttpServletRequest request, @RequestBody Customer customer) {
        ReturnResult resultResult = new ReturnResult();
        if (customer.getCustomerId() != null && customer.getCustomerId() != "") {
            try {
                resultResult.setCode(0);
                resultResult.setMessage(this.custManageSer.updateCustomer(request, customer));
            } catch (SQLException e) {
                resultResult.setCode(-2);
                resultResult.setMessage(e.getMessage());
            }
        }else{
            resultResult.setCode(-1);
            resultResult.setMessage( "数据缺少主键，无法修改");
        }
        return resultResult;
    }

    @RequestMapping(value = "/changeCustomerEMPID", method = RequestMethod.POST)
    @ResponseBody
    public String changeCustomerEMPID(HttpServletRequest request, HttpServletResponse response) {
        return this.custManageSer.changeCustomerEMPID(request);
    }

    @RequestMapping(value = "/checkCustomerID")
    @ResponseBody
    public String checkCustomerID(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        return this.custManageSer.checkCustomerID(request);
    }

    @RequestMapping(value = "/removeCustomer", method = RequestMethod.GET)
    public ModelAndView removeCustomer(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("customerDetail", ObjectBindUtil.getRequestParamData(request));
        return new ModelAndView("/cust/custManage/removeCustomer");
    }

    @RequestMapping(value = "/removeCustomer", method = RequestMethod.POST)
    @ResponseBody
    public ReturnResult removeCustomer(HttpServletRequest request, 
                                 @RequestParam(value="customerId", required=true) String customerId,
                                 @RequestParam(value="removeRemark", required=true) String removeRemark
                                 ) throws SQLException {
        ReturnResult returnResult = new ReturnResult();
        try{
            returnResult.setCode(0);
            returnResult.setMessage(this.custManageSer.removeCustomer(request, customerId,removeRemark));
        }catch(SQLException e){
            returnResult.setCode(-1);
            returnResult.setMessage(e.getMessage());
        }
        return returnResult;
    }

    @RequestMapping(value = "/customerImport", method = RequestMethod.GET)
    public ModelAndView customerImport() throws Exception {
        return new ModelAndView("/cust/custManage/customerImport");
    }

    @RequestMapping(value = "/downloadCustsTemp")
    public void downloadCustsTemp(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        this.custManageSer.downloadCustsTemp(request, response);
    }

    /**
     * 打开上传Excel的窗口
     */
    @RequestMapping(value = "/custInfoFileUpload", method = RequestMethod.GET)
    public ModelAndView proInfoFileUpload() {
        return new ModelAndView("/cust/custManage/custInfoFileUpload");
    }

    /**
     * 查看上传表格的预览
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/custInfoPreview", method = RequestMethod.GET)
    public ModelAndView custInfoPreview(ModelMap modelMap) {
        // 取出临时表的字段名并放到modelMap里，命名为dataColumnsList
        try {
            List dataColumnsList = this.custManageSer.getCustColumnList();
            Map tmpMap = new HashMap();
            tmpMap.put("TITLE_NAME", "执行操作");
            tmpMap.put("TITLE_CODE", "FLAG");
            dataColumnsList.add(0, tmpMap);
            modelMap.put("dataColumnsList", JsonUtil.writeInternal(dataColumnsList));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("/cust/custManage/customerPreview", modelMap);
    }

    /**
     * 上传Excel并将Excel放入临时表中
     * @throws ParseException
     */
    @RequestMapping(value = "/uploadCustInfoTemplate", method = RequestMethod.POST)
    @ResponseBody
    public String uploadCustInfoTemplate(@RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
        String resultString = null;
        try {
            resultString = this.custManageSer.uploadCustInfoTemplate(file, request, response);
        } catch (Exception e) {
            resultString = "发生错误";
            e.printStackTrace();
        }
        return resultString;
    }

    /**
     * 获取临时表中的数据
     * @throws SQLException
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getCustTmpInfoList")
    @ResponseBody
    public Map getCustTmpInfoList(){
        List tmpInfoList;
        Map model = new HashMap();
        try {
            tmpInfoList = this.custManageSer.getCustTmpInfoList();
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
    @RequestMapping(value = "/saveCustTmpInfo", method = RequestMethod.POST)
    @ResponseBody
    public String saveCustTmpInfo(HttpServletRequest request) {
        String result = null;
        try {
            result = this.custManageSer.saveCustTmpInfo(request);
        } catch (Exception e) {
            e.printStackTrace();
            result = "保存出错";
        }
        return result;
    }
}
