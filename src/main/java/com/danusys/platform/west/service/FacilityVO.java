package com.danusys.platform.west.service;

import java.util.ArrayList;

import egovframework.com.cmm.ComDefaultVO;

/**
 * @Class Name : FacilityVO.java
 * @Description : Facility VO class
 * @Modification Information
 *
 * @author 김하울
 * @since 2017-12-11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class FacilityVO extends ComDefaultVO{ 
    private static final long serialVersionUID = 1L;
    
    /** seq_no */
    private String seqNo;
    private ArrayList<String> seqNoList;
    
    /** cctv_nm */
    private String cctvNm;
    
    /** node_ip */
    private String nodeIp;
    
    /** node_id */
    private String nodeId;
    
    /** node_port */
    private String nodePort;
    
    private String acptIp;
    private String acptPort;
    private String acptId;
    private String acptPw;
    private String rtspUrl;
    private String rtspFullUrl;

	/** mng_cd */
    private String mngCd;
    
    /** purpose */
    private String purpose;
    
    /** PTZ_gbn */
    private String PTZGbn;
    
    /** encrypt_latitude */
    private Double encryptLatitude;
    
    /** encrypt_longitude */
    private Double encryptLongitude;
    
    /** latitude */
    private String latitude;
    
    /** longitude */
    private String longitude;
    
    /** inst_id */
    private String instId;
    
    /** upd_id */
    private String updId;
    
    /** distance */
    private String distance;
    
    private String totSearch;
    
    /** flag */
    private String flag;
    
    /** facility_gbn */
    private String facilityGbn;
    
    private String facilityType;
    
    private String state;
    
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

    public String getCctvNm() {
        return cctvNm;
    }

    public void setCctvNm(String cctvNm) {
        this.cctvNm = cctvNm;
    }

    public String getNodeIp() {
        return nodeIp;
    }

    public void setNodeIp(String nodeIp) {
        this.nodeIp = nodeIp;
    }

    public String getNodeId() {
        return nodeId;
    }

    public void setNodeId(String nodeId) {
        this.nodeId = nodeId;
    }
    
    public String getNodePort() {
		return nodePort;
	}

	public void setNodePort(String nodePort) {
		this.nodePort = nodePort;
	}

    public String getAcptIp() {
        return acptIp;
    }

    public void setAcptIp(String acptIp) {
        this.acptIp = acptIp;
    }

    public String getAcptPort() {
        return acptPort;
    }

    public void setAcptPort(String acptPort) {
        this.acptPort = acptPort;
    }

    public String getAcptId() {
        return acptId;
    }

    public void setAcptId(String acptId) {
        this.acptId = acptId;
    }

    public String getAcptPw() {
        return acptPw;
    }

    public void setAcptPw(String acptPw) {
        this.acptPw = acptPw;
    }

    public String getRtspUrl() {
        return rtspUrl;
    }

    public void setRtspUrl(String rtspUrl) {
        this.rtspUrl = rtspUrl;
    }

    public String getRtspFullUrl() {
        return rtspFullUrl;
    }

    public void setRtspFullUrl(String rtspFullUrl) {
        this.rtspFullUrl = rtspFullUrl;
    }

    public String getMngCd() {
        return mngCd;
    }

    public void setMngCd(String mngCd) {
        this.mngCd = mngCd;
    }

    public String getPurpose() {
        return purpose;
    }

    public void setPurpose(String purpose) {
        this.purpose = purpose;
    }

    public String getPTZGbn() {
        return PTZGbn;
    }

    public void setPTZGbn(String pTZGbn) {
        PTZGbn = pTZGbn;
    }

    public Double getEncryptLatitude() {
        return encryptLatitude;
    }

    public void setEncryptLatitude(Double encryptLatitude) {
        this.encryptLatitude = encryptLatitude;
    }

    public Double getEncryptLongitude() {
        return encryptLongitude;
    }

    public void setEncryptLongitude(Double encryptLongitude) {
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

    public String getTotSearch() {
        return totSearch;
    }

    public void setTotSearch(String totSearch) {
        this.totSearch = totSearch;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public String getFacilityGbn() {
        return facilityGbn;
    }

    public void setFacilityGbn(String facilityGbn) {
        this.facilityGbn = facilityGbn;
    }

    public String getFacilityType() {
        return facilityType;
    }

    public void setFacilityType(String facilityType) {
        this.facilityType = facilityType;
    }

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
    
}
