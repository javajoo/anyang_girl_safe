package com.danusys.platform.user.service;

import java.util.List;
import com.danusys.platform.user.service.AdminDefaultVO;
import com.danusys.platform.user.service.AdminVO;

/**
 * @Class Name : AdminService.java
 * @Description : Admin Business class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-06
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface AdminService {
	
	/**
	 * admin을 등록한다.
	 * @param vo - 등록할 정보가 담긴 AdminVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertAdmin(AdminVO vo) throws Exception;
    
    /**
	 * admin을 수정한다.
	 * @param vo - 수정할 정보가 담긴 AdminVO
	 * @return void형
	 * @exception Exception
	 */
    void updateAdmin(AdminVO vo) throws Exception;
    
    /**
	 * admin을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 AdminVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteAdmin(AdminVO vo) throws Exception;
    
    /**
	 * admin을 조회한다.
	 * @param vo - 조회할 정보가 담긴 AdminVO
	 * @return 조회한 admin
	 * @exception Exception
	 */
    AdminVO selectAdmin(AdminVO vo) throws Exception;
    
    /**
	 * admin 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return admin 목록
	 * @exception Exception
	 */
    List selectAdminList(AdminDefaultVO searchVO) throws Exception;
    
    /**
	 * admin 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return admin 총 갯수
	 * @exception
	 */
    int selectAdminListTotCnt(AdminDefaultVO searchVO);
    
}
