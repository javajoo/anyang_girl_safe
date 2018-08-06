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
import com.danusys.platform.west.service.EsEventService;
import com.danusys.platform.west.service.EventOcrService;
import com.danusys.platform.west.service.EventOcrVO;
import com.danusys.platform.west.service.EventService;
import com.danusys.platform.west.service.EventVO;

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
public class EventController {

    @Resource(name = "eventService")
    private EventService eventService;
    
    @Resource(name = "eventOcrService")
    private EventOcrService eventOcrService;
    
    @Resource(name = "esEventService")
    private EsEventService esEventService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @RequestMapping(value="/com/danusys/platform/selectEventList.do")
    public @ResponseBody Map<String, Object> selectEventList(EventVO vo, HttpServletRequest request) throws Exception {
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
            vo.setFlag(user.getAuthority());
            
            List<?> list = eventService.selectEventList(vo);
            
            //List<EgovMap> list = (List<EgovMap>) eventService.selectEventList(vo);
            int totCnt = eventService.selectEventListTotCnt(vo);
            List<EgovMap> list2 = new ArrayList<EgovMap>();
            
            for(EgovMap map2 : (List<EgovMap>)list){
                map2.get("eventNo");
                
                String castNet = "<a href='#' class='row_handle' onclick='row_handle(\""+map2.get("eventNo")+"\")'/>";
                map2.put("castNet", castNet);
                list2.add(map2);
            }
            paginationInfo.setTotalRecordCount(totCnt);
            
            //Map<String, Object> map = new HashMap<String, Object>();

            map.put("rows", list2);
            map.put("total", totCnt);
        }
        else {
            map.put("rows", "sessionOut");
        }
        return map;
    }
    
    @RequestMapping(value="/com/danusys/platform/selectEventState.do")
    public @ResponseBody Map<String, Object> selectEventState(EventVO vo, HttpServletRequest request) throws Exception {
        
        HttpSession session = request.getSession();
        AdminVo user = (AdminVo) session.getAttribute("admin");
        vo.setFlag(user.getAuthority());
        
        List<?> list = eventService.selectEventState(vo);
        
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("rows", list);
        
        return map;
    }
    
    @RequestMapping(value="/com/danusys/platform/selectEventConfm.do", method = RequestMethod.GET)
    public @ResponseBody Map<String, Object> selectEventConfm(EventVO vo, HttpServletRequest request) throws Exception {
        
        HttpSession session = request.getSession();
        AdminVo user = (AdminVo) session.getAttribute("admin");
        //vo.setFlag(user.getAuthority());
        Map<String , Object> map = new HashMap<String ,  Object>();
        if(user!=null){
            List<?> list = eventService.selectEventConfm(vo);
            //Map<String, Object> map = new HashMap<String, Object>();
            map.put("rows", list);
        }
        else {
            map.put("rows", "sessionOut");
        }
        return map;
    }

    
    @RequestMapping(value="/com/danusys/platform/insertEvent.do", method = RequestMethod.POST)
    public @ResponseBody Map<String, String> insertEvent(EventVO vo, SessionStatus status, HttpServletRequest request) throws Exception {
        
        Map<String , String> map = new HashMap<String , String>();
        //LoginVO user = (LoginVO) request.getSession();
        HttpSession session = request.getSession();
        AdminVo user = (AdminVo) session.getAttribute("admin");
        
        if(user!=null){ // 인증된 경우는 메인 페이지로 이동
            vo.setInstId(user.getId());
            vo.setKey(propertiesService.getString("AES_KEY"));
            eventService.insertEvent(vo);
            
            EventOcrVO ocrVO = EventUtil.eventVOToEventOcrVO(vo);
            eventOcrService.insertEvtOcr(ocrVO);
            
            EgovMap hisMap = EventUtil.eventOcrVOToMap(ocrVO);
            eventOcrService.insertCmEvtOcrAction(hisMap);
            
            // System.out.println("sendEvent VO1 : "+vo);
            map.put("stat", "sucess");
            /* sendEvent
            try{
                map.put("stat", "sucess");
                if(vo.getEventType().equals("EVENT_TYPE_3") || vo.getEventType().equals("EVENT_TYPE_4")
                		|| vo.getEventType().equals("EVENT_TYPE_7") || vo.getEventType().equals("EVENT_TYPE_5")) {
                	sendEvent(vo);
                	System.out.println("sendEvent VO2 : "+vo);
                }
            }catch(Exception exx){
                map.put("stat", exx.toString());
            }
            */
        }else{
            map.put("stat", "인증되지 않은 사용자 입니다.");
        }
        status.setComplete();
        return map;
    }

    @RequestMapping("/com/danusys/platform/updateEvent.do")
    public @ResponseBody Map<String, String> updateEvent(EventVO vo, SessionStatus status, HttpServletRequest request) throws Exception {
        
        Map<String , String> map = new HashMap<String , String>();
        HttpSession session = request.getSession();
        AdminVo user = (AdminVo) session.getAttribute("admin");
        
        if(user!=null){ // 인증된 경우는 메인 페이지로 이동
            vo.setUpdId(user.getId());
            vo.setKey(propertiesService.getString("AES_KEY"));
            eventService.updateEvent(vo);
            EventOcrVO ocrVO = EventUtil.eventVOToEventOcrVO(vo);
            eventOcrService.updateEvtOcr(ocrVO);
            EgovMap hisMap = EventUtil.eventOcrVOToMap(ocrVO);
            eventOcrService.insertCmEvtOcrAction(hisMap);
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
    
    @RequestMapping("/com/danusys/platform/updateEventConfm.do")
    public @ResponseBody Map<String, String> updateEventConfm(EventVO vo, SessionStatus status, HttpServletRequest request) throws Exception {
        
        Map<String , String> map = new HashMap<String , String>();
        HttpSession session = request.getSession();
        AdminVo user = (AdminVo) session.getAttribute("admin");
        
        if(user!=null){ // 인증된 경우는 메인 페이지로 이동
            vo.setUpdId(user.getId());
            eventService.updateEventConfm(vo);
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

    @RequestMapping("/com/danusys/platform/deleteEvent.do")
    public @ResponseBody Map<String, String> deleteEvent(HttpServletRequest request)
            throws Exception {
        
        Map<String , String> map = new HashMap<String , String>();
        LoginVO user = EgovUserDetailsHelper.isAuthenticated()? (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser():null;
        
        if(EgovUserDetailsHelper.isAuthenticated() && user!=null){ // 인증된 경우는 메인 페이지로 이동
            int seqNoCnt = Integer.parseInt(request.getParameter("cnt"));
            ArrayList<String> seqNoList = new ArrayList<String>(seqNoCnt);
            
            for(int i = 0; i < seqNoCnt; i++){
                seqNoList.add(request.getParameter("seqNo"+i));
            }
            EventVO vo = new EventVO();
            vo.setSeqNoList(seqNoList);
            
            try{
                eventService.deleteEvent(vo);
                map.put("stat", "sucess");
            }catch(Exception exx){
                map.put("stat", exx.toString());
            }
        }else{
            map.put("stat", "인증되지 않은 사용자 입니다.");
        }
        return map;
    }
    
    @RequestMapping("/com/danusys/platform/insertEventFlagConfm.do")
    public @ResponseBody Map<String, String> insertEventFlagConfm(EventVO vo, SessionStatus status, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        Map<String , String> map = new HashMap<String , String>();
        HttpSession session = request.getSession(false);
        
        if(session.getAttribute("admin")==null){
            response.sendRedirect("/main.do");
        }else{
            AdminVo user = (AdminVo) session.getAttribute("admin");
            if(user!=null){ // 인증된 경우는 메인 페이지로 이동
                if(vo.getSeqNo()!=null){
                    vo.setInstId(user.getId());
                    eventService.insertEventFlagConfm(vo);
                    try{
                        map.put("stat", "sucess");
                    }catch(Exception exx){
                        map.put("stat", exx.toString());
                    }
                }else{
                    map.put("stat", "잘못된 접근입니다.");
                }

            }
        }
        status.setComplete();
        return map;
    }    
    
    @RequestMapping(value="/com/danusys/platform/selectEventFlagConfm.do")
    public @ResponseBody Map<String, Object> selectEventFlagConfm(EventVO vo, HttpServletRequest request) throws Exception {
        
        HttpSession session = request.getSession();
        AdminVo user = (AdminVo) session.getAttribute("admin");
        vo.setFlag(user.getAuthority());
        
        List<?> list = eventService.selectEventFlagConfm(vo);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("rows", list);
        
        return map;
    }
    
    public void sendEvent(EventVO vo) {
    	System.out.println("sendEvent()~!!! "+vo.getAcceptCont());
        HttpHelper httpHelper = new HttpHelper();
        String URL = "http://112.162.35.172:10003/api/nsok/sos";
        JSONObject json = new JSONObject();
        switch(vo.getEventType()) {
	        case "EVENT_TYPE_3" :	// 112
	        	json.put("mcode", "201");
	        	break;
	        case "EVENT_TYPE_4" : 	// 119
	        	json.put("mcode", "202");
	        	break;
	        case "EVENT_TYPE_5" : 	// 비상벨(방범)
	        	json.put("mcode", "204");
	        	break; 
	        case "EVENT_TYPE_6" :	// 환경
	        	json.put("mcode", "205");
	        	break;
	        case "EVENT_TYPE_7" :	// 재난
	        	json.put("mcode", "203");
	        	break;
	        default :				// 그 외에는 이벤트 발생하지 않음.
	        	return;
        }
        json.put("lat", vo.getLatitude());
        json.put("lng", vo.getLongitude());
        json.put("datetime", vo.getEventDe());
        httpHelper.sendHttpRequest(URL, json, "POST", null);
    }
    
    @RequestMapping(value="/com/danusys/platform/selectEventStats.do")
    public @ResponseBody Map<String, Object> selectEventStats(EventVO vo, HttpServletRequest request) throws Exception {
        List<?> list = eventService.selectEventStats(vo);
        
        Map<String, Object> map = new HashMap<String, Object>();
        
        map.put("rows", list);
        
        return map;
    }
    
	@RequestMapping(value = { "/com/danusys/platform/hasAuthorityEvent.do" }, method = { org.springframework.web.bind.annotation.RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> hasAuthorityEvent(@ModelAttribute EventOcrVO vo,
			ModelMap model, HttpServletRequest request) throws Exception {
		AdminVo lgnVO = (AdminVo) request.getSession().getAttribute("admin");
	    String userId = lgnVO.getId();
	    vo.setUserId(userId);
		Map<String, Object> resultMap = new LinkedHashMap();
		int result = eventOcrService.hasAuthorityEvent(vo);
		resultMap.put("result", Integer.valueOf(result));
		return resultMap;
	}
	
	@RequestMapping(value="/com/danusys/platform/updateEsEvents.do")
	@ResponseBody
	public Map<String, Object> updateEsEvents() {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			String key = propertiesService.getString("AES_KEY");
			esEventService.insertAllEsEvent(key);
			
			resultMap.put("respons", "success");
			
		} catch (Exception exx) {
			resultMap.put("respons", "fail");
		}
		
		return resultMap;
	}
	
	@RequestMapping(value="/com/danusys/platform/selectEventEtcCont.do")
	@ResponseBody
	public Map<String, String> selectEventEtcCont(HttpServletRequest request) {
		Map<String, String> resultMap = new HashMap<String, String>();
		String etcCont = "";
		String eventNo = request.getParameter("eventNo");
		try {
			List<?> list = eventService.selectEventEtcCont(eventNo);
			
			for (Map<String, String> map : (List<Map<String, String>>)list) {
				etcCont = etcCont + map.get("evtOcrItemDtl") + " ";
			}
			
			resultMap.put("etcCont", etcCont);
		} catch (Exception exx) {
			
		}
		
		return resultMap;
	}
}
