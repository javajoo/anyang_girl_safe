package com.danusys.controller;


/*
import com.my.space.model.admin.UserInfo;

*/
/*
import com.my.space.util.EncryptUtil;
*/
import com.danusys.exception.BaseException;
import com.danusys.cmm.util.CommonUtil;
import com.danusys.sms.api.ApiClass;
import com.danusys.sms.api.ApiResult;
import com.danusys.cmm.util.JsonUtil;
import com.danusys.platform.vo.AdminVo;
import com.danusys.platform.west.service.GirlSafeVO;
import com.danusys.service.BaseService;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import org.json.JSONArray;
import org.json.JSONException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import com.danusys.sms.service.SmsInfoService;
import com.danusys.cmm.util.AES128;

/*
//  클래스  명 : BaseController
//  클래스설명 : BaseController 클래스
*/
@Controller
public class BaseController
{
    private static final Logger logger = LoggerFactory.getLogger(BaseController.class);

    @Autowired
    private BaseService baseService;
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    @Resource(name="smsInfoService")
    private SmsInfoService smsInfoService;
    /**
     * FuncName : index()
     * FuncDesc : 페이지 Action
     * Param    : 
     * Return   : String
    */
//    @RequestMapping(value = "/index.do", method = { RequestMethod.GET, RequestMethod.POST,  RequestMethod.HEAD } )
//    public String index(@RequestParam Map<String, Object> params, Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session)
//    {
//        EncryptUtil encryptUtil = new EncryptUtil();
//
//    	System.out.println("----------POST----------");
//    	try
//    	{
//    		response.setCharacterEncoding("UTF-8");
//    		
//    		Map<String, Object> param = new HashMap<String, Object>();
//    		List<Map<String, Object>> resList = null;
//    		 
//	        try
//	        {
////		 		System.out.println("Parameter HTTP_IV_USER : " + request.getParameter("hardStatus"));
////
////		        String userId = request.getParameter("HTTP_IV_USER");
//				String hardStatus = request.getParameter("hardStatus");
//				String sID_SABUN = "";
//				if(request.getHeader("iv-user") != null && !request.getHeader("iv-user").isEmpty())
//				{
//					sID_SABUN = request.getHeader("iv-user");
//				}
//				else
//				{
//					sID_SABUN = request.getParameter("ID_SABUN");
//				}
//
//		        System.out.println("Parameter : " + sID_SABUN);
//				System.out.println("Parameter : " + hardStatus);
//
//	        	param.put("userId", sID_SABUN);
//	        	param.put("loginType", "user");
//
//	            resList = baseService.baseSelectList("Login.getLogin", param);
//
//	            if (resList.size() == 1)
//	            {
//	                // 넘어온 파라미터에 ko가 있으면 Locale의 언어를 한국어로 바꿔준다.
//	                String localeStr = ((UserInfo)resList.get(0)).getLanguage();
//
//	                if (localeStr.matches("ko")) // 한국어
//	                {
//	                    locale = Locale.KOREAN;
//	                }
//	                else if (localeStr.matches("en")) // 영어
//	                {
//	                    locale = Locale.ENGLISH;
//	                }
//	                else if (localeStr.matches("cn")) // 중국어
//	                {
//	                    locale = Locale.CHINA;
//	                }
//	                else if (localeStr.matches("jp")) // 일본어
//	                {
//	                    locale = Locale.JAPANESE;
//	                }
//	                else
//	                {
//	                    locale = Locale.KOREAN;
//	                }
//	                
//	                // 세션에 존재하는 Locale을 새로운 언어로 변경해준다.
//	                session.setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, locale);
//	                
//	                session.setMaxInactiveInterval(60 * 30); // Session 시간 설정 (60 * 60 = 1시간)
//
//					session.setAttribute("CONNTYPE", "CHORUS");
//
//	                session.setAttribute("SESSION_USER_ID",       		((UserInfo)resList.get(0)).getUserId());      			// 사용자ID
//					session.setAttribute("SESSION_USER_NAME",     		((UserInfo)resList.get(0)).getUserName());    			// 사용자명
//					session.setAttribute("SESSION_USER_GROUP_CODE", 		((UserInfo)resList.get(0)).getUserGroupCode());			// 사용자그룹ID
//					session.setAttribute("SESSION_USER_GROUP_NAME", 		((UserInfo)resList.get(0)).getUserGroupName());			// 사용자그룹명
//					session.setAttribute("SESSION_USER_TYPE",	  			((UserInfo)resList.get(0)).getUserType());				// 사용자구분
//					session.setAttribute("SESSION_LANGUAGE",	  			((UserInfo)resList.get(0)).getLanguage());				// 사이트 사용언어
//					session.setAttribute("SESSION_IDLEVEL",	  			((UserInfo)resList.get(0)).getIdLevel());				// 계정 레벨
//
//					session.setAttribute("SESSION_USEUSEFLAG",			((UserInfo)resList.get(0)).getUseUseFlag());			// 사용신청 사용여부
//					session.setAttribute("SESSION_USENOTICEFLAG",		((UserInfo)resList.get(0)).getUseNoticeFlag());			// 사용신청 공지사항
//					session.setAttribute("SESSION_USEAGREEFLAG",	  		((UserInfo)resList.get(0)).getUseAgreeFlag());			// 사용신청 동의서
//					session.setAttribute("SESSION_RETURNUSEFLAG",		((UserInfo)resList.get(0)).getReturnUseFlag());			// 반납신청 사용여부
//					session.setAttribute("SESSION_RETURNNOTICEFLAG",		((UserInfo)resList.get(0)).getReturnNoticeFlag());		// 반납신청 공지사항
//					session.setAttribute("SESSION_RETURNAGREEFLAG",	  	((UserInfo)resList.get(0)).getReturnAgreeFlag());		// 반납신청 동의서
//
//					session.setAttribute("SESSION_AFLAG",					((UserInfo)resList.get(0)).getAFlag());
//
//					session.setAttribute("SESSION_AAFLAG",				((UserInfo)resList.get(0)).getAAFlag());
//					session.setAttribute("SESSION_AAAFLAG",				((UserInfo)resList.get(0)).getAAAFlag());
//					session.setAttribute("SESSION_AABFLAG",				((UserInfo)resList.get(0)).getAABFlag());
//
//					session.setAttribute("SESSION_ABFLAG",				((UserInfo)resList.get(0)).getABFlag());
//					session.setAttribute("SESSION_ABAFLAG",				((UserInfo)resList.get(0)).getABAFlag());
//					session.setAttribute("SESSION_ABBFLAG",				((UserInfo)resList.get(0)).getABBFlag());
//
//					session.setAttribute("SESSION_ACFLAG",				((UserInfo)resList.get(0)).getACFlag());
//					session.setAttribute("SESSION_ACAFLAG",				((UserInfo)resList.get(0)).getACAFlag());
//					session.setAttribute("SESSION_ACBFLAG",				((UserInfo)resList.get(0)).getACBFlag());
//
//	 				session.setAttribute("SESSION_ADFLAG",				((UserInfo)resList.get(0)).getADFlag());
//					session.setAttribute("SESSION_ADAFLAG",				((UserInfo)resList.get(0)).getADAFlag());
//					session.setAttribute("SESSION_ADBFLAG",				((UserInfo)resList.get(0)).getADBFlag());
//
//					session.setAttribute("SESSION_AEFLAG",				((UserInfo)resList.get(0)).getAEFlag());
//                    session.setAttribute("SESSION_AEAFLAG",				((UserInfo)resList.get(0)).getAEAFlag());
//
//					session.setAttribute("SESSION_BFLAG",					((UserInfo)resList.get(0)).getBFlag());
//
//					session.setAttribute("SESSION_BAFLAG",				((UserInfo)resList.get(0)).getBAFlag());
//					session.setAttribute("SESSION_BAAFLAG",				((UserInfo)resList.get(0)).getBAAFlag());
//					session.setAttribute("SESSION_BABFLAG",				((UserInfo)resList.get(0)).getBABFlag());
//
//					session.setAttribute("SESSION_BBFLAG",				((UserInfo)resList.get(0)).getBBFlag());
//					session.setAttribute("SESSION_BBAFLAG",				((UserInfo)resList.get(0)).getBBAFlag());
//					session.setAttribute("SESSION_BBBFLAG",				((UserInfo)resList.get(0)).getBBBFlag());
//
//					session.setAttribute("SESSION_BCFLAG",				((UserInfo)resList.get(0)).getBCFlag());
//					session.setAttribute("SESSION_BCAFLAG",				((UserInfo)resList.get(0)).getBCAFlag());
//					session.setAttribute("SESSION_BCBFLAG",				((UserInfo)resList.get(0)).getBCBFlag());
//
//					session.setAttribute("SESSION_BDFLAG",				((UserInfo)resList.get(0)).getBDFlag());
//					session.setAttribute("SESSION_BDAFLAG",				((UserInfo)resList.get(0)).getBDAFlag());
//					session.setAttribute("SESSION_BDBFLAG",				((UserInfo)resList.get(0)).getBDBFlag());
//
//
//					session.setAttribute("SESSION_CFLAG",					((UserInfo)resList.get(0)).getCFlag());
//
//					session.setAttribute("SESSION_CAFLAG",				((UserInfo)resList.get(0)).getCAFlag());
//					session.setAttribute("SESSION_CAAFLAG",				((UserInfo)resList.get(0)).getCAAFlag());
//					session.setAttribute("SESSION_CABFLAG",				((UserInfo)resList.get(0)).getCABFlag());
//
//					session.setAttribute("SESSION_CBFLAG",				((UserInfo)resList.get(0)).getCBFlag());
//					session.setAttribute("SESSION_CBAFLAG",				((UserInfo)resList.get(0)).getCBAFlag());
//					session.setAttribute("SESSION_CBBFLAG",				((UserInfo)resList.get(0)).getCBBFlag());
//
//					session.setAttribute("SESSION_DFLAG",					((UserInfo)resList.get(0)).getDFlag());
//
//					session.setAttribute("SESSION_DAFLAG",				((UserInfo)resList.get(0)).getDAFlag());
//					session.setAttribute("SESSION_DAAFLAG",				((UserInfo)resList.get(0)).getDAAFlag());
//					session.setAttribute("SESSION_DABFLAG",				((UserInfo)resList.get(0)).getDABFlag());
//
//					session.setAttribute("SESSION_DBFLAG",				((UserInfo)resList.get(0)).getDBFlag());
//					session.setAttribute("SESSION_DBAFLAG",				((UserInfo)resList.get(0)).getDBAFlag());
//					session.setAttribute("SESSION_DBBFLAG",				((UserInfo)resList.get(0)).getDBBFlag());
//
//					session.setAttribute("SESSION_DCFLAG",				((UserInfo)resList.get(0)).getDCFlag());
//					session.setAttribute("SESSION_DCAFLAG",				((UserInfo)resList.get(0)).getDCAFlag());
//					session.setAttribute("SESSION_DCBFLAG",				((UserInfo)resList.get(0)).getDCBFlag());
//
//					session.setAttribute("SESSION_DDFLAG",				((UserInfo)resList.get(0)).getDDFlag());
//					session.setAttribute("SESSION_DDAFLAG",				((UserInfo)resList.get(0)).getDDAFlag());
//					session.setAttribute("SESSION_DDBFLAG",				((UserInfo)resList.get(0)).getDDBFlag());
//
//					session.setAttribute("SESSION_DEFLAG",				((UserInfo)resList.get(0)).getDEFlag());
//					session.setAttribute("SESSION_DEAFLAG",				((UserInfo)resList.get(0)).getDEAFlag());
//					session.setAttribute("SESSION_DEBFLAG",				((UserInfo)resList.get(0)).getDEBFlag());
//
//					session.setAttribute("SESSION_HARDSTATUS",			hardStatus);		// 접속로그 설정 메뉴
//
//	                	                
//	            }
//
//	            System.out.println("SESSION Setted! UserId => " + session.getAttribute("SESSION_USER_ID"));
//	        }
//	        catch (Exception ex)
//	        {
//	            logger.error(ex.toString());
//	        }
//	        
//    	}
//    	catch (NullPointerException e)
//    	{
//    		System.out.println("Param is null");
//    	}
//    	
//    	return "index";
//    }
    
