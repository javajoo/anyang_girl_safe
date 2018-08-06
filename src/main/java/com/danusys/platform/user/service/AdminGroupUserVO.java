package com.danusys.platform.user.service;

import egovframework.com.cmm.ComDefaultVO;

/**
 * @Class Name : AdminGroupUserVO.java
 * @Description : AdminGroupUser VO class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-06
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class AdminGroupUserVO  extends AdminDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** seq_no */
    private int seqNo;
    
    /** grp_id */
    private java.lang.String grpId;
    
    /** user_id */
    private java.lang.String userId;
    
    /** use_ty_cd */
    private java.lang.String useTyCd;
    
    /** auth_lvl */
    private int authLvl;
    
    /** upd_user_id */
    private java.lang.String updUserId;
    
    /** upd_date */
    private java.util.Date updDate;
    
    /** rgs_user_id */
    private java.lang.String rgsUserId;
    
    /** rgs_date */
    private java.util.Date rgsDate;
    
    public int getSeqNo() {
        return this.seqNo;
    }
    
    public void setSeqNo(int seqNo) {
        this.seqNo = seqNo;
    }
    
    public java.lang.String getGrpId() {
        return this.grpId;
    }
    
    public void setGrpId(java.lang.String grpId) {
        this.grpId = grpId;
    }
    
    public java.lang.String getUserId() {
        return this.userId;
    }
    
    public void setUserId(java.lang.String userId) {
        this.userId = userId;
    }
    
    public java.lang.String getUseTyCd() {
        return this.useTyCd;
    }
    
    public void setUseTyCd(java.lang.String useTyCd) {
        this.useTyCd = useTyCd;
    }
    
    public int getAuthLvl() {
        return this.authLvl;
    }
    
    public void setAuthLvl(int authLvl) {
        this.authLvl = authLvl;
    }
    
    public java.lang.String getUpdUserId() {
        return this.updUserId;
    }
    
    public void setUpdUserId(java.lang.String updUserId) {
        this.updUserId = updUserId;
    }
    
    public java.util.Date getUpdDate() {
        return this.updDate;
    }
    
    public void setUpdDate(java.util.Date updDate) {
        this.updDate = updDate;
    }
    
    public java.lang.String getRgsUserId() {
        return this.rgsUserId;
    }
    
    public void setRgsUserId(java.lang.String rgsUserId) {
        this.rgsUserId = rgsUserId;
    }
    
    public java.util.Date getRgsDate() {
        return this.rgsDate;
    }
    
    public void setRgsDate(java.util.Date rgsDate) {
        this.rgsDate = rgsDate;
    }
    
}
