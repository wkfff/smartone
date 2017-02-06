package com.siping.productStorage.action.taoBaoProManage;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.hrm.action.EmpInfoCtroller;
import com.siping.productStorage.service.TaoBaoManageSer;
import com.siping.system.service.SystemSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.taobao.api.domain.AddressResult;
import com.taobao.api.domain.Item;
import com.taobao.api.domain.ItemCat;
import com.taobao.api.domain.LogisticsCompany;
import com.taobao.api.domain.Shop;
import com.taobao.api.domain.Trade;
import com.taobao.api.domain.User;

@Controller
@RequestMapping(value = "/productStorage/taoBaoProManage")
public class taoBaoProManageController {
    Logger logger = Logger.getLogger(EmpInfoCtroller.class);
    @Autowired
    private TaoBaoManageSer taoBaoManageSer;
    @Autowired
    private SystemSer systemSer;
    
    /**
     * 登陆淘宝页面
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewTaoBaoLogin", method = RequestMethod.GET)
    public ModelAndView viewTaoBaoLogin(HttpServletRequest request) throws Exception {
        return new ModelAndView("/productStorage/taoBaoProManage/viewTaoBaoLogin");
    }
    
    /**
     * 检查淘宝账号和授权码是否正确
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/checkTaoBaoLogin", method = RequestMethod.POST)
    @ResponseBody
    public String checkTaoBaoLogin(HttpServletRequest request) {
        String returnString = "N";
        User seller = taoBaoManageSer.getSellerBySessionKey(request);
        if(seller != null && seller.getNick() != null && seller.getNick().equals(String.valueOf(request.getParameter("nick")))){
            Shop shop = this.taoBaoManageSer.getShopByNick(request);
            //将淘宝账号信息及key存入session中，视为已经登录淘宝
            request.getSession().setAttribute("taoBaoShop", shop);
            request.getSession().setAttribute("taoBaoSeller", seller);
            request.getSession().setAttribute("sessionKey", request.getParameter("sessionKey"));
            returnString = "Y";
        }
        return returnString;
    }
    
    /**
     * 淘宝店铺商品查看界面
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewTaoBaoProList", method = RequestMethod.GET)
    public ModelAndView viewTaoBaoProList(HttpServletRequest request, ModelMap modelMap) throws Exception {
        Date date2 = new Date(System.currentTimeMillis()+1000*60*60*24);
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        int year = cal.get(Calendar.YEAR);
        String m = "";
        String y = "";
        if(month>=10){
            m = String.valueOf(month);
        }else{
            m = "0"+String.valueOf(month);
        }
        if(year>=10){
            y = String.valueOf(year);
        }else{
            y = "0"+String.valueOf(year);
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        modelMap.put("startDate", y+"-"+m+"-01 00:00:00");
        modelMap.put("endDate", sdf.format(date2)+" 00:00:00");
        return new ModelAndView("/productStorage/taoBaoProManage/viewTaoBaoProList",modelMap);
    }
    
    /**
     * 获取淘宝商铺商品信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getTaoBaoProList", method = RequestMethod.POST)
    @ResponseBody
    public Map getTaoBaoProList(HttpServletRequest request) throws Exception {
        String status = request.getParameter("status");
        
        List<Item> taoBaoproList = new ArrayList<Item>();
        if(status != null && "1".equals(status)){
            taoBaoproList = this.taoBaoManageSer.getTaoBaoProOnSale(request);
        }else if(status != null && "2".equals(status)){
            taoBaoproList = this.taoBaoManageSer.getTaoBaoProOnSale(request);
        }else if(status != null && "3".equals(status)){
            taoBaoproList = this.taoBaoManageSer.getTaoBaoProOnSale(request);
        }else if(status != null && "4".equals(status)){
            taoBaoproList = this.taoBaoManageSer.getTaoBaoProOnSale(request);
        }
        
        List<LinkedHashMap<String, Object>> itemList = new ArrayList<LinkedHashMap<String,Object>>();
        LinkedHashMap<String, Object> paramMap;
        for(int i=0;i<taoBaoproList.size();i++){
            paramMap = new LinkedHashMap<String, Object>();
            paramMap.put("numIid", taoBaoproList.get(i).getNumIid());
            paramMap.put("outerId", taoBaoproList.get(i).getOuterId());
            paramMap.put("title", taoBaoproList.get(i).getTitle());
            paramMap.put("price", taoBaoproList.get(i).getPrice());
            paramMap.put("num", taoBaoproList.get(i).getNum());
            List<ItemCat> list = this.taoBaoManageSer.getTaoBaoCatById(request, taoBaoproList.get(i).getCid().toString());
            if(list!=null&&list.size()>0){
                paramMap.put("catName", list.get(0).getName());
            }
            itemList.add(paramMap);
        }
        Map model = new HashMap();
        model.put("Rows", itemList);
        model.put("Total", 999);
        return model;
    }
    
    /**
     * 从淘宝店铺中删除商品
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/removeProFromTaoBao", method = RequestMethod.POST)
    @ResponseBody
    public String removeProFromTaoBao(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        returnString = this.taoBaoManageSer.removeProFromTaoBao(request);
        return returnString;
    }
    
    /**
     * 获取淘宝商铺订单信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getTaoBaoTradeList", method = RequestMethod.POST)
    @ResponseBody
    public Map getTaoBaoTradeList(HttpServletRequest request) throws Exception {
        List<Trade> taoBaoTradeList = this.taoBaoManageSer.getTaoBaoTradeList(request);
        String flag = "Y";
        for(int i=0;i<taoBaoTradeList.size();i++){
            flag = this.taoBaoManageSer.checkOrderTaobao(request, taoBaoTradeList.get(i).getTid().toString());
            if("N".equals(flag)){
                taoBaoTradeList.get(i).setType("IN_ALREADY");
            }
        }
        Map model = new HashMap();
        model.put("Rows", taoBaoTradeList);
        model.put("Total", 11);
        return model;
    }
    
    /**
     * 获取淘宝订单状态
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getTaoBaoStatus", method = RequestMethod.POST)
    @ResponseBody
    public List<Map> getTaoBaoStatus(HttpServletRequest request) throws Exception {
        Map paramMap = new LinkedHashMap();
        paramMap.put("parentCode", request.getParameter("parentCode"));
        paramMap.put("language", Messages.getLanguage(request));

        List<Map> codeList = systemSer.getSystemCode(paramMap);
        return codeList;
    }
    
    /**
     * 添加宝贝至系统中
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addOrUpdateProduct", method = RequestMethod.POST)
    @ResponseBody
    public String addOrUpdateProduct(HttpServletRequest request) {
        String returnString = "Y";
        try {
            returnString = this.taoBaoManageSer.addOrUpdateProduct(request);
        } catch (Exception e) {
            returnString = "操作失败，可能是网络原因，请稍后再试！！";
            e.printStackTrace();
        }
        return returnString;
    }
    
    /**
     * 查询该淘宝用户是否已经添加至系统中成为客户
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/checkCustIdByTaobaoId", method = RequestMethod.POST)
    @ResponseBody
    public String getCustIdByTaobaoId(HttpServletRequest request) throws Exception {
        List list = this.taoBaoManageSer.getCustById(request);
        if(list!=null && list.size() > 0){
            return "N";
        }
        return "Y";
    }
    
    /**
     * 生成销售单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/saveOrderFromTaobao", method = RequestMethod.POST)
    @ResponseBody
    public List<Map> saveOrderFromTaobao(HttpServletRequest request) throws Exception {
        List<Map> list = this.taoBaoManageSer.saveOrderFromTaobao(request);
        return list;
    }
    
    /**
     * 退出淘宝登录
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/quitTaobao", method = RequestMethod.POST)
    @ResponseBody
    public String quitTaobao(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        request.getSession().removeAttribute("taoBaoShop");
        request.getSession().removeAttribute("taoBaoSeller");
        request.getSession().removeAttribute("sessionKey");
        return returnString;
    }
    
    /**
     * 发货界面
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/viewSendGoods", method = RequestMethod.GET)
    public ModelAndView viewSendGoods(HttpServletRequest request) throws Exception {
        String jsonData = request.getParameter("trade");
        List<LinkedHashMap<String, Object>> orderList = ObjectBindUtil.getRequestJsonData("["+jsonData+"]");
        Map model = new HashMap();
        model.put("trade", orderList.get(0));
        return new ModelAndView("/productStorage/taoBaoProManage/viewSendGoods",model);
    }
    
    /**
     * 获取卖家地址库
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getSellerAddress", method = RequestMethod.POST)
    @ResponseBody
    public List<AddressResult> getSellerAddress(HttpServletRequest request) throws Exception {
        List<AddressResult> list = new ArrayList<AddressResult>();
        list = this.taoBaoManageSer.getSellerAddress(request);
        return list;
    }
    
    /**
     * 获取物流公司
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getLogCompanies", method = RequestMethod.POST)
    @ResponseBody
    public List<LogisticsCompany> getLogCompanies(HttpServletRequest request) throws Exception {
        List<LogisticsCompany> list = new ArrayList<LogisticsCompany>();
        list = this.taoBaoManageSer.getLogCompanies(request);
        return list;
    }
    
    /**
     * 发货保存
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/saveSend", method = RequestMethod.POST)
    @ResponseBody
    public String saveSend(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        returnString = this.taoBaoManageSer.saveSend(request);
        return returnString;
    }
    
    /**
     * 获取授权码回调页面
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getAuthCode", method = RequestMethod.GET)
    public ModelAndView getAuthCode(HttpServletRequest request) throws Exception {
        String top_session = request.getParameter("top_session");
        Map model = new HashMap();
        model.put("top_session", top_session);
        return new ModelAndView("/productStorage/taoBaoProManage/getAuthCode",model);
    }
    
    /**
     * 修改宝贝信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateItem", method = RequestMethod.POST)
    @ResponseBody
    public String updateItem(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        returnString = this.taoBaoManageSer.updateItem(request);
        return returnString;
    }
}
