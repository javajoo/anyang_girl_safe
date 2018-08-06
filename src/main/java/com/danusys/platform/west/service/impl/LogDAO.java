package com.danusys.platform.west.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;
import com.danusys.platform.west.service.LogVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * @Class Name : LogDAO.java
 * @Description : Log DAO Class
 * @Modification Information
 *
 * @author 김하울
 * @since 2018-01-03
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
@Repository("logDAO")
public class LogDAO extends EgovAbstractDAO {

	/**
	 * 로그 기록
	 * 접두사에 상관없이 쿼리는 하나이다.
	 * @param vo
	 */
    public void insertLog(LogVO vo) throws Exception {
        System.out.println("//"+vo.getContent());
        System.out.println("//"+vo.getSessionId());
        insert("logDAO.insertLog", vo);
    }
    
    /*로그 조회-마스터*/
	public List<?> selectLogList(LogVO vo) throws Exception {
	    return list("logDAO.selectLogList", vo);
	}
    public int selectLogListTotCnt(LogVO vo) {
        return (Integer)select("logDAO.selectLogListTotCnt", vo);
    }
}
