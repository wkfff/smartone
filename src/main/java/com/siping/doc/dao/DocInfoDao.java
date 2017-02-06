package com.siping.doc.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.siping.doc.bean.Document;
import com.siping.doc.bean.DocumentFile;
import com.siping.process.bean.PagerRequest;

public interface DocInfoDao {
	@SuppressWarnings({ "rawtypes" })
	public List<Document> getDocumentList(HashMap<String, Object> object, PagerRequest pagerRequest) throws Exception;

	public int getDocumentListCnt(HashMap<String, Object> params) throws Exception;

	@SuppressWarnings({ "rawtypes" })
	public List<DocumentFile> getFileList(Map<String, Object> params, PagerRequest pagerRequest) throws Exception;

	public int getFileListCnt(Map<String, Object> params) throws Exception;

	public DocumentFile getDocumentFileDetail(DocumentFile file) throws Exception;

	@SuppressWarnings({ "rawtypes" })
	public List getDocObjectList(Object object);

	public int getDocObjectListCnt(Object object);

	public Document getDocumentDetail(Document document) throws Exception;

	public Object getDocumentDetailB(Object object);

	public String getNextDocumentId(Object object) throws SQLException;

	@SuppressWarnings("rawtypes")
	public List getWorkDocumentList(Object object);

	public int getWorkDocumentListCnt(Object object);
}
