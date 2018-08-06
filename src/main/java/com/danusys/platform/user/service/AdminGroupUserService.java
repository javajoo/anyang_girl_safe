package com.danusys.platform.user.service;

import java.util.List;
import com.danusys.platform.user.service.AdminGroupUserVO;

/**
 * @Class Name : AdminGroupUserService.java
 * @Description : AdminGroupUser Business class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-06
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface AdminGroupUserService {
	
	/**
	 * admin_group_user을 등록한다.
	 * @param vo - 등록할 정보가 담긴 AdminGroupUserVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertAdminGroupUser(AdminGroupUserVO vo) throws Exception;
    
    /**
	 * admin_group_user을 수정한다.
	 * @param vo - 수정할 정보가 담긴 AdminGroupUserVO
	 * @return void형
	 * @exception Exception
	 */
    void updateAdminGroupUser(AdminGroupUserVO vo) throws Exception;
    
    /**
	 * admin_group_user을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 AdminGroupUserVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteAdminGroupUser(AdminGroupUserVO vo) throws Exception;
    
    /**
	 * admin_group_user을 조회한다.
	 * @param vo - 조회할 정보가 담긴 AdminGroupUserVO
	 * @return 조회한 admin_group_user
	 * @exception Exception
	 */
    AdminGroupUserVO selectAdminGroupUser(AdminGroupUserVO vo) throws Exception;
    
    /**
	 * admin_group_user 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return admin_group_user 목록
	 * @exception Exception
	 */
    List selectAdminGroupUserList(AdminDefaultVO searchVO) throws Exception;
    
    /**
	 * admin_group_user 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return admin_group_user 총 갯수
	 * @exception
	 */
    int selectAdminGroupUserListTotCnt(AdminDefaultVO searchVO);
    
}
