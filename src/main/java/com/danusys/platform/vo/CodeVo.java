package com.danusys.platform.vo;

import java.util.Date;

public class CodeVo {
	private int codeNo;
	private String domain;
	private String codeGroup;
	private String codeName;
	private String code;
	private String deleted;
	private String deleteId;
	private Date deleteDate;
	
	private String strCodeNo;
	private String strDeleteDate;
	public int getCodeNo() {
		return codeNo;
	}
	public void setCodeNo(int codeNo) {
		this.codeNo = codeNo;
	}
	public String getDomain() {
		return domain;
	}
	public void setDomain(String domain) {
		this.domain = domain;
	}
	public String getCodeGroup() {
		return codeGroup;
	}
	public void setCodeGroup(String codeGroup) {
		this.codeGroup = codeGroup;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public String getDeleteId() {
		return deleteId;
	}
	public void setDeleteId(String deleteId) {
		this.deleteId = deleteId;
	}
	public Date getDeleteDate() {
		return deleteDate;
	}
	public void setDeleteDate(Date deleteDate) {
		this.deleteDate = deleteDate;
	}
	public String getStrCodeNo() {
		return strCodeNo;
	}
	public void setStrCodeNo(String strCodeNo) {
		this.strCodeNo = strCodeNo;
	}
	public String getStrDeleteDate() {
		return strDeleteDate;
	}
	public void setStrDeleteDate(String strDeleteDate) {
		this.strDeleteDate = strDeleteDate;
	}
}
