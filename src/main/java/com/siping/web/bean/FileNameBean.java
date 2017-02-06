package com.siping.web.bean;

import org.springframework.web.multipart.MultipartFile;

import com.siping.web.utility.DateUtil;
import com.siping.web.utility.RandomUtil;

public class FileNameBean {
	protected String fileSuffix;
	protected String originalFileName;
	protected String modifiedFileName;
	
	public FileNameBean(MultipartFile file){
		originalFileName = file.getOriginalFilename();
		fileSuffix = originalFileName.substring(
				originalFileName.lastIndexOf(".")+1);
		originalFileName = originalFileName.substring(
				0,originalFileName.lastIndexOf("."));
		modifiedFileName = DateUtil.getSysdateString("yyyyMMddHHmmssSSS")+RandomUtil.getRandomNumber(1)+
				                  RandomUtil.getRandomNumber(1)+RandomUtil.getRandomNumber(1);
		
	}
	

	public String getFileSuffix() {
		return fileSuffix;
	}

	public void setFileSuffix(String fileSuffix) {
		this.fileSuffix = fileSuffix;
	}

	public String getOriginalFileName() {
		return originalFileName;
	}

	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}

	public String getModifiedFileName() {
		return modifiedFileName;
	}

	public void setModifiedFileName(String modifiedFileName) {
		this.modifiedFileName = modifiedFileName;
	}
	
	
}
