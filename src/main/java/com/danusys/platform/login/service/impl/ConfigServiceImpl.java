package com.danusys.platform.login.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import com.danusys.platform.login.service.ConfigService;
import com.danusys.platform.login.service.ConfigVO;
import com.danusys.platform.login.service.impl.ConfigDAO;

/**
 * @Class Name : ConfigServiceImpl.java
 * @Description : Config Business Implement class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-02-02
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("configService")
public class ConfigServiceImpl extends EgovAbstractServiceImpl implements
        ConfigService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(ConfigServiceImpl.class);

    @Resource(name="configDAO")
    private ConfigDAO configDAO;
    
    /** ID Generation */
    //@Resource(name="{egovConfigIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

    /**
	 * config 값을 가져온다.
	 * @param 
	 * @return 조회한 config
	 * @exception Exception
	 */
    public ConfigVO selectConfig() throws Exception {
        ConfigVO resultVO = configDAO.selectConfig();
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }
}
