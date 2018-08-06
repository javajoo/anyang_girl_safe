package com.danusys.platform.west.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import com.danusys.cmm.util.EventUtil;
import com.danusys.platform.helper.HttpHelper;
import com.danusys.platform.vo.AdminVo;
import com.danusys.platform.west.service.GirlSafeService;
import com.danusys.platform.west.service.GirlSafeVO;

import egovframework.com.cmm.LoginVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : EventController.java
 * @Description : Event Controller class
 * @Modification Information
 *
 * @author 김하울
 * @since 2017-12-11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class GirlSafeController {

    @Resource(name = "girlSafeService")
    private GirlSafeService girlSafeService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @RequestMapping(value="/com/danusys/platform/selectUserList.do")
    public @ResponseBody Map<String, Object> selectUserList(GirlSafeVO vo, HttpServletRequest request) throws Exception {
        HttpSession session = request.getSession();        
        AdminVo user = (AdminVo) session.getAttribute("admin");
        /** EgovPropertyService.sample */
        vo.setPageUnit(propertiesService.getInt("pageUnit"));
        //vo.setPageSize(propertiesService.getInt("pageSize")); //공통 아닌 파라미터로 가져오기
        vo.setPageIndex(vo.getPage());
        
        System.out.println("세션아이디 :: "+session.getId());
        Map<String , Object> map = new HashMap<String ,  Object>();
        if(user!=null){
            /** pageing */
            PaginationInfo paginationInfo = new PaginationInfo();
            paginationInfo.setCurrentPageNo(vo.getPageIndex());
            //paginationInfo.setRecordCountPerPage(vo.getPageUnit());
            /* vo.getPageUnit() -> vo.getPageSize() 변경
             * 공통이 아닌 파라미터로 가져오기
             * */
            paginationInfo.setRecordCountPerPage(vo.getPageSize());
            paginationInfo.setPageSize(vo.getPageSize());
            
            vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
            vo.setLastIndex(paginationInfo.getLastRecordIndex());
            vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
            
            vo.setKey(propertiesService.getString("AES_KEY"));
            
            List<?> list = girlSafeService.selectUserList(vo);
            
            
            
            //List<EgovMap> list = (List<EgovMap>) userService.selectEventList(vo);
            int totCnt = girlSafeService.selectUserListTotCnt(vo);
            List<EgovMap> list2 = new ArrayList<EgovMap>();
            
//            for(EgovMap map2 : (List<EgovMap>)list){
//                map2.get("eventNo");
//                
//                String castNet = "<a href='#' class='row_handle' onclick='row_handle(\""+map2.get("eventNo")+"\")'/>";
//                map2.put("castNet", castNet);
//                list2.add(map2);
//            }
            paginationInfo.setTotalRecordCount(totCnt);
            
            //Map<String, Object> map = new HashMap<String, Object>();
            System.out.println("씨발 탄다고?");
            map.put("rows", list);
            map.put("total", totCnt);
            System.out.println(map);
        }
        else {
            map.put("rows", "sessionOut");
        }
        return map;
    }
    

   
 
}
