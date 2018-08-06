package com.danusys.platform.gis.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.danusys.platform.gis.service.CctvTreeService;
import com.danusys.platform.gis.service.CctvTreeVO;
import com.danusys.platform.vo.AdminVo;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @Class Name : CctvTreeController.java
 * @Description : CctvTree Controller class
 * @Modification Information
 *
 * @author 신대영
 * @since 2016-08-03
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class CctvTreeController {

    @Resource(name = "cctvTreeService")
    private CctvTreeService cctvTreeService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @RequestMapping("/selectCctvTreeList.do")
    public @ResponseBody List<?> selectCctvTree(CctvTreeVO vo) throws Exception {
        return this.cctvTreeService.selectCctvTree(vo);
    }
    
    @RequestMapping(value = "/printPageLog.do")
	public void getMgtPrintPageLog(){
		// 로그
    	System.out.println("printPageLog controller");
    	cctvTreeService.getMgtPrintPageLog();
	}

	@RequestMapping(value = "/printPage.do")
	public String getMgtPrintPage(HttpServletRequest request, ModelMap model){
		AdminVo user = (AdminVo) request.getSession().getAttribute("admin");//EgovUserDetailsHelper.isAuthenticated()? (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser():null;
	    if(/*EgovUserDetailsHelper.isAuthenticated() && */user!=null){ // 인증된 경우는 메인 페이지로 이동
			return "print";
	    }else{
			return "login";
	    }		
	}

	@RequestMapping(value = "/printMapPage.do")
	public String getMgtPrintMapPage(HttpServletRequest request, ModelMap model){
		AdminVo user = (AdminVo) request.getSession().getAttribute("admin");//EgovUserDetailsHelper.isAuthenticated()? (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser():null;
		/*LoginVO user = EgovUserDetailsHelper.isAuthenticated()? (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser():null;*/
	    if(/*EgovUserDetailsHelper.isAuthenticated() && */user!=null){ // 인증된 경우는 메인 페이지로 이동
			return "printMap";
	    }else{
			return "login";
	    }		
	}
}
