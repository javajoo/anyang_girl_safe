package com.danusys.platform.login.web;

import java.net.InetAddress;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.danusys.cmm.util.JsonUtil;
import com.danusys.platform.login.service.ConfigService;
import com.danusys.platform.login.service.LoginService;
import com.danusys.platform.login.service.ConfigVO;
import com.danusys.platform.user.service.UsrInfoService;
import com.danusys.platform.vo.AdminVo;
import com.danusys.platform.web.LoginManager;
import com.danusys.platform.west.service.LogService;
import com.danusys.platform.west.service.LogVO;
import com.danusys.service.BaseService;
import com.google.gson.Gson;

import egovframework.let.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
/**
 *
 * U-City Platform 로그인
 *
 */
public class LoginController {
	
	@Resource(name="adminLoginService")
	private LoginService loginService;
	
	@Resource(name="logService")
    private LogService logService;
	
	@Resource(name="configService")
	private ConfigService configService;

	@Resource(name="usrInfoService")
    private UsrInfoService usrInfoService;
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    @Autowired
    private BaseService baseService;
    
    /**
     * 로그인을 수행한다.
     * @param request
     * @param id
     * @param pwd
     * @return
     * @throws Exception 
     */
    @RequestMapping("/danu/com/platform/login2.do")
    public String login2(HttpServletRequest request, @RequestParam("id") String id, @RequestParam("pwd") String pwd) throws Exception {
        AdminVo lgnVO = loginService.login(request, id, pwd);
        LoginManager loginManager = LoginManager.getInstance();
        HttpSession session = request.getSession();
        loginManager.setSession(session, id);
        if (lgnVO != null) {
            request.getSession().setAttribute("admin", lgnVO); // 세션에 로그인 정보 바인드
        }
        return "redirect:/main.do";
    }
    @RequestMapping("/danu/com/platform/login.do")
    public String login(HttpServletRequest request, @RequestParam("id") String id, @RequestParam("pwd") String pwd) throws Exception {    
        System.out.println( "===================  /login.do BEGIN " );
        HttpSession session = request.getSession();
        String rtn = "redirect:/main.do";
        
        Map<String, Object> param = new HashMap<String, Object>();
    	param.put("id", id);
    	
        try{
        	/*로그인실패 카운트 체크 5번이상 실패 시 제한*/
        	int checkCnt = Integer.parseInt(baseService.baseSelectOne("girlSafe.getLoginFailCount", param));
            if(checkCnt >= 5) return rtn = "redirect:/loginError.do?err=3";
            
            AdminVo lgnVO = this.loginService.login(request, id, pwd);
            LoginManager loginManager = LoginManager.getInstance();
            loginManager.setSession(session, id);
            request.getSession().setAttribute("admin", lgnVO); // 세션에 로그인 정보 바인드
            System.out.println( "===================  /login.do getUserCount >>>> " + loginManager.getUserCount() );
            
            /*정상 로그인 시 로그인실패 카운트 초기화*/
            if(lgnVO != null) {
            	param.put("checkFlag", "O");
            	baseService.baseUpdate("girlSafe.updateLoginFailCount", param);
            }
        }catch(NullPointerException e){
            request.getSession().removeAttribute("admin");
            request.getSession().invalidate();
            System.out.println( "===================  /login.do NullPointerException >>>> " + e.getMessage() );
            rtn = "redirect:/loginError.do";
        }catch(Exception e){
        	/*로그인실패 시 카운트 +1*/
        	param.put("checkFlag", "X");
        	baseService.baseUpdate("girlSafe.updateLoginFailCount", param);
        	
            request.getSession().removeAttribute("admin");
            request.getSession().invalidate();
            System.out.println( "===================  /login.do Exception >>>> " + e.getMessage() );
            rtn = "redirect:/loginError.do?err=2";
        }
        return rtn;
    }
    
    @RequestMapping(value = "/updatePassword.do")
	public String actionGpkiRegist() throws Exception {
		return "include/passwordModal";
	}
	
