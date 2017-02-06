package com.siping.system.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.cxf.jaxws.JaxWsProxyFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.system.bean.License;
import com.siping.system.service.LicenseSer;
import com.siping.system.service.LicenseWebSer;
import com.siping.web.utility.LicenseUtil;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

@Controller
public class LicenseController {

    @Autowired
    private LicenseUtil licenseUtil;
    @Autowired
    private LicenseSer licenseSer;

    @RequestMapping(value = "/activate/keyActivate", method = RequestMethod.GET)
    public ModelAndView keyActivate(HttpServletRequest request) throws Exception {
        return new ModelAndView("/system/license/keyActivate");
    }

    @RequestMapping(value = "/activate/activate", method = RequestMethod.POST)
    @ResponseBody
    public String activate(License license,HttpServletRequest request){
        String result = "N";
        String licenseKey = licenseUtil.encodeBack(license.getLicenseKey());
        
        String localActivateType = String.valueOf(license.getActivateType());
        String keyActivateType = licenseKey.substring(16, 17);
        
        if(!localActivateType.equals(keyActivateType)){
            return "无效注册码";
        }
        
        if(license.getActivateType() == 0){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            license.setActivateType(Integer.valueOf(keyActivateType));
            license.setUseType(licenseKey.substring(15, 16));
            try {
                license.setStartDate(sdf.parse(licenseKey.substring(5,13)));
                license.setEndDate(sdf.parse(licenseKey.substring(17,25)));
            } catch (ParseException e) {
                license.setStartDate(null);
                license.setEndDate(null);
                e.printStackTrace();
            }
            result = licenseUtil.checkLicense(license);
            if("Y".equals(result)){
                try {
                    //result = this.licenseSer.addOrUpdateLicense(license);
                	int licenseCnt = this.licenseSer.getLicenseCnt(license);
                	if(licenseCnt <1){
                		result = this.licenseSer.addLicense(license);
                	}else{
                		result = this.licenseSer.updateLicense(license);
                	}
                } catch (Exception e) {
                    result = "激活码验证通过，但由于网络原因未能激活，请重试1111";
                    e.printStackTrace();
                }
            }
        }else{
            JaxWsProxyFactoryBean factory = new JaxWsProxyFactoryBean();
            factory.setServiceClass(LicenseWebSer.class);
            factory.setAddress("http://license.sipingsoft.com/ws/licenseWebService");
            LicenseWebSer service = (LicenseWebSer) factory.create();
            
            /*WebService客户端连接测试*/
            license = service.checkLicenseByNet(license);
            
            result = licenseUtil.checkLicense(license);
            
            if("Y".equals(result)){
                try {
                    license.setLicenseId(null);
                    result = this.licenseSer.addOrUpdateLicense(license);
                } catch (Exception e) {
                    result = "激活码验证通过，但由于网络原因未能激活，请重试2222";
                    e.printStackTrace();
                }
            }
            if("Y".equals(result)){
                license.setStatus(1);
                service.updateLicenseStatusByKey(license);
            }
        }
        if("Y".equals(result)){
            try {
                result = licenseUtil.updatePropertiesFile(request.getSession().getServletContext(),license);
            } catch (Exception e) {
                result = "验证成功，但写入本地时失败，请联系服务商";
                e.printStackTrace();
            }
        }
        if("Y".equals(result)){
            License license2 = new License();
            licenseUtil.getLicenseByProperties(request.getSession().getServletContext(),license2);
            request.getSession().getServletContext().setAttribute("license", license2);
        }
        return result;
    }

    @RequestMapping(value = "/license/viewLicenseManage", method = GET)
    public String viewLicenseManage(ModelMap modelMap) {
        return "/system/license/viewLicenseManage";
    }

    /**
     * 获取产品信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/license/getLicenseList", method = RequestMethod.POST)
    @ResponseBody
    public Map getLicenseList(HttpServletRequest request) throws Exception {
        List<License> licenseList = this.licenseSer.getLicenseList(request);
        int licenseListCnt = this.licenseSer.getLicenseListCnt(request);
        Map model = new HashMap();
        model.put("Rows", licenseList);
        model.put("Total", licenseListCnt);
        return model;
    }
    
    @RequestMapping(value = "/license/viewExtendLimitation", method = GET)
    public String viewExtendLimitation(){
        return "/system/license/viewExtendLimitation";
    }

    @RequestMapping(value = "/license/extendLimitation", method = POST)
    @ResponseBody
    public String extendLimitation(@RequestParam String activationType, @RequestParam String licenseKey){
        
        return "Successfully activate!";
    }
}
