package com.siping.web.utility;

import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.JsonEncoding;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class JsonUtil {

	public static ObjectMapper objectMapper = new ObjectMapper();

	public static boolean prefixJson = false;

	public static JsonEncoding jsonEncoding = JsonEncoding.UTF8;

	public static ObjectMapper getObjectMapper() {
		return objectMapper;
	}

	public static void setObjectMapper(ObjectMapper objectMapper1) {
		objectMapper = objectMapper1;
	}

	public static boolean isPrefixJson() {
		return prefixJson;
	}

	public static void setPrefixJson(boolean prefixJson1) {
		prefixJson = prefixJson1;
	}

	public static JsonEncoding getJsonEncoding() {
		return jsonEncoding;
	}

	public static void setJsonEncoding(JsonEncoding jsonEncoding1) {
		jsonEncoding = jsonEncoding1;
	}

	/**
	 * 将json字符串转换成List<LinkedHashMap<String,Object>>
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static List<LinkedHashMap<String, Object>> getUpdateList(
			HttpServletRequest request) throws Exception {
		List<LinkedHashMap<String, Object>> list = objectMapper.readValue(
				getJsonString(request.getInputStream()), List.class);
		return list;
	}

	/**
	 * 将json字符串转换成List<LinkedHashMap<String,Object>>
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static List<LinkedHashMap<String, Object>> getUpdateList(
			String JsonString) throws Exception {
		List<LinkedHashMap<String, Object>> list = objectMapper.readValue(
				JsonString, List.class);
		return list;
	}

	/**
	 * 将ajax传入的json对象重新utf-8编码返回
	 * 
	 * @param sis
	 * @return
	 * @throws IOException
	 */
	public static synchronized String getJsonString(ServletInputStream sis)
			throws IOException {
		byte b[] = new byte[1024];
		int read = sis.readLine(b, 0, b.length);
		StringBuffer line = new StringBuffer();
		while (read > 0) {
			line.append(new String(b, 0, read, "utf-8"));
			read = sis.readLine(b, 0, b.length);
		}
		return line.toString();
	}

	/**
	 * 将传入对象（map,list<map>）转换成json字符串
	 * 
	 * @param o
	 * @return
	 * @throws Exception
	 */
	public static String writeInternal(Object o) throws Exception {
		String temp = "";
		try {
			temp = objectMapper.writeValueAsString(o);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return temp;
	}

	/**
	 * 生成Json格式的数据
	 * 
	 * @param contacts
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static String deptInfoToJson(
			List<LinkedHashMap<Object, Object>> inforList) {
		try {
			JSONArray jsonArray = new JSONArray();
			for (LinkedHashMap paramap : inforList) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("deptID", paramap.get("DEPTID"));
				jsonObject.put("deptName", paramap.get("DEPTNAME"));
				jsonObject.put("parentDeptID", paramap.get("PARENT_DEPT_ID"));
				if (paramap.get("ISCHECKED").equals("true")) {
					jsonObject.put("ischecked", paramap.get("ISCHECKED"));
				}
				jsonArray.put(jsonObject);
			}
			return jsonArray.toString();
		} catch (JSONException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 生成Json格式的数据
	 * 
	 * @param contacts
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static String areaInfoToJson(
			List<LinkedHashMap<Object, Object>> inforList) {
		try {
			JSONArray jsonArray = new JSONArray();
			for (LinkedHashMap paramap : inforList) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("ID", paramap.get("ID"));
				jsonObject.put("Name", paramap.get("NAME"));
				// jsonObject.put("parentID", paramap.get("PARENT_ID"));

				jsonArray.put(jsonObject);
			}
			return jsonArray.toString();
		} catch (JSONException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 生成Json格式的数据
	 * 
	 * @param contacts
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static String btInfoToJson(
			List<LinkedHashMap<Object, Object>> inforList) {
		try {
			JSONArray jsonArray = new JSONArray();
			for (LinkedHashMap paramap : inforList) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("ID", paramap.get("BT_NO"));
				jsonObject.put("Name", paramap.get("BT_NAME"));

				jsonArray.put(jsonObject);
			}
			return jsonArray.toString();
		} catch (JSONException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 生成Json格式的数据
	 * 
	 * @param contacts
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static String proInfoToJson(
			List<LinkedHashMap<Object, Object>> inforList) {
		try {
			JSONArray jsonArray = new JSONArray();
			for (LinkedHashMap paramap : inforList) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("ID", paramap.get("PRO_ID"));
				jsonObject.put("Name", paramap.get("PRO_NAME"));

				jsonArray.put(jsonObject);
			}
			return jsonArray.toString();
		} catch (JSONException e) {
			e.printStackTrace();
			return null;
		}
	}
	/**
	 * 查询出来的生产订单及图纸号生成Json格式的数据
	 * 
	 * @param contacts
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static String productionOrderInfoToJson(
			List<LinkedHashMap<Object, Object>> inforList) {
		try {
			JSONArray jsonArray = new JSONArray();
			for (LinkedHashMap paramap : inforList) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("ID", paramap.get("PROD_NO"));
				jsonObject.put("Name", paramap.get("PROD_DETAIL"));

				jsonArray.put(jsonObject);
			}
			return jsonArray.toString();
		} catch (JSONException e) {
			e.printStackTrace();
			return null;
		}
	}
	/**
	 * 查询出来的生产订单及图纸号生成Json格式的数据
	 * 
	 * @param contacts
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static String paymentModeInfoToJson(
			List<LinkedHashMap<Object, Object>> inforList) {
		try {
			JSONArray jsonArray = new JSONArray();
			for (LinkedHashMap paramap : inforList) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("ID", paramap.get("CODE_ID"));
				jsonObject.put("Name", paramap.get("CODE_NAME"));

				jsonArray.put(jsonObject);
			}
			return jsonArray.toString();
		} catch (JSONException e) {
			e.printStackTrace();
			return null;
		}
	}
	/**
	 * 查询出来的应用功能生成Json格式的数据
	 * 
	 * @param contacts
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static String applyFunctionInfoToJson(
			List<LinkedHashMap<Object, Object>> inforList) {
		try {
			JSONArray jsonArray = new JSONArray();
			for (LinkedHashMap paramap : inforList) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("ID", paramap.get("ORDER_ID"));
				jsonObject.put("Name", paramap.get("ORDER_NAME"));

				jsonArray.put(jsonObject);
			}
			return jsonArray.toString();
		} catch (JSONException e) {
			e.printStackTrace();
			return null;
		}
	}
	@SuppressWarnings("rawtypes")
	public static String proTypeInfoToJson(
			List<LinkedHashMap<Object, Object>> inforList) {
		try {
			JSONArray jsonArray = new JSONArray();
			for (LinkedHashMap paramap : inforList) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("ID", paramap.get("TYPE_CODE"));
				jsonObject.put("Name", paramap.get("TYPE_NAME"));

				jsonArray.put(jsonObject);
			}
			return jsonArray.toString();
		} catch (JSONException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 生成Json格式的数据
	 * 
	 * @param contacts
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static String listInfoToJson(
			List<LinkedHashMap<Object, Object>> inforList) {
		try {
			JSONArray jsonArray = new JSONArray();
			for (LinkedHashMap paramap : inforList) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("ID", paramap.get("ID"));
				jsonObject.put("Name", paramap.get("NAME"));

				jsonArray.put(jsonObject);
			}
			return jsonArray.toString();
		} catch (JSONException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 生成Json格式的数据
	 * 
	 * @param contacts
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static String listInfoToIdPidJson(
			List<LinkedHashMap<Object, Object>> inforList) {
		try {
			JSONArray jsonArray = new JSONArray();
			for (LinkedHashMap paramap : inforList) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("id", paramap.get("ID"));
				jsonObject.put("pid", "0");
				jsonObject.put("url", "0");
				jsonObject.put("text", paramap.get("NAME"));
				jsonObject.put("isexpand", false);
				jsonObject.put("children", "0");

				jsonArray.put(jsonObject);
			}
			return jsonArray.toString();
		} catch (JSONException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 生成Json格式的数据
	 * 
	 * @param contacts
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static String listInfoToIdTextJson(
			List<LinkedHashMap<Object, Object>> inforList) {
		try {
			JSONArray jsonArray = new JSONArray();
			JSONObject json = new JSONObject();
			json.put("id", "");
			json.put("text", "请选择");
			jsonArray.put(json);
			for (LinkedHashMap paramap : inforList) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("id", paramap.get("ID"));
				jsonObject.put("text", paramap.get("NAME"));

				jsonArray.put(jsonObject);
			}
			return jsonArray.toString();
		} catch (JSONException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 生成Json格式的数据
	 * 
	 * @param contacts
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static String listInfoToIdTextPidJson(
			List<LinkedHashMap<Object, Object>> inforList) {
		try {
			JSONArray jsonArray = new JSONArray();
			JSONObject json = new JSONObject();
			json.put("id", "");
			json.put("pid", "");
			json.put("text", "请选择");
			jsonArray.put(json);
			for (LinkedHashMap paramap : inforList) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("id", paramap.get("ID"));
				jsonObject.put("text", paramap.get("NAME"));
				jsonObject.put("pid", paramap.get("PID"));

				jsonArray.put(jsonObject);
			}
			return jsonArray.toString();
		} catch (JSONException e) {
			e.printStackTrace();
			return null;
		}
	}

	/*******************************************************************************/
	public static String object2json(Object obj) {
		StringBuilder json = new StringBuilder();
		if (obj == null) {
			json.append("\"\"");
		} else if (obj instanceof String || obj instanceof Integer
				|| obj instanceof Float || obj instanceof Boolean
				|| obj instanceof Short || obj instanceof Double
				|| obj instanceof Long || obj instanceof BigDecimal
				|| obj instanceof BigInteger || obj instanceof Byte) {
			json.append("\"").append(string2json(obj.toString())).append("\"");
		} else if (obj instanceof Object[]) {
			json.append(array2json((Object[]) obj));
		} else if (obj instanceof List) {
			json.append(list2json((List<?>) obj));
		} else if (obj instanceof Map) {
			json.append(map2json((Map<?, ?>) obj));
		} else if (obj instanceof Set) {
			json.append(set2json((Set<?>) obj));
		} else {
			json.append(bean2json(obj));
		}
		return json.toString();
	}

	public static String bean2json(Object bean) {
		StringBuilder json = new StringBuilder();
		json.append("{");
		PropertyDescriptor[] props = null;
		try {
			props = Introspector.getBeanInfo(bean.getClass(), Object.class)
					.getPropertyDescriptors();
		} catch (IntrospectionException e) {
		}
		if (props != null) {
			for (int i = 0; i < props.length; i++) {
				try {
					String name = object2json(props[i].getName());
					String value = object2json(props[i].getReadMethod().invoke(
							bean));
					json.append(name);
					json.append(":");
					json.append(value);
					json.append(",");
				} catch (Exception e) {
				}
			}
			json.setCharAt(json.length() - 1, '}');
		} else {
			json.append("}");
		}
		return json.toString();
	}

	public static String list2json(List<?> list) {
		StringBuilder json = new StringBuilder();
		json.append("[");
		if (list != null && list.size() > 0) {
			for (Object obj : list) {
				json.append(object2json(obj));
				json.append(",");
			}
			json.setCharAt(json.length() - 1, ']');
		} else {
			json.append("]");
		}
		return json.toString();
	}

	public static String array2json(Object[] array) {
		StringBuilder json = new StringBuilder();
		json.append("[");
		if (array != null && array.length > 0) {
			for (Object obj : array) {
				json.append(object2json(obj));
				json.append(",");
			}
			json.setCharAt(json.length() - 1, ']');
		} else {
			json.append("]");
		}
		return json.toString();
	}

	public static String map2json(Map<?, ?> map) {
		StringBuilder json = new StringBuilder();
		json.append("{");
		if (map != null && map.size() > 0) {
			for (Object key : map.keySet()) {
				json.append(object2json(key));
				json.append(":");
				json.append(object2json(map.get(key)));
				json.append(",");
			}
			json.setCharAt(json.length() - 1, '}');
		} else {
			json.append("}");
		}
		return json.toString();
	}

	public static String set2json(Set<?> set) {
		StringBuilder json = new StringBuilder();
		json.append("[");
		if (set != null && set.size() > 0) {
			for (Object obj : set) {
				json.append(object2json(obj));
				json.append(",");
			}
			json.setCharAt(json.length() - 1, ']');
		} else {
			json.append("]");
		}
		return json.toString();
	}

	public static String string2json(String s) {
		if (s == null)
			return "";
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < s.length(); i++) {
			char ch = s.charAt(i);
			switch (ch) {
			case '"':
				sb.append("\\\"");
				break;
			case '\\':
				sb.append("\\\\");
				break;
			case '\b':
				sb.append("\\b");
				break;
			case '\f':
				sb.append("\\f");
				break;
			case '\n':
				sb.append("\\n");
				break;
			case '\r':
				sb.append("\\r");
				break;
			case '\t':
				sb.append("\\t");
				break;
			case '/':
				sb.append("\\/");
				break;
			default:
				if (ch >= '\u0000' && ch <= '\u001F') {
					String ss = Integer.toHexString(ch);
					sb.append("\\u");
					for (int k = 0; k < 4 - ss.length(); k++) {
						sb.append('0');
					}
					sb.append(ss.toUpperCase());
				} else {
					sb.append(ch);
				}
			}
		}
		return sb.toString();
	}
	/*******************************************************************************/
}
