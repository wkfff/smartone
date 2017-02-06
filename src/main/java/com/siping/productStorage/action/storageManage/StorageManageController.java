package com.siping.productStorage.action.storageManage;

import com.siping.productStorage.service.StorageManageSer;
import com.siping.web.utility.JsonUtil;
import com.siping.web.utility.ObjectBindUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.springframework.web.bind.annotation.RequestMethod.POST;


@Controller
@RequestMapping(value = "/productStorage/storageManage")
public class StorageManageController {

    @Autowired
    private StorageManageSer storageManageSer;

    @RequestMapping(value = "/viewStorageList", method = RequestMethod.GET)
    public ModelAndView viewProductList(ModelMap modelMap) {

        return new ModelAndView("/productStorage/storageManage/viewStorageList", modelMap);
    }

    @RequestMapping(value = "/saveStorage", method = RequestMethod.POST)
    @ResponseBody
    public String saveStorage(HttpServletRequest request) {
        String returnString;
        try {
            returnString = this.storageManageSer.saveStorage(request);
        } catch (Exception e) {
            e.printStackTrace();
            returnString = e.getMessage();
        }
        return returnString;
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    @RequestMapping(value = "/getStorageList", method = POST)
    @ResponseBody
    public Map getStorageList(HttpServletRequest request) {
        List storageList = this.storageManageSer.getStorageList(request);
        int storageCount = this.storageManageSer.getStorageCount(request);

        Map model = new HashMap();
        model.put("Rows", storageList);
        model.put("Total", storageCount);
        return model;
    }

    @RequestMapping(value = "/deleteStorage", method = POST)
    @ResponseBody
    public String deleteSelectedStorage(HttpServletRequest request) {
        String resultString;
        resultString = this.storageManageSer.deleteStorage(request);
        return resultString;
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    @RequestMapping(value = "/getStorageProList", method = POST)
    @ResponseBody
    public Map getStorageProList(HttpServletRequest request) {
        List proList = this.storageManageSer.getStorageProList(request);
        int proCount = this.storageManageSer.getStorageProListCnt(request);
        Map model = new HashMap();
        model.put("Rows", proList);
        model.put("Total", proCount);
        return model;
    }

	@SuppressWarnings("rawtypes")
    @RequestMapping(value = "/viewProductTransfer", method = RequestMethod.GET)
    public ModelAndView viewProductTransfer(HttpServletRequest request,ModelMap modelMap) throws Exception {
	    List proList = this.storageManageSer.getStorageProList(request);
	    if(proList.size()>0){
	        modelMap.put("product", proList.get(0));
	    }
        return new ModelAndView("/productStorage/storageManage/viewProductTransfer", modelMap);
    }
	
	@RequestMapping(value = "/moveProduct", method = POST)
    @ResponseBody
    public String moveProduct(HttpServletRequest request) {
        String resultString;
        resultString = this.storageManageSer.moveStorage(request);
        return resultString;
    }
}
