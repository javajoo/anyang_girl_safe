package com.danusys.platform.west.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.danusys.platform.west.service.AdminSettingVO;
import com.danusys.platform.west.service.AdminSettingService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : AdminSettingServiceImpl.java
 * @Description : AdminSetting Business Implement class
 * @Modification Information
 *
 * @author 김하울
 * @since 2018-02-09
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("adminSettingService")
public class AdminSettingServiceImpl extends EgovAbstractServiceImpl implements AdminSettingService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(AdminSettingServiceImpl.class);

    @Resource(name="adminSettingDAO")
    private AdminSettingDAO adminSettingDAO;
    
    /**
     * AdminSettingUser 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 AdminSettingVO
     * @return AdminSettingUser 목록
     * @exception Exception
     */
    public List<?> selectAdminSettingUserList(AdminSettingVO vo) throws Exception {
        return adminSettingDAO.selectAdminSettingUserList(vo);
    }

    /**
     * AdminSettingUser 총 갯수를 조회한다.
     * @param searchVO - 조회할 정보가 담긴 AdminSettingVO
     * @return AdminSettingUser 총 갯수
     * @exception
     */
    public int selectAdminSettingUserListTotCnt(AdminSettingVO vo) {
        return adminSettingDAO.selectAdminSettingUserListTotCnt(vo);
    }
}
