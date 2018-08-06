package com.danusys.platform.west.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import com.danusys.platform.west.service.CctvViewLogService;
import com.danusys.platform.west.service.CctvViewLogVO;
import com.danusys.platform.west.service.impl.CctvViewLogDAO;

/**
 * @Class Name : CctvViewLogServiceImpl.java
 * @Description : CctvViewLog Business Implement class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-01-11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("cctvViewLogService")
public class CctvViewLogServiceImpl extends EgovAbstractServiceImpl implements
        CctvViewLogService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(CctvViewLogServiceImpl.class);

    @Resource(name="cctvViewLogDAO")
    private CctvViewLogDAO cctvViewLogDAO;
    
    /** ID Generation */
    //@Resource(name="{egovCctvViewLogIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * cctv_view_log을 등록한다.
	 * @param vo - 등록할 정보가 담긴 CctvViewLogVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public int insertCctvViewLog(CctvViewLogVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return cctvViewLogDAO.insertCctvViewLog(vo);
    }

    /**
	 * cctv_view_log을 수정한다.
	 * @param vo - 수정할 정보가 담긴 CctvViewLogVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateCctvViewLog(CctvViewLogVO vo) throws Exception {
        cctvViewLogDAO.updateCctvViewLog(vo);
    }
    
    /**
	 * cctv_view_log에서 viewEndTime을 수정한다.
	 * @param vo - 수정할 정보가 담긴 CctvViewLogVO
	 * @return void형
	 * @exception Exception
	 */
	public void updateViewEndTime(CctvViewLogVO vo) throws Exception {
		cctvViewLogDAO.updateViewEndTime(vo);
	}

    /**
	 * cctv_view_log 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return cctv_view_log 목록
	 * @exception Exception
	 */
    public List<?> selectCctvViewLogList(CctvViewLogVO searchVO) throws Exception {
        return cctvViewLogDAO.selectCctvViewLogList(searchVO);
    }

    /**
	 * cctv_view_log 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return cctv_view_log 총 갯수
	 * @exception
	 */
    public int selectCctvViewLogListTotCnt(CctvViewLogVO searchVO) {
		return cctvViewLogDAO.selectCctvViewLogListTotCnt(searchVO);
	}
    
}