	@RequestMapping("/uat/uia/passCheck.do")
	public void checkPass(HttpServletRequest request, @ModelAttribute("passwordBoard") AdminVo passwordBoard, HttpServletResponse response, ModelMap model) throws Exception {
		
		String saltText = this.propertiesService.getString("Globals.SaltText").trim();
		
		AdminVo loginVO = (AdminVo) request.getSession().getAttribute("admin");
		Map<String, Object> param = null;
		
		String resultJson;
		
		if (request.getParameter("param").trim().equals("") == true)
        {
        	param = new HashMap<String, Object>();
        }
        else
        {
            param = JsonUtil.JsonToMap(request.getParameter("param"));
        }
		param.put("userId",loginVO.getId());
		
		String password = (String) param.get("orgPassword");
    	//String userId = (String) param.get("userId");
		String orgPassword = EgovFileScrty.encryptPassword(password,saltText);
    	param.put("orgPassword", orgPassword);
		String resultDt = baseService.baseSelectOne("girlSafe.passCheck",param);
		
		resultJson = "{\"cnt\":\""+resultDt+"\"}";
		response.getWriter().print(resultJson);
	}
	
	@RequestMapping("/uat/uia/updatePassword.do")
	public void updatePassword(HttpServletRequest request,  HttpServletResponse response, @ModelAttribute("passwordBoard") AdminVo passwordBoard, ModelMap model) throws Exception {
		
		String saltText = this.propertiesService.getString("Globals.SaltText").trim();
		
		AdminVo loginVO = (AdminVo) request.getSession().getAttribute("admin");
		Map<String, Object> param = null;
		
		String resultCntJson;
		
		if (request.getParameter("param").trim().equals("") == true)
        {
        	param = new HashMap<String, Object>();
        }
        else
        {
            param = JsonUtil.JsonToMap(request.getParameter("param"));
        }
		
		param.put("userId",loginVO.getId());
		
		String orgPass = (String) param.get("orgPassword");
    	String newPass = (String) param.get("newPassword");
    	String passFlag = (String) param.get("passFlag");
		String orgPassword = EgovFileScrty.encryptPassword(orgPass,saltText);
		String newPassword = EgovFileScrty.encryptPassword(newPass,saltText);
    	param.put("orgPassword", orgPassword);
    	param.put("newPassword", newPassword);
    	param.put("passFlag", passFlag);
		
		int resultCnt = baseService.baseUpdate("girlSafe.updatePassword",param);
		System.out.println(resultCnt);
		
		resultCntJson = "{\"cnt\":\""+resultCnt+"\"}";
		response.getWriter().print(resultCntJson);

		loginVO.setPeriod("0");
		request.getSession().setAttribute("admin", loginVO);
	}
    
    /**
     * 로그아웃을 수행한다.
     * @param request
     * @param id
     * @param pwd
     * @return
     * @throws Exception 
     */
    @RequestMapping("/danu/com/platform/logout.do")
    public String logout(HttpServletRequest request) throws Exception {
        System.out.println("세션: "+request.getSession());
        String rtn = "redirect:/main.do";
        HttpSession session = request.getSession();
        System.out.println( "===================  /logout.do session >>>> " + session );
        AdminVo lgnVO = (AdminVo) session.getAttribute("admin");
        try{
            InetAddress local = InetAddress.getLocalHost();
            String ip = local.getHostAddress();
            
            LogVO logVO = new LogVO();
            logVO.setIp(ip);
            logVO.setSessionId(request.getSession().getId());
            logVO.setAdminId(lgnVO.getId());
            logVO.setAdminNm(lgnVO.getName());
            logService.writeLogoutLog(logVO);
            request.getSession().invalidate();
        }catch(Exception e){
            System.out.println( "===================  /logout.do Exception >>>> " + e.getMessage() );
            rtn = "redirect:/main.do";
        }
        return rtn;
    }
    
