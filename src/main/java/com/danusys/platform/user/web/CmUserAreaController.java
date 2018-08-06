package com.danusys.platform.user.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import com.danusys.platform.user.service.AdminDefaultVO;
import com.danusys.platform.user.service.CmUserAreaService;
import com.danusys.platform.user.service.CmUserAreaDefaultVO;
import com.danusys.platform.user.service.CmUserAreaVO;

/**
 * @Class Name : CmUserAreaController.java
 * @Description : CmUserArea Controller class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-10
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=CmUserAreaVO.class)
public class CmUserAreaController {

    @Resource(name = "cmUserAreaService")
    private CmUserAreaService cmUserAreaService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * cm_user_area 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 AdminDefaultVO
	 * @return "/cmUserArea/CmUserAreaList"
	 * @exception Exception
	 */
    @RequestMapping(value="/com/danusys/platform/user/CmUserAreaList.do")
    public @ResponseBody Map<String, Object> selectCmUserAreaList(@ModelAttribute("searchVO") AdminDefaultVO searchVO) throws Exception {
    	
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
		
        List<?> cmUserAreaList = cmUserAreaService.selectCmUserAreaList(searchVO);
        //model.addAttribute("resultList", cmUserAreaList);
        
        int totCnt = cmUserAreaService.selectCmUserAreaListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        //model.addAttribute("paginationInfo", paginationInfo);
        
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("rows", cmUserAreaList);
        map.put("total", totCnt);
        
        return map;
    } 
    
    @RequestMapping("/cmUserArea/addCmUserAreaView.do")
    public String addCmUserAreaView(
            @ModelAttribute("searchVO") CmUserAreaDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("cmUserAreaVO", new CmUserAreaVO());
        return "/cmUserArea/CmUserAreaRegister";
    }
    
    @RequestMapping("/cmUserArea/addCmUserArea.do")
    public String addCmUserArea(
            CmUserAreaVO cmUserAreaVO,
            @ModelAttribute("searchVO") CmUserAreaDefaultVO searchVO, SessionStatus status)
            throws Exception {
        cmUserAreaService.insertCmUserArea(cmUserAreaVO);
        status.setComplete();
        return "forward:/cmUserArea/CmUserAreaList.do";
    }
    
    @RequestMapping("/cmUserArea/updateCmUserAreaView.do")
    public String updateCmUserAreaView(
            @RequestParam("areaCd") java.lang.String areaCd ,
            @ModelAttribute("searchVO") CmUserAreaDefaultVO searchVO, Model model)
            throws Exception {
        CmUserAreaVO cmUserAreaVO = new CmUserAreaVO();
        cmUserAreaVO.setAreaCd(areaCd);        
        // 변수명은 CoC 에 따라 cmUserAreaVO
        model.addAttribute(selectCmUserArea(cmUserAreaVO, searchVO));
        return "/cmUserArea/CmUserAreaRegister";
    }

    @RequestMapping("/cmUserArea/selectCmUserArea.do")
    public @ModelAttribute("cmUserAreaVO")
    CmUserAreaVO selectCmUserArea(
            CmUserAreaVO cmUserAreaVO,
            @ModelAttribute("searchVO") CmUserAreaDefaultVO searchVO) throws Exception {
        return cmUserAreaService.selectCmUserArea(cmUserAreaVO);
    }

    @RequestMapping("/cmUserArea/updateCmUserArea.do")
    public String updateCmUserArea(
            CmUserAreaVO cmUserAreaVO,
            @ModelAttribute("searchVO") CmUserAreaDefaultVO searchVO, SessionStatus status)
            throws Exception {
        cmUserAreaService.updateCmUserArea(cmUserAreaVO);
        status.setComplete();
        return "forward:/cmUserArea/CmUserAreaList.do";
    }
    
    @RequestMapping("/cmUserArea/deleteCmUserArea.do")
    public String deleteCmUserArea(
            CmUserAreaVO cmUserAreaVO,
            @ModelAttribute("searchVO") CmUserAreaDefaultVO searchVO, SessionStatus status)
            throws Exception {
        cmUserAreaService.deleteCmUserArea(cmUserAreaVO);
        status.setComplete();
        return "forward:/cmUserArea/CmUserAreaList.do";
    }

}
