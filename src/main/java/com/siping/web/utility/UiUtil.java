package com.siping.web.utility;


public class UiUtil {

	private static UiUtil instance;
	
	public UiUtil() {
		if (instance == null) {
			getInstance();
		}
	}

	public static UiUtil getInstance() {
		return new UiUtil();
	}
	
}
