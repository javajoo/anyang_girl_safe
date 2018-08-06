package com.danusys.platform.sensor.service;

import egovframework.com.cmm.ComDefaultVO;

/**
 * @Class Name : DatasVO.java
 * @Description : Datas VO class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-01-18
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class DatasVO extends ComDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** SEQ */
    private short seq;
    
    /** SITENO */
    private short siteno;
    
    /** DATE */
    private int date;
    
    /** LNG */
    private double lng;
    
    /** LAT */
    private double lat;
    
    /** WDATE */
    private int wdate;
    
    /** WXY */
    private int wxy;
    
    /** ou */
    private double ou;
    
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
    
    /** humidity */
    private double humidity;
    
    /** winddirection */
    private double winddirection;
    
    /** windspeed */
    private double windspeed;
    
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

    private String search;

    private String hh;

    private String startDate;
    
    private String endDate;
    
    private String searchGubun;

    public short getSeq() {
        return this.seq;
    }
    
    public void setSeq(short seq) {
        this.seq = seq;
    }
    
    public short getSiteno() {
        return this.siteno;
    }
    
    public void setSiteno(short siteno) {
        this.siteno = siteno;
    }
    
    public int getDate() {
        return this.date;
    }
    
    public void setDate(int date) {
        this.date = date;
    }
    
    public double getLng() {
        return this.lng;
    }
    
    public void setLng(double lng) {
        this.lng = lng;
    }
    
    public double getLat() {
        return this.lat;
    }
    
    public void setLat(double lat) {
        this.lat = lat;
    }
    
    public int getWdate() {
        return this.wdate;
    }
    
    public void setWdate(int wdate) {
        this.wdate = wdate;
    }
    
    public int getWxy() {
        return this.wxy;
    }
    
    public void setWxy(int wxy) {
        this.wxy = wxy;
    }
    
    public double getOu() {
        return this.ou;
    }
    
    public void setOu(double ou) {
        this.ou = ou;
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
    
    public double getHumidity() {
        return this.humidity;
    }
    
    public void setHumidity(double humidity) {
        this.humidity = humidity;
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
    
    public String getSearch() {
        return search;
    }

    public void setSearch(String search) {
        this.search = search;
    }
    
    public String getHh() {
        return hh;
    }

    public void setHh(String hh) {
        this.hh = hh;
    }  
    
    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }
    
    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }
    
    public String getSearchGubun() {
        return searchGubun;
    }

    public void setSearchGubun(String searchGubun) {
        this.searchGubun = searchGubun;
    }

}