    /**
     * FuncName : loginPage()
     * FuncDesc : 페이지 Move
     * Param    :
     * Return   : String
    */
    @RequestMapping(value = "/login/login.do", method = RequestMethod.GET)
    public String loginPage(Locale locale, Model model)
    {
    	String version = org.springframework.core.SpringVersion.getVersion();
        System.out.println("----- SpringVersion ----- " + version);
        
        return "login/login";
    }
    
    /**
     * FuncName : loginPopup()
     * FuncDesc : 페이지 Move
     * Param    :
     * Return   : String
    */
    @RequestMapping(value = "/login/forgotPw.do", method = RequestMethod.GET)
    public String forgotPw(Locale locale, Model model)
    {
        String version = org.springframework.core.SpringVersion.getVersion();
        System.out.println("----- SpringVersion ----- " + version);
        
        return "login/popup/forgotPwPop";
    }
    
    /**
     * FuncName : mainPage()
     * FuncDesc : 페이지 Move
     * Param    :
     * Return   : String
    */
    @RequestMapping(value = "/main/main.do", method = { RequestMethod.GET, RequestMethod.POST,  RequestMethod.HEAD } )
    public String mainPage(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session)
    {
        return "main/main";
    }

	/**
     * FuncName : baseAction()
     * FuncDesc : 페이지 Action
     * Param    : path : 지정경로
     * Return   : String
    */
    @RequestMapping(value = "/action/page.do", method = RequestMethod.POST)
    public ModelAndView baseAction(HttpServletRequest request, HttpServletResponse response, Locale locale, Model model)
    {
        System.out.println("----------POST----------");
        System.out.println(request.getParameter("path"));

        HttpSession session = request.getSession();
        AdminVo lgnVO = (AdminVo) session.getAttribute("admin");
        String adminId = lgnVO.getId();
        String adminNm = lgnVO.getName();
        
		InetAddress local = null;
		try {
			local = InetAddress.getLocalHost();
		} catch (UnknownHostException e1) {
			e1.printStackTrace();
		}
        
        Map<String, Object> param = new HashMap<String, Object>();
		String ip = local.getHostAddress();

		param.put("sessionId", request.getSession().getId());
		param.put("adminId", adminId);
		param.put("adminNm", adminNm);
		param.put("ip", ip);
		param.put("logType", "ACCESSPAGE");
		param.put("content", request.getParameter("path"));
        
		try {
	        baseService.baseInsert("log.insertLog", param);
		} catch (Exception ex) {
            logger.error(ex.toString());
		}
        
        ModelAndView mav = new ModelAndView();
        
        Enumeration params = request.getParameterNames();
        while (params.hasMoreElements()) {
			String name = (String) params.nextElement();
			mav.addObject(name, request.getParameter(name));
		}
        
        mav.setViewName(request.getParameter("path"));

		return mav;
    }


