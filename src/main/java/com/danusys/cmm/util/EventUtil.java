package com.danusys.cmm.util;

import com.danusys.platform.west.service.EventOcrVO;
import com.danusys.platform.west.service.EventVO;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public class EventUtil {
	
	public static String stateToEvtPrgrsCd(String state) {
		String result;
		
		switch (state) {
		case "EVENT_STATE_1":
			result = "10";
			break;
		case "EVENT_STATE_2":
			result = "40";
			break;
		case "EVENT_STATE_3":
			result = "50";
			break;
		case "EVENT_STATE_4":
			result = "91";
			break;
		case "EVENT_STATE_5":
			result = "92";
			break;
		default:
			result = "10";
			break;
		}
		
		return result;
	}
	
	public static String evtPrgrsCdToState(String evtPrgrsCd) {
		String result;
		
		switch (evtPrgrsCd) {
		case "10":
			result = "EVENT_STATE_1";
			break;
		case "40":
			result = "EVENT_STATE_2";
			break;
		case "50":
			result = "EVENT_STATE_3";
			break;
		case "90":
			result = "EVENT_STATE_4";
			break;
		case "91":
			result = "EVENT_STATE_4";
			break;
		case "92":
			result = "EVENT_STATE_5";
			break;
		default:
			result = "EVENT_STATE_1";
			break;
		}
		
		return result;
	}
	
	public static String ratingToEvtGradCd(String rating) {
		String result;
		
		switch (rating) {
		case "1":
			result = "10";
			break;
		case "2":
			result = "20";
			break;
		default:
			result = "10";
			break;
		}
		
		return result;
	}
	
	public static String evtgradCdToRating(String evtgradCd) {
		String result;
		
		switch (evtgradCd) {
		case "10":
			result = "1";
			break;
		case "20":
			result = "2";
			break;
		default:
			result = "1";
			break;
		}
		
		return result;
	}
	
	public static String eventTypeToEvtId(String eventType) {
		String result;
		
		switch (eventType) {
		case "EVENT_TYPE_1":
			result = "REHSF110";
			break;
		case "EVENT_TYPE_2":
			result = "WPSSF110";
			break;
		case "EVENT_TYPE_3":
			result = "112UC001";
			break;
		case "EVENT_TYPE_4":
			result = "119UC001";
			break;
		case "EVENT_TYPE_5":
			result = "EBSUC001";
			break;
		case "EVENT_TYPE_6":
			result = "ENVEN001";
			break;
		case "EVENT_TYPE_7":
			result = "CALDP001";
			break;
		default:
			result = "119UC001";
			break;
		}
		
		return result;
	}
	
	public static String evtIdToEventType(String evtId) {
		String result;
		
		switch (evtId) {
		case "REHSF110":
			result = "EVENT_TYPE_1";
			break;
		case "WPSSF110":
			result = "EVENT_TYPE_2";
			break;
		case "112UC001":
			result = "EVENT_TYPE_3";
			break;
		case "119UC001":
			result = "EVENT_TYPE_4";
			break;
		case "EBSUC001":
			result = "EVENT_TYPE_5";
			break;
		case "ENVEN001":
			result = "EVENT_TYPE_6";
			break;
		case "CALDP001":
			result = "EVENT_TYPE_7";
			break;
		default:
			result = "EVENT_TYPE_4";
			break;
		}
		
		return result;
	}
	
	public static EventOcrVO eventVOToEventOcrVO(EventVO eventVO) {
		EventOcrVO eventOcrVO = new EventOcrVO();
		
		eventOcrVO.setEvtOcrNo(eventVO.getEventNo());
		eventOcrVO.setEvtId(EventUtil.eventTypeToEvtId(eventVO.getEventType()));
		eventOcrVO.setEvtGradCd(EventUtil.ratingToEvtGradCd(eventVO.getEventRating()));
		eventOcrVO.setEvtPrgrsCd(EventUtil.stateToEvtPrgrsCd(eventVO.getState()));
		eventOcrVO.setEvtPlace(eventVO.getEventPlace());
		eventOcrVO.setEvtDtl(eventVO.getEventCont());
		eventOcrVO.setEvtOcrYmdHms(eventVO.getEventDe());
		eventOcrVO.setEvtEndYmdHms(eventVO.getEventDeE());
		eventOcrVO.setPointX(eventVO.getEncryptLongitude());
		eventOcrVO.setPointY(eventVO.getEncryptLatitude());
		eventOcrVO.setActionUserId(eventVO.getAcceptId());
		eventOcrVO.setActionUserNm(eventVO.getAcceptId());
		eventOcrVO.setActionConts(eventVO.getAcceptCont());
		eventOcrVO.setRgsUserId(eventVO.getInstId());
		eventOcrVO.setUpdUserId(eventVO.getUpdId());
		
		return eventOcrVO;
	}
	
	public static EventVO eventOcrVOToEventVO(EventOcrVO eventOcrVO) {
		EventVO eventVO = new EventVO();
		
		eventVO.setEventNo(eventOcrVO.getEvtOcrNo());
		eventVO.setEventType(EventUtil.evtIdToEventType(eventOcrVO.getEvtId()));
		eventVO.setEventRating(EventUtil.evtgradCdToRating(eventOcrVO.getEvtGradCd()));
		eventVO.setState(EventUtil.evtPrgrsCdToState(eventOcrVO.getEvtPrgrsCd()));
		eventVO.setEventPlace(eventOcrVO.getEvtPlace());
		eventVO.setEventCont(eventOcrVO.getEvtDtl());
		eventVO.setEventDe(eventOcrVO.getEvtOcrYmdHms());
		eventVO.setEventDeE(eventOcrVO.getEvtEndYmdHms());
		eventVO.setLongitude(eventOcrVO.getPointX());
		eventVO.setLatitude(eventOcrVO.getPointY());
		eventVO.setAcceptId(eventOcrVO.getActionUserId());
		eventVO.setAcceptId(eventOcrVO.getActionUserNm());
		eventVO.setAcceptCont(eventOcrVO.getActionConts());
		eventVO.setInstId(eventOcrVO.getRgsUserId());
		eventVO.setUpdId(eventOcrVO.getUpdUserId());
		
		return eventVO;
	}
	
	public static EgovMap eventOcrVOToMap(EventOcrVO ocrVO) {
		EgovMap hisMap = new EgovMap();
		hisMap.put("evtOcrNo", ocrVO.getEvtOcrNo());
		hisMap.put("evtPrgrsCd", ocrVO.getEvtPrgrsCd());
		hisMap.put("actionUserId", ocrVO.getActionUserId());
		hisMap.put("actionUserNm", ocrVO.getActionUserNm());
		hisMap.put("actionYmdHms", ocrVO.getActionYmdHms());
		hisMap.put("actionConts", ocrVO.getActionConts());
		hisMap.put("updUserId", ocrVO.getUpdUserId());
		return hisMap;
	}
}
