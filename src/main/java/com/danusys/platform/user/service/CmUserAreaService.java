package com.danusys.platform.user.service;

import java.util.List;
import com.danusys.platform.user.service.CmUserAreaDefaultVO;
import com.danusys.platform.user.service.CmUserAreaVO;

/**
 * @Class Name : CmUserAreaService.java
 * @Description : CmUserArea Business class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-10
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface CmUserAreaService {
	
	/**
	 * cm_user_area을 등록한다.
	 * @param vo - 등록할 정보가 담긴 CmUserAreaVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertCmUserArea(CmUserAreaVO vo) throws Exception;
    
    /**
	 * cm_user_area을 수정한다.
	 * @param vo - 수정할 정보가 담긴 CmUserAreaVO
	 * @return void형
	 * @exception Exception
	 */
    void updateCmUserArea(CmUserAreaVO vo) throws Exception;
    
    /**
	 * cm_user_area을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 CmUserAreaVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteCmUserArea(CmUserAreaVO vo) throws Exception;
    
    /**
	 * cm_user_area을 조회한다.
	 * @param vo - 조회할 정보가 담긴 CmUserAreaVO
	 * @return 조회한 cm_user_area
	 * @exception Exception
	 */
    CmUserAreaVO selectCmUserArea(CmUserAreaVO vo) throws Exception;
    
    /**
	 * cm_user_area 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return cm_user_area 목록
	 * @exception Exception
	 */
    List selectCmUserAreaList(AdminDefaultVO searchVO) throws Exception;
    
    /**
	 * cm_user_area 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return cm_user_area 총 갯수
	 * @exception
	 */
    int selectCmUserAreaListTotCnt(AdminDefaultVO searchVO);
    
}
