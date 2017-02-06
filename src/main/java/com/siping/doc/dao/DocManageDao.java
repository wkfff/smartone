package com.siping.doc.dao;

import com.siping.doc.bean.BusinessData;
import com.siping.doc.bean.Document;
import com.siping.doc.bean.DocumentFile;

public interface DocManageDao {
	String addFile(DocumentFile file) throws Exception;

	void deleteFile(DocumentFile file) throws Exception;

	void releaseFileLock(DocumentFile file) throws Exception;

	String addDocument(Document document) throws Exception;

	void updateDocument(Document document) throws Exception;

	public void removeDocument(Document document) throws Exception;

	void updateDocumentStatus(Document document) throws Exception;

	DocumentFile getFileInfo(DocumentFile file) throws Exception;

	void checkOutFile(Object object) throws Exception;

	void deleteDocObject(Object object) throws Exception;

	void addDocObject(Document Document, BusinessData data) throws Exception;

	String copyDocument(Object object)throws Exception;

	public String generateDocId() throws Exception;

}
