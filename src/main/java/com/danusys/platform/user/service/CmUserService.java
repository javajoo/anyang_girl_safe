package com.danusys.platform.user.service;

import java.util.List;
import com.danusys.platform.user.service.CmUserVO;

/**
 * @Class Name : CmUserService.java
 * @Description : CmUser Business class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface CmUserService {
	
	/**
	 * cm_user을 등록한다.
	 * @param vo - 등록할 정보가 담긴 CmUserVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertCmUser(CmUserVO vo) throws Exception;
    
    /**
	 * cm_user을 수정한다.
	 * @param vo - 수정할 정보가 담긴 CmUserVO
	 * @return void형
	 * @exception Exception
	 */
    void updateCmUser(CmUserVO vo) throws Exception;
    
    /**
	 * cm_user을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 CmUserVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteCmUser(CmUserVO vo) throws Exception;
    
    /**
	 * cm_user을 조회한다.
	 * @param vo - 조회할 정보가 담긴 CmUserVO
	 * @return 조회한 cm_user
	 * @exception Exception
	 */
    CmUserVO selectCmUser(CmUserVO vo) throws Exception;
    
    /**
	 * cm_user 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return cm_user 목록
	 * @exception Exception
	 */
    List selectCmUserList(AdminDefaultVO searchVO) throws Exception;
    
    /**
	 * cm_user 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return cm_user 총 갯수
	 * @exception
	 */
    int selectCmUserListTotCnt(AdminDefaultVO searchVO);
    
}
