package com.danusys.platform.sensor.service;

import java.util.ArrayList;

import egovframework.com.cmm.ComDefaultVO;

/**
 * @Class Name : LastsVO.java
 * @Description : Lasts VO class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-01-16
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class LastsVO extends ComDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** SITENO */
    private short siteno;
    private ArrayList<String> sitenoList;
    
    /** DATE */
    private String date;
    
    /** LNG */
    private double longitude;
    
    /** LAT */
    private double latitude;
    
    /** WDATA */
    private java.lang.String wdata;
    
    /** ou */
    private double ou;
    private double ouLo;
    private double ouHi;
    
    /** oi */
    private double oi;
    
    /** signal */
    private double signal;
    
    /** sout1 */
    private double sout1;
    
    /** sout2 */
    private double sout2;
    
    /** sout3 */
    private double sout3;
    
    /** sout4 */
    private double sout4;
    
    /** H2S */
    private double h2s;
    
    /** NH3 */
    private double nh3;
    
    /** CH3SH */
    private double ch3sh;
    
    /** VOC */
    private double voc;
    
    /** temperature */
    private double temperature;
    private double temperatureLo;
    private double temperatureHi;
    
    /** humidity */
    private double humidity;
    private double humidityLo;
    private double humidityHi;
    
    /** winddirection */
    private double winddirection;
    
    /** windspeed */
    private double windspeed;
    private double windspeedLo;
    private double windspeedHi;
    
    /** pozip */
    private double pozip;
    
    /** ou_Alm */
    private java.lang.String ouAlm;
    
    /** H2S_Alm */
    private java.lang.String h2sAlm;
    
    /** NH3_Alm */
    private java.lang.String nh3Alm;
    
    /** VOC_Alm */
    private java.lang.String vocAlm;
    
    /** atm */
    private float atm;
    
    private String name;
    
    private String search;
    
    /** flag */
    private String flag;
    
    public short getSiteno() {
        return this.siteno;
    }
    
    public void setSiteno(short siteno) {
        this.siteno = siteno;
    }
    
    public String getDate() {
        return this.date;
    }
    
    public void setDate(String date) {
        this.date = date;
    }
    
    public double getLongitude() {
        return this.longitude;
    }
    
    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }
    
    public double getLatitude() {
        return this.latitude;
    }
    
    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }
    
    public java.lang.String getWdata() {
        return this.wdata;
    }
    
    public void setWdata(java.lang.String wdata) {
        this.wdata = wdata;
    }
    
    public double getOu() {
        return this.ou;
    }
    
    public void setOu(double ou) {
        this.ou = ou;
    }
    
    public double getOuLo() {
        return ouLo;
    }

    public void setOuLo(double ouLo) {
        this.ouLo = ouLo;
    }

    public double getOuHi() {
        return ouHi;
    }

    public void setOuHi(double ouHi) {
        this.ouHi = ouHi;
    }

    public double getOi() {
        return this.oi;
    }
    
    public void setOi(double oi) {
        this.oi = oi;
    }
    
    public double getSignal() {
        return this.signal;
    }
    
    public void setSignal(double signal) {
        this.signal = signal;
    }
    
    public double getSout1() {
        return this.sout1;
    }
    
    public void setSout1(double sout1) {
        this.sout1 = sout1;
    }
    
    public double getSout2() {
        return this.sout2;
    }
    
    public void setSout2(double sout2) {
        this.sout2 = sout2;
    }
    
    public double getSout3() {
        return this.sout3;
    }
    
    public void setSout3(double sout3) {
        this.sout3 = sout3;
    }
    
    public double getSout4() {
        return this.sout4;
    }
    
    public void setSout4(double sout4) {
        this.sout4 = sout4;
    }
    
    public double getH2s() {
        return this.h2s;
    }
    
    public void setH2s(double h2s) {
        this.h2s = h2s;
    }
    
    public double getNh3() {
        return this.nh3;
    }
    
    public void setNh3(double nh3) {
        this.nh3 = nh3;
    }
    
    public double getCh3sh() {
        return this.ch3sh;
    }
    
    public void setCh3sh(double ch3sh) {
        this.ch3sh = ch3sh;
    }
    
    public double getVoc() {
        return this.voc;
    }
    
    public void setVoc(double voc) {
        this.voc = voc;
    }
    
    public double getTemperature() {
        return this.temperature;
    }
    
    public void setTemperature(double temperature) {
        this.temperature = temperature;
    }
    
    public double getTemperatureLo() {
        return temperatureLo;
    }

    public void setTemperatureLo(double temperatureLo) {
        this.temperatureLo = temperatureLo;
    }

    public double getTemperatureHi() {
        return temperatureHi;
    }

    public void setTemperatureHi(double temperatureHi) {
        this.temperatureHi = temperatureHi;
    }

    public double getHumidity() {
        return this.humidity;
    }
    
    public void setHumidity(double humidity) {
        this.humidity = humidity;
    }
    
    public double getHumidityLo() {
        return humidityLo;
    }

    public void setHumidityLo(double humidityLo) {
        this.humidityLo = humidityLo;
    }

    public double getHumidityHi() {
        return humidityHi;
    }

    public void setHumidityHi(double humidityHi) {
        this.humidityHi = humidityHi;
    }

    public double getWinddirection() {
        return this.winddirection;
    }
    
    public void setWinddirection(double winddirection) {
        this.winddirection = winddirection;
    }
    
    public double getWindspeed() {
        return this.windspeed;
    }
    
    public void setWindspeed(double windspeed) {
        this.windspeed = windspeed;
    }
    
    public double getWindspeedLo() {
        return windspeedLo;
    }

    public void setWindspeedLo(double windspeedLo) {
        this.windspeedLo = windspeedLo;
    }

    public double getWindspeedHi() {
        return windspeedHi;
    }

    public void setWindspeedHi(double windspeedHi) {
        this.windspeedHi = windspeedHi;
    }

    public double getPozip() {
        return this.pozip;
    }
    
    public void setPozip(double pozip) {
        this.pozip = pozip;
    }
    
    public java.lang.String getOuAlm() {
        return this.ouAlm;
    }
    
    public void setOuAlm(java.lang.String ouAlm) {
        this.ouAlm = ouAlm;
    }
    
    public java.lang.String getH2sAlm() {
        return this.h2sAlm;
    }
    
    public void setH2sAlm(java.lang.String h2sAlm) {
        this.h2sAlm = h2sAlm;
    }
    
    public java.lang.String getNh3Alm() {
        return this.nh3Alm;
    }
    
    public void setNh3Alm(java.lang.String nh3Alm) {
        this.nh3Alm = nh3Alm;
    }
    
    public java.lang.String getVocAlm() {
        return this.vocAlm;
    }
    
    public void setVocAlm(java.lang.String vocAlm) {
        this.vocAlm = vocAlm;
    }
    
    public float getAtm() {
        return this.atm;
    }
    
    public void setAtm(float atm) {
        this.atm = atm;
    }

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public ArrayList<String> getSitenoList() {
		return sitenoList;
	}

	public void setSitenoList(ArrayList<String> sitenoList) {
		this.sitenoList = sitenoList;
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
