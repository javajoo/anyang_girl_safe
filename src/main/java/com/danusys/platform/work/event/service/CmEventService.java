package com.danusys.platform.work.event.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : CmEventService.java
 * @Description : CmEvent Business class
 * @Modification Information
 *
 * @author 이인의
 * @since 2018-05-11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface CmEventService {
    
    /**
	 * CM_EVENT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return CM_EVENT 목록
	 * @exception Exception
	 */
    List<Map<String, String>> selectCmEventList(Map<String, String> args) throws Exception;
    
    public List<Map<String, String>> evtItemList(Map<String, String> paramMap) throws Exception;
    	  
    public List<Map<String, String>> evtItemInfoList(Map<String, String> paramMap) throws Exception;
    	  
    public List<Map<String, String>> evtSubList(Map<String, String> paramMap) throws Exception;
    	  
    public String selectEvtId(Map<String, Object> paramMap) throws Exception;
    	  
    public int insertCmEvent(Map<String, Object> paramMap, List<Map<String, Object>> paramList) throws Exception;
    	  
    public int updateCmEvent(Map<String, Object> paramMap) throws Exception;
    	  
    public int deleteCmEvent(Map<String, Object> paramMap) throws Exception;
    	  
    public int insertCmEvtItemInfo(List<Map<String, String>> paramList) throws Exception;
    	  
    public int updateCmEvtItemInfo(List<Map<String, String>> paramList) throws Exception;
    	  
    public int deleteCmEvtItemInfo(List<Map<String, String>> paramList) throws Exception;
    	  
    public int insertCmEventSub(Map<String, String> paramMap) throws Exception;
    	  
    public int updateCmEventSub(List<Map<String, String>> paramList) throws Exception;
    	  
    public int deleteCmEventSub(List<Map<String, String>> paramList) throws Exception;
    
    public int selectEventTypeCurrval() throws Exception;
    
}
