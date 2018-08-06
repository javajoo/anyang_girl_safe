package com.danusys.platform.service;

public class LogVO {
	private String logType;
	private String owner;
	private String content;
	private String ip;
	private String createDate;
	private String startDate;
	private String endDate;
	private String logClass;
	private String logCategory;
	
	public String getLogType() {
		return logType;
	}
	public void setLogType(String logType) {
		this.logType = logType;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
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
	public String getLogClass() {
		return logClass;
	}
	public void setLogClass(String logClass) {
		this.logClass = logClass;
	}
	public String getLogCategory() {
		return logCategory;
	}
	public void setLogCategory(String logCategory) {
		this.logCategory = logCategory;
	}
}
