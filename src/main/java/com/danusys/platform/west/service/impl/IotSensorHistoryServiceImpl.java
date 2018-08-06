package com.danusys.platform.west.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import com.danusys.platform.west.service.IotSensorHistoryService;
import com.danusys.platform.west.service.IotSensorHistoryVO;
import com.danusys.platform.west.service.impl.IotSensorHistoryDAO;

/**
 * @Class Name : IotSensorHistoryServiceImpl.java
 * @Description : IotSensorHistory Business Implement class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-01-17
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("iotSensorHistoryService")
public class IotSensorHistoryServiceImpl extends EgovAbstractServiceImpl implements
        IotSensorHistoryService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(IotSensorHistoryServiceImpl.class);

    @Resource(name="iotSensorHistoryDAO")
    private IotSensorHistoryDAO iotSensorHistoryDAO;
    
    /** ID Generation */
    //@Resource(name="{egovIotSensorHistoryIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * iot_sensor_history을 등록한다.
	 * @param vo - 등록할 정보가 담긴 IotSensorHistoryVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertIotSensorHistory(IotSensorHistoryVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	iotSensorHistoryDAO.insertIotSensorHistory(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * iot_sensor_history을 조회한다.
	 * @param vo - 조회할 정보가 담긴 IotSensorHistoryVO
	 * @return 조회한 iot_sensor_history
	 * @exception Exception
	 */
    public List<IotSensorHistoryVO> selectIotSensorHistory(IotSensorHistoryVO vo) throws Exception {
    	List<IotSensorHistoryVO> resultVO = iotSensorHistoryDAO.selectIotSensorHistory(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }
    public int selectIotSensorHistoryTotCnt(IotSensorHistoryVO vo){
        return iotSensorHistoryDAO.selectIotSensorHistoryTotCnt(vo);
    }
}
