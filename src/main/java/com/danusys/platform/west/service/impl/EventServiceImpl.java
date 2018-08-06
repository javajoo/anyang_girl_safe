package com.danusys.platform.west.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.danusys.platform.west.service.EventService;
import com.danusys.platform.west.service.EventVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : EventServiceImpl.java
 * @Description : Event Business Implement class
 * @Modification Information
 *
 * @author 김하울
 * @since 2017-12-11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("eventService")
public class EventServiceImpl extends EgovAbstractServiceImpl implements EventService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(EventServiceImpl.class);

    @Resource(name="eventDAO")
    private EventDAO eventDAO;
    
    /**
     * Event 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 EventVO
     * @return event 목록
     * @exception Exception
     */
    public List<?> selectEventList(EventVO vo) throws Exception {
        return eventDAO.selectEventList(vo);
    }

    /**
     * Event 총 갯수를 조회한다.
     * @param searchVO - 조회할 정보가 담긴 EventVO
     * @return event 총 갯수
     * @exception
     */
    public int selectEventListTotCnt(EventVO vo) {
        return eventDAO.selectEventListTotCnt(vo);
    }
    
    /**
     * Event 상태 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 EventVO
     * @return event 목록
     * @exception Exception
     */
    public List<?> selectEventState(EventVO vo) throws Exception {
        return eventDAO.selectEventState(vo);
    }
    
    /**
     * Event 확인한다.
     * @param searchVO - 조회할 정보가 담긴 EventVO
     * @return event 목록
     * @exception Exception
     */
    public List<?> selectEventConfm(EventVO vo) throws Exception {
        return eventDAO.selectEventConfm(vo);
    }
    
    /**
     * Event을 등록한다.
     * @param vo - 등록할 정보가 담긴 EventVO
     * @return 등록 결과
     * @exception Exception
     */
    public String insertEvent(EventVO vo) throws Exception {
        LOGGER.debug(vo.toString());
        
        eventDAO.insertEvent(vo);
        //TODO 해당 테이블 정보에 맞게 수정     
        return null;
    }

    /**
     * Event을 수정한다.
     * @param vo - 수정할 정보가 담긴 EventVO
     * @return void형
     * @exception Exception
     */
    public void updateEvent(EventVO vo) throws Exception {
        if(vo.getFlag().equals("end")){ //처리완료
            eventDAO.insertEventEnd(vo);
        }
        else {  //중간저장
            eventDAO.insertEventUpd(vo);
        }
    }

    /**
     * Event 일괄 확인처리.
     * @param vo - 수정할 정보가 담긴 EventVO
     * @return void형
     * @exception Exception
     */
    public void updateEventConfm(EventVO vo) throws Exception {
        eventDAO.updateEventConfm(vo);
    }
    
    /**
     * Event을 삭제한다.
     * @param vo - 삭제할 정보가 담긴 EventVO
     * @return void형 
     * @exception Exception
     */
    public void deleteEvent(EventVO vo) throws Exception {
        eventDAO.deleteEvent(vo);
    }
    
    /**
     * EventFlag를 등록한다.
     * @param vo - 등록할 정보가 담긴 EventVO
     * @return 등록 결과
     * @exception Exception
     */
    public String insertEventFlagConfm(EventVO vo) throws Exception {
        LOGGER.debug(vo.toString());
        eventDAO.insertEventFlagConfm(vo);
        return null;
    }    

    /**
     * EventFlag 확인한다.
     * @param searchVO - 조회할 정보가 담긴 EventVO
     * @return event 목록
     * @exception Exception
     */
    public List<?> selectEventFlagConfm(EventVO vo) throws Exception {
        return eventDAO.selectEventFlagConfm(vo);
    }
    
    /**
     * EventStats 상태 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 EventVO
     * @return event 목록
     * @exception Exception
     */
    public List<?> selectEventStats(EventVO vo) throws Exception {
        return eventDAO.selectEventStats(vo);
    }
    
    public List<?> selectEventEtcCont(String eventNo) throws Exception {
    	return eventDAO.selectEventEtcCont(eventNo);
    }
   
}
