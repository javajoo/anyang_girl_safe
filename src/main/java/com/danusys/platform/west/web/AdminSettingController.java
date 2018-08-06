package com.danusys.platform.west.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.danusys.platform.west.service.AdminSettingVO;
import com.danusys.platform.west.service.AdminSettingService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : AdminSettingController.java
 * @Description : AdminSetting Controller class
 * @Modification Information
 *
 * @author 김하울
 * @since 2018-02-09
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class AdminSettingController {
    
    @Resource(name = "adminSettingService")
    private AdminSettingService adminSettingService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	/* 환결설정 - 사용자관리 조회*/
	@RequestMapping(value="/com/danusys/platform/selectAdminSettingUserList.do")
    public @ResponseBody Map<String, Object> selectAdminSettingUserList(AdminSettingVO vo, HttpServletRequest request) throws Exception {
        
        vo.setPageUnit(propertiesService.getInt("pageUnit"));
        vo.setPageIndex(vo.getPage());
        
        Map<String , Object> map = new HashMap<String ,  Object>();

        /** pageing */
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(vo.getPageIndex());
        paginationInfo.setRecordCountPerPage(vo.getPageSize());
        paginationInfo.setPageSize(vo.getPageSize());
        
        vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
        vo.setLastIndex(paginationInfo.getLastRecordIndex());
        vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        List<?> list = adminSettingService.selectAdminSettingUserList(vo);
        int totCnt = adminSettingService.selectAdminSettingUserListTotCnt(vo);
        paginationInfo.setTotalRecordCount(totCnt);
        
        map.put("rows", list);
        map.put("total", totCnt);
        
        return map;
    }
}
