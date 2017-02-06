package com.siping.web.service.impl;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.siping.system.bean.AdminBean;
import com.siping.web.bean.UploadFileBean;
import com.siping.web.dao.FileUploadDao;
import com.siping.web.service.FileUploadSer;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class FileUploadSerImpl implements FileUploadSer {

	Logger logger = Logger.getLogger(FileUploadSer.class);
	ServletContext servletContext;

	@Autowired
	private FileUploadDao fileUploadDao;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public String uploadPhoto(HttpServletRequest request, MultipartFile file)
			throws IOException, SQLException {

		Map paramMap = this.getRequestParamData(request);
		String empId = (String) paramMap.get("EMPID");
		if (empId.equals(null)) {
			return "No empID";
		}
		String fileSuffix = file.getOriginalFilename().substring(
				file.getOriginalFilename().lastIndexOf("."));
		String photoPath = request.getSession().getServletContext()
				.getRealPath("/resources/picture/employee")
				+ "/" + empId + fileSuffix;
		byte[] bytes = file.getBytes();
		FileOutputStream fos = new FileOutputStream(photoPath);
		fos.write(bytes);
		fos.close();

		paramMap.put("PHOTOPATH", "/resources/picture/employee/" + empId + fileSuffix);
		// SQL的Update语句改变的大于0行说明修改成功
		if (((Integer) this.fileUploadDao.uploadPhoto(paramMap)).intValue() > 0) {
			return "Y";
		} else {
			return "N";
		}
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public String uploadAssetPic(HttpServletRequest request, MultipartFile file)
			throws IOException, SQLException {

		Map paramMap = this.getRequestParamData(request);
		String assetID = (String) paramMap.get("ASSET_ID");
		if (assetID.equals(null)) {
			return "No empID";
		}
		String fileSuffix = file.getOriginalFilename().substring(
				file.getOriginalFilename().lastIndexOf("."));
		String photoPath = request.getSession().getServletContext()
				.getRealPath("/resources/picture")
				+ "/" + assetID + fileSuffix;
		byte[] bytes = file.getBytes();
		FileOutputStream fos = new FileOutputStream(photoPath);
		fos.write(bytes);
		fos.close();

		paramMap.put("PHOTOPATH", "/resources/picture/" + assetID + fileSuffix);
		// SQL的Update语句改变的大于0行说明修改成功
		if (((Integer) this.fileUploadDao.uploadAssetPic(paramMap)).intValue() > 0) {
			return "Y";
		} else {
			return "N";
		}
	}
	

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String uploadExcel(MultipartFile file, HttpServletRequest request,
			HttpServletResponse response) throws IOException, SQLException, ParseException {
		List paramList = new ArrayList();

		//解析 Excel
		HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
		HSSFSheet sheet = workbook.getSheetAt(0);
		HSSFRow row = sheet.getRow(3);
		Map map = new LinkedHashMap();

		// 取出Excel的表头信息,创建表TMP_PERSONAL_INFO和表TMP_PERSONAL_TITLES
		HSSFSheet hidden = workbook.getSheet("hidden");
		if(hidden == null ) return "Wrong Excel!";
		Map columnsTitleMap = this.getColumnsTitle(hidden);
		String titleString = (String) columnsTitleMap.get("title");
		List titleCodeList = (List) columnsTitleMap.get("titleCode");
		List dataTypeList = (List) columnsTitleMap.get("dataType");
		map.put("TITLES", titleString);
		this.fileUploadDao.createTmpPersonalInfo(map);
		
		// 取出Excel里的title有关的信息，放入TMP_PERSONAL_TITLES表中
		List titleList = this.getTitlesInfo(row, hidden);
		this.fileUploadDao.updateTmpPersonalTitles(titleList);
		
		//取出Excel里的内容
 		int i = 3;
		while(true){
			i++;
			row = sheet.getRow(i);
			map = this.getRowInfo(row, titleCodeList, dataTypeList);
			if (map == null)
				break;
			paramList.add(map);
		}

		//将Excel里的内容放入临时表TMP_PERSONAL_INFO
		this.fileUploadDao.updateTmpPersonalInfo(paramList);
		return "Y";

	}

	/**
	 * 从Excel中取出表头的code、name和data type等信息
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	List getTitlesInfo(HSSFRow titleRow, HSSFSheet hidden){
		List result = new ArrayList();
		HSSFRow row = null;
		int i = 0;
		String cellValue = "";
		while(true){
			Map map = new LinkedHashMap();
			row = hidden.getRow(i);
			if(row == null || row.getCell(0) == null) break;
			cellValue = titleRow.getCell(i).getStringCellValue();
			map.put("TITLE_NAME", cellValue);
			cellValue = row.getCell(0).getStringCellValue();
			map.put("TITLE_CODE", cellValue);
			cellValue = row.getCell(1).getStringCellValue();
			map.put("DATA_TYPE", cellValue);
			cellValue = row.getCell(2).getStringCellValue();
			map.put("PARENT_CODE", cellValue);
			cellValue = row.getCell(3).getStringCellValue();
			map.put("TABLE_NAME", cellValue);
			cellValue = row.getCell(4).getStringCellValue();
			map.put("COLUMN_CODE", cellValue);
			cellValue = row.getCell(5).getStringCellValue();
			map.put("COLUMN_NAME", cellValue);
			cellValue = row.getCell(6).getStringCellValue();
			map.put("ORDERNO", cellValue);
			result.add(map);
			i++;
		}
		return result;
	}
	
	/**
	 * 取出Excel两列的数据拼接成字符串，并取出两列的长度 (EMPID varchar2(20) --> EMPID varchar2(20))
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private Map getColumnsTitle(HSSFSheet sheet) {
		Map result = new LinkedHashMap();
		List titleCodeList = new ArrayList();
		List dataTypeList = new ArrayList();
		String columnsTitle = "";
		String tmpStr = "";
		int i = 0, j = 0;
		while(true){
			HSSFRow row = sheet.getRow(i);
			if(row == null) break;
			HSSFCell cell = row.getCell(j);
			if(cell == null) break;
			tmpStr = cell.getStringCellValue();
			titleCodeList.add(tmpStr);
			columnsTitle = columnsTitle + tmpStr +" " ;
			cell = row.getCell(j+1);
			tmpStr = cell.getStringCellValue();
			dataTypeList.add(tmpStr);
			columnsTitle = columnsTitle + tmpStr +",";
			i++;
		}
		columnsTitle = columnsTitle.substring(0, columnsTitle.lastIndexOf(","));
		result.put("title" ,columnsTitle);
		result.put("length", i);
		result.put("titleCode", titleCodeList);
		result.put("dataType", dataTypeList);
		return result;
	}

	/**
	 * 从Excel中取出具体的个人信息
	 * @throws ParseException 
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map getRowInfo(HSSFRow row, List titleCodeList, List dataTypeList) throws ParseException {
		if (row == null) return null;
		String valuesStr = "", titlesStr = "";
		HSSFCell cell = row.getCell(0);
		if (cell == null)
			return null;
		String cellValue = cell.getStringCellValue(); // empId
		if (cellValue == null || cellValue == "")
			return null;
		Map map = new LinkedHashMap();
		map.put("EMPID", cellValue);
		valuesStr = cellValue;
		titlesStr = (String) titleCodeList.get(0);
		//增加对于数据格式的判断（需要先在生成模板时加上去）
		for (int i = 1; i < titleCodeList.size(); i++) {
			cell = row.getCell(i);
			if(cell == null){
				continue;
			}
			if ( ((String)dataTypeList.get(i)).equals("DATE") ) { //判断日期并解析

				String dateValue = this.parseDate2String(cell);
				if(dateValue != null ){
					//map.put(titleCodeList.get(i), dateValue);
					valuesStr = valuesStr + ", to_date(''"+dateValue+"'',''yyyy-MM-dd'') ";
					titlesStr = titlesStr+","+(String) titleCodeList.get(i);
				}
			} 
			else{
				int cellType = cell.getCellType();
				if(cellType == Cell.CELL_TYPE_STRING){
					if ( cell.getStringCellValue().equals("")) {
						cellValue = "";
					} 
					else {
						cellValue = cell.getStringCellValue();
						valuesStr = valuesStr + ",''"+cellValue+"''";
						titlesStr = titlesStr+","+(String) titleCodeList.get(i);
					}
				}else if(cellType == Cell.CELL_TYPE_NUMERIC){
					cellValue = String.valueOf(cell.getNumericCellValue());
					valuesStr = valuesStr + ",''"+cellValue+"''";
					titlesStr = titlesStr+","+(String) titleCodeList.get(i);
				}				 
				//map.put(titleCodeList.get(i), cellValue);
			}
		}
		map.put("valuesStr", valuesStr);
		map.put("titlesStr", titlesStr);
		return map;
	}

	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) {
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		return paramMap;
	}

	/**
	 * 将合同附件上传到指定位置并重命名
	 * @throws SQLException 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String uploadContractAppendix(HttpServletRequest request,
			MultipartFile file) throws IOException, SQLException {
		Map paramMap = this.getRequestParamData(request);
		String empId = (String) paramMap.get("EMPID");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		if (empId.equals(null)) {
			return "No empID";
		}
		UploadFileBean uploadFile = new UploadFileBean("/resources/appendix/contract/" + empId, file);
		uploadFile.save();
		//将两个文件名的对应关系写入数据库的表中
		paramMap.put("ORIGINAL_FILE_NAME",uploadFile.get_fileNameBean().getOriginalFileName());
		paramMap.put("MODIFIED_FILE_NAME",uploadFile.get_fileNameBean().getModifiedFileName());
		paramMap.put("FILE_SUFFIX",uploadFile.get_fileNameBean().getFileSuffix());
		paramMap.put("CREATED_BY", admin.getAdminID());
		this.fileUploadDao.uploadContractAppendix(paramMap);
		
		return "Y";
	}

	/**
	 * 将产品附件上传到指定位置并重命名
	 * @throws SQLException 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String uploadProductAppendix(HttpServletRequest request,
			MultipartFile file) throws IOException, SQLException {
		Map paramMap = this.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		String productID = (String) paramMap.get("PRODUCT_ID");
		if (productID.equals(null)) {
			return "No productID";
		}
		UploadFileBean uploadFile = new UploadFileBean("/resources/appendix/product/" + productID, file);
		uploadFile.save();
		//将两个文件名的对应关系写入数据库的表中
		paramMap.put("ORIGINAL_NAME",uploadFile.get_fileNameBean().getOriginalFileName());
		paramMap.put("APPENDIX_NAME",uploadFile.get_fileNameBean().getModifiedFileName());
		paramMap.put("APPENDIX_FORMAT",uploadFile.get_fileNameBean().getFileSuffix());
		paramMap.put("STORE_PATH","/resources/appendix/product/" + productID);
		paramMap.put("CREATED_BY", admin.getAdminID());
		this.fileUploadDao.uploadProductAppendix(paramMap);
		
		return "Y";
	} 
	
	/**
	 * 将客户附件上传到指定位置并重命名
	 * @throws SQLException 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String uploadCustAppendix(HttpServletRequest request,
			MultipartFile file) throws IOException, SQLException {
		String pathPrefix = "/resources/appendix/customer/";
		Map paramMap = this.getRequestParamData(request);
		String custID = (String) paramMap.get("CUST_ID");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		if (custID.equals(null)) {
			return "No productID";
		}
		UploadFileBean uploadFile = new UploadFileBean(pathPrefix + custID, file);
		uploadFile.save();
		//将两个文件名的对应关系写入数据库的表中
		paramMap.put("ORIGINAL_NAME",uploadFile.get_fileNameBean().getOriginalFileName());
		paramMap.put("APPENDIX_NAME",uploadFile.get_fileNameBean().getModifiedFileName());
		paramMap.put("APPENDIX_FORMAT",uploadFile.get_fileNameBean().getFileSuffix());
		paramMap.put("STORE_PATH",pathPrefix + custID);
		paramMap.put("CREATED_BY", admin.getAdminID());
		this.fileUploadDao.uploadCustAppendix(paramMap);
		
		return "Y";
	} 
	
	
	/**
	 * 将产品图片上传到指定位置
	 * @throws SQLException 
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public String uploadProductPic(HttpServletRequest request,
			MultipartFile file) throws IOException, SQLException {
		Map paramMap = this.getRequestParamData(request);
		String productID = (String) paramMap.get("PRODUCT_ID");
		if (productID==null) {
			return "No productID";
		}
		String filePath = request.getSession().getServletContext()
				.getRealPath("/resources/picture/product/" + productID);
		return this.uploadPicture(filePath, file);
	} 
	
	/**
	 * 将材料图片上传到指定位置
	 * @throws SQLException 
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public String uploadMaterialPic(HttpServletRequest request,
			MultipartFile file) throws IOException, SQLException {
		Map paramMap = this.getRequestParamData(request);
		String materialID = (String) paramMap.get("MAT_ID");
		if (materialID==null) {
			return "No Material Id";
		}
		String filePath = request.getSession().getServletContext()
				.getRealPath("/resources/picture/material/" + materialID);
		return this.uploadPicture(filePath, file);
	} 
	
	
	/**
	 * 获取临时表的字段名字（titleName）
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public List getColumnList(HttpServletRequest request,
			HttpServletResponse response) throws SQLException {
		return this.fileUploadDao.getColumnList("TMP_PERSONAL_INFO");
	}

	/**
	 * 获取临时表中的数据
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public List getTmpInfoList(HttpServletRequest request) throws SQLException {
		Map paramMap = this.getRequestParamData(request);
		return this.fileUploadDao.getTmpInfoList(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String saveUploadExcel(HttpServletRequest request) throws SQLException {
		String resultStr = "Y";
		//修改临时表的内容，将内容转为code
		this.fileUploadDao.modifyTmpTable();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = new LinkedHashMap();
		paramMap.put("ADMIN_ID", admin.getAdminID());
		//取出tmp表中的数据放入list中，根据修改和增加来执行不同的操作
		//List titleList = this.fileUploadDao.getTitleList();
		List updateList = this.fileUploadDao.getUpdateList(paramMap);
		List insertList = this.fileUploadDao.getInsertList(paramMap);
		this.fileUploadDao.updateHire(updateList);
		this.fileUploadDao.insertHire(insertList);
		return resultStr;
	}

	
	public String parseDate2String(HSSFCell cell) throws ParseException{
		Date dateValue = null;
		String stringValue = null;
		int cellType = cell.getCellType();
		if(cellType == Cell.CELL_TYPE_STRING){
			String cellValue = cell.getStringCellValue();
			if (cellValue != null && cellValue != ""){
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				dateValue = format.parse(cellValue);
				if(dateValue != null){ //cellValue符合"yyyy-MM-dd"格式
					return cellValue;
				}else {
					return null;
				}
			}
			else{
				return null;
			}
		}
		else {
			dateValue = cell.getDateCellValue();
			if(dateValue != null){
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				stringValue = format.format(dateValue);
				return stringValue;
			}
			else return null;
		}
	}
	
	/**
	 * 将file（图片）传到filePath处并保存大小两个版本
	 * @param filePath
	 * @param file
	 * @return
	 * @throws IOException
	 */
	public String uploadPicture(String filePath, MultipartFile file) throws IOException{
		File uploadFilePath = new File(filePath);
		uploadFilePath.mkdirs();
		//图片命名为big后上传	
		/*String originalFileName = file.getOriginalFilename();
		String fileSuffix = originalFileName.substring(
				originalFileName.lastIndexOf(".")+1);*/
		byte[] bytes = file.getBytes();
		FileOutputStream fos = new FileOutputStream(filePath + "\\big.jpg");
		fos.write(bytes);
		fos.close();
		//图片调整为宽度为100后命名为small再次上传
		Image img = ImageIO.read(file.getInputStream());
		if(img == null){
			return "Error in Reading Image";
		}
		double width = img.getWidth(null);
		double height = img.getHeight(null);
		height = height * 150 /width;
		width = 150;
		BufferedImage smallImage = new BufferedImage((int)width,(int)height,BufferedImage.TYPE_INT_RGB );
		smallImage.getGraphics().drawImage(img.getScaledInstance((int)width, (int)height, Image.SCALE_SMOOTH), 0, 0, null);  
        ImageIO.write(smallImage,  "jpeg" , new File(filePath + "\\small.jpg"));
        smallImage.flush();
		return "Y";
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String uploadProImage(HttpServletRequest request, MultipartFile file)
			throws IOException, SQLException {
		Map paramMap = this.getRequestParamData(request);
		String productId = (String) paramMap.get("PRODUCT_ID");
		if (productId.equals(null)) {
			return "No productID";
		}
		String fileSuffix = file.getOriginalFilename().substring(
				file.getOriginalFilename().lastIndexOf(".")).toLowerCase();
		String photoPath = request.getSession().getServletContext()
				.getRealPath("/resources/picture/product")
				+ "/" + productId + fileSuffix;
		byte[] bytes = file.getBytes();
		FileOutputStream fos = new FileOutputStream(photoPath);
		fos.write(bytes);
		fos.close();

		paramMap.put("PHOTOPATH", "/resources/picture/product/" + productId + fileSuffix);
		// SQL的Update语句改变的大于0行说明修改成功
		if (((Integer) this.fileUploadDao.uploadProImage(paramMap)).intValue() > 0) {
			return "Y";
		} else {
			return "N";
		}
	}
	
    @SuppressWarnings("rawtypes")
    @Override
    public String uploadMobileAdvImage(HttpServletRequest request, MultipartFile file)
            throws IOException, SQLException {
        Map paramMap = this.getRequestParamData(request);
	    String result = "N";
        String fileName = paramMap.get("PRODUCT_NO").toString();
        
        String fileSuffix = file.getOriginalFilename().substring(
                file.getOriginalFilename().lastIndexOf(".")).toLowerCase();
        String photoPath = request.getSession().getServletContext()
                .getRealPath("/resources/picture/mobileAdv")
                + "/Adv" + fileName + fileSuffix;
        byte[] bytes = file.getBytes();
        FileOutputStream fos = new FileOutputStream(photoPath);
        fos.write(bytes);
        fos.close();

        result = "Adv"+fileName + fileSuffix;
        return result;
    }
}