    /**
     * FuncName : baseActionGet()
     * FuncDesc : 페이지 Action
     * Param    : path : 지정경로
     * Return   : String
    */
    @RequestMapping(value = "/action/page.do", method = RequestMethod.GET)
    public String baseActionGet(HttpServletRequest request, Locale locale, Model model)
    {
        System.out.println("----------GET----------");
        System.out.println(request.getParameter("path"));
        return request.getParameter("path");
    }

    
    @RequestMapping(value = "/selectList/{sqlid}/action.do", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> selectUserList(@PathVariable("sqlid") String sqlid,ComDefaultVO vo,HttpServletRequest request, HttpServletResponse response, Locale locale, Model model) throws IOException, ModelAndViewDefiningException  {
    	response.setCharacterEncoding("UTF-8");
        response.setHeader("Access-Control-Allow-Origin","*"); // 크로스도메인 허용
        Map<String, Object> param = null;
		HttpSession session = request.getSession(false);
		AdminVo user = (AdminVo) session.getAttribute("admin");
		System.out.println("세션아이디 :: "+session.getId());
		System.out.println("탐??");		
		 
        if (request.getParameter("param").trim().equals("") == true)
        {
        	System.out.println("어디");
        	param = new HashMap<String, Object>();
        }
        else
        {
        	System.out.println("타니");
            param = JsonUtil.JsonToMap(request.getParameter("param"));
        }        
        System.out.println("파라미터 " + param);
        
        /** EgovPropertyService.sample */
        vo.setPageUnit(propertiesService.getInt("pageUnit"));
        //vo.setPageSize(propertiesService.getInt("pageSize")); //공통 아닌 파라미터로 가져오기
        vo.setPageIndex(vo.getPage());
   
        Map<String , Object> map = new HashMap<String ,  Object>();
        if(user!=null){
        	 List<Map<String, Object>> resList =  new ArrayList<Map<String, Object>>();
        	 String total;
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
            param.put("firstIndex", paginationInfo.getFirstRecordIndex());
            param.put("lastIndex", paginationInfo.getLastRecordIndex());
            param.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
            
            resList = baseService.baseSelectList(sqlid, param);
            total = baseService.baseSelectOne(sqlid+"Cnt", param);
 
             paginationInfo.setTotalRecordCount(Integer.parseInt(total));
            map.put("rows", resList);
            map.put("total", total);
            System.out.println(map);
        }
        else {
            map.put("rows", "sessionOut");
        }
        return map;
    }
    /**
     * FuncName : select()
     * FuncDesc : 조회
     * Param    : sqlid : SQL ID
     * Return   : String
    */
    @RequestMapping(value = "/select/{sqlid}/action.do", method = RequestMethod.POST)
    public String baseSelect(@PathVariable("sqlid") String sqlid,ComDefaultVO vo,HttpServletRequest request, HttpServletResponse response, Locale locale, Model model) throws IOException, ModelAndViewDefiningException {
        PrintWriter out = null;
        
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Access-Control-Allow-Origin","*"); // 크로스도메인 허용
        Map<String, Object> param = null;
		HttpSession session = request.getSession(false);
		AdminVo user = (AdminVo) session.getAttribute("admin");
		System.out.println("세션아이디 :: "+session.getId());
		System.out.println("탐??");		
		 
        if (request.getParameter("param").trim().equals("") == true)
        {
        	System.out.println("어디");
           param = new HashMap<String, Object>();
        }
        else
        {
        	System.out.println("타니");
            param = JsonUtil.JsonToMap(request.getParameter("param"));
        }
/*
        if (param.get("userId") != null)
        {
            if (session.getAttribute("SESSION_USER_ID") != param.get("userId"))
            {
                param.put("userId", session.getAttribute("SESSION_USER_ID"));
            }
        }
*/
        	        	
        List<Map<String, Object>> resList =  new ArrayList<Map<String, Object>>();

        try
        {
        	param.put("recordCountPerPage","-1");
            resList = baseService.baseSelectList(sqlid, param);
            JSONArray jsonList = new JSONArray(JsonUtil.ListToJson(resList));

            System.out.println("json = [" + jsonList + "]");
            
            model.addAttribute("jsonList", jsonList); // Retun Json String
            model.addAttribute("resList",  resList);

            out = response.getWriter();
            out.write(JsonUtil.ListToJson(resList)); // Ajax Retun Json String
            
            
        }
        catch (Exception ex)
        {
            logger.error(ex.toString());
        }
        
        
        return request.getParameter("path");
        
    }


    /**
     * FuncName : baseInsert()
     * FuncDesc : 등록
     * Param    : sqlid : SQL ID
     * Return   : String
    */
    @RequestMapping(value = "/insert/{sqlid}/action.do", method = RequestMethod.POST)
    public String baseInsert (@PathVariable("sqlid") String sqlid, HttpServletRequest request, HttpServletResponse response, Locale locale, Model model) throws IOException {
    	
        int	iResult = 0;

        Map<String, Object> param = JsonUtil.JsonToMap(request.getParameter("param"));

        try
        {
        	
                // Insert
                iResult = baseService.baseInsert(sqlid, param);
                System.out.println("INSERT iResult = [" + iResult + "]");

                if (iResult == 1)
                {
                    model.addAttribute("result", "SUCCESS");
                    model.addAttribute("path",    request.getParameter("path"));
                    model.addAttribute("action",  request.getParameter("action"));
                    model.addAttribute("message", "정상적으로 '등록' 되었습니다.");
                }
        	

        }
        catch (Exception ex)
        {
            logger.error(ex.toString());
        }

        return "/views/result/result";
    }


    /**
     * FuncName : baseUpdate()
     * FuncDesc : 수정
     * Param    : sqlid : SQL ID
     * Return   : String
    */
    @RequestMapping(value = "/update/{sqlid}/action.do", method = RequestMethod.POST)
    public String baseUpdate (@PathVariable("sqlid") String sqlid, HttpServletRequest request, Locale locale, Model model) throws IOException {
    	
        int iResult = 0;

        Map<String, Object> param = JsonUtil.JsonToMap(request.getParameter("param"));

        try
        {
			  // Update
                iResult = baseService.baseUpdate(sqlid, param);
                System.out.println("UPDATE iResult = [" + iResult + "]");

                if (iResult == 1)
                {
                    model.addAttribute("result", "SUCCESS");
                    model.addAttribute("path",    request.getParameter("path"));
                    model.addAttribute("action",  request.getParameter("action"));
                    model.addAttribute("message", "정상적으로 '수정' 되었습니다.");
                }
        
        }
        catch (Exception ex)
        {
            logger.error(ex.toString());
        }

        return "/views/result/result";
    }


    /**
     * FuncName : baseDelete()
     * FuncDesc : 삭제
     * Param    : sqlid : SQL ID
     * Return   : String
    */
    @RequestMapping(value = "/delete/{sqlid}/action.do", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> baseDelete (@PathVariable("sqlid") String sqlid, HttpServletRequest request, Locale locale, Model model) throws IOException {

        int iResult = 0;

        Map<String, Object> param = JsonUtil.JsonToMap(request.getParameter("param"));
        
        try 
        {
        	
                // Delete
                iResult = baseService.baseDelete(sqlid, param);
                System.out.println("DELETE iResult = [" + iResult + "]");

                if (iResult > -1)
                {
                    model.addAttribute("result", "SUCCESS");
                    model.addAttribute("path",    request.getParameter("path"));
                    model.addAttribute("action",  request.getParameter("action"));
                    model.addAttribute("message", "정상적으로 '삭제' 되었습니다.");
                }
        

        }
        catch(Exception ex)
        {
        	logger.error(ex.toString());
        }

        return param;
    }


    /**
     * 함수명   : ajaxInsertReturnSelectKey()
     * FuncDesc : ajax 등록 (Insert Key 반환)
     * Param    : sqlid : SQL ID
     * Return   : String
    */
    @RequestMapping(value = "/ajax/insert/idkey/{sqlid}/action.do", method = RequestMethod.POST)
    public void ajaxInsertReturnSelectKey (@PathVariable("sqlid") String sqlid, HttpServletRequest request, HttpServletResponse response, Locale locale, Model model) throws IOException {
    	
        String sResult = "";

        PrintWriter out = null;

        response.setCharacterEncoding("UTF-8");

        Map<String, Object> param = JsonUtil.JsonToMap(request.getParameter("param"));

        try
        {
		
                // Insert
                sResult = baseService.baseInsertReturnSelectKey(sqlid, param);
                System.out.println("INSERT iResult Key = [" + sResult + "]");

                if (sResult != "")
                {
                    out = response.getWriter();

                    out.write(JsonUtil.OneStringToJson(sResult));
              
        	}
        	else
        	{
        		out = response.getWriter();
        		out.write(JsonUtil.OneStringToJson("SESSION"));
        	}

        }
        catch (Exception ex)
        {
            logger.error(ex.toString());
        }
    }


    /**
     * FuncName : ajaxInsert()
     * FuncDesc : Ajax 등록
     * Param    : sqlid : SQL ID
     * Return   : String
    */
    @RequestMapping(value = "/ajax/insert/{sqlid}/action.do", method = RequestMethod.POST)
    public void ajaxInsert (@PathVariable("sqlid") String sqlid, HttpServletRequest request, HttpServletResponse response, Locale locale, Model model) throws IOException {

        int iResult = 0;

        PrintWriter out = null;

        response.setCharacterEncoding("UTF-8");

        Map<String, Object> param = JsonUtil.JsonToMap(request.getParameter("param"));

        try
        {
		
                // Insert
                iResult = baseService.baseInsert(sqlid, param);
                System.out.println("INSERT iResult = [" + iResult + "]");

                if (iResult > 0)
                {
                    out = response.getWriter();

                    out.write(JsonUtil.OneStringToJson("SUCCESS"));
            
        	}
        	else
        	{
        		out = response.getWriter();
        		out.write(JsonUtil.OneStringToJson("SESSION"));
        	}

        }
        catch (Exception ex)
        {
            logger.error(ex.toString());
        }
    }


    /**
     * FuncName : ajaxUpdate()
     * FuncDesc : Ajax 수정
     * Param    : sqlid : SQL ID
     * Return   : String
    */
    @RequestMapping(value = "/ajax/update/{sqlid}/action.do", method = RequestMethod.POST)
    public void ajaxUpdate (@PathVariable("sqlid") String sqlid, HttpServletRequest request, HttpServletResponse response, Locale locale, Model model) throws IOException {

        int iResult = 0;

        PrintWriter out = null;

        response.setCharacterEncoding("UTF-8");

        Map<String, Object> param = JsonUtil.JsonToMap(request.getParameter("param"));

        try
        {
			
                // Update
                iResult = baseService.baseUpdate(sqlid, param);
                System.out.println("UPDATE iResult = [" + iResult + "]");

                if (iResult > 0)
                {
                    out = response.getWriter();

                    out.write(JsonUtil.OneStringToJson("SUCCESS"));
                }
         
        	else
        	{
        		out = response.getWriter();
        		out.write(JsonUtil.OneStringToJson("SESSION"));
        	}
        }
        catch (Exception ex)
        {
            logger.error(ex.toString());
        }
    }


    /**
     * FuncName : ajaxDelete()
     * FuncDesc : Ajax 삭제
     * Param    : sqlid : SQL ID
     * Return   : String
    */
    @RequestMapping(value = "/ajax/delete/{sqlid}/action.do", method = RequestMethod.POST)
    public void ajaxDelete (@PathVariable("sqlid") String sqlid, HttpServletRequest request, HttpServletResponse response, Locale locale, Model model) throws IOException {

        int iResult = 0;

        PrintWriter out = null;

        response.setCharacterEncoding("UTF-8");

        Map<String, Object> param = JsonUtil.JsonToMap(request.getParameter("param"));

        try
        {
			
                // Delete
                iResult = baseService.baseDelete(sqlid, param);
                System.out.println("DELETE iResult = [" + iResult + "]");

                if (iResult > 0)
                {
                    out = response.getWriter();

                    out.write(JsonUtil.OneStringToJson("SUCCESS"));
                }
             
        	else
        	{
        		out = response.getWriter();
        		out.write(JsonUtil.OneStringToJson("SESSION"));
        	}
        }
        catch (Exception ex)
        {
            logger.error(ex.toString());
        }
    }


    /**
     * 함수명   : ajaxSave()
     * FuncDesc : Ajax C/U/D N건 처리
     * Param    : sqlCid : INSERT SQL ID,
     *            sqlUid : UPDATE SQL ID,
     *            sqlDid : DELETE SQL ID
     * Return   : String
    */
    @RequestMapping(value = "/ajax/save/{sqlCid}/{sqlUid}/{sqlDid}/action.do", method = RequestMethod.POST)
    public void ajaxSave (@PathVariable("sqlCid") String sqlCid,
                          @PathVariable("sqlUid") String sqlUid,
                          @PathVariable("sqlDid") String sqlDid,
                          HttpServletRequest request, HttpServletResponse response, Locale locale, Model model
                         )
    {
    	
	
        int iResult = 0;

        PrintWriter out = null;

        response.setCharacterEncoding("UTF-8");
        
        try
        {
		
                if (request.getParameter("param").trim().equals("") != true)
                {
                    JSONArray jsonArray = new JSONArray(request.getParameter("param").toString());

                    System.out.println("sqlCid = " + sqlCid);
                    System.out.println("sqlUid = " + sqlUid);
                    System.out.println("sqlDid = " + sqlDid);
                    System.out.println("jsonArray = " + jsonArray.length());

                    iResult = baseService.ajaxSave(sqlCid, sqlUid, sqlDid, jsonArray);
                    System.out.println("ajax SAVE iResult = [" + iResult + "]");

                    if (iResult == 1)
                    {
                        out = response.getWriter();

                        out.write(JsonUtil.OneStringToJson("SUCCESS"));
                    }
                    else
                    {
                        out = response.getWriter();

                        out.write(JsonUtil.OneStringToJson(BaseException.EXCEPTION_MESSAGE));
                    }
                }
        
        }
        catch (Exception ex)
        {
            logger.error(ex.toString());
        }
    }
    
    
    /**
     * 함수명   : ajaxInsertKey()
     * FuncDesc : Ajax C/U/D N건 처리
     * Param    : sqlid : 첫번째 INSERT SQL ID
     *            param : 첫번째 INSERT Parameter Data
     *            jsonArray : C/U/D Parameter Data
     * Return   : String : idKey
    */
    @RequestMapping(value = "/ajax/insert/multiTransaction/idkey/{sqlid}/action.do", method = RequestMethod.POST)
    public void ajaxInsertKey (@PathVariable("sqlid") String sqlid, HttpServletRequest request, HttpServletResponse response, Locale locale, Model model)
    {
    	boolean nullChk = true;
        String sResult = "";

        PrintWriter out = null;

        response.setCharacterEncoding("UTF-8");

        try
        {
			
                Map<String, Object> param = JsonUtil.JsonToMap(request.getParameter("param1"));
                
                JSONArray jsonArray = new JSONArray(request.getParameter("param2").toString());
                
                // Insert
                sResult = baseService.ajaxInsertKey(sqlid, param, jsonArray);
                System.out.println("INSERT iResult Key = [" + sResult + "]");

                if (sResult != "")
                {
                    out = response.getWriter();

                    out.write(JsonUtil.OneStringToJson(sResult));
                }
                else
                {
                    out = response.getWriter();

                    out.write(JsonUtil.OneStringToJson("ERROR"));
                }
        	
        }
        catch (Exception ex)
        {
            logger.error(ex.toString());
        }
    }


    /**
     * 함수명   : insertKeyMultiTransaction()
     * FuncDesc : Insert Key Transaction C/U/D N건 처리
     * Param    : sqlid : SQL ID
     * Return   : String
    */
    @RequestMapping(value = "/insertKeyMultiTransaction/{sqlid1}/{sqlid2}/{sqlid3}/{sqlid4}/action.do", method = RequestMethod.POST)
    public void insertKeyMultiTransaction (@PathVariable("sqlid1") String sqlid1,
                                           @PathVariable("sqlid2") String sqlid2,
                                           @PathVariable("sqlid3") String sqlid3,
                                           @PathVariable("sqlid4") String sqlid4,
                                           HttpServletRequest  request,
                                           HttpServletResponse response,
                                           Locale locale, Model model
                                          )
    {
    	boolean nullChk = true;
        int iResult = 0;

        PrintWriter out = null;

        response.setCharacterEncoding("UTF-8");

        System.out.println("sqlid1 = " + sqlid1);
        System.out.println("sqlid2 = " + sqlid2);
        System.out.println("sqlid3 = " + sqlid3);
        System.out.println("sqlid4 = " + sqlid4);

        try
        {
		
                JSONArray jsonArray1 = new JSONArray(request.getParameter("param1").toString());
                JSONArray jsonArray2 = new JSONArray(request.getParameter("param2").toString());
                JSONArray jsonArray3 = new JSONArray(request.getParameter("param3").toString());
                JSONArray jsonArray4 = new JSONArray(request.getParameter("param4").toString());

                iResult = baseService.insertKeyMultiTransaction(sqlid1, sqlid2, sqlid3, sqlid4, jsonArray1, jsonArray2, jsonArray3, jsonArray4);
                System.out.println("insertKeyMultiTransaction iResult = [" + iResult + "]");

                if (iResult > 0)
                {
                    out = response.getWriter();

                    out.write(JsonUtil.OneStringToJson("SUCCESS"));
                }
                else
                {
                    out = response.getWriter();

                    out.write(JsonUtil.OneStringToJson(BaseException.EXCEPTION_MESSAGE));
                }
        	
        }
        catch (Exception e)
        {
            logger.error(e.toString());
        }
    }


    /**
     * FuncName : setMultiTransaction()
     * FuncDesc : Transaction C/U/D N건 처리
     * Param    : sqlid1     : C/U/D 1번 SQL ID
     *            sqlid2     : C/U/D 2번 SQL ID
     *            sqlid3     : C/U/D 3번 SQL ID
     *            sqlid4     : C/U/D 4번 SQL ID
     *            jsonArray1 : C/U/D 1번 JSONArray
     *            jsonArray2 : C/U/D 2번 JSONArray
     *            jsonArray3 : C/U/D 3번 JSONArray
     *            jsonArray4 : C/U/D 4번 JSONArray
     * Return   : int
    */
    @RequestMapping(value = "/multiTransaction/{sqlid1}/{sqlid2}/{sqlid3}/{sqlid4}/action.do", method = RequestMethod.POST)
    public void setMultiTransaction (@PathVariable("sqlid1") String sqlid1,
                                     @PathVariable("sqlid2") String sqlid2,
                                     @PathVariable("sqlid3") String sqlid3,
                                     @PathVariable("sqlid4") String sqlid4,
                                     HttpServletRequest  request,
                                     HttpServletResponse response,
                                     Locale locale, Model model
                                    )
    {
    	boolean nullChk = true;
        int iResult = 0;

        PrintWriter out = null;

        response.setCharacterEncoding("UTF-8");

        System.out.println("sqlid1 = " + sqlid1);
        System.out.println("sqlid2 = " + sqlid2);
        System.out.println("sqlid3 = " + sqlid3);
        System.out.println("sqlid4 = " + sqlid4);

        try
        {
		
                JSONArray jsonArray1 = new JSONArray(request.getParameter("param1").toString());
                JSONArray jsonArray2 = new JSONArray(request.getParameter("param2").toString());
                JSONArray jsonArray3 = new JSONArray(request.getParameter("param3").toString());
                JSONArray jsonArray4 = new JSONArray(request.getParameter("param4").toString());

                iResult = baseService.setMultiTransaction(sqlid1, sqlid2, sqlid3, sqlid4, jsonArray1, jsonArray2, jsonArray3, jsonArray4);
                System.out.println("MultiTransaction iResult = [" + iResult + "]");

                if (iResult > 0)
                {
                    out = response.getWriter();

                    out.write(JsonUtil.OneStringToJson("SUCCESS"));
                }
                else
                {
                    out = response.getWriter();

                    out.write(JsonUtil.OneStringToJson(BaseException.EXCEPTION_MESSAGE));
                }
        
        	
        }
        catch (Exception e)
        {
            logger.error(e.toString());
        }
    }
    
    /**
     * FuncName : multiAjax
     * FuncDesc : 스크립트 세션 상태 체크
     * Param    : param
     * Return   : String
    */
    @RequestMapping(value = "/multiAjax/action.do", method = RequestMethod.POST)
	public void multiAjax(HttpServletRequest request, HttpServletResponse response, Locale locale, Model model) throws Exception {
    	
    	int iResult = 0;
    	PrintWriter out = null;
    	
    	Map<String, Object> param = JsonUtil.JsonToMap(request.getParameter("param"));
		//List<Map<String, Object>> recordset = JsonUtil.MapToJson();

		System.out.println("**************************************************************");
		System.out.println("param : " + param.toString());
		System.out.println("**************************************************************");

		String singleInsertSid = (String) param.get("singleInsertSid");
		String singleUpdateSid = (String) param.get("singleUpdateSid");
		String singleDeleteSid = (String) param.get("singleDeleteSid");
		String multiInsertsqlmapid = (String) param.get("multiInsertsqlmapid");
		String multiUpdatesqlmapid = (String) param.get("multiUpdatesqlmapid");
		String multiDeletesqlmapid = (String) param.get("multiDeletesqlmapid");
		
		if(singleInsertSid != null && !singleInsertSid.isEmpty())
		{
			System.out.println("**************************************************************");
			System.out.println("sqlmapid : " + singleInsertSid);
			System.out.println("param : " + param.toString());
			System.out.println("**************************************************************");
			
			iResult += baseService.baseInsert(singleInsertSid, param);
		}
		
		if(singleUpdateSid != null && !singleUpdateSid.isEmpty())
		{
			System.out.println("**************************************************************");
			System.out.println("sqlmapid : " + singleUpdateSid);
			System.out.println("pMap : " + param.toString());
			System.out.println("**************************************************************");
			
			iResult += baseService.baseUpdate(singleUpdateSid, param);
		}
		
		if(singleDeleteSid != null && !singleDeleteSid.isEmpty())
		{
			System.out.println("**************************************************************");
			System.out.println("sqlmapid : " + singleDeleteSid);
			System.out.println("param : " + param.toString());
			System.out.println("**************************************************************");
			
			iResult += baseService.baseDelete(singleDeleteSid, param);
		}
		
        System.out.println("iResult = [" + iResult + "]");

        if (iResult > 0)
        {
            out = response.getWriter();

            out.write(JsonUtil.OneStringToJson("SUCCESS"));
        }
        else
        {
            out = response.getWriter();

            out.write(JsonUtil.OneStringToJson(BaseException.EXCEPTION_MESSAGE));
        }

		/*if(recordset != null && recordset.size() > 0)
		{		
			System.out.println("**************************************************************");
			System.out.println("recordset : " + recordset.toString());
			System.out.println("**************************************************************");
			
			if(multiInsertsqlmapid != null && !multiInsertsqlmapid.isEmpty())
			{
				for (int i = 0; i < recordset.size(); i++) {
					HashMap dataList = (HashMap) recordset.get(i);
					baseService.baseInsert(multiInsertsqlmapid, dataList);
				}
			}
			
			if(multiUpdatesqlmapid != null && !multiUpdatesqlmapid.isEmpty())
			{
				for (int i = 0; i < recordset.size(); i++) {
					HashMap dataList = (HashMap) recordset.get(i);
					baseService.baseUpdate(multiUpdatesqlmapid, dataList);
				}			
			}
			
			if(multiDeletesqlmapid != null && !multiDeletesqlmapid.isEmpty())
			{
				for (int i = 0; i < recordset.size(); i++) {
					HashMap dataList = (HashMap) recordset.get(i);
					baseService.baseDelete(multiDeletesqlmapid, dataList);
				}			
			}
		}*/
	}
    
    /**
     * FuncName : baseSessionCheck
     * FuncDesc : 스크립트 세션 상태 체크
     * Param    : userId : userId
     * Return   : String
    */
    @RequestMapping(value = "/baseSessionCheck/action.do", method = RequestMethod.POST)
    public void baseSessionCheck (HttpServletRequest request, HttpServletResponse response, Locale locale, Model model) throws IOException {
   
        String result = "";

        PrintWriter out = null;

        Map<String, Object> param = JsonUtil.JsonToMap(request.getParameter("param"));
        
        try 
        {
        	
        		result = "true";
                //model.addAttribute("message", "세션이 만료되었습니다.");               
        
        	
        	out = response.getWriter();
    		out.write(JsonUtil.OneStringToJson(result));

        }
        catch(Exception ex)
        {
        	logger.error(ex.toString());
        }    
    }

    /**
     * FuncName : writeConnectLog
     * FuncDesc : 접속 로그 기록
     * Return   : String
    */
    @RequestMapping(value = "/writeConnectLog/action.do", method = RequestMethod.POST)
    public void writeConnectLog (HttpServletRequest request, HttpServletResponse response, Locale locale, Model model) throws IOException {
        String result = "";
        int iResult = 0;
        PrintWriter out = null;

        Map<String, Object> param = JsonUtil.JsonToMap(request.getParameter("param"));

        try
        {
        	param.put("connIP", CommonUtil.getClientIp(request));

			iResult = baseService.baseInsert("Common.insertConnectLog", param);

			if(iResult > 0)
			{
				result = "SUCCESS";
			}
			else
			{
				result = "FAIL";
			}
        	out = response.getWriter();
    		out.write(JsonUtil.OneStringToJson(result));

        }
        catch(Exception ex)
        {
        	logger.error(ex.toString());
        }
    }
    
    
    


}
