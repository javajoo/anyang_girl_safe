package com.danusys.platform.west.service;

import java.util.List;

import com.danusys.platform.west.service.AdminSettingVO;

/**
 * @Class Name : AdminSettingService.java
 * @Description : AdminSetting Business class
 * @Modification Information
 *
 * @author 김하울
 * @since 2018-02-09
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface AdminSettingService {
    
    /**
     * AdminSettingUser 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 AdminSettingVO
     * @return AdminSettingUser 목록
     * @exception Exception
     */
    List<?> selectAdminSettingUserList(AdminSettingVO vo) throws Exception;
    
    /**
     * AdminSettingUser 총 갯수를 조회한다.
     * @param searchVO - 조회할 정보가 담긴 AdminSettingVO
     * @return AdminSettingUser 총 갯수
     * @exception
     */
    int selectAdminSettingUserListTotCnt(AdminSettingVO vo);
}
