package com.siping.wechat.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.siping.wechat.bean.AccessToken;
import com.siping.wechat.bean.Oauth2Token;
import com.siping.wechat.bean.WechatUser;
import com.siping.wechat.bean.WechatUserList;

/**
 * 微信工具类
 * @author: LHQ
 * @date: 2014年5月26日 下午5:08:48
 * @email: daysinsun@gmail.com
 * @function:
 * @version :
 */
public class WeChatUtil {
    /**
     * 检查签名，用于微信设置url时认证
     * @param signature
     * @param timestamp
     * @param nonce
     * @return
     */
    public static boolean checkSignature(String signature, String timestamp, String nonce) {
        String[] arr = new String[] { WeChatConstant.TOKEN, timestamp, nonce };
        /**
         * 将token、timestamp、nonce三个参数进行字典序排序
         */
        Arrays.sort(arr);
        StringBuilder content = new StringBuilder();
        for (int i = 0; i < arr.length; i++) {
            content.append(arr[i]);
        }
        MessageDigest md = null;
        String tmpStr = null;

        try {
            md = MessageDigest.getInstance("SHA-1");
            /**
             * 将三个参数字符串拼接成一个字符串进行sha1加密
             */
            byte[] digest = md.digest(content.toString().getBytes());
            tmpStr = byteToStr(digest);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        content = null;
        return tmpStr != null ? tmpStr.equals(signature.toUpperCase()) : false;
    }

    /**
     * 将字节数组转换为十六进制字符串
     * @param byteArray
     * @return
     */
    private static String byteToStr(byte[] byteArray) {
        String strDigest = "";
        for (int i = 0; i < byteArray.length; i++) {
            strDigest += byteToHexStr(byteArray[i]);
        }
        return strDigest;
    }

    /**
     * 将字节转换为十六进制字符串
     * @param mByte
     * @return
     */
    private static String byteToHexStr(byte mByte) {
        char[] Digit = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
        char[] tempArr = new char[2];
        tempArr[0] = Digit[(mByte >>> 4) & 0X0F];
        tempArr[1] = Digit[mByte & 0X0F];
        String s = new String(tempArr);
        return s;
    }
    
    /**
     * 访问url将返回值转换为Json对象
     * @param requestUrl
     * @param requestMethod
     * @param outputStr
     * @return
     */
    public static JSONObject httpRequest(String requestUrl, String requestMethod, String outputStr) {
        JSONObject jsonObject = null;
        StringBuffer buffer = new StringBuffer();
        try {
            /**
             * 创建SSLContext对象
             */
            TrustManager[] tm = { new MyX509TrustManager() };
            SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
            sslContext.init(null, tm, new java.security.SecureRandom());
            /**
             * 从上述SSLContext对象中得到SSLSocketFactory对象
             */
            SSLSocketFactory ssf = sslContext.getSocketFactory();

            URL url = new URL(requestUrl);
            HttpsURLConnection httpUrlConn = (HttpsURLConnection) url.openConnection();
            httpUrlConn.setSSLSocketFactory(ssf);

            httpUrlConn.setDoOutput(true);
            httpUrlConn.setDoInput(true);
            httpUrlConn.setUseCaches(false);
            /**
             * 设置请求方式（GET/POST）
             */
            httpUrlConn.setRequestMethod(requestMethod);

            if ("GET".equalsIgnoreCase(requestMethod))
                httpUrlConn.connect();

            /**
             * 当有数据需要提交时
             */
            if (null != outputStr) {
                OutputStream outputStream = httpUrlConn.getOutputStream();
                outputStream.write(outputStr.getBytes("UTF-8"));
                outputStream.close();
            }

            /**
             * 将返回的输入流转换成字符串
             */
            InputStream inputStream = httpUrlConn.getInputStream();
            InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

            String str = null;
            while ((str = bufferedReader.readLine()) != null) {
                buffer.append(str);
            }
            jsonObject = new JSONObject(buffer.toString());
            /**
             * 释放资源
             */
            bufferedReader.close();
            inputStreamReader.close();
            inputStream.close();
            httpUrlConn.disconnect();
        } catch (ConnectException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

        }
        return jsonObject;
    }

    /**
     * 获取用户信息的方法
     * @param accessToken
     * @param openid
     * @return
     */
    public static WechatUser getUserInfo(String accessToken, String openid) {
        WechatUser info = null;
        String url = WeChatConstant.GET_USERINFO_URL;
        url = url.replace("ACCESS_TOKEN", accessToken).replace("OPENID", openid);
        JSONObject jsonObject = httpRequest(url, "GET", null);
        // System.out.println(jsonObject);
        if (null != jsonObject) {
            info = new WechatUser();
            try {
                info.setOpenid(jsonObject.getString("openid"));
                info.setSubscribe(jsonObject.getInt("subscribe"));
                info.setSubscribeTime(formatTime(jsonObject.getString("subscribe_time")));
                info.setNickname(jsonObject.getString("nickname"));
                info.setSex(jsonObject.getInt("sex"));
                info.setCountry(jsonObject.getString("country"));
                info.setProvince(jsonObject.getString("province"));
                info.setCity(jsonObject.getString("city"));
                info.setHeadImgUrl(jsonObject.getString("headimgurl"));
            } catch (JSONException e) {
                e.printStackTrace();
                return null;
            }
        }
        return info;
    }

    /**
     * 获取access_token
     * @param appid
     * @param appSecret
     * @return
     */
    public static AccessToken getAccessToken(String appid, String appSecret) {
        AccessToken token = null;
        String url = WeChatConstant.GTE_ACCESSTOKEN_URL;
        String requestUrl = url.replace("APPID", appid).replace("APPSECRET", appSecret);
        JSONObject jsonObject = httpRequest(requestUrl, "GET", null);
        if (null != jsonObject) {
            try {
                token = new AccessToken();
                token.setToken(jsonObject.getString("access_token"));
                token.setExpiresIn(jsonObject.getInt("expires_in"));
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        }
        return token;
    }

    /**
     * 获取oauth的消息
     * @param appid
     * @param appSecret
     * @param code
     * @return
     */
    public static Oauth2Token getOauth2Token(String appid, String appSecret, String code) {
        Oauth2Token oauthToken = null;
        String requestURL = WeChatConstant.GET_OAUTH_URL;
        requestURL = requestURL.replace("APPID", appid);
        requestURL = requestURL.replace("SECRET", appSecret);
        requestURL = requestURL.replace("CODE", code);
        JSONObject jsonObject = WeChatUtil.httpRequest(requestURL, "GET", null);
        if (null != jsonObject) {
            try {
                oauthToken = new Oauth2Token();
                oauthToken.setAccessToken(jsonObject.getString("access_token"));
                oauthToken.setExpiresIn(jsonObject.getString("expires_in"));
                oauthToken.setRefreshToken(jsonObject.getString("refresh_token"));
                oauthToken.setOpenId(jsonObject.getString("openid"));
                oauthToken.setScope(jsonObject.getString("scope"));
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        }
        return oauthToken;
    }

    /**
     * 根据OAuth2token获取UserInfo
     * @param accessToken
     * @param openId
     * @return
     */
    public static WechatUser getOAuth2UserInfo(String accessToken, String openId) {
        WechatUser userInfo = null;
        String requestUrl = WeChatConstant.GET_OAUTH_USER;
        requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken).replace("OPENID", openId);
        JSONObject jsonObject = httpRequest(requestUrl, "GET", null);
        if (null != jsonObject) {
            userInfo = new WechatUser();
            try {
                userInfo.setOpenid(jsonObject.getString("openid"));
                userInfo.setNickname(jsonObject.getString("nickname"));
                userInfo.setSex(jsonObject.getInt("sex"));
                userInfo.setCountry(jsonObject.getString("country"));
                userInfo.setProvince(jsonObject.getString("province"));
                userInfo.setCity(jsonObject.getString("city"));
                userInfo.setHeadImgUrl(jsonObject.getString("headimgurl"));
                userInfo.setSubscribeTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
            } catch (JSONException e) {
                e.printStackTrace();
                return null;
            }
        }
        return userInfo;
    }

    public static WechatUserList getUserList(String token, String nextOpenId) {
        WechatUserList userList = null;
        if (null == nextOpenId) {
            nextOpenId = "";
            String url = WeChatConstant.GET_USER_OPENID;
            url = url.replace("ACCESS_TOKEN", token).replace("NEXT_OPENID", nextOpenId);
            JSONObject jsonObject = httpRequest(url, "GET", null);
            if (null != jsonObject) {
                try {
                    userList = new WechatUserList();
                    userList.setTotal(jsonObject.getInt("total"));
                    userList.setCount(jsonObject.getInt("count"));
                    userList.setNextOpenId(jsonObject.getString("next_openid"));
                    JSONObject dataObject = (JSONObject) jsonObject.get("data");
                    JSONArray array = dataObject.getJSONArray("openid");
                    List<String> openidList = new ArrayList<String>();
                    for (int i = 0; i < array.length(); i++) {
                        openidList.add(array.get(i).toString());
                    }
                    userList.setOpenidList(openidList);
                } catch (Exception e) {
                    e.printStackTrace();
                    return null;
                }
            }
        }
        return userList;
    }

    /**
     * 将微信的long类型的时间转换为yyyy-MM-dd的日期字符串
     * @param createTime
     * @return
     */
    public static String formatTime(String createTime) {
        /**
         * 将微信传入的CreateTime转换成long类型，再乘以1000
         */
        long msgCreateTime = Long.parseLong(createTime) * 1000L;
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return format.format(new Date(msgCreateTime));
    }

    /**
     * 将微信信息的xml解析为map类型，便于获取
     * @param request
     * @return
     * @throws IOException
     * @throws DocumentException
     */
    @SuppressWarnings("unchecked")
    public static Map<String, String> parseXml(HttpServletRequest request) throws IOException, DocumentException {
        /**
         * 从request中取得输入流
         */
        InputStream inputStream = request.getInputStream();
        /**
         * 读取输入流
         */
        Document document = new SAXReader().read(inputStream);
        /**
         * 得到xml根元素
         */
        Element root = document.getRootElement();
        /**
         * 将解析结果存储在HashMap中
         */
        Map<String, String> map = new HashMap<String, String>();
        /**
         * 遍历所有子节点
         */
        for (Element e : (List<Element>) root.elements()) {
            map.put(e.getName(), e.getText());
        }
        inputStream.close();

        return map;
    }

}
