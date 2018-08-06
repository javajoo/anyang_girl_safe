package com.danusys.platform.work.code.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.danusys.platform.work.code.service.CmSysCodeService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : CmSysCodeServiceImpl.java
 * @Description : CmSysCode Business Implement class
 * @Modification Information
 *
 * @author 이인의
 * @since 2018-05-14
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("cmSysCodeService")
public class CmSysCodeServiceImpl extends EgovAbstractServiceImpl implements
        CmSysCodeService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(CmSysCodeServiceImpl.class);

    @Resource(name="cmSysCodeDAO")
    private CmSysCodeDAO cmSysCodeDAO;
    
    /** ID Generation */
    //@Resource(name="{egovCmSysCodeIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

    public List<Map<String, String>> grpList(Map<String, Object> map) throws Exception {
    	return this.cmSysCodeDAO.grpList(map);
    }
    	  
    public List<Map<String, String>> sysList(Map<String, Object> map) throws Exception {
    	return this.cmSysCodeDAO.sysList(map);
    }
    	  
    public List<Map<String, String>> view(Map<String, String> map) throws Exception {
    	return this.cmSysCodeDAO.view(map);
    }
    	  
    public int insert(Map<String, Object> map) throws Exception {
    	return this.cmSysCodeDAO.insert(map);
    }
    	  
    public int delete(Map<String, Object> map) throws Exception {
    	return this.cmSysCodeDAO.delete(map);
    }
    	  
    public int update(Map<String, Object> map) throws Exception {
    	return this.cmSysCodeDAO.update(map);
    }
    	  
    public int deleteMulti(List<Map<String, String>> list) throws Exception {
    	return this.cmSysCodeDAO.deleteMulti(list);
    }
    	  
    public String getCurrentDay() throws Exception {
    	return this.cmSysCodeDAO.getCurrentDay();
    }
    	  
    public String getCalDay(int dayCnt) throws Exception {
    	return this.cmSysCodeDAO.getCalDay(dayCnt);
    }
    
}
