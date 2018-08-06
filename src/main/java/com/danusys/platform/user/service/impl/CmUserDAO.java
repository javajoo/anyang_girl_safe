package com.danusys.platform.user.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

import com.danusys.platform.user.service.AdminDefaultVO;
import com.danusys.platform.user.service.CmUserVO;

/**
 * @Class Name : CmUserDAO.java
 * @Description : CmUser DAO Class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("cmUserDAO")
public class CmUserDAO extends EgovAbstractDAO {

	/**
	 * cm_user을 등록한다.
	 * @param vo - 등록할 정보가 담긴 CmUserVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertCmUser(CmUserVO vo) throws Exception {
        return (String)insert("cmUserDAO.insertCmUser_S", vo);
    }

    /**
	 * cm_user을 수정한다.
	 * @param vo - 수정할 정보가 담긴 CmUserVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateCmUser(CmUserVO vo) throws Exception {
        update("cmUserDAO.updateCmUser_S", vo);
    }

    /**
	 * cm_user을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 CmUserVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteCmUser(CmUserVO vo) throws Exception {
        delete("cmUserDAO.deleteCmUser_S", vo);
    }

    /**
	 * cm_user을 조회한다.
	 * @param vo - 조회할 정보가 담긴 CmUserVO
	 * @return 조회한 cm_user
	 * @exception Exception
	 */
    public CmUserVO selectCmUser(CmUserVO vo) throws Exception {
        return (CmUserVO) select("cmUserDAO.selectCmUser_S", vo);
    }

    /**
	 * cm_user 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return cm_user 목록
	 * @exception Exception
	 */
    public List<?> selectCmUserList(AdminDefaultVO searchVO) throws Exception {
        return list("cmUserDAO.selectCmUserList_D", searchVO);
    }

    /**
	 * cm_user 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return cm_user 총 갯수
	 * @exception
	 */
    public int selectCmUserListTotCnt(AdminDefaultVO searchVO) {
        return (Integer)select("cmUserDAO.selectCmUserListTotCnt_S", searchVO);
    }

}
