package com.danusys.platform.user.service;

/**
 * @Class Name : CmUserAreaVO.java
 * @Description : CmUserArea VO class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-10
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class CmUserAreaVO extends AdminDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** AREA_CD */
    private java.lang.String areaCd;
    
    /** USER_ID */
    private java.lang.String userId;
    
    /** USE_TY_CD */
    private java.lang.String useTyCd;
    
    /** UPD_USER_ID */
    private java.lang.String updUserId;
    
    /** UPD_DATE */
    private java.util.Date updDate;
    
    /** RGS_USER_ID */
    private java.lang.String rgsUserId;
    
    /** RGS_DATE */
    private java.util.Date rgsDate;
    
    public java.lang.String getAreaCd() {
        return this.areaCd;
    }
    
    public void setAreaCd(java.lang.String areaCd) {
        this.areaCd = areaCd;
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
