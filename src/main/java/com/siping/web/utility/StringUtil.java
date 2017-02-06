package com.siping.web.utility;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Title: String utility Company: SipingSoft Description: do some string
 * operation Copyright: Copyright (c) 2010
 * 
 * @author
 * @version 1.0
 */
public class StringUtil {

	protected StringUtil() {
	}

	/**
	 * 语言选择
	 * 
	 * @param param
	 * @param mMap
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public static String changeLanguage(Object param, Map mMap) {
		if (param == null)
			return "";
		param = param.toString();
		param = param.toString().replaceAll("\\(", "\\( ");
		param = param.toString().replaceAll("\\)", " \\)");
		param = param.toString().replaceAll("\\,", " \\, ");
		String str[] = param.toString().trim().split(" ");
		for (int i = 0; i < str.length; i++) {
			if (str[i].indexOf("'") == -1) {
				if (mMap.get(str[i]) != null)
					str[i] = mMap.get(str[i].toUpperCase()) + "";
			}
		}
		String returnparam = "";
		for (int i = 0; i < str.length; i++) {
			returnparam += str[i] + " ";
		}
		return returnparam;
	}

	/**
	 * 产生指定大小的序列号
	 * 
	 * @param size
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static Map getDoubleSerialMap(double size) {
		Map object2 = new LinkedHashMap();
		List Rows = new ArrayList<Object>();
		for (double i = 0; i <= size; i = i + 0.5) {
			Map object1 = new LinkedHashMap();
			object1.put("ID", String.valueOf(i));
			object1.put("NAME", String.valueOf(i));
			object1.put("EN_NAME", String.valueOf(i));
			Rows.add(object1);
		}
		object2.put("Rows", Rows != null ? Rows : null);
		object2.put("Total", Rows != null ? Rows.size() : 0);
		return object2;
	}

	/**
	 * 产生指定大小的序列号
	 * 
	 * @param size
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static List getDoubleSerialList(double size) {
		List Rows = new ArrayList<Object>();
		for (double i = 0; i <= size; i = i + 0.5) {
			Map object1 = new LinkedHashMap();
			object1.put("ID", String.valueOf(i));
			object1.put("NAME", String.valueOf(i));
			object1.put("EN_NAME", String.valueOf(i));
			Rows.add(object1);
		}
		return Rows;
	}

	/**
	 * 产生指定大小的序列号
	 * 
	 * @param size
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static Map getIntSerialMap(int size, String removeNum) {
		Map object2 = new LinkedHashMap();
		List Rows = new ArrayList<Object>();
		for (int i = 0; i <= size; i = i + 1) {
			Map object1 = new LinkedHashMap();
			if (removeNum != null && !removeNum.equals("")
					&& (i + "").equals(removeNum)) {
				object1 = null;
			} else {
				object1.put("ID", String.valueOf(i));
				object1.put("NAME", String.valueOf(i));
				object1.put("EN_NAME", String.valueOf(i));
				Rows.add(object1);
			}
		}
		object2.put("Rows", Rows != null ? Rows : null);
		object2.put("Total", Rows != null ? Rows.size() : 0);
		return object2;
	}

	/**
	 * 产生指定大小的序列号
	 * 
	 * @param size
	 * @param removeNum
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static List getIntSerialList(int size, String removeNum) {
		List Rows = new ArrayList<Object>();
		for (int i = 0; i <= size; i = i + 1) {
			Map object1 = new LinkedHashMap();
			if (removeNum != null && !removeNum.equals("")
					&& (i + "").equals(removeNum)) {
				object1 = null;
			} else {
				object1.put("ID", String.valueOf(i));
				object1.put("NAME", String.valueOf(i));
				object1.put("EN_NAME", String.valueOf(i));
				Rows.add(object1);
			}
		}
		return Rows;
	}

	/**
	 * 产生指定大小的序列号
	 * 
	 * @param size
	 * @param removeNum
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static List getOrderSelectList(int size, String removeNum) {
		List Rows = new ArrayList<Object>();
		for (int i = 0; i <= size; i = i + 1) {
			Map object1 = new LinkedHashMap();
			if (removeNum != null && !removeNum.equals("")
					&& (i + "").equals(removeNum)) {
				object1 = null;
			} else {
				object1.put("ORDERNO", String.valueOf(i));
				object1.put("ORDERNO_NAME", String.valueOf(i));
				Rows.add(object1);
			}
		}
		return Rows;
	}

	/**
	 * 产生指定大小的序列号
	 * 
	 * @param size
	 * @param removeNum
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static List getDepthSelectList(int size, String removeNum) {
		List Rows = new ArrayList<Object>();
		for (int i = 0; i <= size; i = i + 1) {
			Map object1 = new LinkedHashMap();
			if (removeNum != null && !removeNum.equals("")
					&& (i + "").equals(removeNum)) {
				object1 = null;
			} else {
				object1.put("DEPTH", String.valueOf(i));
				object1.put("DEPTH_NAME", String.valueOf(i));
				Rows.add(object1);
			}
		}
		return Rows;
	}

	/**
	 * 产生指定大小的序列号
	 * 
	 * @param size
	 * @param removeNum
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static List getLevelSelectList(int size, String removeNum) {
		List Rows = new ArrayList<Object>();
		for (int i = 0; i <= size; i = i + 1) {
			Map object1 = new LinkedHashMap();
			if (removeNum != null && !removeNum.equals("")
					&& (i + "").equals(removeNum)) {
				object1 = null;
			} else {
				object1.put("LEVEL_ID", String.valueOf(i));
				object1.put("LEVEL_NAME", String.valueOf(i));
				Rows.add(object1);
			}
		}
		return Rows;
	}
	
	/**
	 * 产生指定大小的序列号
	 * 
	 * @param size
	 * @param removeNum
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static List getCalcFlagSelectList(Map obj) {
		List Rows = new ArrayList<Object>();
		for (int i = 0; i <= 1; i = i + 1) {
			Map object1 = new LinkedHashMap();
			if (obj.get("language").equals("zh")) {
				if (i == 0) {
					object1.put("CALC_FLAG_ID", "Y");
					object1.put("CALC_FLAG_NAME", "是");
				}
				if (i == 1) {
					object1.put("CALC_FLAG_ID", "N");
					object1.put("CALC_FLAG_NAME", "否");
				}
			} else {
				if (i == 0) {
					object1.put("CALC_FLAG_ID", "Y");
					object1.put("CALC_FLAG_NAME", "Yes");
				}
				if (i == 1) {
					object1.put("CALC_FLAG_ID", "N");
					object1.put("CALC_FLAG_NAME", "No");
				}
			}
			Rows.add(object1);
		}
		return Rows;
	}
	/**
	 * 产生指定大小的序列号
	 * 
	 * @param size
	 * @param removeNum
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static List getYesOrNoSelectList(Map obj) {
		List Rows = new ArrayList<Object>();
		for (int i = 0; i <= 1; i = i + 1) {
			Map object1 = new LinkedHashMap();
			if (obj.get("language").equals("zh")) {
				if (i == 0) {
					object1.put("YN_ID", "yes");
					object1.put("YN_NAME", "是");
				}
				if (i == 1) {
					object1.put("YN_ID", "no");
					object1.put("YN_NAME", "否");
				}
			} else {
				if (i == 0) {
					object1.put("YN_ID", "yes");
					object1.put("YN_NAME", "Yes");
				}
				if (i == 1) {
					object1.put("YN_ID", "no");
					object1.put("YN_NAME", "No");
				}
			}
			Rows.add(object1);
		}
		return Rows;
	}

	/**
	 * 产生指定大小的序列号
	 * 
	 * @param size
	 * @param removeNum
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static List getLockSelectList() {
		List Rows = new ArrayList<Object>();
		for (int i = 0; i <= 1; i = i + 1) {
			Map object1 = new LinkedHashMap();
			if (i == 0) {
				object1.put("ID", "Y");
				object1.put("NAME", "锁定");
				object1.put("EN_NAME", "Locked");
			}
			if (i == 1) {
				object1.put("ID", "N");
				object1.put("NAME", "未锁定");
				object1.put("EN_NAME", "Unlocked");
			}
			Rows.add(object1);
		}
		return Rows;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static List stringToList(String s) {
		Hashtable hash = new Hashtable();
		int tagA = s.indexOf("\r\n");
		int tagB = s.indexOf(",");
		int tagC = s.indexOf("，");
		int tagD = s.indexOf(";");
		int tagF = s.indexOf("。");

		if (tagA != -1) {
			String[] a = s.split("\r\n");
			if (a.length > 0) {
				for (int i = 0; i < a.length; i++) {
					hash.put(i, a[i].trim());
				}
			}
		}
		if (tagB != -1) {
			String[] b = s.split(",");
			if (b.length > 0) {
				for (int i = 0; i < b.length; i++) {
					hash.put(i, b[i].trim());
				}
			}
		}
		if (tagC != -1) {
			String[] c = s.split("，");
			if (c.length > 0) {
				for (int i = 0; i < c.length; i++) {
					hash.put(i, c[i].trim());
				}
			}
		}
		if (tagD != -1) {
			String[] c = s.split(";");
			if (c.length > 0) {
				for (int i = 0; i < c.length; i++) {
					hash.put(i, c[i].trim());
				}
			}
		}
		if (tagF != -1) {
			String[] c = s.split("。");
			if (c.length > 0) {
				for (int i = 0; i < c.length; i++) {
					hash.put(i, c[i].trim());
				}
			}
		}
		if (tagA == -1 && tagB == -1 && tagC == -1 && tagD == -1 && tagF == -1) {
			hash.put(0, s);
		}
		List<Object> infoList = new ArrayList<Object>();
		for (int i = 0; i < hash.size(); i++) {
			infoList.add(hash.get(i));
		}
		return infoList;
	}

	/**
	 * 
	 * @param s
	 * @return
	 */
	public static String checkNull(Object s) {
		return checkNull(s, "");
	}

