package com.danusys.platform.sensor.service;

import java.util.List;

import com.danusys.platform.sensor.service.LastsVO;

/**
 * @Class Name : LastsService.java
 * @Description : Lasts Business class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-01-16
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface LastsService {
    /**
	 * lasts을 조회한다.
	 * @param vo - 조회할 정보가 담긴 LastsVO
	 * @return 조회한 lasts
	 * @exception Exception
	 */
    List<LastsVO> selectLasts(LastsVO vo) throws Exception;
    
    /**
	 * lasts에서 범위가 벗어난 것들만 조회 한다.
	 * @param
	 * @return 조회한 lasts
	 * @exception Exception
	 */
	public List<OutOfRangeSensorVO> selectOutOfRange() throws Exception;
    
}
