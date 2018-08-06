package com.danusys.platform.work.event.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.danusys.platform.work.event.service.CmEventService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : CmEventServiceImpl.java
 * @Description : CmEvent Business Implement class
 * @Modification Information
 *
 * @author 이인의
 * @since 2018-05-11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("cmEventService")
public class CmEventServiceImpl extends EgovAbstractServiceImpl implements
        CmEventService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(CmEventServiceImpl.class);

    @Resource(name="cmEventDAO")
    private CmEventDAO cmEventDAO;
    
    /** ID Generation */
    //@Resource(name="{egovCmEventIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

    /**
	 * CM_EVENT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return CM_EVENT 목록
	 * @exception Exception
	 */
    public List<Map<String, String>> selectCmEventList(Map<String, String> args) throws Exception {
        return cmEventDAO.selectCmEventList(args);
    }
    
    public List<Map<String, String>> evtItemList(Map<String, String> args) throws Exception {
    	return cmEventDAO.evtItemList(args);
    }
    	  
    public List<Map<String, String>> evtItemInfoList(Map<String, String> args) throws Exception {
    	return cmEventDAO.evtItemInfoList(args);
    }
    	  
    public List<Map<String, String>> evtSubList(Map<String, String> args) throws Exception {
    	return cmEventDAO.evtSubList(args);
    }
    	  
    public String selectEvtId(Map<String, Object> args) throws Exception {
    	return cmEventDAO.selectEvtId(args);
    }
    	  
    public int insertCmEvent(Map<String, Object> args, List<Map<String, Object>> list) throws Exception {
    	return cmEventDAO.insertCmEvent(args, list);
    }
    	  
    public int updateCmEvent(Map<String, Object> args) throws Exception {
    	return cmEventDAO.updateCmEvent(args);
    }
    	  
    public int deleteCmEvent(Map<String, Object> args) throws Exception {
    	return cmEventDAO.deleteCmEvent(args);
    }
    	  
    public int insertCmEvtItemInfo(List<Map<String, String>> args) throws Exception {
    	return cmEventDAO.insertCmEvtItemInfo(args);
    }
    	  
    public int updateCmEvtItemInfo(List<Map<String, String>> args) throws Exception {
    	return cmEventDAO.updateCmEvtItemInfo(args);
    }
    	  
    public int deleteCmEvtItemInfo(List<Map<String, String>> args) throws Exception {
    	return cmEventDAO.deleteCmEvtItemInfo(args);
    }
    	  
    public int insertCmEventSub(Map<String, String> args) throws Exception {
    	return cmEventDAO.insertCmEventSub(args);
    }
    	  
    public int updateCmEventSub(List<Map<String, String>> args) throws Exception {
    	return cmEventDAO.updateCmEventSub(args);
    }
    	  
    public int deleteCmEventSub(List<Map<String, String>> args) throws Exception {
    	return cmEventDAO.deleteCmEventSub(args);
    }
    
    public int selectEventTypeCurrval() throws Exception {
    	return cmEventDAO.selectEventTypeCurrval();
    }
    
}
