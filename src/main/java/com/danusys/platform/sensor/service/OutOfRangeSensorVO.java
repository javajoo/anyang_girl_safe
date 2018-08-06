package com.danusys.platform.sensor.service;

import java.util.ArrayList;

import egovframework.com.cmm.ComDefaultVO;

/**
 * @Class Name : OutOfRangeSensorVO.java
 * @Description : OutOfRangeSensor VO class, 임계치가 넘어간 센서들의 조회 결과.
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-01-19
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class OutOfRangeSensorVO extends ComDefaultVO{
    private static final long serialVersionUID = 1L;
    
    String type;
    double value;
    double lo;
    double hi;
    int siteno;
    double longitude;
    double latitude;
    String unit;
    String date;
    String name;
    
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public double getValue() {
		return value;
	}
	public void setValue(double value) {
		this.value = value;
	}
	public double getLo() {
		return lo;
	}
	public void setLo(double lo) {
		this.lo = lo;
	}
	public double getHi() {
		return hi;
	}
	public void setHi(double hi) {
		this.hi = hi;
	}
	public int getSiteno() {
		return siteno;
	}
	public void setSiteno(int siteno) {
		this.siteno = siteno;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
