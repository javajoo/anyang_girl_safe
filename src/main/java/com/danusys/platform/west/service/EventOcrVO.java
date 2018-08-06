package com.danusys.platform.west.service;

import egovframework.com.cmm.ComDefaultVO;

public class EventOcrVO extends ComDefaultVO {
	private static final long serialVersionUID = 1L;

	private String evtOcrNo;
	private String evtId;
	private String evtNm;
	private String evtGradCd;
	private String evtGradNm;
	private String evtPrgrsCd;
	private String evtPrgrsNm;
	private String ocrFcltId;
	private String ocrPointX;
	private String ocrPointY;
	private String evtOcrYmdHms;
	private String uscvGrpCd;
	private String sysCd;
	private String userId;
	private String evtDtl;
	private String imgUrl;
	private String presetNum;
	private String searchEvtOcrYmdHms;
	private String searchEvtPlace;
	private String searchEvtId;
	private boolean excludeFcltError;
	private String evtLcMoveYn;
	private String evtPlace;
	private String evtEndYmdHms;
	private String pointX;
	private String pointY;
	private String pointZ;
	private String pcvYn;
	private String pcvUserId;
	private String pcvUserNm;
	private String pcvDate;
	private String rceptTyCd;
	private String rceptUserId;
	private String rceptUserNm;
	private String rceptYmdHms;
	private String recptConts;
	private String apcNm;
	private String apcTelNo;
	private String actionUserId;
	private String actionUserNm;
	private String actionYmdHms;
	private String actionConts;
	private String actionEtc;
	private String scopeRads;
	private String cnclRsn;
	private String dstrtCd;
	private String ctrCd;
	private String rgsUserId;
	private String rgsDate;
	private String updUserId;
	private String updDate;
	private String itemArr;
	private String itemCnt;
	private String areaCd;
	private String userNm;
	private String actionVal;
	private String actionYmd;
	private String actionCd;
	private String trmsSysCd;
	private String evtIdSubCd;

	public EventOcrVO() {
	}

	public EventOcrVO(String evtOcrNo) {
		this.evtOcrNo = evtOcrNo;
	}

	public String getEvtOcrNo() {
		return this.evtOcrNo;
	}

	public void setEvtOcrNo(String evtOcrNo) {
		this.evtOcrNo = evtOcrNo;
	}

	public String getEvtId() {
		return this.evtId;
	}

	public void setEvtId(String evtId) {
		this.evtId = evtId;
	}

	public String getEvtNm() {
		return this.evtNm;
	}

	public void setEvtNm(String evtNm) {
		this.evtNm = evtNm;
	}

	public String getEvtGradCd() {
		return this.evtGradCd;
	}

	public void setEvtGradCd(String evtGradCd) {
		this.evtGradCd = evtGradCd;
	}

	public String getEvtGradNm() {
		return this.evtGradNm;
	}

	public void setEvtGradNm(String evtGradNm) {
		this.evtGradNm = evtGradNm;
	}

	public String getEvtPrgrsCd() {
		return this.evtPrgrsCd;
	}

	public void setEvtPrgrsCd(String evtPrgrsCd) {
		this.evtPrgrsCd = evtPrgrsCd;
	}

	public String getEvtPrgrsNm() {
		return this.evtPrgrsNm;
	}

	public void setEvtPrgrsNm(String evtPrgrsNm) {
		this.evtPrgrsNm = evtPrgrsNm;
	}

	public String getOcrFcltId() {
		return this.ocrFcltId;
	}

	public void setOcrFcltId(String ocrFcltId) {
		this.ocrFcltId = ocrFcltId;
	}

	public String getOcrPointX() {
		return this.ocrPointX;
	}

	public void setOcrPointX(String ocrPointX) {
		this.ocrPointX = ocrPointX;
	}

	public String getOcrPointY() {
		return this.ocrPointY;
	}

	public void setOcrPointY(String ocrPointY) {
		this.ocrPointY = ocrPointY;
	}

	public String getEvtOcrYmdHms() {
		return this.evtOcrYmdHms;
	}

