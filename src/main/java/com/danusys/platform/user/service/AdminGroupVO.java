package com.danusys.platform.user.service;

/**
 * @Class Name : AdminGroupVO.java
 * @Description : AdminGroup VO class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-06
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class AdminGroupVO extends AdminGroupDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** seq_no */
    private int seqNo;
    
    /** grp_id */
    private java.lang.String grpId;
    
    /** grp_nm */
    private java.lang.String grpNm;
    
    /** dstrt_cd */
    private java.lang.String dstrtCd;
    
    /** use_ty_cd */
    private java.lang.String useTyCd;
    
    /** start_pgm_menu_id */
    private java.lang.String startPgmMenuId;
    
    /** authority */
    private java.lang.String authority;
    
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
    
    public java.lang.String getGrpNm() {
        return this.grpNm;
    }
    
    public void setGrpNm(java.lang.String grpNm) {
        this.grpNm = grpNm;
    }
    
    public java.lang.String getDstrtCd() {
        return this.dstrtCd;
    }
    
    public void setDstrtCd(java.lang.String dstrtCd) {
        this.dstrtCd = dstrtCd;
    }
    
    public java.lang.String getUseTyCd() {
        return this.useTyCd;
    }
    
    public void setUseTyCd(java.lang.String useTyCd) {
        this.useTyCd = useTyCd;
    }
    
    public java.lang.String getStartPgmMenuId() {
        return this.startPgmMenuId;
    }
    
    public void setStartPgmMenuId(java.lang.String startPgmMenuId) {
        this.startPgmMenuId = startPgmMenuId;
    }
    
    public java.lang.String getAuthority() {
        return this.authority;
    }
    
    public void setAuthority(java.lang.String authority) {
        this.authority = authority;
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
