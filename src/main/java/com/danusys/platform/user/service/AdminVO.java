package com.danusys.platform.user.service;

/**
 * @Class Name : AdminVO.java
 * @Description : Admin VO class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-06
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class AdminVO extends AdminDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** seq_no */
    private int seqNo;
    
    /** id */
    private java.lang.String id;
    
    /** pwd */
    private java.lang.String pwd;
    
    /** name */
    private java.lang.String name;
    
    /** birthday */
    private java.lang.String birthday;
    
    /** phone_no */
    private java.lang.String phoneNo;
    
    /** email */
    private java.lang.String email;
    
    /** authority */
    private java.lang.String authority;
    
    /** address */
    private java.lang.String address;
    
    /** join_date */
    private java.util.Date joinDate;
    
    /** leave_date */
    private java.util.Date leaveDate;
    
    /** create_date */
    private java.util.Date createDate;
    
    /** login_fail_count */
    private int loginFailCount;
    
    /** last_pwd_update_date */
    private java.util.Date lastPwdUpdateDate;
    
    /** deleted */
    private java.lang.String deleted;
    
    /** delete_id */
    private java.lang.String deleteId;
    
    /** delete_date */
    private java.util.Date deleteDate;
    
    /** city_no */
    private int cityNo;
    
    /** deptmnt */
    private java.lang.String deptmnt;
    
    /** rank */
    private java.lang.String rank;
    
    /** user_flag */
    private java.lang.String userFlag;
    
    /** grp_id */
    private java.lang.String grpId;
    
    public int getSeqNo() {
        return this.seqNo;
    }
    
    public void setSeqNo(int seqNo) {
        this.seqNo = seqNo;
    }
    
    public java.lang.String getId() {
        return this.id;
    }
    
    public void setId(java.lang.String id) {
        this.id = id;
    }
    
    public java.lang.String getPwd() {
        return this.pwd;
    }
    
    public void setPwd(java.lang.String pwd) {
        this.pwd = pwd;
    }
    
    public java.lang.String getName() {
        return this.name;
    }
    
    public void setName(java.lang.String name) {
        this.name = name;
    }
    
    public java.lang.String getBirthday() {
        return this.birthday;
    }
    
    public void setBirthday(java.lang.String birthday) {
        this.birthday = birthday;
    }
    
    public java.lang.String getPhoneNo() {
        return this.phoneNo;
    }
    
    public void setPhoneNo(java.lang.String phoneNo) {
        this.phoneNo = phoneNo;
    }
    
    public java.lang.String getEmail() {
        return this.email;
    }
    
    public void setEmail(java.lang.String email) {
        this.email = email;
    }
    
    public java.lang.String getAuthority() {
        return this.authority;
    }
    
    public void setAuthority(java.lang.String authority) {
        this.authority = authority;
    }
    
    public java.lang.String getAddress() {
        return this.address;
    }
    
    public void setAddress(java.lang.String address) {
        this.address = address;
    }
    
    public java.util.Date getJoinDate() {
        return this.joinDate;
    }
    
    public void setJoinDate(java.util.Date joinDate) {
        this.joinDate = joinDate;
    }
    
    public java.util.Date getLeaveDate() {
        return this.leaveDate;
    }
    
    public void setLeaveDate(java.util.Date leaveDate) {
        this.leaveDate = leaveDate;
    }
    
    public java.util.Date getCreateDate() {
        return this.createDate;
    }
    
    public void setCreateDate(java.util.Date createDate) {
        this.createDate = createDate;
    }
    
    public int getLoginFailCount() {
        return this.loginFailCount;
    }
    
    public void setLoginFailCount(int loginFailCount) {
        this.loginFailCount = loginFailCount;
    }
    
    public java.util.Date getLastPwdUpdateDate() {
        return this.lastPwdUpdateDate;
    }
    
    public void setLastPwdUpdateDate(java.util.Date lastPwdUpdateDate) {
        this.lastPwdUpdateDate = lastPwdUpdateDate;
    }
    
    public java.lang.String getDeleted() {
        return this.deleted;
    }
    
    public void setDeleted(java.lang.String deleted) {
        this.deleted = deleted;
    }
    
    public java.lang.String getDeleteId() {
        return this.deleteId;
    }
    
    public void setDeleteId(java.lang.String deleteId) {
        this.deleteId = deleteId;
    }
    
    public java.util.Date getDeleteDate() {
        return this.deleteDate;
    }
    
    public void setDeleteDate(java.util.Date deleteDate) {
        this.deleteDate = deleteDate;
    }
    
    public int getCityNo() {
        return this.cityNo;
    }
    
    public void setCityNo(int cityNo) {
        this.cityNo = cityNo;
    }
    
    public java.lang.String getDeptmnt() {
        return this.deptmnt;
    }
    
    public void setDeptmnt(java.lang.String deptmnt) {
        this.deptmnt = deptmnt;
    }
    
    public java.lang.String getRank() {
        return this.rank;
    }
    
    public void setRank(java.lang.String rank) {
        this.rank = rank;
    }
    
    public java.lang.String getUserFlag() {
        return this.userFlag;
    }
    
    public void setUserFlag(java.lang.String userFlag) {
        this.userFlag = userFlag;
    }
    
    public java.lang.String getGrpId() {
        return this.grpId;
    }
    
    public void setGrpId(java.lang.String grpId) {
        this.grpId = grpId;
    }
    
}
