package com.siping.ass.action;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.ass.service.AssInfoSer;
import com.siping.web.utility.ObjectBindUtil;

@Controller
@RequestMapping(value = "/ass/assInfo")
public class AssInfoController {

    @Autowired
    private AssInfoSer assInfoSer;

    @RequestMapping(value = "/viewAssetDetail", method = RequestMethod.GET)
    public ModelAndView viewAssetDetail(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("assetDetail", this.assInfoSer.getAssetDetail(request));
        return new ModelAndView("/ass/assInfo/viewAssetDetail", modelMap);
    }

    @RequestMapping(value = "/viewAssetList", method = RequestMethod.GET)
    public ModelAndView viewAssetList(HttpServletRequest request) {
        return new ModelAndView("/ass/assInfo/viewAssetList");
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getAssetList", method = RequestMethod.POST)
    @ResponseBody
    public Map getAssetList(HttpServletRequest request, HttpServletResponse response) {
        Map modelMap = new HashMap();
        modelMap.put("Rows", this.assInfoSer.getAssetList(request));
        modelMap.put("Total", this.assInfoSer.getAssetListCnt(request));
        return modelMap;
    }

    @RequestMapping(value = "/viewBorrowRecord")
    public ModelAndView viewBorrowRecord(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("assetDetail", ObjectBindUtil.getRequestParamData(request));
        return new ModelAndView("/ass/assInfo/viewBorrowRecord", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getBorrowRecord", method = RequestMethod.POST)
    @ResponseBody
    public Map getBorrowRecord(HttpServletRequest request, HttpServletResponse response) {
        Map model = new HashMap();
        model.put("toolLoanList", this.assInfoSer.getBorrowRecord(request));
        return model;
    }

    /**
     * 资产借用记录
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getBorrowRecordList", method = RequestMethod.POST)
    @ResponseBody
    public Map getBorrowRecordList(HttpServletRequest request) throws Exception {
        List empInfoList = this.assInfoSer.getBorrowRecordList(request);
        int empInfoCnt = this.assInfoSer.getBorrowRecordListCnt(request);
        Map model = new HashMap();
        model.put("Rows", empInfoList);
        model.put("Total", empInfoCnt);
        return model;
    }

    /**
     * 报损情况列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getAssBrokenSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getAssBrokenSelectList(HttpServletRequest request) throws Exception {
        List listMap = this.assInfoSer.getAssBrokenSelectList(request);
        return listMap;
    }

    @RequestMapping(value = "/assReturnUpdate", method = RequestMethod.POST)
    @ResponseBody
    public String assReturnUpdate(HttpServletRequest request) throws Exception {
        String flag = this.assInfoSer.assReturnUpdate(request);
        if (flag.equals("Y")) {
            return "Y";
        } else {
            return "N";
        }
    }
}
