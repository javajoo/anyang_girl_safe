/*package com.danusys.platform.user.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import com.danusys.platform.user.service.AdminVO;
import com.danusys.platform.user.service.AdminDefaultVO;

*//**
 * @Class Name : AdminDAO.java
 * @Description : Admin DAO Class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-06
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 *//*

@Repository("adminDAO")
public class AdminDAO extends EgovAbstractDAO {

	*//**
	 * admin을 등록한다.
	 * @param vo - 등록할 정보가 담긴 AdminVO
	 * @return 등록 결과
	 * @exception Exception
	 *//*
    public String insertAdmin(AdminVO vo) throws Exception {
        return (String)insert("adminDAO.insertAdmin_S", vo);
    }

    *//**
	 * admin을 수정한다.
	 * @param vo - 수정할 정보가 담긴 AdminVO
	 * @return void형
	 * @exception Exception
	 *//*
    public void updateAdmin(AdminVO vo) throws Exception {
        update("adminDAO.updateAdmin_S", vo);
    }

    *//**
	 * admin을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 AdminVO
	 * @return void형 
	 * @exception Exception
	 *//*
    public void deleteAdmin(AdminVO vo) throws Exception {
        delete("adminDAO.deleteAdmin_S", vo);
    }

    *//**
	 * admin을 조회한다.
	 * @param vo - 조회할 정보가 담긴 AdminVO
	 * @return 조회한 admin
	 * @exception Exception
	 *//*
    public AdminVO selectAdmin(AdminVO vo) throws Exception {
        return (AdminVO) select("adminDAO.selectAdmin_S", vo);
    }

    *//**
	 * admin 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return admin 목록
	 * @exception Exception
	 *//*
    public List<?> selectAdminList(AdminDefaultVO searchVO) throws Exception {
        return list("adminDAO.selectAdminList_D", searchVO);
    }

    *//**
	 * admin 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return admin 총 갯수
	 * @exception
	 *//*
    public int selectAdminListTotCnt(AdminDefaultVO searchVO) {
        return (Integer)select("adminDAO.selectAdminListTotCnt_S", searchVO);
    }

}
*/