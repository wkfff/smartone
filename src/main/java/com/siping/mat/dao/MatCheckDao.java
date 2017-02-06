package com.siping.mat.dao;

import java.sql.SQLException;

public interface MatCheckDao {

	public int checkMaterialID(Object object) throws SQLException;
	public int checkMaterialName(Object object) throws SQLException;
	public int checkCategoryName(Object object) throws SQLException;
	public int checkStorageID(Object object) throws SQLException;
	public int checkStorageName(Object object) throws SQLException;
}
