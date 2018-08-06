package com.danusys.platform.login.service;

/**
 * @Class Name : ConfigVO.java
 * @Description : Config VO class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-02-02
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class ConfigVO{
    private static final long serialVersionUID = 1L;
    
    /** mgr_ip */
    private java.lang.String mgrIp;
    
    /** mgr_port */
    private java.lang.String mgrPort;
    
    /** mgr_id */
    private java.lang.String mgrId;
    
    /** mgr_pw */
    private java.lang.String mgrPw;
    
    /** gis_dfms_url */
    private java.lang.String gisDfmsUrl;
    
    /** gis_dfmswfs_url */
    private java.lang.String gisDfmswfsUrl;
    
    public java.lang.String getMgrIp() {
        return this.mgrIp;
    }
    
    public void setMgrIp(java.lang.String mgrIp) {
        this.mgrIp = mgrIp;
    }
    
    public java.lang.String getMgrPort() {
        return this.mgrPort;
    }
    
    public void setMgrPort(java.lang.String mgrPort) {
        this.mgrPort = mgrPort;
    }
    
    public java.lang.String getMgrId() {
        return this.mgrId;
    }
    
    public void setMgrId(java.lang.String mgrId) {
        this.mgrId = mgrId;
    }
    
    public java.lang.String getMgrPw() {
        return this.mgrPw;
    }
    
    public void setMgrPw(java.lang.String mgrPw) {
        this.mgrPw = mgrPw;
    }
    
    public java.lang.String getGisDfmsUrl() {
        return this.gisDfmsUrl;
    }
    
    public void setGisDfmsUrl(java.lang.String gisDfmsUrl) {
        this.gisDfmsUrl = gisDfmsUrl;
    }
    
    public java.lang.String getGisDfmswfsUrl() {
        return this.gisDfmswfsUrl;
    }
    
    public void setGisDfmswfsUrl(java.lang.String gisDfmswfsUrl) {
        this.gisDfmswfsUrl = gisDfmswfsUrl;
    }
    
}
