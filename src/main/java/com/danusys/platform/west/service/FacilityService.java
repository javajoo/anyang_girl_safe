package com.danusys.platform.west.service;

import java.util.List;

import com.danusys.platform.sensor.service.LastsVO;

import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * @Class Name : FacilityService.java
 * @Description : Facility Business class
 * @Modification Information
 *
 * @author 김하울
 * @since 2017-12-11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface FacilityService {
    
    /**
     * Facility 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 FacilityVO
     * @return facility 목록
     * @exception Exception
     */
    List<?> selectFacilityList(FacilityVO vo) throws Exception;
    
    /**
     * Facility를 NodeID로 조회 한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return facility 목록
     * @exception Exception
     */
    List<?> selectFacilityToNodeId(FacilityVO vo) throws Exception;
    
    /**
     * Facility를 Siteno(환경센서 id)로 조회 한다.(환경센서와 연결된 카메라를 조회)
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return facility 목록
     * @exception Exception
     */
    List<?> selectFacilityToSiteno(LastsVO vo) throws Exception;
    
    /**
     * 특정 위치의 반경 내에 있는 Facility를  조회 한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return facility 목록
     * @exception Exception
     */
    public List<?> selectFacilityRadius(FacilityVO vo) throws Exception;
    
    /**
     * Facility 총 갯수를 조회한다.
     * @param searchVO - 조회할 정보가 담긴 FacilityVO
     * @return facility 총 갯수
     * @exception
     */
    int selectFacilityListTotCnt(FacilityVO vo);
    
    /**
     * Facility을 등록한다.
     * @param vo - 등록할 정보가 담긴 FacilityVO
     * @return void형
     * @exception Exception
     */
    void insertFacility(FacilityVO vo) throws Exception;
    
    /**
     * Facility을 등록 하는데, 중복된 node_id가 있으면 업데이트 한다.
     * @param vo - 등록할 정보가 담긴 FacilityVO
     * @return void형
     * @exception Exception
     */
    public void insertFacilityDuplicateUpdate(FacilityVO vo) throws Exception;
    
    /**
     * Facility을 수정한다.
     * @param vo - 수정할 정보가 담긴 FacilityVO
     * @return void형
     * @exception Exception
     */
    //void updateFacility(FacilityVO vo) throws Exception;
    
    /**
     * Facility 테이블에 node id가 같은 것을 수정한다.
     * @param vo - 수정할 정보가 담긴 FacilityVO
     * @return void형
     * @exception Exception
     */
    void updateFacilityToNodeId(FacilityVO vo) throws Exception;
    
    /**
     * Facility을 삭제한다.
     * @param vo - 삭제할 정보가 담긴 FacilityVO
     * @return void형 
     * @exception Exception
     */
    void deleteFacility(FacilityVO vo) throws Exception;
    
    /***********************************시설물관제******************************************************/
    /*시설물관리 - 조회*/
    List<?> selectFacilityMList(FacilityVO vo) throws Exception;
    int selectFacilityMListTotCnt(FacilityVO vo);
    
    /*시설물관리 - 추가*/
    void insertFacilityCctvList(FacilityVO vo) throws Exception;
    void insertFacilitySensorList(FacilityVO vo) throws Exception;
    void insertFacilityCenterList(FacilityVO vo) throws Exception;
    
    /*시설물관리 - 수정*/
    void updateFacilityCctvList(FacilityVO vo) throws Exception;
    void updateFacilitySensorList(FacilityVO vo) throws Exception;
    void updateFacilityCenterList(FacilityVO vo) throws Exception;
    
    /*시설물관리 - 삭제*/
    void deleteFacilityCctvList(FacilityVO vo) throws Exception;
    void deleteFacilitySensorList(FacilityVO vo) throws Exception;
    void deleteFacilityCenterList(FacilityVO vo) throws Exception;
    
    /*시설물현황(전체) - 조회*/
    List<?> selectFacilityRTotList(FacilityVO vo) throws Exception;
    
    /*시설물현황(종류) - 조회*/
    List<?> selectFacilityRTypeList(FacilityVO vo) throws Exception;
    
    EgovMap selectFacility(int facilityNo) throws Exception;
    
    void updateFacilityState(FacilityVO vo) throws Exception;
}
