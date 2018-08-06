package com.danusys.platform.user.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.let.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import com.danusys.platform.code.service.CodeCmcdService;
import com.danusys.platform.user.service.AdminDefaultVO;
import com.danusys.platform.user.service.CmUserService;
import com.danusys.platform.user.service.CmUserVO;

import egovframework.com.cmm.LoginVO;

import com.danusys.cmm.EgovUserDetailsHelper;
import com.danusys.cmm.util.CommonUtil;
import com.danusys.platform.user.service.UsrInfoService;
import com.danusys.platform.vo.AdminVo; //login

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * @Class Name : CmUserController.java
 * @Description : CmUser Controller class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-04-11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=CmUserVO.class)
public class CmUserController {

    private final Logger logger = LogManager.getLogger(getClass());
    
    @Resource(name = "cmUserService")
    private CmUserService cmUserService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    @Resource(name="usrInfoService")
    private UsrInfoService usrInfoService;
    @Resource(name="codeCmcdService")
    private CodeCmcdService codeCmcdService;
    
    @RequestMapping({"/wrks/sstm/usr/info/list.do"})
    @ResponseBody
    public Map<String, Object> list(ModelMap model, HttpServletRequest request, HttpServletResponse response)  throws Exception
    {
        
      Map<String, Object> map = new HashMap();
      
      String userId = request.getParameter("userId");
      String userNmKo = request.getParameter("userNmKo");
      String useTyCd = request.getParameter("useTyCd");
      String moblNo = request.getParameter("moblNo");
      String pageNo = request.getParameter("page");
      String rowsPerPage = request.getParameter("rows");
      String sidx = request.getParameter("sidx");
      String sord = request.getParameter("sord");
      
      //LoginVO lgnVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
      AdminVo lgnVO = (AdminVo) request.getSession().getAttribute("admin");
      //LoginVO lgnVO = (LoginVO)request.getSession().getAttribute("LoginVO");
      //EgovUserDetailsHelper.isAuthenticated()? (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser():null;
      /*LoginVO user = EgovUserDetailsHelper.isAuthenticated()? (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser():null;*/
      //System.out.println("======================"+lgnVO.getId());
      Map<String, String> args = new HashMap();
      
      args.put("sysId", lgnVO.getAuthority());//GRP_ID
      args.put("USER_ID", userId);
      args.put("USER_NM_KO", userNmKo);
      args.put("USE_TY_CD", useTyCd);
      args.put("MOBL_NO", moblNo);
      args.put("pageNo", pageNo);
      args.put("rowsPerPage", rowsPerPage);
      args.put("sidx", sidx);
      args.put("sord", sord);
      
      List<Map<String, String>> list = this.usrInfoService.list(args);
      map.put("rows", list);
      map.put("page", pageNo);
      System.out.println(map);
      return map;
    }    
    @RequestMapping({"/wrks/sstm/usr/info/insert.do"})
    @ResponseBody
    public Map<String, Object> insert(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception
    {
      //LoginVO lgnVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
      AdminVo lgnVO = (AdminVo) request.getSession().getAttribute("admin");
      String sesUserId = lgnVO.getId();
      System.out.println("================="+sesUserId);
      String[] grpIds = request.getParameterValues("grpId");
      String[] authLvls = request.getParameterValues("authLvl");
      
      String userId = request.getParameter("userId");
      String password = request.getParameter("password");
      if (password == null)
      {
        Map<String, Object> map = new HashMap();
        map.put("msg", "비밀번호의 값이 없습니다.");
        return map;
      }
      List<Map<String, String>> grplist = new ArrayList();
      int grpCnt = grpIds.length;
      if (grpCnt > 0) {
        for (int i = 0; i < grpCnt; i++)
        {
          Map<String, String> map_item_id = new HashMap();
          
          map_item_id.put("GRP_ID", grpIds[i]);
          map_item_id.put("USER_ID", userId);
          map_item_id.put("USE_TY_CD", "Y");
          map_item_id.put("AUTH_LVL", authLvls[i]);
          map_item_id.put("RGS_USER_ID", sesUserId);
          map_item_id.put("UPD_USER_ID", sesUserId);
          
          grplist.add(map_item_id);
        }
      }
      String[] areaCds = request.getParameterValues("areaCd");
      List<Map<String, String>> arealist = new ArrayList();
      int areaCnt = areaCds.length;
      if (areaCnt > 0) {
        for (int i = 1; i < areaCnt; i++)
        {
          Map<String, String> map_item_id = new HashMap();
          map_item_id.put("AREA_CD", areaCds[i]);
          map_item_id.put("USER_ID", userId);
          map_item_id.put("USE_TY_CD", "Y");
          map_item_id.put("RGS_USER_ID", sesUserId);
          map_item_id.put("UPD_USER_ID", sesUserId);
          arealist.add(map_item_id);
        }
      }
      System.out.println(grplist);
      System.out.println(arealist);
      Map<String, Object> map_ret = new HashMap();
      
      String saltText = EgovStringUtil.isNullToStringChange(this.propertiesService.getString("Globals.SaltText").trim(), "scmpworld");
      //System.out.println("===========================saltText:"+saltText);
      String ssoLoginTag = EgovStringUtil.isNullToStringChange(this.propertiesService.getString("Globals.SSOLogin").trim(), "UCP");
      //System.out.println("===========================ssoLoginTag:"+ssoLoginTag);
      String dbEncryptTag = EgovStringUtil.isNullToStringChange(this.propertiesService.getString("Globals.DBEncrypt").trim(), "UCP");
      //System.out.println("===========================dbEncryptTag:"+dbEncryptTag);
      String userPw;
      if ("UCP".equals(dbEncryptTag)) {System.out.println("===========================UCP:"+("UCP".equals(dbEncryptTag)));
        userPw = EgovFileScrty.encryptPassword(request.getParameter("adminPw"), saltText);
      } else {
        userPw = request.getParameter("adminPw");
      }
      String sesUserPw = lgnVO.getPwd();
      
      Map<String, Object> map = new HashMap();
      
      map.put("USER_ID", userId);
      
      map.put("USER_NM_KO", request.getParameter("userNmKo"));
      map.put("USER_NM_EN", request.getParameter("userNmEn"));
      map.put("USE_TY_CD", request.getParameter("useTyCd"));
      map.put("MOBL_NO", request.getParameter("moblNo"));
      map.put("EMAIL", request.getParameter("email"));
      map.put("OFFC_TEL_NO", request.getParameter("offcTelNo"));
      map.put("INSTT_NM", request.getParameter("insttNm"));
      map.put("DEPT_NM", request.getParameter("deptNm"));
      map.put("RANK_NM", request.getParameter("rankNm"));
      map.put("RPSB_WORK", request.getParameter("rpsbWork"));
      map.put("IP_ADRES", request.getParameter("ipAdres"));
      map.put("IP_TY_CD", request.getParameter("ipTyCd"));
      map.put("IP_CD", request.getParameter("ipCd"));
      map.put("REMARK", request.getParameter("remark"));
      map.put("RGS_USER_ID", sesUserId);
      
      map.put("dbEncryptTag", dbEncryptTag);
      map.put("ssoLoginTag", ssoLoginTag);
      
      String[] DSTRT_CD = request.getParameterValues("dstrtCd");
      Map<String, String> dstrtMap = new HashMap();
      int dstetCnt = DSTRT_CD.length;
      if (dstetCnt > 0)
      {
        for (int i = 0; i < dstetCnt; i++) {
          dstrtMap.put("DSTRT_CD", DSTRT_CD[i]);
        }
        dstrtMap.put("USER_ID", userId);
        dstrtMap.put("RGS_USER_ID", sesUserId);
      }
      if (!CommonUtil.checkDataFilterObj(map))
      {
        map_ret.put("session", Integer.valueOf(1));
        map_ret.put("msg", "특수문자를 포함한 자료는 저장할 수 없습니다.");
        return map_ret;
      }
      if ("UCP".equals(dbEncryptTag)) {
        map.put("PASSWORD", EgovFileScrty.encryptPassword(password, saltText));
      } else {
        map.put("PASSWORD", password);
      }
      try
      {
        int insertResult = 0;
        try
        {
          insertResult = this.usrInfoService.insert(map, grplist, arealist, dstrtMap);
        }
        catch (DataIntegrityViolationException e)
        {
          if (e.getRootCause().getMessage().indexOf("UNIQUE constraint violation") >= 0)
          {
            map_ret.put("session", Integer.valueOf(0));
            map_ret.put("msg", "이미 등록된 코드입니다.");
            return map_ret;
          }
          this.logger.error("insert DataIntegrityViolationException : {}", new Object[] { e.getMessage() });
        }
        catch (UncategorizedSQLException e)
        {
          if (e.getCause().getMessage().indexOf("JDBC-590730") >= 0)
          {
            map_ret.put("session", Integer.valueOf(0));
            map_ret.put("msg", "아이디 확인 후 다시 등록해 주십시요.");
            return map_ret;
          }
          this.logger.error("insert UncategorizedSQLException : {}", new Object[] { e.getMessage() });
        }
        catch (Exception e)
        {
          this.logger.error("insert Exception : {}", new Object[] { e.getMessage() });
        }
        if (insertResult == 0)
        {
          map_ret.put("session", Integer.valueOf(0));
          map_ret.put("msg", "등록에 실패하였습니다..");
          return map_ret;
        }
        map_ret.put("session", Integer.valueOf(1));
        map_ret.put("msg", "저장하였습니다.");
      }
      catch (Exception e)
      {
        map_ret.put("session", Integer.valueOf(0));
        map_ret.put("msg", "알수 없는 에러!!!");
      }
      return map_ret;
    }   
    
    @RequestMapping({"/wrks/sstm/usr/info/delete.do"})
    @ResponseBody
    public Map<String, Object> delete(ModelMap model, HttpServletRequest request, HttpServletResponse response)
      throws Exception
    {
      //LoginVO lgnVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
      AdminVo lgnVO = (AdminVo) request.getSession().getAttribute("admin");
      String sesUserId = lgnVO.getId();
      String dUserId = request.getParameter("userId");
      
      Map<String, Object> map = new HashMap();
      Map<String, Object> mapRet = new HashMap();
      
      map.put("USER_ID", request.getParameter("userId"));
      map.put("UPD_USER_ID", sesUserId);
      
      logger.error("delete : {} / {}", sesUserId, dUserId);
      if (!sesUserId.equals(dUserId))
      {
        logger.error("=================delete.do 삭제성공 ");
        
        int ret = this.usrInfoService.delete(map);
        
        mapRet.put("session", Integer.valueOf(1));
        mapRet.put("msg", "삭제하였습니다.");
      }
      else
      {
        logger.error("=================delete.do 접속중인 아이디는 삭제불가 ");
        
        mapRet.put("session", Integer.valueOf(0));
        mapRet.put("msg", "접속중인 아이디는 삭제할 수 없습니다.");
      }
      return mapRet;
    }
    
    @RequestMapping({"/wrks/sstm/usr/info/list_grp.do"})
    @ResponseBody
    public Map<String, Object> list_grp(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, HttpServletResponse response, ModelMap model)
      throws Exception
    {
      String userId = request.getParameter("userId");
      String pageNo = request.getParameter("page");
      String rowsPerPage = request.getParameter("rows");
      String sidx = request.getParameter("sidx");
      String sord = request.getParameter("sord");
      
      Map<String, String> args = new HashMap();
      args.put("USER_ID", userId);
      args.put("pageNo", pageNo);
      args.put("rowsPerPage", rowsPerPage);
      args.put("sidx", sidx);
      args.put("sord", sord);
      List<Map<String, String>> result_rows = this.usrInfoService.getCM_GROUP(args);
      
      Map<String, Object> map = new HashMap();
      map.put("page", pageNo);
      map.put("rows", result_rows);
      return map;
    }

    @RequestMapping({"/wrks/sstm/usr/info/list_user_area.do"})
    @ResponseBody
    public Map<String, Object> list_user_area(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, HttpServletResponse response, ModelMap model)
      throws Exception
    {
      String userId = request.getParameter("userId");
      String pageNo = request.getParameter("page");
      String rowsPerPage = request.getParameter("rows");
      String sidx = request.getParameter("sidx");
      String sord = request.getParameter("sord");
      
      Map<String, String> args = new HashMap();
      args.put("USER_ID", userId);
      args.put("pageNo", pageNo);
      args.put("rowsPerPage", rowsPerPage);
      args.put("sidx", sidx);
      args.put("sord", sord);
      List<Map<String, String>> result_rows = this.usrInfoService.getCM_USER_AREA(args);
      
      Map<String, Object> map = new HashMap();
      map.put("page", pageNo);
      map.put("rows", result_rows);
      return map;
    }    

    @RequestMapping({"/wrks/sstm/usr/info/list_user_grp.do"})
    @ResponseBody
    public Map<String, Object> list_user_grp(@ModelAttribute("loginVO") com.danusys.cmm.LoginVO loginVO, HttpServletRequest request, HttpServletResponse response, ModelMap model)
      throws Exception
    {
      String userId = request.getParameter("userId");
      String pageNo = request.getParameter("page");
      String rowsPerPage = request.getParameter("rows");
      String sidx = request.getParameter("sidx");
      String sord = request.getParameter("sord");
      
      Map<String, String> args = new HashMap();
      args.put("USER_ID", userId);
      args.put("pageNo", pageNo);
      args.put("rowsPerPage", rowsPerPage);
      args.put("sidx", sidx);
      args.put("sord", sord);
      List<Map<String, String>> result_rows = this.usrInfoService.getCM_GRP_USER(args);
      
      Map<String, Object> map = new HashMap();
      map.put("page", pageNo);
      map.put("rows", result_rows);
      return map;
    }    
    
    @RequestMapping({"/wrks/sstm/usr/info/update.do"})
    @ResponseBody
    public Map<String, Object> updateUserInfo(ModelMap model, HttpServletRequest request, HttpServletResponse response)
      throws Exception
    {
      //LoginVO lgnVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
      AdminVo lgnVO = (AdminVo) request.getSession().getAttribute("admin");
      String sesUserId = lgnVO.getId();
      
      Map<String, Object> mapRet = new HashMap();
      
      String ssoLoginTag = this.propertiesService.getString("Globals.SSOLogin").trim();
      //System.out.println("===========================ssoLoginTag:"+ssoLoginTag);
      //String ucpSiteTag = this.propertiesService.getString("Globals.UcpSite").trim();
      //System.out.println("===========================ucpSiteTag:"+ucpSiteTag);
      String dbEncryptTag = this.propertiesService.getString("Globals.DBEncrypt").trim();
      //System.out.println("===========================dbEncryptTag:"+dbEncryptTag);
      String saltText = this.propertiesService.getString("Globals.SaltText").trim();
      //System.out.println("===========================saltText:"+saltText);
      String userPw;
      
      if ("UCP".equals(dbEncryptTag)) {
        userPw = EgovFileScrty.encryptPassword(request.getParameter("adminPw"), saltText);
      } else {
        userPw = request.getParameter("adminPw");
      }
      String sesUserPw = lgnVO.getPwd();
      
      Map<String, Object> map = new HashMap();
      
      map.put("USER_ID", request.getParameter("userId"));
      map.put("USER_NM_KO", request.getParameter("userNmKo"));
      map.put("USER_NM_EN", request.getParameter("userNmEn"));
      map.put("USE_TY_CD", request.getParameter("useTyCd"));
      map.put("MOBL_NO", request.getParameter("moblNo"));
      map.put("EMAIL", request.getParameter("email"));
      map.put("OFFC_TEL_NO", request.getParameter("offcTelNo"));
      map.put("INSTT_NM", request.getParameter("insttNm"));
      map.put("DEPT_NM", request.getParameter("deptNm"));
      map.put("RANK_NM", request.getParameter("rankNm"));
      map.put("IP_ADRES", request.getParameter("ipAdres"));
      map.put("IP_TY_CD", request.getParameter("ipTyCd"));
      map.put("IP_CD", request.getParameter("ipCd"));
      map.put("RPSB_WORK", request.getParameter("rpsbWork"));
      map.put("REMARK", request.getParameter("remark"));
      map.put("UPD_USER_ID", sesUserId);
      
      //map.put("ucpSiteTag", ucpSiteTag);
      map.put("dbEncryptTag", dbEncryptTag);
      map.put("ssoLoginTag", ssoLoginTag);
      if (!CommonUtil.checkDataFilterObj(map))
      {
        mapRet.put("session", Integer.valueOf(1));
        mapRet.put("msg", "특수문자를 포함한 자료는 저장할 수 없습니다.");
        return mapRet;
      }
      String password = request.getParameter("password");
      if ((password == null) || ("".equals(password))) {
        map.put("PASSWORD", "");
      } else if ("UCP".equals(dbEncryptTag)) {
        map.put("PASSWORD", EgovFileScrty.encryptPassword(password, saltText));
      } else {
        map.put("PASSWORD", password);
      }
      List<Map<String, String>> grplist = new ArrayList();
      if (request.getParameter("grpId") != null)
      {
        String[] grpIds = request.getParameterValues("grpId");
        String[] authLvls = request.getParameterValues("authLvl");
        if (grpIds.length > 0) {
          for (int i = 0; i < grpIds.length; i++)
          {
            Map<String, String> mapItemId = new HashMap();
            mapItemId.put("GRP_ID", grpIds[i]);
            mapItemId.put("USER_ID", request.getParameter("userId"));
            mapItemId.put("USE_TY_CD", "Y");
            mapItemId.put("AUTH_LVL", authLvls[i]);
            mapItemId.put("RGS_USER_ID", sesUserId);
            mapItemId.put("UPD_USER_ID", sesUserId);
            
            grplist.add(mapItemId);
          }
        }
      }
      System.out.println(grplist);
      try
      {
        int updateResult;
        try
        {
          updateResult = this.usrInfoService.update(map, grplist);
        }
        catch (DataIntegrityViolationException e)
        {
          //int updateResult;
          logger.error("updateUserInfo DataIntegrityViolationException : {}", e.getMessage());
        }
        catch (UncategorizedSQLException e)
        {
          if (e.getCause().getMessage().indexOf("JDBC-590730") >= 0)
          {
            mapRet.put("session", Integer.valueOf(0));
            mapRet.put("msg", "이미 등록된 코드입니다.");
            return mapRet;
          }
          logger.error("updateUserInfo UncategorizedSQLException : {}", e.getMessage());
        }
        catch (Exception e)
        {
          logger.error("updateUserInfo Exception : {}", e.getMessage());
        }
        mapRet.put("session", Integer.valueOf(1));
        mapRet.put("msg", "저장하였습니다.");
      }
      catch (Exception e)
      {
        logger.error("updateUserInfo QueryException  : {}", e.getMessage());
        mapRet.put("session", Integer.valueOf(0));
        mapRet.put("msg", "알수없는 에러!!!");
      }
      return mapRet;
    }
       
    
    @SuppressWarnings("unchecked")
    @RequestMapping(value="/com/danusys/platform/user/user_list.do")
    public @ResponseBody Map<String, Object> selectAdminGroupUserTest(@ModelAttribute("searchVO") AdminDefaultVO searchVO) throws Exception {
        /** EgovPropertyService.sample */
        searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
        //searchVO.setPageSize(propertiesService.getInt("pageSize"));
        searchVO.setPageIndex(searchVO.getPage());
        
        List<?> serviceList = this.cmUserService.selectCmUserList(searchVO);
        int totCnt = cmUserService.selectCmUserListTotCnt(searchVO);
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("rows", serviceList);
        map.put("total", totCnt);
        
        return map;
    }   
    /**
	 * cm_user 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 AdminDefaultVO
	 * @return "/cmUser/CmUserList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cmUser/CmUserList.do")
    public @ResponseBody Map<String, Object> selectCmUserList(@ModelAttribute("searchVO") AdminDefaultVO searchVO) throws Exception {
    	
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
		
        List<?> cmUserList = cmUserService.selectCmUserList(searchVO);
        //model.addAttribute("resultList", cmUserList);
        
        int totCnt = cmUserService.selectCmUserListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        //model.addAttribute("paginationInfo", paginationInfo);
        
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("rows", cmUserList);
        map.put("total", totCnt);
        
        return map;
    } 
    
    @RequestMapping("/cmUser/addCmUserView.do")
    public String addCmUserView(
            @ModelAttribute("searchVO") AdminDefaultVO searchVO, Model model)
            throws Exception {
        model.addAttribute("cmUserVO", new CmUserVO());
        return "/cmUser/CmUserRegister";
    }
    
    @RequestMapping("/cmUser/addCmUser.do")
    public String addCmUser(
            CmUserVO cmUserVO,
            @ModelAttribute("searchVO") AdminDefaultVO searchVO, SessionStatus status)
            throws Exception {
        cmUserService.insertCmUser(cmUserVO);
        status.setComplete();
        return "forward:/cmUser/CmUserList.do";
    }
    
    @RequestMapping("/cmUser/updateCmUserView.do")
    public String updateCmUserView(
            @RequestParam("userId") java.lang.String userId ,
            @ModelAttribute("searchVO") AdminDefaultVO searchVO, Model model)
            throws Exception {
        CmUserVO cmUserVO = new CmUserVO();
        cmUserVO.setUserId(userId);        
        // 변수명은 CoC 에 따라 cmUserVO
        model.addAttribute(selectCmUser(cmUserVO, searchVO));
        return "/cmUser/CmUserRegister";
    }

    @RequestMapping("/cmUser/selectCmUser.do")
    public @ModelAttribute("cmUserVO")
    CmUserVO selectCmUser(
            CmUserVO cmUserVO,
            @ModelAttribute("searchVO") AdminDefaultVO searchVO) throws Exception {
        return cmUserService.selectCmUser(cmUserVO);
    }

    @RequestMapping("/cmUser/updateCmUser.do")
    public String updateCmUser(
            CmUserVO cmUserVO,
            @ModelAttribute("searchVO") AdminDefaultVO searchVO, SessionStatus status)
            throws Exception {
        cmUserService.updateCmUser(cmUserVO);
        status.setComplete();
        return "forward:/cmUser/CmUserList.do";
    }
    
    @RequestMapping("/cmUser/deleteCmUser.do")
    public String deleteCmUser(
            CmUserVO cmUserVO,
            @ModelAttribute("searchVO") AdminDefaultVO searchVO, SessionStatus status)
            throws Exception {
        cmUserService.deleteCmUser(cmUserVO);
        status.setComplete();
        return "forward:/cmUser/CmUserList.do";
    }

}
