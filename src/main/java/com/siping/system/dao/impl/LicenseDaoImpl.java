package com.siping.system.dao.impl;

import com.siping.system.bean.License;
import com.siping.system.dao.LicenseDao;
import com.siping.web.utility.SqlMapClientSupport;

import org.springframework.stereotype.Repository;

import java.sql.SQLException;
import java.util.List;

@Repository
public class LicenseDaoImpl extends SqlMapClientSupport implements LicenseDao {
    @Override
    public License getCurrentLicense() {
        License license = null;
        try {
            license = (License)this.queryForObject("license.getCurrentLicense");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return license;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<License> getLicenseList(Object obj) {
        List<License> licenseList = null;
        try {
            licenseList = this.queryForList("license.getLicenseList",obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return licenseList;
    }
    
    @Override
    public int getLicenseListCnt(Object obj) {
        int cnt = 0;
        try {
            cnt = (Integer) this.queryForObject("license.getLicenseListCnt",obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cnt;
    }

    @Override
    public void addOrUpdateLicense(Object obj) throws SQLException {
        this.insert("license.addOrUpdateLicense", obj);
    }

	@Override
	public void addLicense(Object obj) throws Exception {
		this.insert("license.addLicense",obj);
		
	}
	@Override
	public void updateLicense(Object obj) throws Exception {
		this.insert("license.updateLicense",obj);
		
	}
	@Override
	public int getLicenseCnt(Object obj) throws Exception {
		int cnt = 0;
        try {
            cnt = (Integer) this.queryForObject("license.getLicenseCnt",obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cnt;
	}
}
