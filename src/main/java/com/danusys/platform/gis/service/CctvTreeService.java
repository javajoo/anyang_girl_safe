package com.danusys.platform.gis.service;

import java.util.List;

/**
 * @Class Name : CctvTreeService.java
 * @Description : CctvTree Business class
 * @Modification Information
 *
 * @author 신대영
 * @since 2016-08-03
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface CctvTreeService {
    
    /**
	 * cctv_tree을 조회한다.
	 * @param vo - 조회할 정보가 담긴 CctvTreeVO
	 * @return 조회한 cctv_tree
	 * @exception Exception
	 */
    List<?> selectCctvTree(CctvTreeVO vo) throws Exception;

    /**
     * 로그기록
     */
	void getMgtPrintPageLog();
    
}
