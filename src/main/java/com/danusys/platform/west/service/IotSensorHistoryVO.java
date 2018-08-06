package com.danusys.platform.west.service;

import java.util.ArrayList;

import egovframework.com.cmm.ComDefaultVO;

/**
 * @Class Name : IotSensorHistoryVO.java
 * @Description : IotSensorHistory VO class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-01-17
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class IotSensorHistoryVO extends ComDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** seq_no */
    private int seqNo;
    private ArrayList<String> seqNoList;
    
    /** name */
    private java.lang.String name;
    
    /** type */
    private java.lang.String type;
    private String typeNm;
    
    /** value */
    private java.lang.String value;
    
    /** threshold_lo */
    private java.lang.String thresholdLo;
    
    /** threshold_hi */
    private java.lang.String thresholdHi;
    
    /** date */
    private String date;
    
    /** site_no */
    private int siteNo;
    
    private double latitude;
    
    private double longitude;
    
    private String unit;
    
    private String search;
    
    public int getSeqNo() {
        return this.seqNo;
    }
    
    public void setSeqNo(int seqNo) {
        this.seqNo = seqNo;
    }
    
    public java.lang.String getName() {
        return this.name;
    }
    
    public void setName(java.lang.String name) {
        this.name = name;
    }
    
    public java.lang.String getType() {
        return this.type;
    }
    
    public void setType(java.lang.String type) {
        this.type = type;
    }
    
    public String getTypeNm() {
        return typeNm;
    }

    public void setTypeNm(String typeNm) {
        this.typeNm = typeNm;
    }

    public java.lang.String getValue() {
        return this.value;
    }
    
    public void setValue(java.lang.String value) {
        this.value = value;
    }
    
    public java.lang.String getThresholdLo() {
		return thresholdLo;
	}

	public void setThresholdLo(java.lang.String thresholdLo) {
		this.thresholdLo = thresholdLo;
	}

	public java.lang.String getThresholdHi() {
		return thresholdHi;
	}

	public void setThresholdHi(java.lang.String thresholdHi) {
		this.thresholdHi = thresholdHi;
	}

	public String getDate() {
        return this.date;
    }
    
    public void setDate(String date) {
        this.date = date;
    }
    
    public int getSiteNo() {
        return this.siteNo;
    }
    
    public void setSiteNo(int siteNo) {
        this.siteNo = siteNo;
    }

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double langitude) {
		this.latitude = langitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}
    
}
