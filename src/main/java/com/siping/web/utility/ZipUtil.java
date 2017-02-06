package com.siping.web.utility;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.zip.CRC32;
import java.util.zip.CheckedOutputStream;

import javax.servlet.http.HttpServletResponse;

import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;

/**
 * zip打包工具类
 * @author Sipingsoft
 *
 */
public class ZipUtil {
	
	/**
	 * 在某一目录下的多个文件，经过压缩，将压缩文件并放入response中。
	 * @param response 
	 * @param filePath 绝对路径，不包含文件，即存放文件的目录
	 * @param fileName 文件名，list形式，可多个
	 */
	public static void downZipFile(HttpServletResponse response,String filePath,List<String> fileNameList){
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy_MM_dd_HH_mm_ss");
		String dateString = formatter.format(new Date());
		String zipName ="DownloadFile_"+ dateString+".zip";
		
		File zipFile = new File(zipName);
		if(fileNameList == null || fileNameList.isEmpty()){
			return;
		}
		try {
			FileOutputStream fileOutputStream = new FileOutputStream(zipFile);
			CheckedOutputStream cos = new CheckedOutputStream(fileOutputStream, new CRC32());
			ZipOutputStream out = new ZipOutputStream(cos);
			out.setEncoding("UTF-8");
			for(String fn : fileNameList){
				FileInputStream in = new FileInputStream(new File(filePath+"\\"+fn));
				ZipEntry entry = new ZipEntry(fn);
				out.putNextEntry(entry);
				int len = 0;
				byte[] bytes = new byte[1024];
				while ((len = in.read(bytes,0,bytes.length)) != -1) {
					out.write(bytes, 0, len);
				}
				out.closeEntry();
				in.close();
			}
			out.flush();
			out.close();
		
			response.setContentType("multipart/form-data");
			response.setHeader("Content-Disposition", "attachment;fileName="+java.net.URLEncoder.encode(zipName, "UTF-8"));
			InputStream inputStream = new FileInputStream(zipFile);
			OutputStream outputStream = response.getOutputStream();
			byte[] b = new byte[1024];
			int length;
			while((length = inputStream.read(b))>0){
				outputStream.write(b, 0, length);
			}
			inputStream.close();
			outputStream.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
