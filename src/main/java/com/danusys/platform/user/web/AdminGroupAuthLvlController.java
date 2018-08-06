package com.danusys.platform.user.web;

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

import com.danusys.platform.user.service.AdminGroupAuthLvlDefaultVO;
import com.danusys.platform.user.service.AdminGroupAuthLvlService;
import com.danusys.platform.user.service.AdminGroupAuthLvlVO;

/**
 * @Class Name : AdminGroupAuthLvlController.java
 * @Description : AdminGroupAuthLvl Controller class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-06
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=AdminGroupAuthLvlVO.class)
public class AdminGroupAuthLvlController {

    @Resource(name = "adminGroupAuthLvlService")
    private AdminGroupAuthLvlService adminGroupAuthLvlService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * admin_group_auth_lvl 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 AdminGroupAuthLvlDefaultVO
	 * @return "/adminGroupAuthLvl/AdminGroupAuthLvlList"
	 * @exception Exception
	 */
    @RequestMapping(value="/adminGroupAuthLvl/AdminGroupAuthLvlList.do")
    public String selectAdminGroupAuthLvlList(@ModelAttribute("searchVO") AdminGroupAuthLvlDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List<?> adminGroupAuthLvlList = adminGroupAuthLvlService.selectAdminGroupAuthLvlList(searchVO);
        model.addAttribute("resultList", adminGroupAuthLvlList);
        
        int totCnt = adminGroupAuthLvlService.selectAdminGroupAuthLvlListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/adminGroupAuthLvl/AdminGroupAuthLvlList";
    } 
    
    @RequestMapping("/adminGroupAuthLvl/addAdminGroupAuthLvlView.do")
    public String addAdminGroupAuthLvlView(
            @ModelAttribute("searchVO") AdminGroupAuthLvlDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("adminGroupAuthLvlVO", new AdminGroupAuthLvlVO());
        return "/adminGroupAuthLvl/AdminGroupAuthLvlRegister";
    }
    
    @RequestMapping("/adminGroupAuthLvl/addAdminGroupAuthLvl.do")
    public String addAdminGroupAuthLvl(
            AdminGroupAuthLvlVO adminGroupAuthLvlVO,
            @ModelAttribute("searchVO") AdminGroupAuthLvlDefaultVO searchVO, SessionStatus status)
            throws Exception {
        adminGroupAuthLvlService.insertAdminGroupAuthLvl(adminGroupAuthLvlVO);
        status.setComplete();
        return "forward:/adminGroupAuthLvl/AdminGroupAuthLvlList.do";
    }
    
    @RequestMapping("/adminGroupAuthLvl/updateAdminGroupAuthLvlView.do")
    public String updateAdminGroupAuthLvlView(
            @RequestParam("seqNo") int seqNo ,
            @ModelAttribute("searchVO") AdminGroupAuthLvlDefaultVO searchVO, Model model)
            throws Exception {
        AdminGroupAuthLvlVO adminGroupAuthLvlVO = new AdminGroupAuthLvlVO();
        adminGroupAuthLvlVO.setSeqNo(seqNo);        
        // 변수명은 CoC 에 따라 adminGroupAuthLvlVO
        model.addAttribute(selectAdminGroupAuthLvl(adminGroupAuthLvlVO, searchVO));
        return "/adminGroupAuthLvl/AdminGroupAuthLvlRegister";
    }

    @RequestMapping("/adminGroupAuthLvl/selectAdminGroupAuthLvl.do")
    public @ModelAttribute("adminGroupAuthLvlVO")
    AdminGroupAuthLvlVO selectAdminGroupAuthLvl(
            AdminGroupAuthLvlVO adminGroupAuthLvlVO,
            @ModelAttribute("searchVO") AdminGroupAuthLvlDefaultVO searchVO) throws Exception {
        return adminGroupAuthLvlService.selectAdminGroupAuthLvl(adminGroupAuthLvlVO);
    }

    @RequestMapping("/adminGroupAuthLvl/updateAdminGroupAuthLvl.do")
    public String updateAdminGroupAuthLvl(
            AdminGroupAuthLvlVO adminGroupAuthLvlVO,
            @ModelAttribute("searchVO") AdminGroupAuthLvlDefaultVO searchVO, SessionStatus status)
            throws Exception {
        adminGroupAuthLvlService.updateAdminGroupAuthLvl(adminGroupAuthLvlVO);
        status.setComplete();
        return "forward:/adminGroupAuthLvl/AdminGroupAuthLvlList.do";
    }
    
    @RequestMapping("/adminGroupAuthLvl/deleteAdminGroupAuthLvl.do")
    public String deleteAdminGroupAuthLvl(
            AdminGroupAuthLvlVO adminGroupAuthLvlVO,
            @ModelAttribute("searchVO") AdminGroupAuthLvlDefaultVO searchVO, SessionStatus status)
            throws Exception {
        adminGroupAuthLvlService.deleteAdminGroupAuthLvl(adminGroupAuthLvlVO);
        status.setComplete();
        return "forward:/adminGroupAuthLvl/AdminGroupAuthLvlList.do";
    }

}
