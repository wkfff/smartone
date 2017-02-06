package com.siping.system.bean;

import java.util.Locale;

import com.siping.doc.bean.MasterData;
import com.siping.doc.bean.MetaData;
import com.siping.productStorage.bean.Company;

public class AdminBean extends MasterData {
    public static final String KEY_OBJECT = "user";

    private static final long serialVersionUID = -2034432429142674566L;

    public static final String DEFAULT_LANGUAGE_PREFERENCE = "en";

    public static final String DEFAULT_COUNTRY_PREFERENCE = "US";

    public static final Locale DEFAULT_Locale = new Locale("en", "US");

    private Locale locale = DEFAULT_Locale;

    private String adminNo;

    private String adminID;

    private int adminLevel;

    private String username;

    private String password;

    private String chineseName;

    private String pinyin;

    private String englishName;

    private String deptID;

    private String department;

    private String englishdept;

    private String screenGrantNo;

    private String screenGrantID;

    private String createDate;

    private String createdBy;

    private String updateDate;

    private String updatedBy;

    private int activity;

    private int orderNo;

    private String languagePreference = DEFAULT_LANGUAGE_PREFERENCE;

    private String countryPreference = DEFAULT_COUNTRY_PREFERENCE;

    private String cpnyId;

    private String cpnyName;

    private String personId;

    private String channelID;

    private String bpID;

    private String contactName;

    private String channelName;

    private String genderCode;

    private int leftCredit;

    private String accountType;

    /**
     * 0 means admin login, 1 means client login
     */
    private int loginType;

    /**
     * 0 means admin login, 1 means client login
     */
    public int getLoginType() {
        return loginType;
    }

    public void setLoginType(int loginType) {
        this.loginType = loginType;
    }

    public AdminBean() {
    }

    public void setLocale(Locale locale) {
        this.locale = locale;
    }

    public Locale getLocale() {
        return new Locale(this.getLanguagePreference(), this.getCountryPreference());
    }

    public String getScreenGrantID() {
        return screenGrantID;
    }

