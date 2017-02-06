package com.siping.bom.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.bom.bean.Bom;
import com.siping.bom.bean.BomItem;
import com.siping.bom.service.BOMInfoSer;
import com.siping.doc.bean.MetaData;
import com.siping.process.bean.PagerRequest;
import com.siping.process.bean.PagerResult;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/bom/bomInfo")
public class BOMInfoCtroller {
    Logger logger = Logger.getLogger(BOMInfoCtroller.class);

    @Autowired
    private BOMInfoSer bomInfoSer;

    @RequestMapping(value = "/viewBOMList", method = RequestMethod.GET)
    public ModelAndView viewBOMList(HttpServletRequest request, ModelMap modelMap) {
        return new ModelAndView("/bom/bomInfo/viewBOMList", modelMap);
    }

    @RequestMapping(value = "/viewBOMTree", method = RequestMethod.GET)
    public ModelAndView viewBOMTree(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("paramMap", ObjectBindUtil.getRequestParamData(request));
        return new ModelAndView("/bom/bomInfo/viewBOMTree", modelMap);
    }

    @RequestMapping(value = "/getBOMTreeList", method = RequestMethod.GET)
    @ResponseBody
    public List<Bom> getBOMTreeList(HttpServletRequest request, @RequestParam("bomNo") Long bomNo) {
        List<Bom> bomList = new ArrayList<Bom>();
        try {
            Map<String, Object> params = ObjectBindUtil.getRequestParams(request);
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            params.put(MetaData.KEY, metaData);

            Bom bom = new Bom();
            bom.setNo(bomNo);
            bom.setMetaData(metaData);

            bomList = this.bomInfoSer.getBOMList(params, null);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return bomList;
    }

    @RequestMapping(value = "/viewBOMDetail", method = RequestMethod.GET)
    public ModelAndView viewBOMDetail(HttpServletRequest request, ModelMap modelMap, @RequestParam("bomNo") Long bomNo) {
        try {
            Map<String, Object> params = ObjectBindUtil.getRequestParams(request);
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            params.put(MetaData.KEY, metaData);

            Bom bom = new Bom();
            bom.setNo(bomNo);
            bom.setMetaData(metaData);

            modelMap.put(Bom.KEY, this.bomInfoSer.getBOMDetail(bom));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return new ModelAndView("/bom/bomInfo/viewBOMDetail", modelMap);
    }

    @RequestMapping(value = "/getBOMList", method = RequestMethod.POST)
    @ResponseBody
    public PagerResult<Bom> getBOMList(HttpServletRequest request, @RequestParam(value = PagerRequest.KEY_PAGE, required = false) int page,
                                       @RequestParam(value = PagerRequest.KEY_PAGESIZE, required = false) int pagesize) {
        PagerResult<Bom> result = new PagerResult<Bom>();
        PagerRequest pagerRequest = new PagerRequest(page, pagesize);

        try {
            Map<String, Object> params = ObjectBindUtil.getRequestParams(request);
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            params.put(MetaData.KEY, metaData);

            result.setRows(this.bomInfoSer.getBOMList(params, pagerRequest));
            result.setTotal(this.bomInfoSer.getBOMListCnt(params));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/getBOMItemList", method = RequestMethod.POST)
    @ResponseBody
    public PagerResult<BomItem> getBOMItemList(HttpServletRequest request, @RequestParam(value = PagerRequest.KEY_PAGE, required = false) int page,
                                               @RequestParam(value = PagerRequest.KEY_PAGESIZE, required = false) int pagesize, @RequestParam("bomNo") Long bomNo) {
        PagerResult<BomItem> result = new PagerResult<BomItem>();
        PagerRequest pagerRequest = new PagerRequest(page, pagesize);
        try {
            Map<String, Object> params = ObjectBindUtil.getRequestParams(request);
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            params.put(MetaData.KEY, metaData);

            Bom bom = new Bom();
            bom.setNo(bomNo);
            bom.setMetaData(metaData);
            params.put(Bom.KEY, bom);

            result.setRows(this.bomInfoSer.getBOMItemList(params, pagerRequest));
            result.setTotal(this.bomInfoSer.getBOMItemListCnt(params));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return result;
    }

}
