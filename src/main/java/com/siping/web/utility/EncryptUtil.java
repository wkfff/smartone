/*
 * @(#)EncryptUtil.java 1.0 2012-01-09 下午01:14:31
 *
 *Copyright 2010 - 2011 SipingSoft. All Rights Reserved.
 */
package com.siping.web.utility;

import java.security.MessageDigest;
import org.apache.log4j.Logger;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;

/**
 * Copyright: SipingSoft (c) Company: SipingSoft
 * 
 * @author (sipingSoft@SipingSoft.com)
 * @Date 2012-01-09 下午01:14:31
 * @version 1.0
 * 
 */
public class EncryptUtil {

	@SuppressWarnings("unused")
	private Logger logger = Logger.getLogger(EncryptUtil.class);

	private EncryptUtil() {
		/* empty */
	} 
	/**
	 * md5加密
	 * md5 length: 32
	 * @param inputText
	 * @return
	 */
	public static String md5(String inputText) {
		return encrypt(inputText, "md5");
	} 
	/**
	 * sha加密
	 * sha length: 40
	 * @param inputText
	 * @return
	 */
	public static String sha(String inputText) {
		return encrypt(inputText, "sha-1");
	} 
	/**
	 * md5或者sha-1加密
	 * 
	 * @param inputText
	 *            要加密的内容
	 * @param algorithmName
	 *            加密算法名称：md5或者sha-1，不区分大小写
	 * @return
	 */
	private static String encrypt(String inputText, String algorithmName) {
		if (algorithmName == null || "".equals(algorithmName.trim())) {
			algorithmName = "md5";
		}
		String encryptText = null;
		try {
			MessageDigest m = MessageDigest.getInstance(algorithmName);
			m.update(inputText.getBytes("UTF8"));
			byte s[] = m.digest();
			m.digest(inputText.getBytes("UTF8"));
			return hex(s);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return encryptText;
	}
	/**
	 * 返回十六进制字符串
	 * @param arr
	 * @return
	 */
	private static String hex(byte[] arr) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < arr.length; ++i) {
			sb.append(Integer.toHexString((arr[i] & 0xFF) | 0x100).substring(1,
					3));
		}
		return sb.toString();
	}
    public static String MD5Encode(String origin) {
    	StringBuffer sb = new StringBuffer();
    	try {
    		MessageDigest md = MessageDigest.getInstance("MD5");
    		md.update(origin.getBytes("utf8"));
    		byte[] result = md.digest();
    		for (int i = 0; i < result.length; i++) {
    			//int val = result[i] & 0xff;
    			//sb.append(Integer.toHexString(val));
    			int val = (result[i] & 0x000000ff) | 0xffffff00;
    			sb.append(Integer.toHexString(val).substring(6));
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    
    	return sb.toString();
    }
}
