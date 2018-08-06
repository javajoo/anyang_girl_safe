package com.danusys.platform.login.service;

import java.util.List;
import com.danusys.platform.login.service.ConfigVO;

import egovframework.com.cmm.ComDefaultVO;

/**
 * @Class Name : ConfigService.java
 * @Description : Config Business class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-02-02
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface ConfigService {
	
    /**
	 * config을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ConfigVO
	 * @return 조회한 config
	 * @exception Exception
	 */
    ConfigVO selectConfig() throws Exception;

}
