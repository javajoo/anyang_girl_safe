package com.danusys.platform.west.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.danusys.platform.west.service.AdminSettingVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * @Class Name : AdminSettingDAO.java
 * @Description : AdminSetting DAO Class
 * @Modification Information
 *
 * @author 김하울
 * @since 2018-02-09
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("adminSettingDAO")
public class AdminSettingDAO extends EgovAbstractDAO {
    /**
     * AdminSettingUser 목록을 조회한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return AdminSettingUser 목록
     * @exception Exception
     */
    public List<?> selectAdminSettingUserList(AdminSettingVO vo) throws Exception {
        return list("adminSettingDAO.selectAdminSettingUserList", vo);
    }

    /**
     * AdminSettingUser 총 갯수를 조회한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return AdminSettingUser 총 갯수
     * @exception
     */
    public int selectAdminSettingUserListTotCnt(AdminSettingVO vo) {
        return (Integer)select("adminSettingDAO.selectAdminSettingUserListTotCnt", vo);
    }
}
