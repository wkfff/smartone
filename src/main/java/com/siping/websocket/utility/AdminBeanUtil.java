package com.siping.websocket.utility;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.siping.system.bean.AdminBean;
import com.siping.web.utility.DateUtil;

public class AdminBeanUtil {

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public static Map beanToMap(AdminBean admin) {
        Map resultMap = new HashMap();
        String name = admin.getChineseName();
        resultMap.put("name", name);
        String eName = admin.getEnglishName();
        resultMap.put("eName", eName);
        String empid = admin.getAdminID();
        resultMap.put("empid", empid);
        String date = DateUtil.formatDate(new Date(), "yyyy-MM-dd hh:mm:ss");
        resultMap.put("date", date);
        return resultMap;
    }
}
