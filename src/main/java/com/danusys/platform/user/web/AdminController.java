/*package com.danusys.platform.user.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import com.danusys.platform.user.service.AdminService;
import com.danusys.platform.user.service.AdminDefaultVO;
import com.danusys.platform.user.service.AdminVO;

*//**
 * @Class Name : AdminController.java
 * @Description : Admin Controller class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-06
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 *//*

@Controller
@SessionAttributes(types=AdminVO.class)
public class AdminController {

    @Resource(name = "adminService")
    private AdminService adminService;
    
    *//** EgovPropertyService *//*
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    *//**
	 * admin 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 AdminDefaultVO
	 * @return "/admin/AdminList"
	 * @exception Exception
	 *//*
    @RequestMapping(value="/admin/AdminList.do")
    public String selectAdminList(@ModelAttribute("searchVO") AdminDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	
    	*//** EgovPropertyService.sample *//*
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	*//** pageing *//*
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List<?> adminList = adminService.selectAdminList(searchVO);
        model.addAttribute("resultList", adminList);
        
        int totCnt = adminService.selectAdminListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/admin/AdminList";
    } 
    
    @RequestMapping("/admin/addAdminView.do")
    public String addAdminView(
            @ModelAttribute("searchVO") AdminDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("adminVO", new AdminVO());
        return "/admin/AdminRegister";
    }
    
    @RequestMapping("/admin/addAdmin.do")
    public String addAdmin(
            AdminVO adminVO,
            @ModelAttribute("searchVO") AdminDefaultVO searchVO, SessionStatus status)
            throws Exception {
        adminService.insertAdmin(adminVO);
        status.setComplete();
        return "forward:/admin/AdminList.do";
    }
    
    @RequestMapping("/admin/updateAdminView.do")
    public String updateAdminView(
            @RequestParam("seqNo") int seqNo ,
            @ModelAttribute("searchVO") AdminDefaultVO searchVO, Model model)
            throws Exception {
        AdminVO adminVO = new AdminVO();
        adminVO.setSeqNo(seqNo);        
        // 변수명은 CoC 에 따라 adminVO
        model.addAttribute(selectAdmin(adminVO, searchVO));
        return "/admin/AdminRegister";
    }

    @RequestMapping("/admin/selectAdmin.do")
    public @ModelAttribute("adminVO")
    AdminVO selectAdmin(
            AdminVO adminVO,
            @ModelAttribute("searchVO") AdminDefaultVO searchVO) throws Exception {
        return adminService.selectAdmin(adminVO);
    }

    @RequestMapping("/admin/updateAdmin.do")
    public String updateAdmin(
            AdminVO adminVO,
            @ModelAttribute("searchVO") AdminDefaultVO searchVO, SessionStatus status)
            throws Exception {
        adminService.updateAdmin(adminVO);
        status.setComplete();
        return "forward:/admin/AdminList.do";
    }
    
    @RequestMapping("/admin/deleteAdmin.do")
    public String deleteAdmin(
            AdminVO adminVO,
            @ModelAttribute("searchVO") AdminDefaultVO searchVO, SessionStatus status)
            throws Exception {
        adminService.deleteAdmin(adminVO);
        status.setComplete();
        return "forward:/admin/AdminList.do";
    }

}
*/