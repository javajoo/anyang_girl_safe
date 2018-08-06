package com.danusys.platform.user.service;

import java.util.List;

/**
 * @Class Name : AdminGroupAuthLvlService.java
 * @Description : AdminGroupAuthLvl Business class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-06
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface AdminGroupAuthLvlService {
	
	/**
	 * admin_group_auth_lvl을 등록한다.
	 * @param vo - 등록할 정보가 담긴 AdminGroupAuthLvlVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertAdminGroupAuthLvl(AdminGroupAuthLvlVO vo) throws Exception;
    
    /**
	 * admin_group_auth_lvl을 수정한다.
	 * @param vo - 수정할 정보가 담긴 AdminGroupAuthLvlVO
	 * @return void형
	 * @exception Exception
	 */
    void updateAdminGroupAuthLvl(AdminGroupAuthLvlVO vo) throws Exception;
    
    /**
	 * admin_group_auth_lvl을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 AdminGroupAuthLvlVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteAdminGroupAuthLvl(AdminGroupAuthLvlVO vo) throws Exception;
    
    /**
	 * admin_group_auth_lvl을 조회한다.
	 * @param vo - 조회할 정보가 담긴 AdminGroupAuthLvlVO
	 * @return 조회한 admin_group_auth_lvl
	 * @exception Exception
	 */
    AdminGroupAuthLvlVO selectAdminGroupAuthLvl(AdminGroupAuthLvlVO vo) throws Exception;
    
    /**
	 * admin_group_auth_lvl 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return admin_group_auth_lvl 목록
	 * @exception Exception
	 */
    List selectAdminGroupAuthLvlList(AdminGroupAuthLvlDefaultVO searchVO) throws Exception;
    
    /**
	 * admin_group_auth_lvl 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return admin_group_auth_lvl 총 갯수
	 * @exception
	 */
    int selectAdminGroupAuthLvlListTotCnt(AdminGroupAuthLvlDefaultVO searchVO);
    
}
