package com.danusys.platform.west.service;

import java.util.List;

/**
 * @Class Name : EventService.java
 * @Description : Event Business class
 * @Modification Information
 *
 * @author 김하울
 * @since 2017-12-11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface EventService {
    
    /**
     * Event 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 EventVO
     * @return event 목록
     * @exception Exception
     */
    List<?> selectEventList(EventVO vo) throws Exception;
    
    /**
     * Event 총 갯수를 조회한다.
     * @param searchVO - 조회할 정보가 담긴 EventVO
     * @return event 총 갯수
     * @exception
     */
    int selectEventListTotCnt(EventVO vo);
    
    /**
     * Event 상태 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 EventVO
     * @return event 목록
     * @exception Exception
     */
    List<?> selectEventState(EventVO vo) throws Exception;
    
    /**
     * Event 확인한다.
     * @param searchVO - 조회할 정보가 담긴 EventVO
     * @return event 목록
     * @exception Exception
     */
    List<?> selectEventConfm(EventVO vo) throws Exception;
    
    /**
     * Event을 등록한다.
     * @param vo - 등록할 정보가 담긴 EventVO
     * @return 등록 결과
     * @exception Exception
     */
    String insertEvent(EventVO vo) throws Exception;
    
    /**
     * Event을 수정한다.
     * @param vo - 수정할 정보가 담긴 EventVO
     * @return void형
     * @exception Exception
     */
    void updateEvent(EventVO vo) throws Exception;
    
    /**
     * Event 일괄 확인처리.
     * @param vo - 수정할 정보가 담긴 EventVO
     * @return void형
     * @exception Exception
     */
    void updateEventConfm(EventVO vo) throws Exception;
    
    /**
     * Event을 삭제한다.
     * @param vo - 삭제할 정보가 담긴 EventVO
     * @return void형 
     * @exception Exception
     */
    void deleteEvent(EventVO vo) throws Exception;
    
    /**
     * EventFlag을 등록한다.
     * @param vo - 등록할 정보가 담긴 EventVO
     * @return 등록 결과
     * @exception Exception
     */
    String insertEventFlagConfm(EventVO vo) throws Exception;
    
    /**
     * EventFlag 확인한다.
     * @param searchVO - 조회할 정보가 담긴 EventVO
     * @return event 목록
     * @exception Exception
     */
    List<?> selectEventFlagConfm(EventVO vo) throws Exception;
   
    
    /**
     * EventStats 확인한다.
     * @param EventVO - 조회할 정보가 담긴 EventVO
     * @return stats 목록
     * @exception Exception
     */
    List<?> selectEventStats(EventVO vo) throws Exception;    
    
    List<?> selectEventEtcCont(String eventNo) throws Exception;
    
}
