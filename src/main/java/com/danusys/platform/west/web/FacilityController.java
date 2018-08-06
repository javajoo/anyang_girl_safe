package com.danusys.platform.west.web;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.danusys.platform.sensor.service.LastsVO;
import com.danusys.platform.service.ExcelHeaderVO;
import com.danusys.platform.vo.AdminVo;
import com.danusys.platform.web.JSONResult;
import com.danusys.platform.west.service.FacilityService;
import com.danusys.platform.west.service.FacilityVO;

import egovframework.com.cmm.LoginVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : FacilityController.java
 * @Description : Facility Controller class
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
public class FacilityController {
    private static final Logger LOGGER = LoggerFactory.getLogger(FacilityController.class);

    @Resource(name = "facilityService")
    private FacilityService facilityService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @RequestMapping(value="/com/danusys/platform/selectFacilityList.do")
    public @ResponseBody Map<String, Object> selectFacilityList(FacilityVO vo) throws Exception {
        
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
        
        List<?> list = facilityService.selectFacilityList(vo);
        int totCnt = facilityService.selectFacilityListTotCnt(vo);
        paginationInfo.setTotalRecordCount(totCnt);
        
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("rows", list);
        map.put("total", totCnt);
        
        return map;
    }
    
    @RequestMapping(value="/com/danusys/platform/selectFacilityToNodeId.do")
    public @ResponseBody Object selectFacilityToNodeId(FacilityVO vo) throws Exception {
        
        /** EgovPropertyService.sample */
        /*vo.setPageUnit(propertiesService.getInt("pageUnit"));
        vo.setPageSize(propertiesService.getInt("pageSize"));
        vo.setPageIndex(vo.getPage());
        
        *//** pageing *//*
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(vo.getPageIndex());
        paginationInfo.setRecordCountPerPage(vo.getPageUnit());
        paginationInfo.setPageSize(vo.getPageSize());
        
        vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
        vo.setLastIndex(paginationInfo.getLastRecordIndex());
        vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());*/
        
        List<?> list = facilityService.selectFacilityToNodeId(vo);
        /*int totCnt = facilityService.selectFacilityListTotCnt(vo);
        paginationInfo.setTotalRecordCount(totCnt);
        
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("rows", list);
        map.put("total", totCnt);*/
        
        return list;
    }
    
    @RequestMapping(value="/com/danusys/platform/selectFacilityToSiteno.do")
    public @ResponseBody List<?> selectFacilityToSiteno(LastsVO vo) throws Exception {
        LOGGER.debug("selectFacilityToSiteno.do!!! "+vo.getSiteno());
        List<?> list = facilityService.selectFacilityToSiteno(vo);
        return list;
    }
    
    @RequestMapping(value="/com/danusys/platform/selectFacilityRadius.do")
    public @ResponseBody Object selectFacilityRadius(FacilityVO vo) throws Exception {
        LOGGER.debug("selectFacilityRadius.do!!! "+vo.getEncryptLatitude()+", "+vo.getEncryptLongitude());
        vo.setEncryptLatitude(Double.valueOf(vo.getEncryptLatitude()).doubleValue());
        vo.setEncryptLongitude(Double.valueOf(vo.getEncryptLongitude()).doubleValue());
        
        List<?> list = facilityService.selectFacilityRadius(vo);
        
        return list;
    }
    
