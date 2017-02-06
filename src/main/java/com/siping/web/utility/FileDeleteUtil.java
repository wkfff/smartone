package com.siping.web.utility;

import java.io.File;

public class FileDeleteUtil {
	/**
	 * 删除文件夹下的所有文件
	 * @param folderFullPath
	 * @return
	 */
	public static boolean deleteAllFile(String folderFullPath){
        boolean flag = false;
        File file = new File(folderFullPath);
        if(file.exists()){
        	if(file.isDirectory()){
        		File[] fileList = file.listFiles();
        		for (int i = 0; i < fileList.length; i++) {
        			String filePath = fileList[i].getPath();
        			deleteAllFile(filePath);
        		}
        	}
	        if(file.isFile()){
	        	file.delete();
	        }
	    }
	    return flag;
	}
	/**
	 * 删除文件夹下的所有空文件夹
	 * @param folderFullPath
	 * @return
	 */
	public static boolean deleteAllFullFolder(String folderFullPath){
		 boolean flag = false;
	     File file = new File(folderFullPath);
	     if(file.exists()){
	    	 File[] fileList=file.listFiles();
	    	 if(fileList.length>0){
	        	for(int i=0;i<fileList.length;i++){
	        		String filePath = fileList[i].getPath();
	        		deleteAllFullFolder(filePath);
	        	}
	        }else{
	        	file.delete();
	        }
	     }
	     return flag;
	}
}
