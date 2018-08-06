package com.danusys.platform.west.service;

import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public abstract interface EventOcrService {
	public abstract int isExistEvent(EventOcrVO paramEventVO) throws Exception;

	public abstract EgovMap selectEvent(EventOcrVO paramEventVO)
			throws Exception;

	public abstract int selectUnfinishedEventListTotCnt(EventOcrVO paramEventVO)
			throws Exception;

	public abstract List<EgovMap> selectUnfinishedEventList(
			EventOcrVO paramEventVO) throws Exception;

	public abstract List selectEventKindList(EventOcrVO paramEventVO)
			throws Exception;

	public abstract List selectEventGrpList() throws Exception;

	public abstract List selectUsvcGrpList() throws Exception;

	public abstract List<EgovMap> selectEventAction(EventOcrVO paramEventVO)
			throws Exception;

	public abstract List<EgovMap> selectEventItem(EventOcrVO paramEventVO)
			throws Exception;

	public abstract List<EgovMap> selectEventImage(EventOcrVO paramEventVO)
			throws Exception;

	public abstract int hasAuthorityEvent(EventOcrVO paramEventVO)
			throws Exception;

	public abstract EgovMap selectVtalkTelNo(EventOcrVO paramEventVO)
			throws Exception;

	public abstract List<EgovMap> selectCarLcInfoList(EventOcrVO paramEventVO)
			throws Exception;

	public abstract int selectCarLcInfoListTotCnt(EventOcrVO paramEventVO)
			throws Exception;

	public abstract List<EgovMap> selectCar119LcInfoList(EventOcrVO paramEventVO)
			throws Exception;

	public abstract int selectCar119LcInfoListTotCnt(EventOcrVO paramEventVO)
			throws Exception;

	public abstract List<EgovMap> selectCar119LcDtlList(EventOcrVO paramEventVO)
			throws Exception;

	public abstract int insertEvtOcr(EventOcrVO paramEventVO) throws Exception;

	public abstract int updateEvtOcr(EventOcrVO paramEventVO) throws Exception;

	public abstract int insertCmEvtOcrAction(EgovMap paramEgovMap)
			throws Exception;

	public abstract int updatePrgrsEvtOcr(String paramString) throws Exception;
	
	public abstract int insertData(EventOcrVO paramEventVO,
			String paramString2) throws Exception;

	public abstract int selectEvtOctCount2(EgovMap paramMap) throws Exception;

	public abstract int selectEvtOctCount(String paramString) throws Exception;

	public abstract EgovMap selectEvtNm(EgovMap paramMap) throws Exception;

	public abstract EgovMap selectFcltInfo(String paramString) throws Exception;

	/*
	 * public abstract List<EgovMap> selectReportList(CommonVO paramCommonVO)
	 * throws Exception;
	 * 
	 * public abstract int selectReportListTotCnt(CommonVO paramCommonVO) throws
	 * Exception;
	 */
}
