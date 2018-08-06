package com.danusys.platform.user.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import com.danusys.platform.user.service.AdminGroupVO;
import com.danusys.platform.user.service.AdminGroupDefaultVO;

/**
 * @Class Name : AdminGroupDAO.java
 * @Description : AdminGroup DAO Class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-06
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("adminGroupDAO")
public class AdminGroupDAO extends EgovAbstractDAO {

	/**
	 * admin_group을 등록한다.
	 * @param vo - 등록할 정보가 담긴 AdminGroupVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertAdminGroup(AdminGroupVO vo) throws Exception {
        return (String)insert("adminGroupDAO.insertAdminGroup_S", vo);
    }

    /**
	 * admin_group을 수정한다.
	 * @param vo - 수정할 정보가 담긴 AdminGroupVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateAdminGroup(AdminGroupVO vo) throws Exception {
        update("adminGroupDAO.updateAdminGroup_S", vo);
    }

    /**
	 * admin_group을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 AdminGroupVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteAdminGroup(AdminGroupVO vo) throws Exception {
        delete("adminGroupDAO.deleteAdminGroup_S", vo);
    }

    /**
	 * admin_group을 조회한다.
	 * @param vo - 조회할 정보가 담긴 AdminGroupVO
	 * @return 조회한 admin_group
	 * @exception Exception
	 */
    public AdminGroupVO selectAdminGroup(AdminGroupVO vo) throws Exception {
        return (AdminGroupVO) select("adminGroupDAO.selectAdminGroup_S", vo);
    }

    /**
	 * admin_group 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return admin_group 목록
	 * @exception Exception
	 */
    public List<?> selectAdminGroupList(AdminGroupDefaultVO searchVO) throws Exception {
        return list("adminGroupDAO.selectAdminGroupList_D", searchVO);
    }

    /**
	 * admin_group 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return admin_group 총 갯수
	 * @exception
	 */
    public int selectAdminGroupListTotCnt(AdminGroupDefaultVO searchVO) {
        return (Integer)select("adminGroupDAO.selectAdminGroupListTotCnt_S", searchVO);
    }

}
