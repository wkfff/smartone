package com.siping.web.utility;

import java.io.IOException;
import java.security.MessageDigest;
import java.util.Iterator;

import org.apache.commons.httpclient.*;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

public class SMSUtil {
    private static Logger logger = Logger.getLogger(SMSUtil.class);

    private static String TELCOMEURL = "http://open.fjii.com:8088/httpIntf/dealIntf";
    private static String SMSMETHODNAME = "SmsSend";
    private static String VOICENOTICE = "VoiceNotice";

    private static String spid = "";
    private static String appid = "";
    private static String pwd = "";
    private static String ims = "";
    private static String key = "";

    public String getSpid() {
        return spid;
    }

    public void setSpid(String spid) {
        this.spid = spid;
    }

    public String getAppid() {
        return appid;
    }

    public void setAppid(String appid) {
        this.appid = appid;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getIms() {
        return ims;
    }

    public void setIms(String ims) {
        this.ims = ims;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    /**
     * 通过中国电信IMS能力平台发送短信
     * @param mobileNumber 手机号
     * @param messageCounent 消息内容
     * @return
     */
    @SuppressWarnings("rawtypes")
    public static int sendSMSWithIMSTelcome(String mobileNumbber, String messageContent) {
        HttpClient httpClient = new HttpClient();
        GetMethod getMethod = new GetMethod(TELCOMEURL);
        NameValuePair smsParames = new NameValuePair("postData", getTelcomeSMSHttpPostdataParam(mobileNumbber, messageContent));
        NameValuePair[] nameValuePairs = { smsParames };

        try {
            if (null != nameValuePairs && nameValuePairs.length > 0)
                getMethod.setQueryString(nameValuePairs);
            int statusCode = httpClient.executeMethod(getMethod);
            if (statusCode == HttpStatus.SC_OK) {
                /*
                 * <Response> <Head> <Result>0</Result>
                 * <ResultDesc></ResultDesc>
                 * <Sessionid>37865625886674135538229797327676</Sessionid>
                 * </Head> </Response>
                 */
                SAXReader saxReader = new SAXReader();
                Document document = saxReader.read(getMethod.getResponseBodyAsStream());
                Element rootElement = document.getRootElement();
                return getResultCode(rootElement);
            }
        } catch (HttpException e) {
            logger.error("Network error");
        } catch (DocumentException e) {
            logger.error("Document stream parse error");
        } catch (IOException e) {
            logger.error("IO error");
        } finally {
            getMethod.releaseConnection();
        }
        return -1;
    }

    /**
     * 通过中国电信IMS能力平台发送语音信息
     * @param mobileNumber 手机号
     * @param messageCounent 消息内容
     * @return
     */
    @SuppressWarnings("rawtypes")
    public static int sendVoiceWithIMSTelcome(String mobileNumbber, String messageContent) {
        HttpClient httpClient = new HttpClient();
        GetMethod getMethod = new GetMethod(TELCOMEURL);
        NameValuePair smsParames = new NameValuePair("postData", getTelcomeVoiceHttpPostdataParam(mobileNumbber, messageContent));
        NameValuePair[] nameValuePairs = { smsParames };
        try {
            if (null != nameValuePairs && nameValuePairs.length > 0)
                getMethod.setQueryString(nameValuePairs);
            int statusCode = httpClient.executeMethod(getMethod);
            if (statusCode == HttpStatus.SC_OK) {
                /*
                 * 如果能够调用，则返回值为 <Response> <Head> <Result>-1</Result>
                 * <ResultDesc>短信发送接口暂时关闭，如有疑问请联系 系统管理员
                 * 联系号码:059522020009</ResultDesc> </Head> </Response>
                 */
                SAXReader saxReader = new SAXReader();
                Document document = saxReader.read(getMethod.getResponseBodyAsStream());
                Element rootElement = document.getRootElement();
                return getResultCode(rootElement);
            }
        } catch (HttpException e) {
            logger.error("Network error");
        } catch (DocumentException e) {
            logger.error("Document stream parse error");
        } catch (IOException e) {
            logger.error("IO error");
        } finally {
            getMethod.releaseConnection();
        }
        return -1;
    }

    private static String getTelcomeVoiceHttpPostdataParam(String mobileNum, String messageContent) {
        String returnString = "<Request><Head><MethodName>" + VOICENOTICE + "</MethodName><Spid>" + spid + "</Spid><Appid>" + appid + "</Appid><Passwd>" + sha1Encrypt(pwd)
            + "</Passwd></Head><Body><ChargeNbr>" + ims + "</ChargeNbr><Key>" + key + "</Key><DisplayNbr>" + ims + "</DisplayNbr><CalleeNbr>" + mobileNum + "</CalleeNbr><VoiceName></VoiceName><TTSContent>" + messageContent + "</TTSContent>"
            + "<vReplay></vReplay><ReplayTTS></ReplayTTS></Body></Request>";
        return returnString;
    }

    public static String sha1Encrypt(String Passwd) {
        MessageDigest md = null;
        try {
            md = MessageDigest.getInstance("SHA-1");
        } catch (Exception e) {
            return "";
        }
        md.update(Passwd.getBytes());
        byte[] bts = md.digest();
        String result = "";
        String tmp = "";
        for (int i = 0; i < bts.length; i++) {
            tmp = (Integer.toHexString(bts[i] & 0xFF));
            if (tmp.length() == 1)
                result += "0";
            result += tmp;
        }
        return result;
    }

    private static int getResultCode(Element rootElement) {
        for (Iterator i = rootElement.elementIterator(); i.hasNext();) {
            Element lv1node = (Element) i.next();
            for (Iterator j = lv1node.elementIterator(); j.hasNext();) {
                Element node = (Element) j.next();
                System.out.println(node.getName() + ":" + node.getText());
                if (node.getName().equals("Result"))
                    return Integer.parseInt(node.getTextTrim());
            }
        }
        return -1;
    }

    private static String getTelcomeSMSHttpPostdataParam(String mobileNum, String messageContent) {
        String returnString = "<Request><Head><MethodName>" + SMSMETHODNAME + "</MethodName><Spid>" + spid + "</Spid><Appid>" + appid + "</Appid><Passwd>" + sha1Encrypt(pwd)
            + "</Passwd></Head><Body><Ims>" + ims + "</Ims><Key>" + key + "</Key><CalleeNbr>" + mobileNum + "</CalleeNbr><SmsContent>" + messageContent + "</SmsContent></Body></Request>";
        return returnString;
    }

    public static void main(String[] args) {
        int m = sendSMSWithIMSTelcome("15828548629", "hello");
        System.out.println(m);
    }
}
