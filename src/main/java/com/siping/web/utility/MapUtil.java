package com.siping.web.utility;
 
import java.util.Iterator; 
import java.util.Map;

/**
 * Title: String utility Company: SipingSoft Description: do some string
 * operation Copyright: Copyright (c) 2010
 * 
 * @author
 * @version 1.0
 */
public class MapUtil {

	protected MapUtil() {
	}

	/**
	 * 语言选择
	 * 
	 * @param param
	 * @param mMap
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map checkInfoMaps(Object newObj,Object oldObj) {
		Map returnMap = (Map) newObj;
		Map returnNewMap = (Map) newObj;
		Map returnOldMap = (Map) oldObj;   
		try { 
			Iterator newIt = returnNewMap.keySet().iterator();
			while(newIt.hasNext()){
				Object key = newIt.next();
				if(returnOldMap.containsKey(key)) {
					Object newVal = returnNewMap.get(key);
					Object oldVal = returnOldMap.get(key);
					if(newVal.equals(oldVal)){ 
						
					}else{
						returnMap.put(key, setStyle(newVal));
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnNewMap;
	}
	@SuppressWarnings({ "rawtypes" })
	public static boolean perAppInfoCheck(Object newObj,Object oldObj) {
		
		boolean returnBoolean = false;
		Map returnNewMap = (Map) newObj;
		Map returnOldMap = (Map) oldObj;   
		try { 
			String returnString = "";
			Iterator newIt = returnNewMap.keySet().iterator();
			while(newIt.hasNext()){
				Object key = newIt.next();
				if(returnOldMap.containsKey(key)) {
					Object newVal = returnNewMap.get(key);
					Object oldVal = returnOldMap.get(key);
					if(newVal == null) newVal = "";
					if(oldVal == null) oldVal = "";
					if(newVal.equals(oldVal)){  
						
					}else{
						returnString = returnString + key;
					}
				}
			}
			if(returnString.equals("")){
				returnBoolean = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnBoolean;
	} 
	public static String setStyle(Object str) {
		String returnString = ""; 
		try { 
			if(str == null){
				returnString = "<div style='font: normal;color: purple;'>" + " " + "</div>";
			}else{
				returnString = "<div style='font: normal;color: purple;'>" + str + "</div>";
			}
		} catch (Exception e) {
			returnString = str+""; 
			e.printStackTrace();
		}
		return returnString;
	}
}
