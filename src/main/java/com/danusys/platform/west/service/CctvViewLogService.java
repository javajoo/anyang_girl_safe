package com.danusys.platform.west.service;

import java.util.List;
import com.danusys.platform.west.service.CctvViewLogVO;

/**
 * @Class Name : CctvViewLogService.java
 * @Description : CctvViewLog Business class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-01-11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface CctvViewLogService {
	
	/**
	 * cctv_view_log을 등록한다.
	 * @param vo - 등록할 정보가 담긴 CctvViewLogVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    int insertCctvViewLog(CctvViewLogVO vo) throws Exception;
    
    /**
	 * cctv_view_log을 수정한다.
	 * @param vo - 수정할 정보가 담긴 CctvViewLogVO
	 * @return void형
	 * @exception Exception
	 */
    void updateCctvViewLog(CctvViewLogVO vo) throws Exception;
    
    /**
	 * cctv_view_log에서 viewEndTime을 수정한다.
	 * @param vo - 수정할 정보가 담긴 CctvViewLogVO
	 * @return void형
	 * @exception Exception
	 */
	public void updateViewEndTime(CctvViewLogVO vo) throws Exception;
    
    /**
	 * cctv_view_log 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return cctv_view_log 목록
	 * @exception Exception
	 */
    List selectCctvViewLogList(CctvViewLogVO searchVO) throws Exception;
    
    /**
	 * cctv_view_log 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return cctv_view_log 총 갯수
	 * @exception
	 */
    int selectCctvViewLogListTotCnt(CctvViewLogVO searchVO);
    
}