    @RequestMapping(value="/com/danusys/platform/insertFacility.do", method = RequestMethod.POST)
    public @ResponseBody Map<String, String> insertFacility(FacilityVO vo, SessionStatus status, HttpServletRequest request) throws Exception {
        
        Map<String , String> map = new HashMap<String , String>();
        //LoginVO user = (LoginVO) request.getSession();
        HttpSession session = request.getSession();
        AdminVo user = (AdminVo) session.getAttribute("admin");
        LOGGER.debug("insertFacility.do!!! "+vo.getCctvNm()+", "+vo.getNodeId()+", "+user);
        if(user!=null){ // 인증된 경우는 메인 페이지로 이동
            vo.setInstId(user.getId());
            facilityService.insertFacility(vo);
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
    
    @RequestMapping(value="/com/danusys/platform/insertFacilityDuplicateUpdate.do", method = RequestMethod.POST)
    public @ResponseBody Map<String, String> insertFacilityDuplicateUpdate(FacilityVO vo, SessionStatus status, HttpServletRequest request) throws Exception {
        Map<String , String> map = new HashMap<String , String>();
        //LoginVO user = (LoginVO) request.getSession();
        HttpSession session = request.getSession();
        AdminVo user = (AdminVo) session.getAttribute("admin");
        LOGGER.debug("insertFacilityDuplicateUpdate.do!!! "+vo.getCctvNm()+", "+vo.getNodeId()+", "+user);
        if (user!=null) { // 인증된 경우는 메인 페이지로 이동
            vo.setInstId(user.getId());
            vo.setUpdId(user.getId());
            facilityService.insertFacilityDuplicateUpdate(vo);
            try {
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

    /*@RequestMapping("/com/danusys/platform/updateFacility.do")
    public @ResponseBody Map<String, String> updateFacility(FacilityVO vo, SessionStatus status, HttpServletRequest request) throws Exception {
        
        Map<String , String> map = new HashMap<String , String>();
        //LoginVO user = (LoginVO) request.getSession();
        HttpSession session = request.getSession();
        AdminVo user = (AdminVo) session.getAttribute("admin");
        LOGGER.debug("updateFacility.do!!! "+vo.getCctvNm()+", "+vo.getNodeId()+", "+", "+vo.getNodePort()+", "+user);
        
        if(user!=null){ // 인증된 경우는 메인 페이지로 이동
            vo.setUpdId(user.getId());
            facilityService.updateFacility(vo);
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
    }*/
    
    @RequestMapping("/com/danusys/platform/updateFacilityToNodeId.do")
    public @ResponseBody Map<String, String> updateFacilityToNodeId(FacilityVO vo, SessionStatus status, HttpServletRequest request) throws Exception {
        
        Map<String , String> map = new HashMap<String , String>();
        //LoginVO user = (LoginVO) request.getSession();
        HttpSession session = request.getSession();
        AdminVo user = (AdminVo) session.getAttribute("admin");
        LOGGER.debug("updateFacilityToNodeId.do!!! "+vo.getCctvNm()+", "+vo.getNodeId()+", "+", "+vo.getNodePort()+", "+user);
        if(user!=null){ // 인증된 경우는 메인 페이지로 이동
            vo.setUpdId(user.getId());
            facilityService.updateFacilityToNodeId(vo);
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
    
    @RequestMapping("/com/danusys/platform/deleteFacility.do")
    public @ResponseBody Map<String, String> deleteFacility(HttpServletRequest request)
            throws Exception {
        
        Map<String , String> map = new HashMap<String , String>();
        LoginVO user = EgovUserDetailsHelper.isAuthenticated()? (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser():null;
        
        if(EgovUserDetailsHelper.isAuthenticated() && user!=null){ // 인증된 경우는 메인 페이지로 이동
            int seqNoCnt = Integer.parseInt(request.getParameter("cnt"));
            ArrayList<String> seqNoList = new ArrayList<String>(seqNoCnt);
            
            for(int i = 0; i < seqNoCnt; i++){
                seqNoList.add(request.getParameter("seqNo"+i));
            }
            FacilityVO vo = new FacilityVO();
            vo.setSeqNoList(seqNoList);
            
            try{
                facilityService.deleteFacility(vo);
                map.put("stat", "sucess");
            }catch(Exception exx){
                map.put("stat", exx.toString());
            }
        }else{
            map.put("stat", "인증되지 않은 사용자 입니다.");
        }
        return map;
    }
    
    /* 중계서버로 부터 카메라 정보를 받는 API */
    @RequestMapping(value="/com/danusys/platform/recvNodeInfo.do", method = RequestMethod.POST)
    public @ResponseBody JSONResult receiveNodeInfo(HttpServletRequest request) {
        Map<String , String> map = new HashMap<String , String>();
        try {
            LOGGER.debug("receiveNodeInfo.do!!! nodeInfo:" + request);
            InputStream is = request.getInputStream();
            /*BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
            String thisLine = null;
            while ((thisLine = br.readLine()) != null) {
                System.out.println(thisLine);
             }*/
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(is);
            doc.getDocumentElement().normalize();
            NodeList streamNodeList = doc.getElementsByTagName("StreamNodeInfo");
            StreamNodeLoop : for (int i=0 ; i<streamNodeList.getLength() ; i++) {
                Node streamNode = streamNodeList.item(i);
                NamedNodeMap nodeMap = streamNode.getAttributes();
                FacilityVO vo = new FacilityVO(); 
                for (int j=0 ; j<nodeMap.getLength() ; j++) {       
                    if (null==nodeMap.item(j).getNodeValue() || "".equals(nodeMap.item(j).getNodeValue())
                            || "0".equals(nodeMap.item(j).getNodeValue())) {
                        continue StreamNodeLoop;
                    }
                    LOGGER.debug(nodeMap.item(j).getNodeName()+":"+nodeMap.item(j).getNodeValue());
                    switch (nodeMap.item(j).getNodeName()) {
                        case "NodeID" : 
                            vo.setNodeId(nodeMap.item(j).getNodeValue());
                            break;
                        case "Name" : 
                            vo.setCctvNm(nodeMap.item(j).getNodeValue());
                            break;
                        case "IP" : 
                            vo.setNodeIp(nodeMap.item(j).getNodeValue());
                            break;
                        case "PORT" :
                            vo.setNodePort(nodeMap.item(j).getNodeValue());
                            break;
                        case "MgrCode" :
                            vo.setMngCd(nodeMap.item(j).getNodeValue());
                            break;
                    }
                    // System.out.println("receiveNodeInfo.do!!! "+ nodeMap.item(j));
                }
                vo.setInstId("SYSTEM");
                facilityService.insertFacilityDuplicateUpdate(vo);
            }
            map.put("stat", "node info receive success");
            return new JSONResult("OK", "", map);
        } catch(Exception e) {
            System.out.println("error : "+e);
            map.put("stat", e.toString());
            return new JSONResult("Error", map);
        }
    }
    
    /***********************************시설물관제******************************************************/
    /*시설물관리 - 조회*/
    @RequestMapping(value="/com/danusys/platform/selectFacilityMList.do")
    public @ResponseBody Map<String, Object> selectFacilityMList(FacilityVO vo) throws Exception {
        
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
        
        List<?> list = facilityService.selectFacilityMList(vo);
        int totCnt = facilityService.selectFacilityMListTotCnt(vo);
        paginationInfo.setTotalRecordCount(totCnt);
        
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("rows", list);
        map.put("total", totCnt);
        
        return map;
    }
    
    @RequestMapping(value="/com/danusys/platform/selectFacilityMListExcel.do")
    public ModelAndView selectFacilityMListExcel(FacilityVO searchVO, HttpServletRequest request) throws Exception {
        searchVO.setRecordCountPerPage(-1);
        
        List<?> result = new ArrayList<EgovMap>();
        result = (List<EgovMap>)facilityService.selectFacilityMList(searchVO);
        
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
        
        return new ModelAndView("searchFacilityMListExcel", map);
    }
    
    @RequestMapping("/com/danusys/platform/insertFacilityMList.do")
    public @ResponseBody Map<String, String> insertFacilityMList(FacilityVO vo, SessionStatus status, HttpServletRequest request) throws Exception {
        
        Map<String , String> map = new HashMap<String , String>();
        HttpSession session = request.getSession();
        AdminVo user = (AdminVo) session.getAttribute("admin");
        
        if(user!=null){ // 인증된 경우는 메인 페이지로 이동
            vo.setInstId(user.getId());
            
            if(vo.getFacilityType().equals("CCTV")){
                facilityService.insertFacilityCctvList(vo);                
            }
            else if(vo.getFacilityType().equals("SENSOR")){
                facilityService.insertFacilitySensorList(vo);
            }
            else{
                facilityService.insertFacilityCenterList(vo);
            }
            
            try{
                map.put("stat", "sucess");
            }catch(Exception exx){
                map.put("stat", exx.toString());
            }
        }else{
            map.put("stat", "인증되지 않은 사용자 입니다.");
        }
        status.setComplete();
        return map;
    }
    
    @RequestMapping("/com/danusys/platform/updateFacilityMList.do")
    public @ResponseBody Map<String, String> updateFacilityMList(FacilityVO vo, SessionStatus status, HttpServletRequest request) throws Exception {
        
        Map<String , String> map = new HashMap<String , String>();
        HttpSession session = request.getSession();
        AdminVo user = (AdminVo) session.getAttribute("admin");
        LOGGER.debug("updateFacilityMList.do!!! "+vo.getCctvNm()+", "+vo.getNodeId()+", "+", "+vo.getNodePort()+", "+user);
        
        if(user!=null){ // 인증된 경우는 메인 페이지로 이동
            vo.setUpdId(user.getId());
            
            if(vo.getFacilityType().equals("CCTV")){
                facilityService.updateFacilityCctvList(vo);                
            }
            else if(vo.getFacilityType().equals("SENSOR")){
                facilityService.updateFacilitySensorList(vo);
            }
            else{
                facilityService.updateFacilityCenterList(vo);
            }
            
            try{
                map.put("stat", "sucess");
            }catch(Exception exx){
                map.put("stat", exx.toString());
            }
        }else{
            map.put("stat", "인증되지 않은 사용자 입니다.");
        }
        status.setComplete();
        return map;
    }
    
    @RequestMapping("/com/danusys/platform/deleteFacilityMList.do")
    public @ResponseBody Map<String, String> deleteFacilityMList(FacilityVO vo, SessionStatus status, HttpServletRequest request) throws Exception {
        
        Map<String , String> map = new HashMap<String , String>();
        HttpSession session = request.getSession();
        AdminVo user = (AdminVo) session.getAttribute("admin");
        
        if(user!=null){ // 인증된 경우는 메인 페이지로 이동
            vo.setUpdId(user.getId());
            
            if(vo.getFacilityType().equals("CCTV")){
                facilityService.deleteFacilityCctvList(vo);                
            }
            else if(vo.getFacilityType().equals("SENSOR")){
                facilityService.deleteFacilitySensorList(vo);
            }
            else{
                facilityService.deleteFacilityCenterList(vo);
            }
            
            try{
                map.put("stat", "sucess");
            }catch(Exception exx){
                map.put("stat", exx.toString());
            }
        }else{
            map.put("stat", "인증되지 않은 사용자 입니다.");
        }
        status.setComplete();
        return map;
    }
    
    /*시설물현황(전체) - 조회*/
    @RequestMapping(value="/com/danusys/platform/selectFacilityRTotList.do")
    public @ResponseBody Map<String, Object> selectFacilityRTotList(FacilityVO vo) throws Exception {
        List<?> list = facilityService.selectFacilityRTotList(vo);
        
        Map<String, Object> map = new HashMap<String, Object>();
        
        map.put("rows", list);
        
        return map;
    }
    
    /*시설물현황(종류) - 조회*/
    @RequestMapping(value="/com/danusys/platform/selectFacilityRTypeList.do")
    public @ResponseBody Map<String, Object> selectFacilityRTypeList(FacilityVO vo) throws Exception {
        List<?> list = facilityService.selectFacilityRTypeList(vo);
        
        Map<String, Object> map = new HashMap<String, Object>();
        
        map.put("rows", list);
        
        return map;
    }
    
    @RequestMapping(value="/com/danusys/platform/selectFacility.do")
    @ResponseBody
    public EgovMap selectFacility(int facilityNo) throws Exception{
    	EgovMap map = facilityService.selectFacility(facilityNo);
    	
    	return map;
    }
    
    @RequestMapping(value="/com/danusys/platform/updateFacilityState.do")
    @ResponseBody
    public Map<String, String> updateFacilityState(FacilityVO vo){
    	Map<String, String> map = new HashMap<String, String>();
    	
    	try {
    		facilityService.updateFacilityState(vo);
    		map.put("response", "success");
    	} catch(Exception exx) {
    		map.put("response", "failed");
    	}
    	
    	return map;
    }
}
