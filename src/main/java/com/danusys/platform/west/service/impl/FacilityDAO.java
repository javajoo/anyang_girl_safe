package com.danusys.platform.west.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.danusys.platform.sensor.service.LastsVO;
import com.danusys.platform.west.service.FacilityVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * @Class Name : FacilityDAO.java
 * @Description : Facility DAO Class
 * @Modification Information
 *
 * @author 김하울
 * @since 2017-12-11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("facilityDAO")
public class FacilityDAO extends EgovAbstractDAO {
    /**
     * Facility 목록을 조회한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return facility 목록
     * @exception Exception
     */
    public List<?> selectFacilityList(FacilityVO vo) throws Exception {
        return list("facilityDAO.selectFacilityList", vo);
    }
    
    /**
     * Facility를 NodeID로 조회 한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return facility 목록
     * @exception Exception
     */
    public List<?> selectFacilityToNodeId(FacilityVO vo) throws Exception {
        return list("facilityDAO.selectFacilityToNodeId", vo);
    }
    
    /**
     * Facility를 Siteno(환경센서 id)로 조회 한다.(환경센서와 연결된 카메라를 조회)
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return facility 목록
     * @exception Exception
     */
    public List<?> selectFacilityToSiteno(LastsVO vo) throws Exception {
        return list("facilityDAO.selectFacilityToSiteno", vo);
    }
    
    /**
     * 특정 위치의 반경 내에 있는 Facility를  조회 한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return facility 목록
     * @exception Exception
     */
    public List<?> selectFacilityRadius(FacilityVO vo) throws Exception {
        return list("facilityDAO.selectFacilityRadius", vo);
    }

    /**
     * Facility 총 갯수를 조회한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return facility 총 갯수
     * @exception
     */
    public int selectFacilityListTotCnt(FacilityVO vo) {
        return (Integer)select("facilityDAO.selectFacilityListTotCnt", vo);
    }
    /**
     * Facility을 등록한다.
     * @param vo - 등록할 정보가 담긴 FacilityVO
     * @return void형
     * @exception Exception
     */
    public void insertFacility(FacilityVO vo) throws Exception {
        insert("facilityDAO.insertFacility", vo);
    }

    /**
     * Facility을 등록 하는데, 중복된 node_id가 있으면 업데이트 한다.
     * @param vo - 등록할 정보가 담긴 FacilityVO
     * @return void형
     * @exception Exception
     */
    public void insertFacilityDuplicateUpdate(FacilityVO vo) throws Exception {
        insert("facilityDAO.insertFacilityDuplicateUpdate", vo);
    }

    /**
     * Facility을 수정한다.
     * @param vo - 수정할 정보가 담긴 FacilityVO
     * @return void형
     * @exception Exception
     */
    /*public void updateFacility(FacilityVO vo) throws Exception {
        update("facilityDAO.updateFacility", vo);
    }*/

    /**
     * Facility 테이블에 node id가 같은 것을 수정한다.
     * @param vo - 수정할 정보가 담긴 FacilityVO
     * @return void형
     * @exception Exception
     */
    public void updateFacilityToNodeId(FacilityVO vo) throws Exception {
        update("facilityDAO.updateFacilityToNodeId", vo);
    }

    /**
     * Facility을 삭제한다.
     * @param vo - 삭제할 정보가 담긴 FacilityVO
     * @return void형 
     * @exception Exception
     */
    public void deleteFacility(FacilityVO vo) throws Exception {
        delete("facilityDAO.deleteFacility", vo);
    }
    
    /***********************************시설물관제******************************************************/
    /*시설물관리 - 조회*/
    public List<?> selectFacilityMList(FacilityVO vo) throws Exception {
        return list("facilityDAO.selectFacilityMList", vo);
    }
    public int selectFacilityMListTotCnt(FacilityVO vo) {
        return (Integer)select("facilityDAO.selectFacilityMListTotCnt", vo);
    }
    
    /*시설물관리 - 추가*/
    public void insertFacilityCctvList(FacilityVO vo) throws Exception {
        update("facilityDAO.insertFacilityCctvList", vo);
    }
    public void insertFacilitySensorList(FacilityVO vo) throws Exception {
        update("facilityDAO.insertFacilitySensorList", vo);
    }
    public void insertFacilityCenterList(FacilityVO vo) throws Exception {
        update("facilityDAO.insertFacilityCenterList", vo);
    }
    
    /*시설물관리 - 수정*/
    public void updateFacilityCctvList(FacilityVO vo) throws Exception {
        update("facilityDAO.updateFacilityCctvList", vo);
    }
    public void updateFacilitySensorList(FacilityVO vo) throws Exception {
        update("facilityDAO.updateFacilitySensorList", vo);
    }
    public void updateFacilityCenterList(FacilityVO vo) throws Exception {
        update("facilityDAO.updateFacilityCenterList", vo);
    }
    
    /*시설물관리 - 삭제*/
    public void deleteFacilityCctvList(FacilityVO vo) throws Exception {
        delete("facilityDAO.deleteFacilityCctvList", vo);
    }
    public void deleteFacilitySensorList(FacilityVO vo) throws Exception {
        delete("facilityDAO.deleteFacilitySensorList", vo);
    }
    public void deleteFacilityCenterList(FacilityVO vo) throws Exception {
        delete("facilityDAO.deleteFacilityCenterList", vo);
    }
    
    /*시설물현황(전체) - 조회*/
    public List<?> selectFacilityRTotList(FacilityVO vo) throws Exception {
        return list("facilityDAO.selectFacilityRTotList", vo);
    }
    
    /*시설물현황(종류) - 조회*/
    public List<?> selectFacilityRTypeList(FacilityVO vo) throws Exception {
        return list("facilityDAO.selectFacilityRTypeList", vo);
    }
    
    public EgovMap selectFacility(int facilityNo) throws Exception {
    	return (EgovMap) select("facilityDAO.selectFacility", facilityNo);
    }
    
    public void updateFacilityState(FacilityVO vo) throws Exception {
    	update("facilityDAO.updateFacilityState", vo);
    }
}
