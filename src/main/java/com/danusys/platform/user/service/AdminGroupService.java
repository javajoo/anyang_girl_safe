package com.danusys.platform.user.service;

import java.util.List;
import com.danusys.platform.user.service.AdminGroupDefaultVO;
import com.danusys.platform.user.service.AdminGroupVO;

/**
 * @Class Name : AdminGroupService.java
 * @Description : AdminGroup Business class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-06
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface AdminGroupService {
	
	/**
	 * admin_group을 등록한다.
	 * @param vo - 등록할 정보가 담긴 AdminGroupVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertAdminGroup(AdminGroupVO vo) throws Exception;
    
    /**
	 * admin_group을 수정한다.
	 * @param vo - 수정할 정보가 담긴 AdminGroupVO
	 * @return void형
	 * @exception Exception
	 */
    void updateAdminGroup(AdminGroupVO vo) throws Exception;
    
    /**
	 * admin_group을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 AdminGroupVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteAdminGroup(AdminGroupVO vo) throws Exception;
    
    /**
	 * admin_group을 조회한다.
	 * @param vo - 조회할 정보가 담긴 AdminGroupVO
	 * @return 조회한 admin_group
	 * @exception Exception
	 */
    AdminGroupVO selectAdminGroup(AdminGroupVO vo) throws Exception;
    
    /**
	 * admin_group 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return admin_group 목록
	 * @exception Exception
	 */
    List selectAdminGroupList(AdminGroupDefaultVO searchVO) throws Exception;
    
    /**
	 * admin_group 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return admin_group 총 갯수
	 * @exception
	 */
    int selectAdminGroupListTotCnt(AdminGroupDefaultVO searchVO);
    
}
