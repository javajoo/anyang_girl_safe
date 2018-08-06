package com.danusys.platform.west.service;

import egovframework.com.cmm.ComDefaultVO;

/**
 * @Class Name : LogVO.java
 * @Description : Log VO class
 * @Modification Information
 *
 * @author 김하울
 * @since 2018-01-03
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class LogVO extends ComDefaultVO{
    private static final long serialVersionUID = 1L;
    
    /** log_no */
    private String logNo;
    
    /** log_type */
    private String logType;
    
    /** admin_id */
	private String adminId;
	
	/** admin_nm */
    private String adminNm;
	
	/** content */
	private String content;
	
	/** ip */
	private String ip;
	
	/** session */
    private String sessionId;
	
	/** create_date */
	private String createDate;
	
	private String startDate;
	
	private String endDate;
	
	private String totSearch;

    public String getLogNo() {
        return logNo;
    }

    public void setLogNo(String logNo) {
        this.logNo = logNo;
    }

    public String getLogType() {
        return logType;
    }

    public void setLogType(String logType) {
        this.logType = logType;
    }

    public String getAdminId() {
        return adminId;
    }

    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    public String getAdminNm() {
        return adminNm;
    }

    public void setAdminNm(String adminNm) {
        this.adminNm = adminNm;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
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

    public String getTotSearch() {
        return totSearch;
    }

    public void setTotSearch(String totSearch) {
        this.totSearch = totSearch;
    }
}
