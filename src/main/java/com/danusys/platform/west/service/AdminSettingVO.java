package com.danusys.platform.west.service;

import java.util.ArrayList;

import egovframework.com.cmm.ComDefaultVO;

public class AdminSettingVO extends ComDefaultVO{
    private static final long serialVersionUID = 1L;
    
    private ArrayList<String> seqNoList;
    private String seqNo;
    
    private String id;
	private String pwd;
	private String name;
	private String birthday;
	private String phoneNo;
	private String email;
	private String authority;
	private String address;
	private String joinDate;
	private String deleted;
	private String deleteId;
	private String deleteDate;
	private String deptmnt;
    private String rank;
	private String userFlag;
		
	private String flag;
	private String key;
	
	private String orgPwd;

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

    public String getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(String joinDate) {
        this.joinDate = joinDate;
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

    public String getDeleteDate() {
        return deleteDate;
    }

    public void setDeleteDate(String deleteDate) {
        this.deleteDate = deleteDate;
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

    public String getUserFlag() {
        return userFlag;
    }

    public void setUserFlag(String userFlag) {
        this.userFlag = userFlag;
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

    public String getOrgPwd() {
        return orgPwd;
    }

    public void setOrgPwd(String orgPwd) {
        this.orgPwd = orgPwd;
    }
}
