package com.danusys.platform.work.event.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.danusys.platform.work.event.service.CmEvtItemService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : CmEvtItemServiceImpl.java
 * @Description : CmEvtItem Business Implement class
 * @Modification Information
 *
 * @author 이인의
 * @since 2018-05-15
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("cmEvtItemService")
public class CmEvtItemServiceImpl extends EgovAbstractServiceImpl implements
        CmEvtItemService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(CmEvtItemServiceImpl.class);

    @Resource(name="cmEvtItemDAO")
    private CmEvtItemDAO cmEvtItemDAO;
    
    /** ID Generation */
    //@Resource(name="{egovCmEvtItemIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

    public List<Map<String, String>> view(Map<String, String> args) throws Exception {
    	return this.cmEvtItemDAO.view(args);
    }
    	  
    public int insert(Map<String, Object> args) throws Exception {
    	return this.cmEvtItemDAO.insert(args);
    }
    	  
    public int update(Map<String, Object> args) throws Exception {
    	return this.cmEvtItemDAO.update(args);
    }
    	  
    public int delete(Map<String, Object> args) throws Exception {
    	return this.cmEvtItemDAO.delete(args);
    }
    	  
    public int deleteMulti(List<Map<String, String>> args) throws Exception {
    	return this.cmEvtItemDAO.deleteMulti(args);
    }
    
}