	/**
	 * 
	 * @param s
	 * @param defaultValue
	 * @return
	 */
	public static String checkNull(Object s, String defaultValue) {
		if (s == null || s.equals("")) {
			return defaultValue;
		} else {
			return s.toString().trim();
		}
	}

	/**
	 * String to hash
	 * 
	 * @param s
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static Hashtable stringToHash(String s) {
		Hashtable hash = new Hashtable();
		if (s != null && !s.equals("")) {
			int tagA = s.indexOf("\r\n");
			int tagB = s.indexOf(",");
			int tagC = s.indexOf("，");
			int tagD = s.indexOf(";");
			int tagE = s.indexOf(".");
			int tagF = s.indexOf("。");

			if (tagA != -1) {
				String[] a = s.split("\r\n");
				if (a.length > 0) {
					for (int i = 0; i < a.length; i++) {
						hash.put(i, a[i].trim());
					}
				}
			}
			if (tagB != -1) {
				String[] b = s.split(",");
				if (b.length > 0) {
					for (int i = 0; i < b.length; i++) {
						hash.put(i, b[i].trim());
					}
				}
			}
			if (tagC != -1) {
				String[] c = s.split("，");
				if (c.length > 0) {
					for (int i = 0; i < c.length; i++) {
						hash.put(i, c[i].trim());
					}
				}
			}
			if (tagD != -1) {
				String[] c = s.split(";");
				if (c.length > 0) {
					for (int i = 0; i < c.length; i++) {
						hash.put(i, c[i].trim());
					}
				}
			}
			if (tagE != -1) {
				String[] c = s.split("[.]");
				if (c.length > 0) {
					for (int i = 0; i < c.length; i++) {
						hash.put(i, c[i].trim());
					}
				}
			}
			if (tagF != -1) {
				String[] c = s.split("。");
				if (c.length > 0) {
					for (int i = 0; i < c.length; i++) {
						hash.put(i, c[i].trim());
					}
				}
			}
			if (tagA == -1 && tagB == -1 && tagC == -1 && tagD == -1
					&& tagE == -1 && tagF == -1) {
				hash.put(0, s);
			} 
		}
		return hash;
	}

	/**
	 * hash to List
	 * 
	 * @param s
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public static List hashToList(Hashtable hash) {
		List<Object> returnList = new ArrayList<Object>();
		if(!hash.isEmpty()){
			for (int i = 0; i < hash.size(); i++) {
				returnList.add(hash.get(i));
			}
		}
		return returnList;
	}
}
