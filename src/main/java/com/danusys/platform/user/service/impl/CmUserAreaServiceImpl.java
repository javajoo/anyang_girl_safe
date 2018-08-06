package com.danusys.platform.user.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import com.danusys.platform.user.service.AdminDefaultVO;
import com.danusys.platform.user.service.CmUserAreaService;
import com.danusys.platform.user.service.CmUserAreaDefaultVO;
import com.danusys.platform.user.service.CmUserAreaVO;
import com.danusys.platform.user.service.impl.CmUserAreaDAO;

/**
 * @Class Name : CmUserAreaServiceImpl.java
 * @Description : CmUserArea Business Implement class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-10
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("cmUserAreaService")
public class CmUserAreaServiceImpl extends EgovAbstractServiceImpl implements
        CmUserAreaService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(CmUserAreaServiceImpl.class);

    @Resource(name="cmUserAreaDAO")
    private CmUserAreaDAO cmUserAreaDAO;
    
    /** ID Generation */
    //@Resource(name="{egovCmUserAreaIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * cm_user_area을 등록한다.
	 * @param vo - 등록할 정보가 담긴 CmUserAreaVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertCmUserArea(CmUserAreaVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	cmUserAreaDAO.insertCmUserArea(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * cm_user_area을 수정한다.
	 * @param vo - 수정할 정보가 담긴 CmUserAreaVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateCmUserArea(CmUserAreaVO vo) throws Exception {
        cmUserAreaDAO.updateCmUserArea(vo);
    }

    /**
	 * cm_user_area을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 CmUserAreaVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteCmUserArea(CmUserAreaVO vo) throws Exception {
        cmUserAreaDAO.deleteCmUserArea(vo);
    }

    /**
	 * cm_user_area을 조회한다.
	 * @param vo - 조회할 정보가 담긴 CmUserAreaVO
	 * @return 조회한 cm_user_area
	 * @exception Exception
	 */
    public CmUserAreaVO selectCmUserArea(CmUserAreaVO vo) throws Exception {
        CmUserAreaVO resultVO = cmUserAreaDAO.selectCmUserArea(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * cm_user_area 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return cm_user_area 목록
	 * @exception Exception
	 */
    public List<?> selectCmUserAreaList(AdminDefaultVO searchVO) throws Exception {
        return cmUserAreaDAO.selectCmUserAreaList(searchVO);
    }

    /**
	 * cm_user_area 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return cm_user_area 총 갯수
	 * @exception
	 */
    public int selectCmUserAreaListTotCnt(AdminDefaultVO searchVO) {
		return cmUserAreaDAO.selectCmUserAreaListTotCnt(searchVO);
	}
    
}
