package com.siping.web.bean;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.springframework.web.multipart.MultipartFile;

public class UploadPictureBean {
	private String filePath;
	private MultipartFile file;
	
	public UploadPictureBean(String filePath, MultipartFile file){
		this.file = file;
		this.filePath = filePath;
		new File(filePath).mkdirs();
	}
	
	public void save() throws IOException{
		uploadBigPicture();
		uploadSmallPicture();
	}
	
	public void uploadBigPicture() throws IOException{
		byte[] bytes = file.getBytes();
		FileOutputStream fos = new FileOutputStream(filePath + "\\big.jpg");
		fos.write(bytes);
		fos.close();
	}
	
    public void uploadSmallPicture() throws IOException{
    	Image img = ImageIO.read(file.getInputStream());
		if(img == null){
			throw new IOException("Error Generating small IMG");
		}
		double width = img.getWidth(null);
		double height = img.getHeight(null);
		height = height * 150 /width;
		width = 150;
		BufferedImage smallImage = new BufferedImage((int)width,(int)height,BufferedImage.TYPE_INT_RGB );
		smallImage.getGraphics().drawImage(img.getScaledInstance((int)width, (int)height, Image.SCALE_SMOOTH), 0, 0, null);  
        ImageIO.write(smallImage,  "jpeg" , new File(filePath + "\\small.jpg"));
        smallImage.flush();
	}
	
}