    public void setScreenGrantID(String screenGrantID) {
        this.screenGrantID = screenGrantID;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public void setAdminID(String adminID) {
        this.adminID = adminID;
    }

    public String getAdminID() {
        return this.adminID;
    }

    public void setAdminLevel(int adminLevel) {
        this.adminLevel = adminLevel;
    }

    public int getAdminLevel() {
        return this.adminLevel;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUsername() {
        return this.username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPassword() {
        return this.password;
    }

    public String getChineseName() {
        return chineseName;
    }

    public void setChineseName(String chineseName) {
        this.chineseName = chineseName;
    }

    public String getScreenGrantNo() {
        return screenGrantNo;
    }

    public void setScreenGrantNo(String screenGrantNo) {
        this.screenGrantNo = screenGrantNo;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public String getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(String updateDate) {
        this.updateDate = updateDate;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public int getOrderNo() {
        return orderNo;
    }

    public int getActivity() {
        return activity;
    }

    public void setOrderNo(int orderNo) {
        this.orderNo = orderNo;
    }

    public void setActivity(int activity) {
        this.activity = activity;
    }

    public String getDeptID() {
        return deptID;
    }

    public void setDeptID(String deptID) {
        this.deptID = deptID;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getCountryPreference() {
        return countryPreference;
    }

    public void setCountryPreference(String countryPreference) {
        this.countryPreference = countryPreference;
    }

    public String getLanguagePreference() {
        return languagePreference;
    }

    public void setLanguagePreference(String languagePreference) {
        this.languagePreference = languagePreference;
    }

    public String getEnglishName() {
        return englishName;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + activity;
        result = prime * result + ((adminID == null) ? 0 : adminID.hashCode());
        result = prime * result + adminLevel;
        result = prime * result + ((adminNo == null) ? 0 : adminNo.hashCode());
        result = prime * result + ((chineseName == null) ? 0 : chineseName.hashCode());
        result = prime * result + ((countryPreference == null) ? 0 : countryPreference.hashCode());
        result = prime * result + ((cpnyId == null) ? 0 : cpnyId.hashCode());
        result = prime * result + ((cpnyName == null) ? 0 : cpnyName.hashCode());
        result = prime * result + ((createDate == null) ? 0 : createDate.hashCode());
        result = prime * result + ((createdBy == null) ? 0 : createdBy.hashCode());
        result = prime * result + ((department == null) ? 0 : department.hashCode());
        result = prime * result + ((deptID == null) ? 0 : deptID.hashCode());
        result = prime * result + ((englishName == null) ? 0 : englishName.hashCode());
        result = prime * result + ((englishdept == null) ? 0 : englishdept.hashCode());
        result = prime * result + ((languagePreference == null) ? 0 : languagePreference.hashCode());
        result = prime * result + orderNo;
        result = prime * result + ((password == null) ? 0 : password.hashCode());
        result = prime * result + ((personId == null) ? 0 : personId.hashCode());
        result = prime * result + ((pinyin == null) ? 0 : pinyin.hashCode());
        result = prime * result + ((screenGrantNo == null) ? 0 : screenGrantNo.hashCode());
        result = prime * result + ((screenGrantID == null) ? 0 : screenGrantID.hashCode());
        result = prime * result + ((updateDate == null) ? 0 : updateDate.hashCode());
        result = prime * result + ((updatedBy == null) ? 0 : updatedBy.hashCode());
        result = prime * result + ((username == null) ? 0 : username.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        AdminBean other = (AdminBean) obj;
        if (activity != other.activity)
            return false;
        if (adminID == null) {
            if (other.adminID != null)
                return false;
        } else if (!adminID.equals(other.adminID))
            return false;
        if (adminLevel != other.adminLevel)
            return false;
        if (adminNo == null) {
            if (other.adminNo != null)
                return false;
        } else if (!adminNo.equals(other.adminNo))
            return false;
        if (chineseName == null) {
            if (other.chineseName != null)
                return false;
        } else if (!chineseName.equals(other.chineseName))
            return false;
        if (countryPreference == null) {
            if (other.countryPreference != null)
                return false;
        } else if (!countryPreference.equals(other.countryPreference))
            return false;
        if (cpnyId == null) {
            if (other.cpnyId != null)
                return false;
        } else if (!cpnyId.equals(other.cpnyId))
            return false;
        if (cpnyName == null) {
            if (other.cpnyName != null)
                return false;
        } else if (!cpnyName.equals(other.cpnyName))
            return false;
        if (createDate == null) {
            if (other.createDate != null)
                return false;
        } else if (!createDate.equals(other.createDate))
            return false;
        if (createdBy == null) {
            if (other.createdBy != null)
                return false;
        } else if (!createdBy.equals(other.createdBy))
            return false;
        if (department == null) {
            if (other.department != null)
                return false;
        } else if (!department.equals(other.department))
            return false;
        if (deptID == null) {
            if (other.deptID != null)
                return false;
        } else if (!deptID.equals(other.deptID))
            return false;
        if (englishName == null) {
            if (other.englishName != null)
                return false;
        } else if (!englishName.equals(other.englishName))
            return false;
        if (englishdept == null) {
            if (other.englishdept != null)
                return false;
        } else if (!englishdept.equals(other.englishdept))
            return false;
        if (languagePreference == null) {
            if (other.languagePreference != null)
                return false;
        } else if (!languagePreference.equals(other.languagePreference))
            return false;
        if (orderNo != other.orderNo)
            return false;
        if (password == null) {
            if (other.password != null)
                return false;
        } else if (!password.equals(other.password))
            return false;
        if (personId == null) {
            if (other.personId != null)
                return false;
        } else if (!personId.equals(other.personId))
            return false;
        if (pinyin == null) {
            if (other.pinyin != null)
                return false;
        } else if (!pinyin.equals(other.pinyin))
            return false;
        if (screenGrantNo == null) {
            if (other.screenGrantNo != null)
                return false;
        } else if (!screenGrantNo.equals(other.screenGrantNo))
            return false;
        if (screenGrantID == null) {
            if (other.screenGrantID != null)
                return false;
        } else if (!screenGrantID.equals(other.screenGrantID))
            return false;
        if (updateDate == null) {
            if (other.updateDate != null)
                return false;
        } else if (!updateDate.equals(other.updateDate))
            return false;
        if (updatedBy == null) {
            if (other.updatedBy != null)
                return false;
        } else if (!updatedBy.equals(other.updatedBy))
            return false;
        if (username == null) {
            if (other.username != null)
                return false;
        } else if (!username.equals(other.username))
            return false;
        return true;
    }

    public void setEnglishName(String englishName) {
        this.englishName = englishName;
    }

    public String getEnglishdept() {
        return englishdept;
    }

    public void setEnglishdept(String englishdept) {
        this.englishdept = englishdept;
    }

    public String getPinyin() {
        return pinyin;
    }

    public void setPinyin(String pinyin) {
        this.pinyin = pinyin;
    }

    public String getAdminNo() {
        return adminNo;
    }

    public void setAdminNo(String adminNo) {
        this.adminNo = adminNo;
    }

    public String getCpnyId() {
        return cpnyId;
    }

    public void setCpnyId(String cpnyId) {
        if (getMetaData() == null) {
            Company company = new Company();
            company.setCompanyId(cpnyId);

            MetaData metaData = new MetaData();
            metaData.setCompany(company);
            setMetaData(metaData);
        }
        this.cpnyId = cpnyId;
    }

    public String getCpnyName() {
        return cpnyName;
    }

    public void setCpnyName(String cpnyName) {
        this.cpnyName = cpnyName;
    }

    public String getChannelID() {
        return channelID;
    }

    public void setChannelID(String channelID) {
        this.channelID = channelID;
    }

    public String getBpID() {
        return bpID;
    }

    public void setBpID(String bpID) {
        this.bpID = bpID;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getChannelName() {
        return channelName;
    }

    public void setChannelName(String channelName) {
        this.channelName = channelName;
    }

    public String getGenderCode() {
        return genderCode;
    }

    public void setGenderCode(String genderCode) {
        this.genderCode = genderCode;
    }

    public int getLeftCredit() {
        return leftCredit;
    }

    public void setLeftCredit(int leftCredit) {
        this.leftCredit = leftCredit;
    }

    public String getAccountType() {
        return accountType;
    }

    public void setAccountType(String accountType) {
        this.accountType = accountType;
    }
}
