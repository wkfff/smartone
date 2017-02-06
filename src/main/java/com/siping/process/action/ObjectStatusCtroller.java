package com.siping.process.action;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

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

import com.siping.doc.bean.MetaData;
import com.siping.doc.bean.RequestResult;
import com.siping.process.bean.PagerRequest;
import com.siping.process.bean.PagerResult;
import com.siping.process.bean.State;
import com.siping.process.service.ObjectStatusSer;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/process/objectStatus")
public class ObjectStatusCtroller {
    Logger logger = Logger.getLogger(ObjectStatusCtroller.class);

    @Autowired
    private ObjectStatusSer objectStatusSer;

    @RequestMapping(value = "/viewObjectStatusList", method = RequestMethod.GET)
    public ModelAndView viewObjectStatusList(HttpServletRequest request, ModelMap modelMap) {
        return new ModelAndView("/process/objectStatus/viewObjectStatusList", modelMap);
    }

    @RequestMapping(value = "/getObjectStatusList", method = RequestMethod.POST)
    @ResponseBody
    public PagerResult<State> getObjectStatusList(HttpServletRequest request, ModelMap modelMap, @RequestParam(value = PagerRequest.KEY_PAGE, required = false) int page,
                                                  @RequestParam(value = PagerRequest.KEY_PAGESIZE, required = false) int pagesize) {
        PagerRequest pagerRequest = new PagerRequest(page, pagesize);
        LinkedHashMap<String, Object> params = ObjectBindUtil.getRequestParams(request);

        PagerResult<State> pagerResult = new PagerResult<State>();
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            params.put(MetaData.KEY, metaData);

            pagerResult.setRows(this.objectStatusSer.getObjectStatusList(params, pagerRequest));
            pagerResult.setTotal(this.objectStatusSer.getObjectStatusListCnt(params));
        } catch (Exception e) {
            logger.error("Fail to get data" + e.getMessage());
        }
        return pagerResult;
    }

    @RequestMapping(value = "/transferObjectStatus", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> transferObjectStatus(HttpServletRequest request, ModelMap modelMap, @RequestParam("jsonData") String jsonData) {
        RequestResult<String> result = new RequestResult<String>();

        try {
            List<State> dataList = ObjectBindUtil.parseRequestJsonDataToList(jsonData, State.class);
            List<State> insertList = new ArrayList<State>();
            List<State> updateList = new ArrayList<State>();

            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            for (State oneState : dataList) {
                if (oneState.getNo() == null || oneState.getNo() == 0L) {
                    insertList.add(oneState);
                } else {
                    updateList.add(oneState);
                }
                oneState.setMetaData(metaData);
            }

            if (insertList.size() > 0) {
                this.objectStatusSer.addStatus(insertList);
            }
            if (updateList.size() > 0) {
                this.objectStatusSer.updateStatus(updateList);
            }
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }


    @RequestMapping(value = "/removeObjectStatus", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> removeObjectStatus(HttpServletRequest request, ModelMap modelMap, @RequestParam("stateNo") Long stateNo) {
        RequestResult<String> result = new RequestResult<String>();
        State state = new State();
        state.setNo(stateNo);
        state.setActive(false);

        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            state.setMetaData(metaData);
            this.objectStatusSer.removeState(state);
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }
}
