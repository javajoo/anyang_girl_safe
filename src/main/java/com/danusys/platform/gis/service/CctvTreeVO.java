package com.danusys.platform.gis.service;

import egovframework.com.cmm.ComDefaultVO;

/**
 * @Class Name : CctvTreeVO.java
 * @Description : CctvTree VO class
 * @Modification Information
 *
 * @author 신대영
 * @since 2016-08-03
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class CctvTreeVO extends ComDefaultVO{ 
    private static final long serialVersionUID = 1L;
    
    /** id */
    private java.lang.String id;
    
    /** parent_id */
    private java.lang.String parentId;
    
    /** name */
    private java.lang.String name;
    
    /** state */
    private java.lang.String state;
    
    /** checked */
    private java.lang.String checked;
    
    /** icon_cls */
    private java.lang.String iconCls;
    
    /** order */
    private java.math.BigDecimal odr;
    
    
    /** inst_id */
    private java.lang.String instId;
    
    
    /** upd_id */
    private java.lang.String updId;
    
    private String flag;
    
    public java.lang.String getId() {
        return this.id;
    }
    
    public void setId(java.lang.String id) {
        this.id = id;
    }
    
    public java.lang.String getParentId() {
        return this.parentId;
    }
    
    public void setParentId(java.lang.String parentId) {
        this.parentId = parentId;
    }
    
    public java.lang.String getName() {
        return this.name;
    }
    
    public void setName(java.lang.String name) {
        this.name = name;
    }
    
    public java.lang.String getState() {
        return this.state;
    }
    
    public void setState(java.lang.String state) {
        this.state = state;
    }
    
    public java.lang.String getChecked() {
        return this.checked;
    }
    
    public void setChecked(java.lang.String checked) {
        this.checked = checked;
    }
    
    public java.lang.String getIconCls() {
        return this.iconCls;
    }
    
    public void setIconCls(java.lang.String iconCls) {
        this.iconCls = iconCls;
    }
    
    public java.math.BigDecimal getOdr() {
        return this.odr;
    }
    
    public void setOdr(java.math.BigDecimal odr) {
        this.odr = odr;
    }
    
    public java.lang.String getInstId() {
        return this.instId;
    }
    
    public void setInstId(java.lang.String instId) {
        this.instId = instId;
    }
    
    public java.lang.String getUpdId() {
        return this.updId;
    }
    
    public void setUpdId(java.lang.String updId) {
        this.updId = updId;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }
    
}
