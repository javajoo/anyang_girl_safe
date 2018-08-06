package com.danusys.platform.user.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import com.danusys.platform.user.service.AdminGroupService;
import com.danusys.platform.user.service.AdminGroupDefaultVO;
import com.danusys.platform.user.service.AdminGroupVO;

/**
 * @Class Name : AdminGroupController.java
 * @Description : AdminGroup Controller class
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
@SessionAttributes(types=AdminGroupVO.class)
public class AdminGroupController {

    @Resource(name = "adminGroupService")
    private AdminGroupService adminGroupService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    @SuppressWarnings("unchecked")
    @RequestMapping(value="/adminGroup/AdminGroupALL.do")
    public  @ResponseBody List<?> selectAdminGroupTest(@ModelAttribute("searchVO") AdminGroupDefaultVO searchVO) throws Exception {
        return (List<EgovMap>) this.adminGroupService.selectAdminGroupList(searchVO);
    }	
    /**
	 * admin_group 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 AdminGroupDefaultVO
	 * @return "/adminGroup/AdminGroupList"
	 * @exception Exception
	 */
    @RequestMapping(value="/adminGroup/AdminGroupList.do")
    public @ResponseBody Map<String, Object> selectAdminGroupList(@ModelAttribute("searchVO") AdminGroupDefaultVO searchVO, HttpServletRequest request) throws Exception {
        
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	searchVO.setPageIndex(searchVO.getPageIndex());
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List<?> adminGroupList = adminGroupService.selectAdminGroupList(searchVO);
        //model.addAttribute("resultList", adminGroupList);
        
        int totCnt = adminGroupService.selectAdminGroupListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        //model.addAttribute("paginationInfo", paginationInfo);
        
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("rows", adminGroupList);
        map.put("total", totCnt);
        
        return map;
    } 
    
    @RequestMapping("/adminGroup/addAdminGroupView.do")
    public String addAdminGroupView(
            @ModelAttribute("searchVO") AdminGroupDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("adminGroupVO", new AdminGroupVO());
        return "/adminGroup/AdminGroupRegister";
    }
    
    @RequestMapping("/adminGroup/addAdminGroup.do")
    public String addAdminGroup(
            AdminGroupVO adminGroupVO,
            @ModelAttribute("searchVO") AdminGroupDefaultVO searchVO, SessionStatus status)
            throws Exception {
        adminGroupService.insertAdminGroup(adminGroupVO);
        status.setComplete();
        return "forward:/adminGroup/AdminGroupList.do";
    }
    
    @RequestMapping("/adminGroup/updateAdminGroupView.do")
    public String updateAdminGroupView(
            @RequestParam("grpId") java.lang.String grpId ,
            @ModelAttribute("searchVO") AdminGroupDefaultVO searchVO, Model model)
            throws Exception {
        AdminGroupVO adminGroupVO = new AdminGroupVO();
        adminGroupVO.setGrpId(grpId);
        // 변수명은 CoC 에 따라 adminGroupVO
        model.addAttribute(selectAdminGroup(adminGroupVO, searchVO));
        return "/adminGroup/AdminGroupRegister";
    }

    @RequestMapping("/adminGroup/selectAdminGroup.do")
    public @ModelAttribute("adminGroupVO")
    AdminGroupVO selectAdminGroup(
            AdminGroupVO adminGroupVO,
            @ModelAttribute("searchVO") AdminGroupDefaultVO searchVO) throws Exception {
        return adminGroupService.selectAdminGroup(adminGroupVO);
    }

    @RequestMapping("/adminGroup/updateAdminGroup.do")
    public String updateAdminGroup(
            AdminGroupVO adminGroupVO,
            @ModelAttribute("searchVO") AdminGroupDefaultVO searchVO, SessionStatus status)
            throws Exception {
        adminGroupService.updateAdminGroup(adminGroupVO);
        status.setComplete();
        return "forward:/adminGroup/AdminGroupList.do";
    }
    
    @RequestMapping("/adminGroup/deleteAdminGroup.do")
    public String deleteAdminGroup(
            AdminGroupVO adminGroupVO,
            @ModelAttribute("searchVO") AdminGroupDefaultVO searchVO, SessionStatus status)
            throws Exception {
        adminGroupService.deleteAdminGroup(adminGroupVO);
        status.setComplete();
        return "forward:/adminGroup/AdminGroupList.do";
    }

}
