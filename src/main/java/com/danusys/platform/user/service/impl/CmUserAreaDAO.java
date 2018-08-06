package com.danusys.platform.user.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

import com.danusys.platform.user.service.AdminDefaultVO;
import com.danusys.platform.user.service.CmUserAreaVO;
import com.danusys.platform.user.service.CmUserAreaDefaultVO;

/**
 * @Class Name : CmUserAreaDAO.java
 * @Description : CmUserArea DAO Class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-10
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("cmUserAreaDAO")
public class CmUserAreaDAO extends EgovAbstractDAO {

	/**
	 * cm_user_area을 등록한다.
	 * @param vo - 등록할 정보가 담긴 CmUserAreaVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertCmUserArea(CmUserAreaVO vo) throws Exception {
        return (String)insert("cmUserAreaDAO.insertCmUserArea_S", vo);
    }

    /**
	 * cm_user_area을 수정한다.
	 * @param vo - 수정할 정보가 담긴 CmUserAreaVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateCmUserArea(CmUserAreaVO vo) throws Exception {
        update("cmUserAreaDAO.updateCmUserArea_S", vo);
    }

    /**
	 * cm_user_area을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 CmUserAreaVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteCmUserArea(CmUserAreaVO vo) throws Exception {
        delete("cmUserAreaDAO.deleteCmUserArea_S", vo);
    }

    /**
	 * cm_user_area을 조회한다.
	 * @param vo - 조회할 정보가 담긴 CmUserAreaVO
	 * @return 조회한 cm_user_area
	 * @exception Exception
	 */
    public CmUserAreaVO selectCmUserArea(CmUserAreaVO vo) throws Exception {
        return (CmUserAreaVO) select("cmUserAreaDAO.selectCmUserArea_S", vo);
    }

    /**
	 * cm_user_area 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return cm_user_area 목록
	 * @exception Exception
	 */
    public List<?> selectCmUserAreaList(AdminDefaultVO searchVO) throws Exception {
        return list("cmUserAreaDAO.selectCmUserAreaList_D2", searchVO);
    }

    /**
	 * cm_user_area 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return cm_user_area 총 갯수
	 * @exception
	 */
    public int selectCmUserAreaListTotCnt(AdminDefaultVO searchVO) {
        return (Integer)select("cmUserAreaDAO.selectCmUserAreaListTotCnt_S", searchVO);
    }

}