	public void setEvtOcrYmdHms(String evtOcrYmdHms) {
		this.evtOcrYmdHms = evtOcrYmdHms;
	}

	public String getEvtDtl() {
		return this.evtDtl;
	}

	public void setEvtDtl(String evtDtl) {
		this.evtDtl = evtDtl;
	}

	public String getImgUrl() {
		return this.imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public String getPresetNum() {
		return this.presetNum;
	}

	public void setPresetNum(String presetNum) {
		this.presetNum = presetNum;
	}

	public String getSearchEvtOcrYmdHms() {
		return this.searchEvtOcrYmdHms;
	}

	public void setSearchEvtOcrYmdHms(String searchEvtOcrYmdHms) {
		this.searchEvtOcrYmdHms = searchEvtOcrYmdHms;
	}

	public String getUscvGrpCd() {
		return this.uscvGrpCd;
	}

	public void setUscvGrpCd(String uscvGrpCd) {
		this.uscvGrpCd = uscvGrpCd;
	}

	public String getUserId() {
		return this.userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getSysCd() {
		return this.sysCd;
	}

	public void setSysCd(String sysCd) {
		this.sysCd = sysCd;
	}

	public String getSearchEvtPlace() {
		return this.searchEvtPlace;
	}

	public void setSearchEvtPlace(String searchEvtPlace) {
		this.searchEvtPlace = searchEvtPlace;
	}

	public String getSearchEvtId() {
		return this.searchEvtId;
	}

	public void setSearchEvtId(String searchEvtId) {
		this.searchEvtId = searchEvtId;
	}

	public boolean isExcludeFcltError() {
		return this.excludeFcltError;
	}

	public void setExcludeFcltError(boolean excludeFcltError) {
		this.excludeFcltError = excludeFcltError;
	}

	public String getEvtLcMoveYn() {
		return this.evtLcMoveYn;
	}

	public void setEvtLcMoveYn(String evtLcMoveYn) {
		this.evtLcMoveYn = evtLcMoveYn;
	}

	public String getEvtPlace() {
		return evtPlace;
	}

	public void setEvtPlace(String evtPlace) {
		this.evtPlace = evtPlace;
	}

	public String getEvtEndYmdHms() {
		return evtEndYmdHms;
	}

	public void setEvtEndYmdHms(String evtEndYmdHms) {
		this.evtEndYmdHms = evtEndYmdHms;
	}

	public String getPointX() {
		return pointX;
	}

	public void setPointX(String pointX) {
		this.pointX = pointX;
	}

	public String getPointY() {
		return pointY;
	}

	public void setPointY(String pointY) {
		this.pointY = pointY;
	}

	public String getPointZ() {
		return pointZ;
	}

	public void setPointZ(String pointZ) {
		this.pointZ = pointZ;
	}

	public String getPcvYn() {
		return pcvYn;
	}

	public void setPcvYn(String pcvYn) {
		this.pcvYn = pcvYn;
	}

	public String getPcvUserId() {
		return pcvUserId;
	}

	public void setPcvUserId(String pcvUserId) {
		this.pcvUserId = pcvUserId;
	}

	public String getPcvUserNm() {
		return pcvUserNm;
	}

	public void setPcvUserNm(String pcvUserNm) {
		this.pcvUserNm = pcvUserNm;
	}

	public String getPcvDate() {
		return pcvDate;
	}

	public void setPcvDate(String pcvDate) {
		this.pcvDate = pcvDate;
	}

	public String getRceptTyCd() {
		return rceptTyCd;
	}

	public void setRceptTyCd(String rceptTyCd) {
		this.rceptTyCd = rceptTyCd;
	}

	public String getRceptUserId() {
		return rceptUserId;
	}

	public void setRceptUserId(String rceptUserId) {
		this.rceptUserId = rceptUserId;
	}

	public String getRceptUserNm() {
		return rceptUserNm;
	}

	public void setRceptUserNm(String rceptUserNm) {
		this.rceptUserNm = rceptUserNm;
	}

	public String getRceptYmdHms() {
		return rceptYmdHms;
	}

	public void setRceptYmdHms(String rceptYmdHms) {
		this.rceptYmdHms = rceptYmdHms;
	}

	public String getRecptConts() {
		return recptConts;
	}

	public void setRecptConts(String recptConts) {
		this.recptConts = recptConts;
	}

	public String getApcNm() {
		return apcNm;
	}

	public void setApcNm(String apcNm) {
		this.apcNm = apcNm;
	}

	public String getApcTelNo() {
		return apcTelNo;
	}

	public void setApcTelNo(String apcTelNo) {
		this.apcTelNo = apcTelNo;
	}

	public String getActionUserId() {
		return actionUserId;
	}

	public void setActionUserId(String actionUserId) {
		this.actionUserId = actionUserId;
	}

	public String getActionUserNm() {
		return actionUserNm;
	}

	public void setActionUserNm(String actionUserNm) {
		this.actionUserNm = actionUserNm;
	}

	public String getActionYmdHms() {
		return actionYmdHms;
	}

	public void setActionYmdHms(String actionYmdHms) {
		this.actionYmdHms = actionYmdHms;
	}

	public String getActionConts() {
		return actionConts;
	}

	public void setActionConts(String actionConts) {
		this.actionConts = actionConts;
	}

	public String getActionEtc() {
		return actionEtc;
	}

	public void setActionEtc(String actionEtc) {
		this.actionEtc = actionEtc;
	}

	public String getScopeRads() {
		return scopeRads;
	}

	public void setScopeRads(String scopeRads) {
		this.scopeRads = scopeRads;
	}

	public String getCnclRsn() {
		return cnclRsn;
	}

	public void setCnclRsn(String cnclRsn) {
		this.cnclRsn = cnclRsn;
	}

	public String getDstrtCd() {
		return dstrtCd;
	}

	public void setDstrtCd(String dstrtCd) {
		this.dstrtCd = dstrtCd;
	}

	public String getCtrCd() {
		return ctrCd;
	}

	public void setCtrCd(String ctrCd) {
		this.ctrCd = ctrCd;
	}

	public String getRgsUserId() {
		return rgsUserId;
	}

	public void setRgsUserId(String rgsUserId) {
		this.rgsUserId = rgsUserId;
	}

	public String getRgsDate() {
		return rgsDate;
	}

	public void setRgsDate(String rgsDate) {
		this.rgsDate = rgsDate;
	}

	public String getUpdUserId() {
		return updUserId;
	}

	public void setUpdUserId(String updUserId) {
		this.updUserId = updUserId;
	}

	public String getUpdDate() {
		return updDate;
	}

	public void setUpdDate(String updDate) {
		this.updDate = updDate;
	}

	public String getItemArr() {
		return itemArr;
	}

	public void setItemArr(String itemArr) {
		this.itemArr = itemArr;
	}

	public String getItemCnt() {
		return itemCnt;
	}

	public void setItemCnt(String itemCnt) {
		this.itemCnt = itemCnt;
	}

	public String getAreaCd() {
		return areaCd;
	}

	public void setAreaCd(String areaCd) {
		this.areaCd = areaCd;
	}

	public String getUserNm() {
		return userNm;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	public String getActionVal() {
		return actionVal;
	}

	public void setActionVal(String actionVal) {
		this.actionVal = actionVal;
	}

	public String getActionYmd() {
		return actionYmd;
	}

	public void setActionYmd(String actionYmd) {
		this.actionYmd = actionYmd;
	}

	public String getActionCd() {
		return actionCd;
	}

	public void setActionCd(String actionCd) {
		this.actionCd = actionCd;
	}

	public String getTrmsSysCd() {
		return trmsSysCd;
	}

	public void setTrmsSysCd(String trmsSysCd) {
		this.trmsSysCd = trmsSysCd;
	}

	public String getEvtIdSubCd() {
		return evtIdSubCd;
	}

	public void setEvtIdSubCd(String evtIdSubCd) {
		this.evtIdSubCd = evtIdSubCd;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
