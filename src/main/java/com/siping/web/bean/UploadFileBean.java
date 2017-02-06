package com.siping.web.bean;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

public class UploadFileBean {

	private MultipartFile _file;
	private String _filePath;
	private FileNameBean _fileNameBean;
	
	public UploadFileBean(String filePath, MultipartFile file){
		this._filePath = filePath;
		this._file = file;
		new File(this._filePath).mkdirs();
		this._fileNameBean = new FileNameBean(this._file);
	}
	
	public void save() throws IOException{
		FileOutputStream fos = new FileOutputStream(_filePath + "\\" + _fileNameBean.getModifiedFileName());
		fos.write(_file.getBytes());
		fos.close();
	}

	public FileNameBean get_fileNameBean() {
		return _fileNameBean;
	}


	
	
}
