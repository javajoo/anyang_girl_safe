package com.danusys.platform.west.service;

import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * @Class Name : UserService.java
 * @Description : User Business class
 * @Modification Information
 *
 * @author 배선교
 * @since 2018
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface GirlSafeService {
    
    /**
     * Event 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 EventVO
     * @return event 목록
     * @exception Exception
     */
    List<?> selectUserList(GirlSafeVO vo) throws Exception;
    
    /**
     * Event 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 EventVO
     * @return event 목록
     * @exception Exception
     */
    void updateSensorStatus(GirlSafeVO vo) throws Exception;
    
    /**
     * Event 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 EventVO
     * @return event 목록
     * @exception Exception
     */
    void updateSmartStatus(GirlSafeVO vo) throws Exception;
    
    /**
     * Event 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 EventVO
     * @return event 목록
     * @exception Exception
     */
    void updateSensorEmergency(GirlSafeVO vo) throws Exception;
    
    /**
     * Event 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 EventVO
     * @return event 목록
     * @exception Exception
     */
    void updateSmartEmergency(GirlSafeVO vo) throws Exception;
    
    /**
     * Event 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 EventVO
     * @return event 목록
     * @exception Exception
     */
    EgovMap selectSensor(GirlSafeVO vo) throws Exception;
    
    /**
     * Event 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 EventVO
     * @return event 목록
     * @exception Exception
     */
    EgovMap selectSmart(GirlSafeVO vo) throws Exception;
    
    /**
     * Event 총 갯수를 조회한다.
     * @param searchVO - 조회할 정보가 담긴 EventVO
     * @return event 총 갯수
     * @exception
     */
    int selectUserListTotCnt(GirlSafeVO vo);
    
}
