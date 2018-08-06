package com.danusys.platform.west.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import com.danusys.platform.west.service.CctvViewLogVO;

/**
 * @Class Name : CctvViewLogDAO.java
 * @Description : CctvViewLog DAO Class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-01-11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("cctvViewLogDAO")
public class CctvViewLogDAO extends EgovAbstractDAO {

	/**
	 * cctv_view_log을 등록한다.
	 * @param vo - 등록할 정보가 담긴 CctvViewLogVO
	 * @return 등록 결과(insert한 log의 pk값을 가져온다)
	 * @exception Exception
	 */
    public int insertCctvViewLog(CctvViewLogVO vo) throws Exception {
        return ((Integer)insert("cctvViewLogDAO.insertCctvViewLog_S", vo)).intValue();
    }

    /**
	 * cctv_view_log을 수정한다.
	 * @param vo - 수정할 정보가 담긴 CctvViewLogVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateCctvViewLog(CctvViewLogVO vo) throws Exception {
        update("cctvViewLogDAO.updateCctvViewLog_S", vo);
    }
    
    /**
	 * cctv_view_log에서 viewEndTime을 수정한다.
	 * @param vo - 수정할 정보가 담긴 CctvViewLogVO
	 * @return void형
	 * @exception Exception
	 */
	public void updateViewEndTime(CctvViewLogVO vo) throws Exception {
		update("cctvViewLogDAO.updateCctvViewLog_viewEnd", vo);
	}

    /**
	 * cctv_view_log 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return cctv_view_log 목록
	 * @exception Exception
	 */
    public List<?> selectCctvViewLogList(CctvViewLogVO searchVO) throws Exception {
        return list("cctvViewLogDAO.selectCctvViewLogList", searchVO);
    }

    /**
	 * cctv_view_log 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return cctv_view_log 총 갯수
	 * @exception
	 */
    public int selectCctvViewLogListTotCnt(CctvViewLogVO searchVO) {
        return (Integer)select("cctvViewLogDAO.selectCctvViewLogListTotCnt", searchVO);
    }

}
