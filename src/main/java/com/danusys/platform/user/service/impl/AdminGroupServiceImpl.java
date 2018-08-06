package com.danusys.platform.user.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import com.danusys.platform.user.service.AdminGroupService;
import com.danusys.platform.user.service.AdminGroupDefaultVO;
import com.danusys.platform.user.service.AdminGroupVO;
import com.danusys.platform.user.service.impl.AdminGroupDAO;

/**
 * @Class Name : AdminGroupServiceImpl.java
 * @Description : AdminGroup Business Implement class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-06
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("adminGroupService")
public class AdminGroupServiceImpl extends EgovAbstractServiceImpl implements
        AdminGroupService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(AdminGroupServiceImpl.class);

    @Resource(name="adminGroupDAO")
    private AdminGroupDAO adminGroupDAO;
    
    /** ID Generation */
    //@Resource(name="{egovAdminGroupIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * admin_group을 등록한다.
	 * @param vo - 등록할 정보가 담긴 AdminGroupVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertAdminGroup(AdminGroupVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	adminGroupDAO.insertAdminGroup(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * admin_group을 수정한다.
	 * @param vo - 수정할 정보가 담긴 AdminGroupVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateAdminGroup(AdminGroupVO vo) throws Exception {
        adminGroupDAO.updateAdminGroup(vo);
    }

    /**
	 * admin_group을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 AdminGroupVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteAdminGroup(AdminGroupVO vo) throws Exception {
        adminGroupDAO.deleteAdminGroup(vo);
    }

    /**
	 * admin_group을 조회한다.
	 * @param vo - 조회할 정보가 담긴 AdminGroupVO
	 * @return 조회한 admin_group
	 * @exception Exception
	 */
    public AdminGroupVO selectAdminGroup(AdminGroupVO vo) throws Exception {
        AdminGroupVO resultVO = adminGroupDAO.selectAdminGroup(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * admin_group 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return admin_group 목록
	 * @exception Exception
	 */
    public List<?> selectAdminGroupList(AdminGroupDefaultVO searchVO) throws Exception {
        return adminGroupDAO.selectAdminGroupList(searchVO);
    }

    /**
	 * admin_group 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return admin_group 총 갯수
	 * @exception
	 */
    public int selectAdminGroupListTotCnt(AdminGroupDefaultVO searchVO) {
		return adminGroupDAO.selectAdminGroupListTotCnt(searchVO);
	}
    
}
