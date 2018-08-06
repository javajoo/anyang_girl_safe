package com.danusys.platform.west.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.danusys.platform.west.service.GirlSafeVO;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * @Class Name : UserDAO.java
 * @Description : User DAO Class
 * @Modification Information
 *
 * @author 배선교
 * @since 2018
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("girlSafeDAO")
public class GirlSafeDAO extends EgovAbstractMapper {
    /**
     * User 목록을 조회한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return user 목록
     * @exception Exception
     */
    public List<?> selectUserList(GirlSafeVO vo) throws Exception {
        return selectList("girlSafeDAO.selectUserList", vo);
    }
    
    /**
     * User 목록을 조회한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return user 목록
     * @exception Exception
     */
    public void updateSensorStatus(GirlSafeVO vo) throws Exception {
        update("girlSafeDAO.updateSensorStatus", vo);
    }
    
    /**
     * User 목록을 조회한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return user 목록
     * @exception Exception
     */
    public void updateSmartStatus(GirlSafeVO vo) throws Exception {
        update("girlSafeDAO.updateSmartStatus", vo);
    }
    
    /**
     * User 목록을 조회한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return user 목록
     * @exception Exception
     */
    public void updateSensorEmergency(GirlSafeVO vo) throws Exception {
        update("girlSafeDAO.updateSensorEmergency", vo);
    }
    
    /**
     * User 목록을 조회한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return user 목록
     * @exception Exception
     */
    public void updateSmartEmergency(GirlSafeVO vo) throws Exception {
        update("girlSafeDAO.updateSmartEmergency", vo);
    }
    
    /**
     * User 목록을 조회한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return user 목록
     * @exception Exception
     */
    public EgovMap selectSensor(GirlSafeVO vo) throws Exception {
        return (EgovMap) selectOne("girlSafeDAO.selectSensor",vo);
    }
    
    /**
     * User 목록을 조회한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return user 목록
     * @exception Exception
     */
    public EgovMap selectSmart(GirlSafeVO vo) throws Exception {
        return (EgovMap) selectOne("girlSafeDAO.selectSmart",vo);
    }

    /**
     * User 총 갯수를 조회한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return user 총 갯수
     * @exception
     */
    public int selectUserListTotCnt(GirlSafeVO vo) {
        return (Integer)selectOne("girlSafeDAO.selectUserListTotCnt", vo);
    }
    
    
}
