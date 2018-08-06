package com.danusys.platform.west.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.danusys.platform.west.service.EventVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * @Class Name : EventDAO.java
 * @Description : Event DAO Class
 * @Modification Information
 *
 * @author 김하울
 * @since 2017-12-11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("eventDAO")
public class EventDAO extends EgovAbstractDAO {
    /**
     * Event 목록을 조회한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return event 목록
     * @exception Exception
     */
    public List<?> selectEventList(EventVO vo) throws Exception {
        return list("eventDAO.selectEventList", vo);
    }

    /**
     * Event 총 갯수를 조회한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return event 총 갯수
     * @exception
     */
    public int selectEventListTotCnt(EventVO vo) {
        return (Integer)select("eventDAO.selectEventListTotCnt", vo);
    }
    
    /**
     * Event 상태 목록을 조회한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return event 목록
     * @exception Exception
     */
    public List<?> selectEventState(EventVO vo) throws Exception {
        return list("eventDAO.selectEventState", vo);
    }
    
    /**
     * Event 확인한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return event 목록
     * @exception Exception
     */
    public List<?> selectEventConfm(EventVO vo) throws Exception {
        return list("eventDAO.selectEventConfm", vo);
    }
    
    /**
     * Event을 등록한다.
     * @param vo - 등록할 정보가 담긴 EventVO
     * @return 등록 결과
     * @exception Exception
     */
    public String insertEvent(EventVO vo) throws Exception {
        return (String)insert("eventDAO.insertEvent", vo);
    }
    
    /**
     * Event을 등록(처리중, 완료)한다.
     * @param vo - 등록할 정보가 담긴 EventVO
     * @return 등록 결과
     * @exception Exception
     */
    public String insertEventEnd(EventVO vo) throws Exception {
        return (String)insert("eventDAO.insertEventEnd", vo);
    }
    public String insertEventUpd(EventVO vo) throws Exception {
        return (String)insert("eventDAO.insertEventUpd", vo);
    }

    /**
     * Event 일괄 확인처리.
     * @param vo - 수정할 정보가 담긴 EventVO
     * @return void형
     * @exception Exception
     */
    public void updateEventConfm(EventVO vo) throws Exception {
        update("eventDAO.updateEventConfm", vo);
    }
    
    /**
     * Event을 삭제한다.
     * @param vo - 삭제할 정보가 담긴 EventVO
     * @return void형 
     * @exception Exception
     */
    public void deleteEvent(EventVO vo) throws Exception {
        delete("eventDAO.deleteEvent", vo);
    }
    
    /**
     * EventFlag 확인처리.
     * @param vo - 등록할 정보가 담긴 EventVO
     * @return 등록 결과
     * @exception Exception
     */
    public String insertEventFlagConfm(EventVO vo) throws Exception {
        return (String)insert("eventDAO.insertEventFlagConfm", vo);
    }    
    
    /**
     * EventFlag 확인한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return event 목록
     * @exception Exception
     */
    public List<?> selectEventFlagConfm(EventVO vo) throws Exception {
        return list("eventDAO.selectEventFlagConfm", vo);
    }    
    
    /**
     * EventStats 목록을 조회한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return event 목록
     * @exception Exception
     */
    public List<?> selectEventStats(EventVO vo) throws Exception {
        return list("eventDAO.selectEventStats", vo);
    }   
    
    public List<?> selectEventEtcCont(String eventNo) throws Exception {
    	return list("eventDAO.selectEventEtcCont", eventNo);
    }
}
