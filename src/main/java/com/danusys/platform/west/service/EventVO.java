package com.danusys.platform.west.service;

import java.util.ArrayList;

import egovframework.com.cmm.ComDefaultVO;

/**
 * @Class Name : EventVO.java
 * @Description : Event VO class
 * @Modification Information
 *
 * @author 김하울
 * @since 2017-12-11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class EventVO extends ComDefaultVO{ 
    private static final long serialVersionUID = 1L;
    
    /** seq_no */
    private String seqNo;
    private ArrayList<String> seqNoList;
    
    /** event_no */
    private String eventNo;
    
    /** event_type */
    private String eventType;
    
    /** event_de */
    private String eventDe;
    private String eventDeS;
    private String eventDeE;
    
    /** end_de */
    private String endDe;
    
    /** event_rating */
    private String eventRating;
    
    /** event_place */
    private String eventPlace;
    
    /** event_cont */
    private String eventCont;
    
    /** state */
    private String state;
    private String comboState;
    
    /** encrypt_latitude */
    private String encryptLatitude;
    
    /** encrypt_longitude */
    private String encryptLongitude;
    
    /** latitude */
    private String latitude;
    
    /** longitude */
    private String longitude;
    
    /** accept_type */
    private String acceptType;
    
    /** accept_id */
    private String acceptId;
    
    /** accept_cont */
    private String acceptCont;
    
    /** info_nm */
    private String infoNm;
    
    /** zone */
    private String zone;
    
    /** facility_id */
    private String facilityId;
    
    /** confm_flag */
    private String confmFlag;
    
    /** inst_id */
    private String instId;
    
    /** upd_id */
    private String updId;
    
    /** ASE_KEY */
    private String key;
    
    /** flag */
    private String flag;
    
    private String totSearch;
    
    private String etcCont;

    public String getSeqNo() {
        return seqNo;
    }

    public void setSeqNo(String seqNo) {
        this.seqNo = seqNo;
    }

    public ArrayList<String> getSeqNoList() {
        return seqNoList;
    }

    public void setSeqNoList(ArrayList<String> seqNoList) {
        this.seqNoList = seqNoList;
    }

    public String getEventNo() {
        return eventNo;
    }

    public void setEventNo(String eventNo) {
        this.eventNo = eventNo;
    }

    public String getEventType() {
        return eventType;
    }

    public void setEventType(String eventType) {
        this.eventType = eventType;
    }

    public String getEventDe() {
        return eventDe;
    }

    public void setEventDe(String eventDe) {
        this.eventDe = eventDe;
    }

    public String getEventDeS() {
        return eventDeS;
    }

    public void setEventDeS(String eventDeS) {
        this.eventDeS = eventDeS;
    }

    public String getEventDeE() {
        return eventDeE;
    }

    public void setEventDeE(String eventDeE) {
        this.eventDeE = eventDeE;
    }

    public String getEndDe() {
        return endDe;
    }

    public void setEndDe(String endDe) {
        this.endDe = endDe;
    }

    public String getEventRating() {
        return eventRating;
    }

    public void setEventRating(String eventRating) {
        this.eventRating = eventRating;
    }

    public String getEventPlace() {
        return eventPlace;
    }

    public void setEventPlace(String eventPlace) {
        this.eventPlace = eventPlace;
    }

    public String getEventCont() {
        return eventCont;
    }

    public void setEventCont(String eventCont) {
        this.eventCont = eventCont;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getComboState() {
        return comboState;
    }

    public void setComboState(String comboState) {
        this.comboState = comboState;
    }

    public String getEncryptLatitude() {
        return encryptLatitude;
    }

    public void setEncryptLatitude(String encryptLatitude) {
        this.encryptLatitude = encryptLatitude;
    }

    public String getEncryptLongitude() {
        return encryptLongitude;
    }

    public void setEncryptLongitude(String encryptLongitude) {
        this.encryptLongitude = encryptLongitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getAcceptType() {
        return acceptType;
    }

    public void setAcceptType(String acceptType) {
        this.acceptType = acceptType;
    }

    public String getAcceptId() {
        return acceptId;
    }

    public void setAcceptId(String acceptId) {
        this.acceptId = acceptId;
    }

    public String getAcceptCont() {
        return acceptCont;
    }

    public void setAcceptCont(String acceptCont) {
        this.acceptCont = acceptCont;
    }

    public String getInfoNm() {
        return infoNm;
    }

    public void setInfoNm(String infoNm) {
        this.infoNm = infoNm;
    }

    public String getZone() {
        return zone;
    }

    public void setZone(String zone) {
        this.zone = zone;
    }

    public String getFacilityId() {
        return facilityId;
    }

    public void setFacilityId(String facilityId) {
        this.facilityId = facilityId;
    }

    public String getConfmFlag() {
        return confmFlag;
    }

    public void setConfmFlag(String confmFlag) {
        this.confmFlag = confmFlag;
    }

    public String getInstId() {
        return instId;
    }

    public void setInstId(String instId) {
        this.instId = instId;
    }

    public String getUpdId() {
        return updId;
    }

    public void setUpdId(String updId) {
        this.updId = updId;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public String getTotSearch() {
        return totSearch;
    }

    public void setTotSearch(String totSearch) {
        this.totSearch = totSearch;
    }

	public String getEtcCont() {
		return etcCont;
	}

	public void setEtcCont(String etcCont) {
		this.etcCont = etcCont;
	}
    
}
