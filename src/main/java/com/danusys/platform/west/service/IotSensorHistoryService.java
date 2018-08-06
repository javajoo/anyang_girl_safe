package com.danusys.platform.west.service;

import java.util.List;

import com.danusys.platform.west.service.IotSensorHistoryVO;

/**
 * @Class Name : IotSensorHistoryService.java
 * @Description : IotSensorHistory Business class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-01-17
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface IotSensorHistoryService {
	
	/**
	 * iot_sensor_history을 등록한다.
	 * @param vo - 등록할 정보가 담긴 IotSensorHistoryVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertIotSensorHistory(IotSensorHistoryVO vo) throws Exception;
    
    /**
	 * iot_sensor_history을 조회한다.
	 * @param vo - 조회할 정보가 담긴 IotSensorHistoryVO
	 * @return 조회한 iot_sensor_history
	 * @exception Exception
	 */
    List selectIotSensorHistory(IotSensorHistoryVO vo) throws Exception;
    int selectIotSensorHistoryTotCnt(IotSensorHistoryVO vo);
}
