package com.danusys.platform.user.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import com.danusys.platform.user.service.AdminGroupAuthLvlVO;
import com.danusys.platform.user.service.AdminGroupAuthLvlDefaultVO;

/**
 * @Class Name : AdminGroupAuthLvlDAO.java
 * @Description : AdminGroupAuthLvl DAO Class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-06
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("adminGroupAuthLvlDAO")
public class AdminGroupAuthLvlDAO extends EgovAbstractDAO {

	/**
	 * admin_group_auth_lvl을 등록한다.
	 * @param vo - 등록할 정보가 담긴 AdminGroupAuthLvlVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertAdminGroupAuthLvl(AdminGroupAuthLvlVO vo) throws Exception {
        return (String)insert("adminGroupAuthLvlDAO.insertAdminGroupAuthLvl_S", vo);
    }

    /**
	 * admin_group_auth_lvl을 수정한다.
	 * @param vo - 수정할 정보가 담긴 AdminGroupAuthLvlVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateAdminGroupAuthLvl(AdminGroupAuthLvlVO vo) throws Exception {
        update("adminGroupAuthLvlDAO.updateAdminGroupAuthLvl_S", vo);
    }

    /**
	 * admin_group_auth_lvl을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 AdminGroupAuthLvlVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteAdminGroupAuthLvl(AdminGroupAuthLvlVO vo) throws Exception {
        delete("adminGroupAuthLvlDAO.deleteAdminGroupAuthLvl_S", vo);
    }

    /**
	 * admin_group_auth_lvl을 조회한다.
	 * @param vo - 조회할 정보가 담긴 AdminGroupAuthLvlVO
	 * @return 조회한 admin_group_auth_lvl
	 * @exception Exception
	 */
    public AdminGroupAuthLvlVO selectAdminGroupAuthLvl(AdminGroupAuthLvlVO vo) throws Exception {
        return (AdminGroupAuthLvlVO) select("adminGroupAuthLvlDAO.selectAdminGroupAuthLvl_S", vo);
    }

    /**
	 * admin_group_auth_lvl 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return admin_group_auth_lvl 목록
	 * @exception Exception
	 */
    public List<?> selectAdminGroupAuthLvlList(AdminGroupAuthLvlDefaultVO searchVO) throws Exception {
        return list("adminGroupAuthLvlDAO.selectAdminGroupAuthLvlList_D", searchVO);
    }

    /**
	 * admin_group_auth_lvl 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return admin_group_auth_lvl 총 갯수
	 * @exception
	 */
    public int selectAdminGroupAuthLvlListTotCnt(AdminGroupAuthLvlDefaultVO searchVO) {
        return (Integer)select("adminGroupAuthLvlDAO.selectAdminGroupAuthLvlListTotCnt_S", searchVO);
    }

}
