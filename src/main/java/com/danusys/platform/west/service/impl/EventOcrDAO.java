package com.danusys.platform.west.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.danusys.platform.west.service.EventOcrVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("eventOcrDAO")
public class EventOcrDAO extends EgovAbstractMapper {
	public int isExistEvent(EventOcrVO paramEventVO) throws Exception {
		return selectOne("eventOcrDAO.isExistEvent", paramEventVO);
	}

	public EgovMap selectEvent(EventOcrVO paramEventVO) throws Exception {
		return selectOne("eventOcrDAO.selectEvent", paramEventVO);
	}

	public int selectUnfinishedEventListTotCnt(EventOcrVO paramEventVO)
			throws Exception {
		return selectOne("eventOcrDAO.selectUnfinishedEventListTotCnt", paramEventVO);
	}

	public List<EgovMap> selectUnfinishedEventList(EventOcrVO paramEventVO)
			throws Exception {
		return selectList("eventOcrDAO.selectUnfinishedEventList", paramEventVO);
	}

	public List selectEventKindList(EventOcrVO paramEventVO) throws Exception {
		return selectList("eventOcrDAO.selectEventKindList", paramEventVO);
	}

	public List selectUsvcGrpList() throws Exception {
		return selectList("eventOcrDAO.selectUsvcGrpList");
	}

	public List selectEventGrpList() throws Exception {
		return selectList("eventOcrDAO.selectEventGrpList");
	}

	public List<EgovMap> selectEventAction(EventOcrVO paramEventVO)
			throws Exception {
		return selectList("eventOcrDAO.selectEventAction", paramEventVO);
	}

	public List<EgovMap> selectEventItem(EventOcrVO paramEventVO) throws Exception {
		return selectList("eventOcrDAO.selectEventItem", paramEventVO);
	}

	public List<EgovMap> selectEventImage(EventOcrVO paramEventVO)
			throws Exception {
		return selectList("eventOcrDAO.selectEventImage", paramEventVO);
	}

	public int hasAuthorityEvent(EventOcrVO paramEventVO) throws Exception {
		return selectOne("eventOcrDAO.hasAuthorityEvent", paramEventVO);
	}

	public EgovMap selectVtalkTelNo(EventOcrVO paramEventVO) throws Exception {
		return selectOne("eventOcrDAO.selectVtalkTelNo", paramEventVO);
	}

	public List<EgovMap> selectCarLcInfoList(EventOcrVO paramEventVO)
			throws Exception {
		return selectList("eventOcrDAO.selectCarLcInfoList", paramEventVO);
	}

	public int selectCarLcInfoListTotCnt(EventOcrVO paramEventVO) throws Exception {
		return selectOne("eventOcrDAO.selectCarLcInfoListTotCnt", paramEventVO);
	}

	public List<EgovMap> selectCar119LcInfoList(EventOcrVO paramEventVO)
			throws Exception {
		return selectList("eventOcrDAO.selectCar119LcInfoList", paramEventVO);
	}

	public int selectCar119LcInfoListTotCnt(EventOcrVO paramEventVO)
			throws Exception {
		return selectOne("eventOcrDAO.selectCar119LcInfoListTotCnt", paramEventVO);
	}

	public List<EgovMap> selectCar119LcDtlList(EventOcrVO paramEventVO)
			throws Exception {
		return selectList("eventOcrDAO.selectCar119LcDtlList", paramEventVO);
	}
	
	public int insertEvtOcr(EventOcrVO paramEventOcrVO) throws Exception {
		return insert("eventOcrDAO.insertEvtOcr", paramEventOcrVO);
	}

	public int updateEvtOcr(EventOcrVO paramEventOcrVO) throws Exception {
		return update("eventOcrDAO.updateEvtOcr", paramEventOcrVO);
	}

	public int insertCmEvtOcrAction(EgovMap paramMap) throws Exception {
		return insert("eventOcrDAO.insertCmEvtOcrAction", paramMap);
	}

	public int updatePrgrsEvtOcr(String paramString) throws Exception {
		return update("eventOcrDAO.updatePrgrsEvtOcr", paramString);
	}
	