	/**
	 * 로그인페이지로 진입(최초의 진입점)
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = {"/main.do"})
	public ModelAndView getBetweenPage(HttpServletRequest request, ModelMap model) throws Exception{
		String err = request.getParameter("err");
		ModelAndView mav = new ModelAndView();
	    AdminVo lgnVO = (AdminVo) request.getSession().getAttribute("admin");
		ConfigVO configVo = (ConfigVO)configService.selectConfig();
		System.out.println("===================  /main.do 세션타임 >>>> "+request.getSession().getMaxInactiveInterval());
		System.out.println("===================  /main.do getUserId >>>> "+ request.getSession().getId());
	
		if (lgnVO == null) {
			mav.setViewName("login");
		} else {
			mav.addObject("admin", lgnVO);
			mav.addObject("config", configVo);
			mav.setViewName("gis");
		}
	    return mav;
	}
	@RequestMapping(value = {"/loginError.do"})
    public ModelAndView getLoginErrorPage(HttpServletRequest request, ModelMap model) throws Exception{
        String err = request.getParameter("err");
        ModelAndView mav = new ModelAndView();
        AdminVo lgnVO = (AdminVo) request.getSession().getAttribute("admin");
        ConfigVO configVo = (ConfigVO)configService.selectConfig();
        System.out.println("===================  /main.do 세션타임 >>>> "+request.getSession().getMaxInactiveInterval());
        System.out.println("===================  /main.do getUserId >>>> "+ request.getSession().getId());
    
        if (lgnVO == null) {
            mav.setViewName("loginError");
        } else {
            //request.getSession().removeAttribute("admin");
            request.getSession().invalidate();
            mav.setViewName("login");
        }
        
        /*로그인실패 카운트 체크 5번이상 실패 시 오류페이지 이동*/
        if(err.equals("3")) mav.setViewName("loginErrorCnt");
        
