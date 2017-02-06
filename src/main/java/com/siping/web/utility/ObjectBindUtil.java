/*
 * @(#)DateTag.java 1.0 2012-01-09 下午01:14:31Copyright 2010 - 2011 SipingSoft.
 * All Rights Reserved.
 */
package com.siping.web.utility;

import java.io.IOException;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;

/**
 * Copyright: SipingSoft (c) Company: SipingSoft
 * @author (sipingSoft@SipingSoft.com)
 * @version 1.0
 * @Date 2012-01-09 下午01:14:31
 */
public class ObjectBindUtil {

    @SuppressWarnings("unused")
    private Logger logger = Logger.getLogger(ObjectBindUtil.class);

    private ObjectBindUtil() {
        /* empty */
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    public static LinkedHashMap getAllRequestParamData(HttpServletRequest request) {
        LinkedHashMap data = new LinkedHashMap();
        Enumeration e = request.getParameterNames();
        while (e.hasMoreElements()) {
            String key = (String) e.nextElement();
            data.put(key, request.getParameter(key));
        }
        return getUserRelatedParam(request, data);
    }

    private static LinkedHashMap getUserRelatedParam(HttpServletRequest request, LinkedHashMap data) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        data.put("language", Messages.getLanguage(request));
        data.put("CPNY_ID", admin.getCpnyId());
        return data;
    }

    /**
     * bind parameter data to Map object from Request Object
     * @param req
     * @return LinkedHashMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public static LinkedHashMap getRequestParamData(HttpServletRequest request) {
        LinkedHashMap data = new LinkedHashMap();
        Enumeration e = request.getParameterNames();
        while (e.hasMoreElements()) {
            String key = (String) e.nextElement();
            data.put(key, request.getParameter(key));
        }
        return data;
    }

    /**
     * bind parameters to Map object from Request Object
     * @param req
     * @return LinkedHashMap
     */
    public static LinkedHashMap<String, Object> getRequestParams(HttpServletRequest request) {
        LinkedHashMap<String, Object> data = new LinkedHashMap<String, Object>();
        Enumeration<String> e = request.getParameterNames();
        while (e.hasMoreElements()) {
            String key = e.nextElement();
            data.put(key, request.getParameter(key));
        }
        return data;
    }

    /**
     * bind parameter data to Map object from Request Object
     * @param req
     * @return LinkedHashMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public static LinkedHashMap getRequestParamData(HttpServletRequest request, String embellish) {
        LinkedHashMap data = new LinkedHashMap();
        Enumeration e = request.getParameterNames();
        while (e.hasMoreElements()) {
            String key = (String) e.nextElement();
            if (key.indexOf(embellish) > 0) {
                data.put(key.replaceAll(embellish, ""), request.getParameter(key));
            }
        }
        return data;
    }

    /**
     * parse json string to Class<T> object
     * @param req
     * @return List<T>>
     * @throws Exception
     */
    public static <T> List<T> parseRequestJsonDataToList(String jsonData, Class<T> objectType) throws Exception {
        List<T> objectList = new ArrayList<T>(10);
        T[] array = null;
        try {
            JSONArray tempObject = JSONArray.fromObject(jsonData);
            array = (T[]) JSONArray.toArray(tempObject, objectType);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        for (int i = 0; i < array.length; i++) {
            objectList.add(array[i]);
        }

        return objectList;
    }

    /**
     * parse json string to Class<T> object
     * @param req
     * @return List<T>>
     * @throws Exception
     */
    public static <T> T parseRequestJsonDataToObject(String jsonData, Class<T> objectType) throws Exception {
        T object = null;
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            object = objectMapper.readValue(jsonData, objectType);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }

        return object;
    }

    /**
     * parse json string to Class<T> object
     * @param req
     * @return List<T>>
     * @throws Exception
     */
    public static <T> List<T> parseRequestJsonDataToListWithJacason(String jsonData, Class<T[]> arrayType) throws Exception {
        List<T> objectList = new ArrayList<T>(10);
        T[] array = null;
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            array = (T[]) objectMapper.readValue(jsonData, arrayType);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        for (int i = 0; i < array.length; i++) {
            objectList.add(array[i]);
        }

        return objectList;
    }

    /**
     * bind json string to List<Map> object
     * @param req
     * @return List<LinkedHashMap<String, Object>>
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public static List<LinkedHashMap<String, Object>> getRequestJsonData(String jsonString, String status, LinkedHashMap<String, Object> appendMap) {
        List<LinkedHashMap<String, Object>> returnList = new ArrayList(10);
        try {
            List<LinkedHashMap<String, Object>> jsonDataList = JsonUtil.getUpdateList(jsonString);
            if (status == null && appendMap == null) {
                returnList = jsonDataList;
            } else {
                int jsonDataListSzie = jsonDataList.size();

                for (int i = 0; i < jsonDataListSzie; ++i) {
                    LinkedHashMap<String, Object> map = jsonDataList.get(i);

                    // System.out.println(map);

                    if (status != null) {
                        String __status = ObjectUtils.toString(map.get("__status"));
                        if (__status.equals(status)) {
                            if (appendMap != null) {
                                map.putAll(appendMap);
                            }

                            returnList.add(map);
                        }
                    } else {
                        if (appendMap != null) {
                            map.putAll(appendMap);
                        }
                        returnList.add(map);
                    }
                }
            }

        } catch (JsonParseException e) {
            e.printStackTrace();
        } catch (JsonMappingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * bind json string to List<Map> object
     * @param req
     * @return List<LinkedHashMap<String, Object>>
     */
    public static List<LinkedHashMap<String, Object>> getRequestJsonData(String jsonString, String status) {

        return getRequestJsonData(jsonString, status, null);
    }

    /**
     * bind json string to List<Map> object
     * @param req
     * @return List<LinkedHashMap<String, Object>>
     */
    public static List<LinkedHashMap<String, Object>> getRequestJsonData(String jsonString) {

        return getRequestJsonData(jsonString, null, null);
    }

    /**
     * bind json string to List<Map> object
     * @param req
     * @return List<LinkedHashMap<String, Object>>
     */
    public static List<LinkedHashMap<String, Object>> getRequestJsonData(String jsonString, LinkedHashMap<String, Object> appendMap) {

        return getRequestJsonData(jsonString, null, appendMap);
    }

    /**
     * bind appendMap to List<Map> object
     * @param req
     * @return List<LinkedHashMap<String, Object>>
     */
    public static List<LinkedHashMap<String, Object>> getRequestListData(List<LinkedHashMap<String, Object>> mainMapList, LinkedHashMap<String, Object> appendMap) {
        for (LinkedHashMap<String, Object> nodeMap : mainMapList) {
            nodeMap.putAll(appendMap);
        }
        return mainMapList;
    }
}
