package com.siping.ecm.util;

public class CNExecuteUtil {

	public static String getObjectUpdateURL(String objectCategory){
		String resultString = "";
		if(objectCategory.equals("DOC")){
			resultString = "/doc/docManage/updateDocument?MENU_CODE=doc0202&USE_CN=1&DOC_ID=";
		}else if(objectCategory.equals("BOM")){
			resultString = "/bom/bomManage/updateBOM?MENU_CODE=bom0202&USE_CN=1&BOM_ID=";
		}
		
		return resultString;
	}
}
