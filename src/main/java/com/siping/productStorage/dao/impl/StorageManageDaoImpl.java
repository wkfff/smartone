package com.siping.productStorage.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.siping.productStorage.dao.StorageManageDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class StorageManageDaoImpl extends SqlMapClientSupport implements StorageManageDao {

    private static final String SUCCESS = "Y";
    private static final String ADD_NEW_STORAGE = "prostor.storage.addNewStorage";
    private static final String GET_ALL_STORAGES = "prostor.storage.getAllStorages";
    private static final String DELETE_STORAGE = "prostor.storage.deleteStorage";
    private static final String UPDATE_STORAGE = "prostor.storage.updateStorage";
    private static final String GET_STORAGE_NAME = "prostor.storage.getStorageName";
    private static final String GET_STORAGE_COUNT = "prostor.storage.getStorageCount";
    private static final String PRODUCT_COUNT_IN_STORAGE = "prostor.storage.productCountInStorage";
    private static final String STORAGE_PRODUCT_LIST = "prostor.storage.getStorageProList";
    private static final String STORAGE_PRODUCT_LISTCNT = "prostor.storage.getStorageProListCnt";
    private static final String MOVE_STORAGE = "prostor.storage.moveStorage";
    private static final String CHECK_STORAGEID = "prostor.storage.checkStorageId";

    @Override
    public String addNewStorage(Object paramObj) {
        String resultString = SUCCESS;
        try {
            this.insert(ADD_NEW_STORAGE, paramObj);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getStorageList(Map paramMap) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList(GET_ALL_STORAGES, paramMap);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getStorageList(Map paramMap, int currentPage, int pagesize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList(GET_ALL_STORAGES, paramMap, currentPage, pagesize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @Override
    public String deleteStorage(Object param) {
        String resultString;
        try {
            resultString = this.delete(DELETE_STORAGE, param).toString();
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String updateStorage(Object param) {
        String resultString = SUCCESS;
        try {
            this.update(UPDATE_STORAGE, param);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * 获取仓库名称
     */
	@SuppressWarnings("rawtypes")
	@Override
	public List getStorageName(Map paramMap) {
		List storList = new ArrayList();
		try {
			storList = this.queryForList(GET_STORAGE_NAME, paramMap);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return storList;
	}
	
    @Override
    public int getStorageCount(Object obj) {
        int count = 0;
        try {
            count = Integer.parseInt(this.queryForObject(GET_STORAGE_COUNT,obj).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    @Override
    public int getProductCountInStorage(Object obj) {
        int count = 0;
        try {
            count = Integer.parseInt(this.queryForObject(PRODUCT_COUNT_IN_STORAGE,obj).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

	@SuppressWarnings("rawtypes")
	@Override
	public List getStorageProList(Map paramMap, int currentPage, int pagesize) {
		List returnList = new ArrayList();
        try {
            returnList = this.queryForList(STORAGE_PRODUCT_LIST, paramMap, currentPage, pagesize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public Integer getStorageProListCnt(Map paramMap) {
        int proCnt = 0;
        try {
            proCnt = (Integer) this.queryForObject(STORAGE_PRODUCT_LISTCNT, paramMap);
		} catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return proCnt;
    }
    
    @Override
    public String moveStorage(Object param) {
        String resultString = SUCCESS;
        try {
            this.update(MOVE_STORAGE, param);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public int checkStorageId(Object param) {
        int proCnt = 0;
        try {
            proCnt = (Integer) this.queryForObject(CHECK_STORAGEID, param);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return proCnt;
    }
}
