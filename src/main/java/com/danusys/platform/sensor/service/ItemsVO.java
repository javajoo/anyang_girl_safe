package com.danusys.platform.sensor.service;

import java.util.ArrayList;

import egovframework.com.cmm.ComDefaultVO;

/**
 * @Class Name : ItemsVO.java
 * @Description : Items VO class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-01-18
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class ItemsVO extends ComDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** ID */
    private java.lang.String id;
    private ArrayList<String> idList;
    
    /** NAME */
    private java.lang.String name;
    
    /** UNIT */
    private java.lang.String unit;
    
    /** DEC */
    private byte dec;
    
    /** LO */
    private double lo;
    
    /** HI */
    private double hi;
    
    /** BOTTOM */
    private double bottom;
    
    /** TOP */
    private double top;
    
    /** REMARK */
    private java.lang.String remark;
    
    /** ORDER */
    private int order;
    
    /** USING */
    private int using;
    
    private String search;
    
    /** flag */
    private String flag;
    
    public java.lang.String getId() {
        return this.id;
    }
    
    public void setId(java.lang.String id) {
        this.id = id;
    }
    
    public java.lang.String getName() {
        return this.name;
    }
    
    public void setName(java.lang.String name) {
        this.name = name;
    }
    
    public java.lang.String getUnit() {
        return this.unit;
    }
    
    public void setUnit(java.lang.String unit) {
        this.unit = unit;
    }
    
    public byte getDec() {
        return this.dec;
    }
    
    public void setDec(byte dec) {
        this.dec = dec;
    }
    
    public double getLo() {
        return this.lo;
    }
    
    public void setLo(double lo) {
        this.lo = lo;
    }
    
    public double getHi() {
        return this.hi;
    }
    
    public void setHi(double hi) {
        this.hi = hi;
    }
    
    public double getBottom() {
        return this.bottom;
    }
    
    public void setBottom(double bottom) {
        this.bottom = bottom;
    }
    
    public double getTop() {
        return this.top;
    }
    
    public void setTop(double top) {
        this.top = top;
    }
    
    public java.lang.String getRemark() {
        return this.remark;
    }
    
    public void setRemark(java.lang.String remark) {
        this.remark = remark;
    }
    
    public int getOrder() {
        return this.order;
    }
    
    public void setOrder(int order) {
        this.order = order;
    }
    
    public int getUsing() {
        return this.using;
    }
    
    public void setUsing(int using) {
        this.using = using;
    }

	public ArrayList<String> getIdList() {
		return idList;
	}

	public void setIdList(ArrayList<String> idList) {
		this.idList = idList;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}
    
}
