package com.siping.cust.action;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siping.cust.bean.Receiver;
import com.siping.cust.service.CustReceiverSer;
import com.siping.web.bean.ReturnResult;

@Controller
@RequestMapping("/cust/custManager")
public class CustReceiverController {
    @Autowired
    private CustReceiverSer custReceiverSer;

    @RequestMapping("/addOrUpdateReceiver")
    @ResponseBody
    public ReturnResult addOrUpdateReceiver(HttpServletRequest request, @RequestBody Receiver receiver) {
        ReturnResult returnResult = new ReturnResult();
        if (receiver.getReceiverId() == null || receiver.getReceiverId() == ""){
            try {
                returnResult.setCode(0);
                returnResult.setMessage(this.custReceiverSer.addReceiver(request, receiver));
            } catch (SQLException e) {
                returnResult.setCode(-1);
                returnResult.setMessage(e.getMessage());
            }
        } else {
            try {
                returnResult.setCode(0);
                returnResult.setMessage(this.custReceiverSer.updateReceiver(request, receiver));
            } catch (SQLException e) {
                returnResult.setCode(-2);
                returnResult.setMessage(e.getMessage());
            }
        }
        return returnResult;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @ResponseBody
    @RequestMapping("/getReceiverList")
    public Map getReceiverList(HttpServletRequest request) {
        List list = this.custReceiverSer.getReceiverList(request);
        int total = this.custReceiverSer.getReceiverCnt(request);
        Map map = new HashMap();
        map.put("Rows", list);
        map.put("Total", total);
        return map;
    }

    @RequestMapping("/deleteReceiver")
    @ResponseBody
    public ReturnResult deleteReceiver(HttpServletRequest request,@RequestParam(value="receiverId", required=true) String receiverId) {
        ReturnResult returnResult = new ReturnResult();
        try{
            returnResult.setCode(0);
            returnResult.setMessage(this.custReceiverSer.deleteReceiver(request, receiverId));
        }catch(SQLException e){
            returnResult.setCode(-1);
            returnResult.setMessage(e.getMessage());
        }
        return returnResult;
    }

    @RequestMapping("/getReceiver")
    public Object getReceiver(HttpServletRequest request) {
        return this.custReceiverSer.getReceiver(request);
    }
}
