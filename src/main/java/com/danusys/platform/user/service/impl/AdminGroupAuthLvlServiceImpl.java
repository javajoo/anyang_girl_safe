package com.danusys.platform.user.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import com.danusys.platform.user.service.AdminGroupAuthLvlDefaultVO;
import com.danusys.platform.user.service.AdminGroupAuthLvlService;
import com.danusys.platform.user.service.AdminGroupAuthLvlVO;
import com.danusys.platform.user.service.impl.AdminGroupAuthLvlDAO;

/**
 * @Class Name : AdminGroupAuthLvlServiceImpl.java
 * @Description : AdminGroupAuthLvl Business Implement class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-06
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("adminGroupAuthLvlService")
public class AdminGroupAuthLvlServiceImpl extends EgovAbstractServiceImpl implements
        AdminGroupAuthLvlService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(AdminGroupAuthLvlServiceImpl.class);

    @Resource(name="adminGroupAuthLvlDAO")
    private AdminGroupAuthLvlDAO adminGroupAuthLvlDAO;
    
    /** ID Generation */
    //@Resource(name="{egovAdminGroupAuthLvlIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * admin_group_auth_lvl을 등록한다.
	 * @param vo - 등록할 정보가 담긴 AdminGroupAuthLvlVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertAdminGroupAuthLvl(AdminGroupAuthLvlVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	adminGroupAuthLvlDAO.insertAdminGroupAuthLvl(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * admin_group_auth_lvl을 수정한다.
	 * @param vo - 수정할 정보가 담긴 AdminGroupAuthLvlVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateAdminGroupAuthLvl(AdminGroupAuthLvlVO vo) throws Exception {
        adminGroupAuthLvlDAO.updateAdminGroupAuthLvl(vo);
    }

    /**
	 * admin_group_auth_lvl을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 AdminGroupAuthLvlVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteAdminGroupAuthLvl(AdminGroupAuthLvlVO vo) throws Exception {
        adminGroupAuthLvlDAO.deleteAdminGroupAuthLvl(vo);
    }

    /**
	 * admin_group_auth_lvl을 조회한다.
	 * @param vo - 조회할 정보가 담긴 AdminGroupAuthLvlVO
	 * @return 조회한 admin_group_auth_lvl
	 * @exception Exception
	 */
    public AdminGroupAuthLvlVO selectAdminGroupAuthLvl(AdminGroupAuthLvlVO vo) throws Exception {
        AdminGroupAuthLvlVO resultVO = adminGroupAuthLvlDAO.selectAdminGroupAuthLvl(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * admin_group_auth_lvl 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return admin_group_auth_lvl 목록
	 * @exception Exception
	 */
    public List<?> selectAdminGroupAuthLvlList(AdminGroupAuthLvlDefaultVO searchVO) throws Exception {
        return adminGroupAuthLvlDAO.selectAdminGroupAuthLvlList(searchVO);
    }

    /**
	 * admin_group_auth_lvl 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return admin_group_auth_lvl 총 갯수
	 * @exception
	 */
    public int selectAdminGroupAuthLvlListTotCnt(AdminGroupAuthLvlDefaultVO searchVO) {
		return adminGroupAuthLvlDAO.selectAdminGroupAuthLvlListTotCnt(searchVO);
	}
    
}