	public int insertEvtOcrItem(EgovMap paramMap) throws Exception {
		return insert("eventOcrDAO.insertEvtOcrItem", paramMap);
	}

	public EventOcrVO selectEvent(int paramInt) throws Exception {
		return selectOne("eventOcrDAO.selectEvent", paramInt);
	}

	public List<EventOcrVO> eventList() throws Exception {
		return selectList("eventOcrDAO.eventList");
	}

	public int selectEvtOctCount(String paramString) throws Exception {
		return selectOne("eventOcrDAO.selectEvtOctCount", paramString);
	}

	public EgovMap selectFcltPoint(String paramString) throws Exception {
		return selectOne("eventOcrDAO.selectFcltPoint", paramString);
	}

	public int updateEvtOcrXYZ(EgovMap paramMap) throws Exception {
		return update("eventOcrDAO.updateEvtOcrXYZ", paramMap);
	}

	public int updateEvtOcrOther(EgovMap paramMap) throws Exception {
		return update("eventOcrDAO.updateEvtOcrOther", paramMap);
	}

	public int insertUcIntrstVhcleOcr(EgovMap paramMap) throws Exception {
		return insert("eventOcrDAO.insertUcIntrstVhcleOcr", paramMap);
	}

	public int selectEvtOctCount2(EgovMap paramMap) throws Exception {
		return selectOne("eventOcrDAO.selectEvtOctCount2", paramMap);
	}

	public int updateUcIntrstVhcleOcr(EgovMap paramMap) throws Exception {
		return update("eventOcrDAO.updateUcIntrstVhcleOcr", paramMap);
	}

	public EgovMap selectEvtNm(EgovMap paramMap) throws Exception {
		return selectOne("eventOcrDAO.selectEvtNm", paramMap);
	}

	public int updateFacilitySttus0(String paramString) throws Exception {
		return update("eventOcrDAO.updateFacilitySttus0", paramString);
	}

	public int updateFacilitySttus1(String paramString) throws Exception {
		return update("eventOcrDAO.updateFacilitySttus1", paramString);
	}

	public String selectEvtOctFcltId(String paramString) throws Exception {
		return selectOne("eventOcrDAO.selectEvtOctFcltId", paramString);
	}

	public List selectPrgrsUpdateList(String paramString) throws Exception {
		return selectList("eventOcrDAO.selectPrgrsUpdateList", paramString);
	}

	public int updateStepCdVhcleOcr(String paramString) throws Exception {
		return update("eventOcrDAO.updateStepCdVhcleOcr", paramString);
	}

	public String selectCarNumEvtOcr(String paramString) throws Exception {
		return selectOne("eventOcrDAO.selectCarNumEvtOcr", paramString);
	}

	public int insertEvtOcrArea(EgovMap paramMap) throws Exception {
		return insert("eventOcrDAO.insertEvtOcrArea", paramMap);
	}

	public int updateEvtOcrBuga(EgovMap paramMap) throws Exception {
		return update("eventOcrDAO.updateEvtOcrBuga", paramMap);
	}

	public int insertUwTodoMng(EgovMap paramMap) throws Exception {
		return insert("eventOcrDAO.insertUwTodoMng", paramMap);
	}

	public int updateUwTodoMng(EgovMap paramMap) throws Exception {
		return update("eventOcrDAO.updateUwTodoMng", paramMap);
	}

	public List selectPrgrsUpdateListIdNo(String paramString) throws Exception {
		return selectList("eventOcrDAO.selectPrgrsUpdateListIdNo", paramString);
	}

	public EgovMap select112Event(String paramString) throws Exception {
		return selectOne("eventOcrDAO.select112Event", paramString);
	}

	public int insert112info(EgovMap paramHashMap) throws Exception {
		return insert("eventOcrDAO.insert112info", paramHashMap);
	}

	public int insert112image(EgovMap paramHashMap) throws Exception {
		return insert("eventOcrDAO.insert112image", paramHashMap);
	}

	/*public List<EgovMap> selectReportList(CommonVO paramCommonVO)
			throws Exception;

	public int selectReportListTotCnt(CommonVO paramCommonVO) throws Exception;*/
}
