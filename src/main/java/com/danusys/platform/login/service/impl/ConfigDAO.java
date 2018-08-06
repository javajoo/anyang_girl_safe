package com.danusys.platform.login.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import com.danusys.platform.login.service.ConfigVO;

/**
 * @Class Name : ConfigDAO.java
 * @Description : Config DAO Class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-02-02
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("configDAO")
public class ConfigDAO extends EgovAbstractDAO {

    /**
	 * config 값을 가져온다.
	 * @param 
	 * @return config data
	 * @exception Exception
	 */
    public ConfigVO selectConfig() throws Exception {
        return (ConfigVO) select("configDAO.selectConfig_S");
    }
}
