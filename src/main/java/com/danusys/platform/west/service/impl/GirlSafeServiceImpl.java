package com.danusys.platform.west.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.danusys.platform.west.service.EventVO;
import com.danusys.platform.west.service.GirlSafeService;
import com.danusys.platform.west.service.GirlSafeVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * @Class Name : EventServiceImpl.java
 * @Description : Event Business Implement class
 * @Modification Information
 *
 * @author 배선교
 * @since 2018
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("girlSafeService")
public class GirlSafeServiceImpl extends EgovAbstractServiceImpl implements GirlSafeService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(GirlSafeServiceImpl.class);

    @Resource(name="girlSafeDAO")
    private GirlSafeDAO girlSafeDAO;
    
    /**
     * Event 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 UserVO
     * @return event 목록
     * @exception Exception
     */
    public List<?> selectUserList(GirlSafeVO vo) throws Exception {
        return girlSafeDAO.selectUserList(vo);
    }
    
    /**
     * Event 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 UserVO
     * @return event 목록
     * @exception Exception
     */
    public void updateSensorStatus(GirlSafeVO vo) throws Exception {
        girlSafeDAO.updateSensorStatus(vo);
    }
    
    /**
     * Event 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 UserVO
     * @return event 목록
     * @exception Exception
     */
    public void updateSmartStatus(GirlSafeVO vo) throws Exception {
        girlSafeDAO.updateSmartStatus(vo);
    }
    
    /**
     * Event 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 UserVO
     * @return event 목록
     * @exception Exception
     */
    public void updateSensorEmergency(GirlSafeVO vo) throws Exception {
        girlSafeDAO.updateSensorEmergency(vo);
    }
    
    /**
     * Event 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 UserVO
     * @return event 목록
     * @exception Exception
     */
    public void updateSmartEmergency(GirlSafeVO vo) throws Exception {
        girlSafeDAO.updateSmartEmergency(vo);
    }

    /**
     * Event 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 UserVO
     * @return event 목록
     * @exception Exception
     */
    public EgovMap selectSensor(GirlSafeVO vo) throws Exception {
        return this.girlSafeDAO.selectSensor(vo);
    }
    
    /**
     * Event 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 UserVO
     * @return event 목록
     * @exception Exception
     */
    public EgovMap selectSmart(GirlSafeVO vo) throws Exception {
        return this.girlSafeDAO.selectSmart(vo);
    }
    
    /**
     * Event 총 갯수를 조회한다.
     * @param searchVO - 조회할 정보가 담긴 UserVO
     * @return event 총 갯수
     * @exception
     */
    public int selectUserListTotCnt(GirlSafeVO vo) {
        return girlSafeDAO.selectUserListTotCnt(vo);
    }
    
}
