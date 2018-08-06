package com.danusys.platform.vo;

import java.util.ArrayList;
import java.util.Date;

public class AdminVo {
	private String id;
	private String pwd;
	private int loginFailCount;
	private Date lastPwdUpdateDate;
	private String name;
	private String birthday;
	private String phoneNo;
	private String email;
	private String authority;
	private String address;
	private Date joinDate;
	private Date leaveDate;
	private Date createDate;
	private String deleted;
	private String deleteId;
	private Date deleteDate;
	
	private String strLoginFailCount;
	private String strLastPwdUpdateDate;
	private String strJoinDate;
	private String strLeaveDate;
	private String strCreateDate;
	private String strDeleteDate;
	
	private int Ecnt;
	private String flag;
	private String key;
	
	private String deptmnt;
	private String rank;
	
	private String orgPwd;
	
	private ArrayList<String> seqNoList;
	private String seqNo;
	
	private String sessionId;
	
	private String USER_NM_KO;
	private String USER_NM_EN;
	private String USE_TY_CD;
	private String GRP_ID;
	private String GRP_NM_KO;
	private String AUTH_LVL_NM;
	
	

   
    public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public int getLoginFailCount() {
		return loginFailCount;
	}
	public void setLoginFailCount(int loginFailCount) {
		this.loginFailCount = loginFailCount;
	}
	public Date getLastPwdUpdateDate() {
		return lastPwdUpdateDate;
	}
	public void setLastPwdUpdateDate(Date lastPwdUpdateDate) {
		this.lastPwdUpdateDate = lastPwdUpdateDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Date getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}
	public Date getLeaveDate() {
		return leaveDate;
	}
	public void setLeaveDate(Date leaveDate) {
		this.leaveDate = leaveDate;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public String getDeleteId() {
		return deleteId;
	}
	public void setDeleteId(String deleteId) {
		this.deleteId = deleteId;
	}
	public Date getDeleteDate() {
		return deleteDate;
	}
	public void setDeleteDate(Date deleteDate) {
		this.deleteDate = deleteDate;
	}
	public String getStrLoginFailCount() {
		return strLoginFailCount;
	}
	public void setStrLoginFailCount(String strLoginFailCount) {
		this.strLoginFailCount = strLoginFailCount;
	}
	public String getStrLastPwdUpdateDate() {
		return strLastPwdUpdateDate;
	}
	public void setStrLastPwdUpdateDate(String strLastPwdUpdateDate) {
		this.strLastPwdUpdateDate = strLastPwdUpdateDate;
	}
	public String getStrJoinDate() {
		return strJoinDate;
	}
	public void setStrJoinDate(String strJoinDate) {
		this.strJoinDate = strJoinDate;
	}
	public String getStrLeaveDate() {
		return strLeaveDate;
	}
	public void setStrLeaveDate(String strLeaveDate) {
		this.strLeaveDate = strLeaveDate;
	}
	public String getStrCreateDate() {
		return strCreateDate;
	}
	public void setStrCreateDate(String strCreateDate) {
		this.strCreateDate = strCreateDate;
	}
	public String getStrDeleteDate() {
		return strDeleteDate;
	}
	public void setStrDeleteDate(String strDeleteDate) {
		this.strDeleteDate = strDeleteDate;
	}
	public int getEcnt() {
		return Ecnt;
	}
	public void setEcnt(int ecnt) {
		Ecnt = ecnt;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getDeptmnt() {
		return deptmnt;
	}
	public void setDeptmnt(String deptmnt) {
		this.deptmnt = deptmnt;
	}
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}
	public String getOrgPwd() {
		return orgPwd;
	}
	public void setOrgPwd(String orgPwd) {
		this.orgPwd = orgPwd;
	}
	public ArrayList<String> getSeqNoList() {
		return seqNoList;
	}
	public void setSeqNoList(ArrayList<String> seqNoList) {
		this.seqNoList = seqNoList;
	}
	public String getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}
    public String getSessionId() {
        return sessionId;
    }
    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }
    
    public String getUSER_NM_KO() {
        return USER_NM_KO;
    }
    public void setUSER_NM_KO(String uSER_NM_KO) {
        USER_NM_KO = uSER_NM_KO;
    }
    public String getUSER_NM_EN() {
        return USER_NM_EN;
    }
    public void setUSER_NM_EN(String uSER_NM_EN) {
        USER_NM_EN = uSER_NM_EN;
    }
    public String getUSE_TY_CD() {
        return USE_TY_CD;
    }
    public void setUSE_TY_CD(String uSE_TY_CD) {
        USE_TY_CD = uSE_TY_CD;
    }
    public String getGRP_ID() {
        return GRP_ID;
    }
    public void setGRP_ID(String gRP_ID) {
        GRP_ID = gRP_ID;
    }
    public String getGRP_NM_KO() {
        return GRP_NM_KO;
    }
    public void setGRP_NM_KO(String gRP_NM_KO) {
        GRP_NM_KO = gRP_NM_KO;
    }
    public String getAUTH_LVL_NM() {
        return AUTH_LVL_NM;
    }
    public void setAUTH_LVL_NM(String aUTH_LVL_NM) {
        AUTH_LVL_NM = aUTH_LVL_NM;
    }
    
    
}
