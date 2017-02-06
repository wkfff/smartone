package com.siping.productStorage.action.proBusinessManage;

import java.util.HashMap;
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
import com.siping.productStorage.service.SalesModelSer;


@Controller
@RequestMapping(value="/productStorage/proBusinessManage")
public class SalesModelManageController {

	Logger logger = Logger.getLogger(EmpInfoCtroller.class);
	@Autowired
	private SalesModelSer salesModelSer; 
	
	/**
	 * 进入销售渠道界面
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/viewSalesModelList", method=RequestMethod.GET)
	public ModelAndView viewProductList(HttpServletRequest request, ModelMap modelMap){

		return new ModelAndView("/productStorage/proBusinessManage/viewSalesModelList", modelMap);
	}

	/**
	 * 获取销售方式信息
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */ 
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getSalesModelList", method = RequestMethod.POST)
	@ResponseBody
	public Map getSalesModelList(HttpServletRequest request) throws Exception {
 
		List salesModelList = this.salesModelSer.getSalesModelList(request);
		int salesModelListCnt = this.salesModelSer.getSalesModelListCnt(request);
		Map model = new HashMap();
		model.put("Rows", salesModelList);
		model.put("Total", salesModelListCnt);
		return model;
	}
	
	/**
	 * 添加或修改销售方式
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping(value = "/addOrUpdateSalesModel", method = RequestMethod.POST)
	@ResponseBody
	public String addOrUpdateSalesModel(HttpServletRequest request) throws Exception {
		String returnString = "Y";
		returnString = this.salesModelSer.addOrUpdateSalesModel(request);
		return returnString;
	}
	
	/**
	 * 删除销售方式
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping(value = "/deleteSalesModel", method = RequestMethod.POST)
	@ResponseBody
	public String deleteSalesModel(HttpServletRequest request){
		String returnString = "Y";
		int temp = this.salesModelSer.checkSalesDistri(request);
		if(temp<=0){
			returnString = this.salesModelSer.deleteSalesModel(request);
		}else{
			returnString = "该销售方式已经被分配给货品，不能删除";
		}
		return returnString;
	}
	
	/**
     * 修改移动端显示价格
     * 
     * @param request
     * @return
     * @throws Exception
     */ 
    @RequestMapping(value = "/updateSalesMobileStatus", method = RequestMethod.POST)
    @ResponseBody
    public String updateSalesMobileStatus(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        returnString = this.salesModelSer.updateSalesMobileStatus(request);
        return returnString;
    }
}
