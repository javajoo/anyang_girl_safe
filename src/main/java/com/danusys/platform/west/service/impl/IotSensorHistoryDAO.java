package com.danusys.platform.west.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.danusys.platform.west.service.IotSensorHistoryVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * @Class Name : IotSensorHistoryDAO.java
 * @Description : IotSensorHistory DAO Class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-01-17
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("iotSensorHistoryDAO")
public class IotSensorHistoryDAO extends EgovAbstractDAO {

	/**
	 * iot_sensor_history을 등록한다.
	 * @param vo - 등록할 정보가 담긴 IotSensorHistoryVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertIotSensorHistory(IotSensorHistoryVO vo) throws Exception {
        return (String)insert("iotSensorHistoryDAO.insertIotSensorHistory_S", vo);
    }

    /**
	 * iot_sensor_history을 조회한다.
	 * @param vo - 조회할 정보가 담긴 IotSensorHistoryVO
	 * @return 조회한 iot_sensor_history
	 * @exception Exception
	 */
    public List<IotSensorHistoryVO> selectIotSensorHistory(IotSensorHistoryVO vo) throws Exception {
        return (List<IotSensorHistoryVO>) list("iotSensorHistoryDAO.selectIotSensorHistory_S", vo);
    }
    public int selectIotSensorHistoryTotCnt(IotSensorHistoryVO vo){
        return (Integer)select("iotSensorHistoryDAO.selectIotSensorHistoryTotCnt", vo);
    }
}
