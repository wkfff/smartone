package com.siping.pa.service.imp.salary;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.pa.dao.salary.PaProgressDao;
import com.siping.pa.service.salary.PaProgressSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class PaProgressSerImp implements PaProgressSer {

	Logger logger = Logger.getLogger(PaProgressSerImp.class);

	@Autowired
	private PaProgressDao paProgressDao;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object getPaProgressObjectInfo(HttpServletRequest request) {
		Object retrunObj = new Object();

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		// 判断PA_MONTH参数是否为空,为空赋予当前月
		if (paramMap.get("PA_MONTH") == null) {
			paramMap.put("PA_MONTH", DateUtil.getSysdateString("yyyyMM"));
		}
		retrunObj = this.paProgressDao.getPaProgressObjectInfo(paramMap);

		return retrunObj;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getPaProgressInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		// 判断PA_MONTH参数是否为空,为空赋予当前月
		if (paramMap.get("PA_MONTH") == null) {
			paramMap.put("PA_MONTH", DateUtil.getSysdateString("yyyyMM"));
		}

		retrunList = this.paProgressDao.getPaProgressInfo(paramMap);

		return retrunList;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int updatePaProgressInfo(HttpServletRequest request) {

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		// 页面提交数据
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());

		this.paProgressDao.updatePaProgressInfo(paramMap);

		return 0;
	}

	@SuppressWarnings({ "rawtypes" })
	public int getPaProgressPaLockFlag(HttpServletRequest request) {
		int paLockFalg = 0;

		Object retrunObj = this.getPaProgressInfo(request);
		if (retrunObj != null) {
			LinkedHashMap paProgressMap = (LinkedHashMap) retrunObj;
			paLockFalg = NumberUtils.parseNumber(ObjectUtils.toString(
					paProgressMap.get("PA_LOCK_FLAG"), "0"), Integer.class);
		}

		return paLockFalg;
	}

	@SuppressWarnings({ "rawtypes" })
	public int getPaProgressLockFlag(HttpServletRequest request) {
		int lockFalg = 0;
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		LinkedHashMap paProgressMap = (LinkedHashMap) this
				.getPaProgressObjectInfo(request);
		if (paProgressMap != null) {
			String flag = paramMap.get("LOCK_FLAG").toString();
			lockFalg = NumberUtils.parseNumber(ObjectUtils.toString(
					paProgressMap.get(flag), "0"), Integer.class);
		}

		return lockFalg;
	}

}