        return mav;
    }
	
	/**
	 * 메인화면 진입
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = {"/MainPage.do"})
	public ModelAndView getMgtMainPage(HttpServletRequest request) throws Exception{
		AdminVo vo = (AdminVo) request.getSession().getAttribute("admin");
		ConfigVO configVo = (ConfigVO)configService.selectConfig();
		System.out.println("===================  /MainPage.do 세션타임 >>>> "+request.getSession().getMaxInactiveInterval());
        System.out.println("===================  /MainPage.do getUserId >>>> "+ request.getSession().getId());
		ModelAndView mav = new ModelAndView();
		if (vo == null) {
			mav.setViewName("login");
		} else {
			mav.addObject("admin", vo);
			mav.addObject("config", configVo);
			if(vo.getAuthority().equals("E")) mav.setViewName("gis_iot");
			else mav.setViewName("gis");
		}
	    
	    return mav;
	}
	
    /**
     * 상황정보
     * @param request
     * @param model
     * @return
     * @throws Exception 
     */
    @RequestMapping(value = {"/situationInfo.do"})
    public ModelAndView getSituationInfoPage(HttpServletRequest request, ModelMap model) throws Exception{
        AdminVo vo = (AdminVo) request.getSession().getAttribute("admin");
        ConfigVO configVo = (ConfigVO)configService.selectConfig();
        System.out.println("getBetweenPage 세션시간 : "+request.getSession().getMaxInactiveInterval());
        ModelAndView mav = new ModelAndView();
        if (vo == null) {
            mav.setViewName("login");
        } else {
            mav.addObject("admin", vo);
            mav.addObject("config", configVo);
            mav.setViewName("situation_info");
        }
        return mav;
    }   
 
    /**
     * 업무처리
     * @param request
     * @param model
     * @return
     * @throws Exception 
     */
    @RequestMapping(value = {"/workProcess.do"})
    public ModelAndView getWorkProcessPage(HttpServletRequest request, ModelMap model) throws Exception{
        AdminVo vo = (AdminVo) request.getSession().getAttribute("admin");
        ConfigVO configVo = (ConfigVO)configService.selectConfig();
        System.out.println("getBetweenPage 세션시간 : "+request.getSession().getMaxInactiveInterval());
        ModelAndView mav = new ModelAndView();
        if (vo == null) {
            mav.setViewName("login");
        } else {
            mav.addObject("admin", vo);
            mav.addObject("config", configVo);
            mav.setViewName("work_process");
        }
        return mav;
    }  
    
    /**
     * 상황이력
     * @param request
     * @param model
     * @return
     * @throws Exception 
     */
    @RequestMapping(value = {"/situationHistory.do"})
    public ModelAndView getSituationHistoryPage(HttpServletRequest request, ModelMap model) throws Exception{
        AdminVo vo = (AdminVo) request.getSession().getAttribute("admin");
        ConfigVO configVo = (ConfigVO)configService.selectConfig();
        System.out.println("getBetweenPage 세션시간 : "+request.getSession().getMaxInactiveInterval());
        ModelAndView mav = new ModelAndView();
        if (vo == null) {
            mav.setViewName("login");
        } else {
            mav.addObject("admin", vo);
            mav.addObject("config", configVo);
            mav.setViewName("situation_history");
        }
        return mav;
    }   
    /**
     * 상황통계
     * @param request
     * @param model
     * @return
     * @throws Exception 
     */
    @RequestMapping(value = {"/situationStats.do"})
    public ModelAndView getSitualionStatsPage(HttpServletRequest request, ModelMap model) throws Exception{
        AdminVo vo = (AdminVo) request.getSession().getAttribute("admin");
        ConfigVO configVo = (ConfigVO)configService.selectConfig();
        System.out.println("getBetweenPage 세션시간 : "+request.getSession().getMaxInactiveInterval());
        ModelAndView mav = new ModelAndView();
        if (vo == null) {
            mav.setViewName("login");
        } else {
            mav.addObject("admin", vo);
            mav.addObject("config", configVo);
            mav.setViewName("situation_stats");
        }
        return mav;
    }   
    /**
     * 커뮤니티
     * @param request
     * @param model
     * @return
     * @throws Exception 
     */
    @RequestMapping(value = {"/cop.do"})
    public ModelAndView getCopPage(HttpServletRequest request, ModelMap model) throws Exception{
        AdminVo vo = (AdminVo) request.getSession().getAttribute("admin");
        ConfigVO configVo = (ConfigVO)configService.selectConfig();
        System.out.println("getBetweenPage 세션시간 : "+request.getSession().getMaxInactiveInterval());
        ModelAndView mav = new ModelAndView();
        if (vo == null) {
            mav.setViewName("login");
        } else {
            mav.addObject("admin", vo);
            mav.addObject("config", configVo);
            mav.setViewName("cop");
        }
        return mav;
    }   
    /**
     * 시스템
     * @param request
     * @param model
     * @return
     * @throws Exception 
     */
    @RequestMapping(value = {"/system.do"})
    public ModelAndView getSystemPage(HttpServletRequest request, ModelMap model) throws Exception{
        AdminVo vo = (AdminVo) request.getSession().getAttribute("admin");
        ConfigVO configVo = (ConfigVO)configService.selectConfig();
        System.out.println("getBetweenPage 세션시간 : "+request.getSession().getMaxInactiveInterval());
        ModelAndView mav = new ModelAndView();
        if (vo == null) {
            mav.setViewName("login");
        } else {
            mav.addObject("admin", vo);
            mav.addObject("config", configVo);
            mav.setViewName("system");
        }
        return mav;
    }	
    /**
     * 환경설정
     * @param request
     * @param model
     * @return
     * @throws Exception 
     */
    @RequestMapping(value = {"/setting.do"})
    public ModelAndView getSettingPage(HttpServletRequest request, ModelMap model) throws Exception{
        AdminVo vo = (AdminVo) request.getSession().getAttribute("admin");
        ConfigVO configVo = (ConfigVO)configService.selectConfig();
        System.out.println("getBetweenPage 세션시간 : "+request.getSession().getMaxInactiveInterval());
        ModelAndView mav = new ModelAndView();
        if (vo == null) {
            mav.setViewName("login");
        } else {
            mav.addObject("admin", vo);
            mav.addObject("config", configVo);
            mav.setViewName("setting");
        }
        return mav;
    }   
    /**
     * 사용자정보
     * @param request
     * @param model
     * @return
     * @throws Exception 
     */
    @RequestMapping(value = {"/wrks/sstm/usr/info.do"})
    public ModelAndView getInfoPage(HttpServletRequest request, ModelMap model) throws Exception{
        AdminVo vo = (AdminVo) request.getSession().getAttribute("admin");
        ConfigVO configVo = (ConfigVO)configService.selectConfig();
        System.out.println("getBetweenPage 세션시간 : "+request.getSession().getMaxInactiveInterval());
        ModelAndView mav = new ModelAndView();
        if (vo == null) {
            mav.setViewName("login");
        } else {
            mav.addObject("admin", vo);
            mav.addObject("config", configVo);
            mav.setViewName("/user/info");
        }
        return mav;
    }
    /**
     * 지역정보
     * @param request
     * @param model
     * @return
     * @throws Exception 
     */
    @RequestMapping(value = {"/wrks/sstm/usr/area.do"})
    public ModelAndView getAreaPage(HttpServletRequest request, ModelMap model) throws Exception{
        AdminVo vo = (AdminVo) request.getSession().getAttribute("admin");
        ConfigVO configVo = (ConfigVO)configService.selectConfig();
        System.out.println("getBetweenPage 세션시간 : "+request.getSession().getMaxInactiveInterval());
        ModelAndView mav = new ModelAndView();
        if (vo == null) {
            mav.setViewName("login");
        } else {
            mav.addObject("admin", vo);
            mav.addObject("config", configVo);
            mav.setViewName("/user/area");
        }
        return mav;
    }    
    /**
     * 그룹관리
     * @param request
     * @param model
     * @return
     * @throws Exception 
     */
    @RequestMapping(value = {"/wrks/sstm/grp/code.do"})
    public ModelAndView getGroupInfo(HttpServletRequest request, ModelMap model) throws Exception{
        AdminVo vo = (AdminVo) request.getSession().getAttribute("admin");
        ConfigVO configVo = (ConfigVO)configService.selectConfig();
        System.out.println("getBetweenPage 세션시간 : "+request.getSession().getMaxInactiveInterval());
        ModelAndView mav = new ModelAndView();
        if (vo == null) {
            mav.setViewName("login");
        } else {
            mav.addObject("admin", vo);
            mav.addObject("config", configVo);
            mav.setViewName("/group/group_info");
        }
        return mav;
    }    
    /**
     * 그룹별사용자조회
     * @param request
     * @param model
     * @return
     * @throws Exception 
     */
    @RequestMapping(value = {"/wrks/sstm/grp/user.do"})
    public ModelAndView getGroupUser(HttpServletRequest request, ModelMap model) throws Exception{
        AdminVo vo = (AdminVo) request.getSession().getAttribute("admin");
        ConfigVO configVo = (ConfigVO)configService.selectConfig();
        System.out.println("getBetweenPage 세션시간 : "+request.getSession().getMaxInactiveInterval());
        ModelAndView mav = new ModelAndView();
        if (vo == null) {
            mav.setViewName("login");
        } else {
            mav.addObject("admin", vo);
            mav.addObject("config", configVo);
            mav.setViewName("/group/group_user");
        }
        return mav;
    }       
    
	
	@RequestMapping("danu/com/platform/adminList.do")
	public @ResponseBody List<?> adminList(@ModelAttribute("searchVO") AdminVo vo, HttpServletRequest request) throws Exception {
		vo.setKey(propertiesService.getString("AES_KEY"));
		//System.out.println("================ "+propertiesService.getString("AES_KEY"));
		return loginService.adminList(vo);
	}
	
	@RequestMapping("danu/com/platform/insertAdminList.do")
	public @ResponseBody Map<String, String> insertAdminList(AdminVo vo, SessionStatus status) throws Exception {
		Map<String , String> map = new HashMap<String , String>();
		
		vo.setKey(propertiesService.getString("AES_KEY"));
		loginService.insertAdminList(vo);
		try{
        	map.put("stat", "sucess");
    	}catch(Exception exx){
    		map.put("stat", exx.toString());
    	}
		status.setComplete();
        return map;
	}
	
	@RequestMapping("danu/com/platform/chkAdminPwd.do")
	public @ResponseBody String chkAdminPwd(AdminVo vo) throws Exception {
		return loginService.chkAdminPwd(vo);
	}
	
	@RequestMapping("danu/com/platform/updateAdminList.do")
	public @ResponseBody Map<String, String> updateAdminList(AdminVo vo, SessionStatus status) throws Exception {
		Map<String , String> map = new HashMap<String , String>();
		
		vo.setKey(propertiesService.getString("AES_KEY"));
		loginService.updateAdminList(vo);
		try{
        	map.put("stat", "sucess");
    	}catch(Exception exx){
    		map.put("stat", exx.toString());
    	}
		status.setComplete();
        return map;
	}
	
	@RequestMapping("danu/com/platform/deleteAdminList.do")
	public @ResponseBody Map<String, String> deleteAdminList(HttpServletRequest request) throws Exception {
		Map<String , String> map = new HashMap<String , String>();
		
		int seqNoCnt = Integer.parseInt(request.getParameter("cnt"));
    	ArrayList<String> seqNoList = new ArrayList<String>(seqNoCnt);
    	
    	for(int i = 0; i < seqNoCnt; i++){
    		seqNoList.add(request.getParameter("seqNo"+i));
    	}
    	
    	AdminVo vo = new AdminVo();
    	vo.setSeqNoList(seqNoList);
		
		loginService.deleteAdminList(vo);
		try{
        	map.put("stat", "sucess");
    	}catch(Exception exx){
    		map.put("stat", exx.toString());
    	}
        return map;
	}
	
	  @RequestMapping({"/wrks/lgn/myinfo.do"})
	  public String myInfo(@ModelAttribute("loginVO") AdminVo adminVo, HttpServletRequest request, HttpServletResponse response, ModelMap model)
	    throws Exception
	  {
	    //LoginVO lgnVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	    AdminVo lgnVO = (AdminVo) request.getSession().getAttribute("admin");
	    String sesUserId = lgnVO.getId();
	    System.out.println("============================= myinfo.do >>>> "+sesUserId);
	    Map<String, String> args = new HashMap();
	    args.put("sysId", lgnVO.getAuthority());
	    args.put("USER_ID", sesUserId);
	    args.put("USER_NM_KO", "");
	    args.put("USE_TY_CD", "Y");
	    args.put("MOBL_NO", "");
	    args.put("pageNo", "1");
	    args.put("rowsPerPage", "15");
	    args.put("sidx", "USER_ID");
	    args.put("sord", "ASC");
	    System.out.println("============================= myinfo.do >>>> "+args);
	    List<Map<String, String>> lst = this.usrInfoService.list(args);
	    request.setAttribute("myinfoList", lst);
	    request.setAttribute("myinfoListJson", new Gson().toJson(lst));
	    
	    return "user/myinfo";
	  }
	    
	    /**
	     * 통합업무
	     * @param request
	     * @param model
	     * @return
	     * @throws Exception 
	     */
	    @RequestMapping(value = {"/mainWork.do"})
	    public ModelAndView getWorkPage(HttpServletRequest request, ModelMap model) throws Exception{
	        String err = request.getParameter("err");
	        ModelAndView mav = new ModelAndView();
	        AdminVo lgnVO = (AdminVo) request.getSession().getAttribute("admin");
	        ConfigVO configVo = (ConfigVO)configService.selectConfig();
	        System.out.println("===================  /main.do 세션타임 >>>> "+request.getSession().getMaxInactiveInterval());
	        System.out.println("===================  /main.do getUserId >>>> "+ request.getSession().getId());
	    
	        if (lgnVO == null) {
	            mav.setViewName("login");
	        } else {
	            mav.addObject("admin", lgnVO);
	            mav.addObject("config", configVo);
	            mav.setViewName("situation_info"); //main_work
	        }
	        return mav;
	    }
	    
	    /**
	     * 통합업무
	     * @param request
	     * @param model
	     * @return
	     * @throws Exception 
	     */
	    @RequestMapping(value = {"/work/event/item.do"})
	    public ModelAndView getEventItemInfoPage(HttpServletRequest request, ModelMap model) throws Exception{
	    	String err = request.getParameter("err");
	        ModelAndView mav = new ModelAndView();
	        AdminVo lgnVO = (AdminVo) request.getSession().getAttribute("admin");
	        ConfigVO configVo = (ConfigVO)configService.selectConfig();
	        System.out.println("===================  /main.do 세션타임 >>>> "+request.getSession().getMaxInactiveInterval());
	        System.out.println("===================  /main.do getUserId >>>> "+ request.getSession().getId());
	    
	        if (lgnVO == null) {
	            mav.setViewName("login");
	        } else {
	            mav.addObject("admin", lgnVO);
	            mav.addObject("config", configVo);
	            mav.setViewName("/work/item"); //main_work
	        }
	        return mav;
	    }  
	  
}
