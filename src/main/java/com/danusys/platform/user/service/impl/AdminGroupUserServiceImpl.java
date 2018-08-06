package com.danusys.platform.user.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import com.danusys.platform.user.service.AdminGroupUserService;
import com.danusys.platform.user.service.AdminDefaultVO;
import com.danusys.platform.user.service.AdminGroupUserVO;
import com.danusys.platform.user.service.impl.AdminGroupUserDAO;

/**
 * @Class Name : AdminGroupUserServiceImpl.java
 * @Description : AdminGroupUser Business Implement class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-06
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("adminGroupUserService")
public class AdminGroupUserServiceImpl extends EgovAbstractServiceImpl implements
        AdminGroupUserService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(AdminGroupUserServiceImpl.class);

    @Resource(name="adminGroupUserDAO")
    private AdminGroupUserDAO adminGroupUserDAO;
    
    /** ID Generation */
    //@Resource(name="{egovAdminGroupUserIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * admin_group_user을 등록한다.
	 * @param vo - 등록할 정보가 담긴 AdminGroupUserVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertAdminGroupUser(AdminGroupUserVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	adminGroupUserDAO.insertAdminGroupUser(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * admin_group_user을 수정한다.
	 * @param vo - 수정할 정보가 담긴 AdminGroupUserVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateAdminGroupUser(AdminGroupUserVO vo) throws Exception {
        adminGroupUserDAO.updateAdminGroupUser(vo);
    }

    /**
	 * admin_group_user을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 AdminGroupUserVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteAdminGroupUser(AdminGroupUserVO vo) throws Exception {
        adminGroupUserDAO.deleteAdminGroupUser(vo);
    }

    /**
	 * admin_group_user을 조회한다.
	 * @param vo - 조회할 정보가 담긴 AdminGroupUserVO
	 * @return 조회한 admin_group_user
	 * @exception Exception
	 */
    public AdminGroupUserVO selectAdminGroupUser(AdminGroupUserVO vo) throws Exception {
        AdminGroupUserVO resultVO = adminGroupUserDAO.selectAdminGroupUser(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * admin_group_user 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return admin_group_user 목록
	 * @exception Exception
	 */
    public List<?> selectAdminGroupUserList(AdminDefaultVO searchVO) throws Exception {
        return adminGroupUserDAO.selectAdminGroupUserList(searchVO);
    }

    /**
	 * admin_group_user 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return admin_group_user 총 갯수
	 * @exception
	 */
    public int selectAdminGroupUserListTotCnt(AdminDefaultVO searchVO) {
		return adminGroupUserDAO.selectAdminGroupUserListTotCnt(searchVO);
	}
    
}
