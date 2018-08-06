package com.danusys.platform.sensor.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import com.danusys.platform.sensor.service.LastsService;
import com.danusys.platform.sensor.service.LastsVO;
import com.danusys.platform.sensor.service.OutOfRangeSensorVO;
import com.danusys.platform.sensor.service.impl.LastsDAO;

/**
 * @Class Name : LastsServiceImpl.java
 * @Description : Lasts Business Implement class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-01-16
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("lastsService")
public class LastsServiceImpl extends EgovAbstractServiceImpl implements
        LastsService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(LastsServiceImpl.class);

    @Resource(name="lastsDAO")
    private LastsDAO lastsDAO;
    
    /** ID Generation */
    //@Resource(name="{egovLastsIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;
    
    /**
	 * lasts을 조회한다.
	 * @param vo - 조회할 정보가 담긴 LastsVO
	 * @return 조회한 lasts
	 * @exception Exception
	 */
    public List<LastsVO> selectLasts(LastsVO vo) throws Exception {
        /*LastsVO resultVO = lastsDAO.selectLasts(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;*/
    	return lastsDAO.selectLasts(vo);
    }
    
    /**
	 * lasts에서 범위가 벗어난 것들만 조회 한다.
	 * @param
	 * @return 조회한 lasts
	 * @exception Exception
	 */
    public List<OutOfRangeSensorVO> selectOutOfRange() throws Exception {
		return lastsDAO.selectOutOfRange();
	}
}
