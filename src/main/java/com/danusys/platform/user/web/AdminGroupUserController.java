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

import com.danusys.platform.user.service.AdminGroupUserService;
import com.danusys.platform.user.service.AdminDefaultVO;
import com.danusys.platform.user.service.AdminGroupUserVO;

/**
 * @Class Name : AdminGroupUserController.java
 * @Description : AdminGroupUser Controller class
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
@SessionAttributes(types=AdminGroupUserVO.class)
public class AdminGroupUserController {

    @Resource(name = "adminGroupUserService")
    private AdminGroupUserService adminGroupUserService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    @SuppressWarnings("unchecked")
    @RequestMapping(value="/com/danusys/platform/user/AdminGroupUserALL.do")
    public  @ResponseBody List<?> selectAdminGroupUserTest(@ModelAttribute("searchVO") AdminDefaultVO searchVO) throws Exception {
        return (List<EgovMap>) this.adminGroupUserService.selectAdminGroupUserList(searchVO);
    }	
    /**
	 * admin_group 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 AdminDefaultVO
	 * @return "/adminGroupUser/AdminGroupUserList"
	 * @exception Exception
	 */
    @RequestMapping(value="/com/danusys/platform/user/AdminGroupUserList.do")
    public @ResponseBody Map<String, Object> selectAdminGroupUserList(@ModelAttribute("searchVO") AdminDefaultVO searchVO, HttpServletRequest request) throws Exception {
        
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	//searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	searchVO.setPageIndex(searchVO.getPage());
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageSize());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List<?> adminGroupUserList = adminGroupUserService.selectAdminGroupUserList(searchVO);
        
        //model.addAttribute("resultList", adminGroupUserList);
        
        int totCnt = adminGroupUserService.selectAdminGroupUserListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        //model.addAttribute("paginationInfo", paginationInfo);
		//System.out.println("searchVO: "+searchVO);
		//System.out.println("adminGroupUserList: "+adminGroupUserList);
		
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("rows", adminGroupUserList);
        map.put("total", totCnt);
        
        return map;
    } 
   
    @RequestMapping("/adminGroupUser/addAdminGroupUserView.do")
    public String addAdminGroupUserView(
            @ModelAttribute("searchVO") AdminDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("AdminGroupUserVO", new AdminGroupUserVO());
        return "/adminGroupUser/AdminGroupUserRegister";
    }
    
    @RequestMapping("/adminGroupUser/addAdminGroupUser.do")
    public String addAdminGroupUser(
            AdminGroupUserVO adminGroupUserVO,
            @ModelAttribute("searchVO") AdminDefaultVO searchVO, SessionStatus status)
            throws Exception {
        adminGroupUserService.insertAdminGroupUser(adminGroupUserVO);
        status.setComplete();
        return "forward:/adminGroup/AdminGroupUserList.do";
    }
    
    @RequestMapping("/adminGroup/updateAdminGroupUserView.do")
    public String updateAdminGroupUserView(
            @RequestParam("grpId") java.lang.String grpId ,
            @ModelAttribute("searchVO") AdminDefaultVO searchVO, Model model)
            throws Exception {
        AdminGroupUserVO adminGroupUserVO = new AdminGroupUserVO();
        adminGroupUserVO.setGrpId(grpId);
        // 변수명은 CoC 에 따라 adminGroupUserVO
        model.addAttribute(selectAdminGroupUser(adminGroupUserVO, searchVO));
        return "/adminGroup/AdminGroupUserRegister";
    }

    @RequestMapping("/adminGroup/selectAdminGroupUser.do")
    public @ModelAttribute("adminGroupUserVO")
    AdminGroupUserVO selectAdminGroupUser(
            AdminGroupUserVO adminGroupUserVO,
            @ModelAttribute("searchVO") AdminDefaultVO searchVO) throws Exception {
        return adminGroupUserService.selectAdminGroupUser(adminGroupUserVO);
    }

    @RequestMapping("/adminGroup/updateAdminGroupUser.do")
    public String updateAdminGroupUser(
            AdminGroupUserVO adminGroupUserVO,
            @ModelAttribute("searchVO") AdminDefaultVO searchVO, SessionStatus status)
            throws Exception {
        adminGroupUserService.updateAdminGroupUser(adminGroupUserVO);
        status.setComplete();
        return "forward:/adminGroup/AdminGroupUserList.do";
    }
    
    @RequestMapping("/adminGroupUser/deleteAdminGroupUser.do")
    public String deleteAdminGroupUser(
            AdminGroupUserVO adminGroupUserVO,
            @ModelAttribute("searchVO") AdminDefaultVO searchVO, SessionStatus status)
            throws Exception {
        adminGroupUserService.deleteAdminGroupUser(adminGroupUserVO);
        status.setComplete();
        return "forward:/adminGroupUser/AdminGroupUserList.do";
    }

}
