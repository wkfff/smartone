package com.siping.productStorage.action.productManage;

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
import com.siping.hrm.action.EmpInfoCtroller;
import com.siping.productStorage.service.ProductSer;
import com.siping.web.utility.JsonUtil;

@Controller
@RequestMapping(value = "/productStorage/productManage")
public class ProductManageController {
    Logger logger = Logger.getLogger(EmpInfoCtroller.class);
    @Autowired
    private ProductSer productSer;

    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/viewProductList", method = RequestMethod.GET)
    public ModelAndView viewProductList(HttpServletRequest request, ModelMap modelMap) throws Exception {
        //获取商品显示列
        List proColumnsList = this.productSer.getProColumns(request);
        modelMap.put("proColumnsList", JsonUtil.writeInternal(proColumnsList));
        return new ModelAndView("/productStorage/productManage/viewProductList", modelMap);
    }

    /**
     * 获取产品信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getProductList", method = RequestMethod.POST)
    @ResponseBody
    public Map getProductList(HttpServletRequest request) throws Exception {
        List<HashMap> productList = this.productSer.getProductList(request);
        int productListCnt = this.productSer.getProductListCnt(request);
        Map model = new HashMap();
        model.put("Rows", productList);
        model.put("Total", productListCnt);
        return model;
    }

    /**
     * 查看货品详细信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/viewProductDetail", method = RequestMethod.GET)
    public ModelAndView viewProductDetail(HttpServletRequest request, ModelMap modelMap) throws Exception {

        List<HashMap> productList = this.productSer.getProductList(request);
        Map map = this.productSer.getProStorageSaleDetail(request);
        modelMap.put("product", productList.get(0));
        modelMap.put("p_valueList", map.get("p_valueList"));

        return new ModelAndView("/productStorage/productManage/viewProductDetail", modelMap);
    }

    /**
     * 点击更新商品时获取商品库存及销售渠道详细信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getProductListUpdate", method = RequestMethod.POST)
    @ResponseBody
    public Map getProductListUpdate(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        Map map = this.productSer.getProStorageSaleDetail(request);

        model.put("p_valueList", map.get("p_valueList"));
        model.put("storList", map.get("storList"));
        model.put("saleList", map.get("saleList"));

        return model;
    }

    /**
     * 添加产品信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addOrUpdateProduct", method = RequestMethod.POST)
    @ResponseBody
    public String addOrUpdateProduct(HttpServletRequest request) throws Exception {
        String returnString = "";
        returnString = this.productSer.addOrUpdateProduct(request);
        return returnString;
    }

    /**
     * 删除商品信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deleteProduct", method = RequestMethod.POST)
    @ResponseBody
    public String deleteSalesModel(HttpServletRequest request) {
        String returnString = "Y";
        returnString = this.productSer.deleteProduct(request);
        return returnString;
    }

    /**
     * 获取货物库存详细信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getProStorDetailList", method = RequestMethod.POST)
    @ResponseBody
    public Map getProStorDetailList(HttpServletRequest request) throws Exception {

        List<HashMap> productList = this.productSer.getProStorDetailList(request);
        int productListCnt = this.productSer.getProStorDetailListCnt(request);
        Map model = new HashMap();
        model.put("Rows", productList);
        model.put("Total", productListCnt);

        return model;
    }

    /**
     * 获取货物销售详细信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getProSaleDetailList", method = RequestMethod.POST)
    @ResponseBody
    public Map getProSaleDetailList(HttpServletRequest request) throws Exception {

        List<HashMap> productList = this.productSer.getProSaleDetailList(request);
        int productListCnt = this.productSer.getProSaleDetailListCnt(request);
        Map model = new HashMap();
        model.put("Rows", productList);
        model.put("Total", productListCnt);

        return model;
    }

    @RequestMapping(value = "/viewProductReport", method = RequestMethod.GET)
    public void viewProductReport(HttpServletRequest request, HttpServletResponse response) throws Exception {
        this.productSer.viewProductReport(request, response);
    }

    @RequestMapping(value = "/productImport", method = RequestMethod.GET)
    public ModelAndView productImport() throws Exception {
        return new ModelAndView("/productStorage/productManage/productImport");
    }

    @RequestMapping(value = "/downloadProductsTemp")
    public void downloadProductsTemp(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        this.productSer.downloadProductsTemp(request, response);
    }

    /**
     * 打开上传Excel的窗口
     */
    @RequestMapping(value = "/proInfoFileUpload", method = RequestMethod.GET)
    public ModelAndView proInfoFileUpload() {
        return new ModelAndView("/productStorage/productManage/proInfoFileUpload");
    }

    /**
     * 查看上传表格的预览
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/proInfoPreview", method = RequestMethod.GET)
    public ModelAndView proInfoPreview(ModelMap modelMap) {
        // 取出临时表的字段名并放到modelMap里，命名为dataColumnsList
        try {
            List dataColumnsList = this.productSer.getProColumnList();
            Map tmpMap = new HashMap();
            tmpMap.put("TITLE_NAME", "执行操作");
            tmpMap.put("TITLE_CODE", "FLAG");
            dataColumnsList.add(0, tmpMap);
            modelMap.put("dataColumnsList", JsonUtil.writeInternal(dataColumnsList));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("/productStorage/productManage/productPreview", modelMap);
    }

    /**
     * 上传Excel并将Excel放入临时表中
     * @throws ParseException
     */
    @RequestMapping(value = "/uploadProInfoTemplate", method = RequestMethod.POST)
    @ResponseBody
    public String uploadProInfoTemplate(@RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
        String resultString = null;
        try {
            resultString = this.productSer.uploadProInfoTemplate(file, request, response);
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
    @RequestMapping(value = "/getProTmpInfoList")
    @ResponseBody
    public Map getProTmpInfoList(){
        List tmpInfoList;
        Map model = new HashMap();
        try {
            tmpInfoList = this.productSer.getProTmpInfoList();
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
    @RequestMapping(value = "/saveProTmpInfo", method = RequestMethod.POST)
    @ResponseBody
    public String saveProTmpInfo(HttpServletRequest request) {
        String result = null;
        try {
            result = this.productSer.saveProTmpInfo(request);
        } catch (Exception e) {
            e.printStackTrace();
            result = "保存出错";
        }
        return result;
    }
}
