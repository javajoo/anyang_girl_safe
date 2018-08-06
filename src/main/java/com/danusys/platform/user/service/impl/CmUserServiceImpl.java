package com.danusys.platform.user.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import com.danusys.platform.user.service.AdminDefaultVO;
import com.danusys.platform.user.service.CmUserService;
import com.danusys.platform.user.service.CmUserVO;
import com.danusys.platform.user.service.impl.CmUserDAO;

/**
 * @Class Name : CmUserServiceImpl.java
 * @Description : CmUser Business Implement class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("cmUserService")
public class CmUserServiceImpl extends EgovAbstractServiceImpl implements
        CmUserService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(CmUserServiceImpl.class);

    @Resource(name="cmUserDAO")
    private CmUserDAO cmUserDAO;
    
    /** ID Generation */
    //@Resource(name="{egovCmUserIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * cm_user을 등록한다.
	 * @param vo - 등록할 정보가 담긴 CmUserVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertCmUser(CmUserVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	cmUserDAO.insertCmUser(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * cm_user을 수정한다.
	 * @param vo - 수정할 정보가 담긴 CmUserVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateCmUser(CmUserVO vo) throws Exception {
        cmUserDAO.updateCmUser(vo);
    }

    /**
	 * cm_user을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 CmUserVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteCmUser(CmUserVO vo) throws Exception {
        cmUserDAO.deleteCmUser(vo);
    }

    /**
	 * cm_user을 조회한다.
	 * @param vo - 조회할 정보가 담긴 CmUserVO
	 * @return 조회한 cm_user
	 * @exception Exception
	 */
    public CmUserVO selectCmUser(CmUserVO vo) throws Exception {
        CmUserVO resultVO = cmUserDAO.selectCmUser(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * cm_user 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return cm_user 목록
	 * @exception Exception
	 */
    public List<?> selectCmUserList(AdminDefaultVO searchVO) throws Exception {
        return cmUserDAO.selectCmUserList(searchVO);
    }

    /**
	 * cm_user 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return cm_user 총 갯수
	 * @exception
	 */
    public int selectCmUserListTotCnt(AdminDefaultVO searchVO) {
		return cmUserDAO.selectCmUserListTotCnt(searchVO);
	}
    
}
