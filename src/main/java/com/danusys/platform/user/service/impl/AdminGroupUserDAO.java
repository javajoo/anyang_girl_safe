package com.danusys.platform.user.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import com.danusys.platform.user.service.AdminGroupUserVO;
import com.danusys.platform.user.service.AdminDefaultVO;

/**
 * @Class Name : AdminGroupUserDAO.java
 * @Description : AdminGroupUser DAO Class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-06
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("adminGroupUserDAO")
public class AdminGroupUserDAO extends EgovAbstractDAO {

	/**
	 * admin_group_user을 등록한다.
	 * @param vo - 등록할 정보가 담긴 AdminGroupUserVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertAdminGroupUser(AdminGroupUserVO vo) throws Exception {
        return (String)insert("adminGroupUserDAO.insertAdminGroupUser_S", vo);
    }

    /**
	 * admin_group_user을 수정한다.
	 * @param vo - 수정할 정보가 담긴 AdminGroupUserVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateAdminGroupUser(AdminGroupUserVO vo) throws Exception {
        update("adminGroupUserDAO.updateAdminGroupUser_S", vo);
    }

    /**
	 * admin_group_user을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 AdminGroupUserVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteAdminGroupUser(AdminGroupUserVO vo) throws Exception {
        delete("adminGroupUserDAO.deleteAdminGroupUser_S", vo);
    }

    /**
	 * admin_group_user을 조회한다.
	 * @param vo - 조회할 정보가 담긴 AdminGroupUserVO
	 * @return 조회한 admin_group_user
	 * @exception Exception
	 */
    public AdminGroupUserVO selectAdminGroupUser(AdminGroupUserVO vo) throws Exception {
        return (AdminGroupUserVO) select("adminGroupUserDAO.selectAdminGroupUser_S", vo);
    }

    /**
	 * admin_group_user 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return admin_group_user 목록
	 * @exception Exception
	 */
    public List<?> selectAdminGroupUserList(AdminDefaultVO searchVO) throws Exception {
        return list("adminGroupUserDAO.selectAdminGroupUserList_D2", searchVO);
    }

    /**
	 * admin_group_user 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return admin_group_user 총 갯수
	 * @exception
	 */
    public int selectAdminGroupUserListTotCnt(AdminDefaultVO searchVO) {
        return (Integer)select("adminGroupUserDAO.selectAdminGroupUserListTotCnt_S", searchVO);
    }

}
