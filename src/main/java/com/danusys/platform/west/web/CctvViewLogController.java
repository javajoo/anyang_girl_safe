package com.danusys.platform.west.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.danusys.platform.service.ExcelHeaderVO;
import com.danusys.platform.vo.AdminVo;
import com.danusys.platform.west.service.CctvViewLogService;
import com.danusys.platform.west.service.CctvViewLogVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : CctvViewLogController.java
 * @Description : CctvViewLog Controller class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-01-11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class CctvViewLogController {
	private static final Logger LOGGER = LoggerFactory.getLogger(CctvViewLogController.class);

    @Resource(name = "cctvViewLogService")
    private CctvViewLogService cctvViewLogService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @RequestMapping(value="/com/danusys/platform/selectCctvViewLogList.do")
    public @ResponseBody Map<String, Object> selectCctvViewLogList(CctvViewLogVO vo) throws Exception {
        
        /** EgovPropertyService.sample */
        vo.setPageUnit(propertiesService.getInt("pageUnit"));
        vo.setPageIndex(vo.getPage());
        
        /** pageing */
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(vo.getPageIndex());
        paginationInfo.setRecordCountPerPage(vo.getPageSize());
        paginationInfo.setPageSize(vo.getPageSize());
        
        vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
        vo.setLastIndex(paginationInfo.getLastRecordIndex());
        vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        List<?> list = cctvViewLogService.selectCctvViewLogList(vo);
        int totCnt = cctvViewLogService.selectCctvViewLogListTotCnt(vo);
        paginationInfo.setTotalRecordCount(totCnt);
        
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("rows", list);
        map.put("total", totCnt);
        
        return map;
    }
    
    @RequestMapping(value="/com/danusys/platform/selectCctvViewLogExcel.do")
    public ModelAndView selectCctvViewLogExcel(CctvViewLogVO searchVO, HttpServletRequest request) throws Exception {
        searchVO.setRecordCountPerPage(-1);
        List<?> result = new ArrayList<EgovMap>();
        result = (List<EgovMap>) cctvViewLogService.selectCctvViewLogList(searchVO);
        
        List<ExcelHeaderVO> headerList = new ArrayList<ExcelHeaderVO>();
        
        int headerCnt = Integer.parseInt(request.getParameter("headerCnt"));
        
        for(int i = 0; i < headerCnt; i++){
            ExcelHeaderVO vo = new ExcelHeaderVO();
            vo.setHeaderText(request.getParameter("headerText"+i));
            vo.setHeaderField(request.getParameter("headerField"+i));
            vo.setHeaderUse(Boolean.parseBoolean(request.getParameter("headerUse"+i)));
            headerList.add(vo);
        }

        Map<String, Object> map = new HashMap<String, Object>();

        map.put("result", result);
        map.put("headerList", headerList);
        
        return new ModelAndView("searchViewLogExcel", map);
    }
    
    @RequestMapping(value="/com/danusys/platform/insertCctvViewLog.do", method = RequestMethod.POST)
    public @ResponseBody Object insertCctvViewLog(CctvViewLogVO vo, SessionStatus status, HttpServletRequest request) throws Exception {
    	JSONObject results = new JSONObject();
    	//LoginVO user = (LoginVO) request.getSession();
        HttpSession session = request.getSession();
        AdminVo user = (AdminVo) session.getAttribute("admin");
        LOGGER.debug("insertCctvViewLog.do!!! "+vo.getCamera1Name()+", "+vo.getCamera1Id()+", "+user);
        if(user!=null){ // 인증된 경우는 메인 페이지로 이동
            vo.setUserId(user.getId());
            vo.setSessionId(session.getId());
            int seqId = cctvViewLogService.insertCctvViewLog(vo);
            try{
            	results.put("stat", "success");
            	results.put("seqId", seqId);
            }catch(Exception exx){
            	results.put("stat", exx.toString());
            }
        }else{
        	results.put("stat", "인증되지 않은 사용자 입니다.");
        }
        status.setComplete();
        return results;
    }

    @RequestMapping("/com/danusys/platform/updateCctvViewLog.do")
    public @ResponseBody Map<String , String> updateCctvViewLog(CctvViewLogVO vo, SessionStatus status, HttpServletRequest request) throws Exception {
    	
    	Map<String , String> map = new HashMap<String , String>();
        //LoginVO user = (LoginVO) request.getSession();
        HttpSession session = request.getSession();
        AdminVo user = (AdminVo) session.getAttribute("admin");      
        if(user!=null){ // 인증된 경우는 메인 페이지로 이동
        	cctvViewLogService.updateCctvViewLog(vo);
            try{
                map.put("stat", "success");
            }catch(Exception exx){
                map.put("stat", exx.toString());
            }
        }else{
            map.put("stat", "인증되지 않은 사용자 입니다.");
        }
        status.setComplete();
        return map;
    }
    
    @RequestMapping("/com/danusys/platform/updateViewEndTime.do")
    public @ResponseBody Map<String , String> updateViewEndTime(CctvViewLogVO vo, SessionStatus status, HttpServletRequest request) throws Exception {
    	
    	Map<String , String> map = new HashMap<String , String>();
        //LoginVO user = (LoginVO) request.getSession();
        HttpSession session = request.getSession();
        AdminVo user = (AdminVo) session.getAttribute("admin");
        LOGGER.debug("updateViewEndTime.do!!! "+"seq_id: "+vo.getSeqId()+", "+vo.getViewEndTime()+", "+user);        
        if(user!=null){ // 인증된 경우는 메인 페이지로 이동
        	cctvViewLogService.updateViewEndTime(vo);
            try{
                map.put("stat", "success");
            }catch(Exception exx){
                map.put("stat", exx.toString());
            }
        }else{
            map.put("stat", "인증되지 않은 사용자 입니다.");
        }
        status.setComplete();
        return map;
    }
    
}
