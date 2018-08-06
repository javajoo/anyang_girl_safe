package com.danusys.platform.group.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.cmmn.trace.LeaveaTrace;
import egovframework.rte.fdl.property.EgovPropertyService;

import com.danusys.cmm.EgovUserDetailsHelper;
import com.danusys.cmm.LoginVO;
import com.danusys.cmm.util.CommonUtil;
import com.danusys.platform.code.service.CodeCmcdService;
import com.danusys.platform.group.service.GrpCodeService;
import com.danusys.platform.vo.AdminVo;
/**
 * @Class Name : CmGroupController.java
 * @Description : CmGroup Controller class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-05-11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class CmGroupController {
    
    private final Logger logger = LogManager.getLogger(getClass());
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    @Resource(name="propertiesService")
    protected EgovPropertyService propertiesService;
    @Resource(name="leaveaTrace")
    LeaveaTrace leaveaTrace;
    @Resource(name="grpCodeService")
    private GrpCodeService grpCodeService;
    @Resource(name="codeCmcdService")
    private CodeCmcdService codeCmcdService;
    
    @RequestMapping({"/wrks/sstm/grp/code/list.do"})
    @ResponseBody
    public Map<String, Object> getList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
      throws Exception
    {
      String grpId = request.getParameter("grpId");
      String grpNm = request.getParameter("grpNmKo");
      String useTyCd = request.getParameter("useTyCd");
      String pageNo = request.getParameter("page");
      String rowsPerPage = request.getParameter("rows");
      String sidx = request.getParameter("sidx");
      String sord = request.getParameter("sord");
      
      Map<String, String> args = new HashMap<String, String>();
      args.put("GRP_ID", grpId);
      args.put("GRP_NM_KO", grpNm);
      args.put("USE_TY_CD", useTyCd);
      args.put("pageNo", pageNo);
      args.put("rowsPerPage", rowsPerPage);
      args.put("sidx", sidx);
      args.put("sord", sord);
      
      Map<String, Object> map = new HashMap<String, Object>();
      List<Map<String, String>> result_rows = this.grpCodeService.getList(args);
      
      map.put("page", pageNo);
      map.put("rows", result_rows);
      
      return map;
    }
    
    @RequestMapping({"/wrks/sstm/grp/code/insert.do"})
    @ResponseBody
    public Map<String, Object> insert(ModelMap model, HttpServletRequest request, HttpServletResponse response)
      throws Exception
    {
      AdminVo lgnVO = (AdminVo) request.getSession().getAttribute("admin");
      String sesUserId = lgnVO.getId();
      //LoginVO lgnVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
      //String sesUserId = lgnVO.getUserId();
      
      Map<String, Object> map = new HashMap<String, Object>();
      
      map.put("GRP_ID", request.getParameter("grpId"));
      map.put("DSTRT_CD", request.getParameter("dstrtCd"));
      map.put("GRP_NM_KO", request.getParameter("grpNmKo"));
      map.put("GRP_NM_EN", request.getParameter("grpNmEn"));
      map.put("GRP_DSCRT", request.getParameter("grpDscrt"));
      map.put("USE_TY_CD", request.getParameter("useTyCd"));
      map.put("RGS_USER_ID", sesUserId);
      map.put("UPD_USER_ID", sesUserId);
      
      Map<String, Object> map_ret = new HashMap<String, Object>();
      if (!CommonUtil.checkDataFilterObj(map))
      {
        map_ret.put("session", Integer.valueOf(1));
        map_ret.put("msg", "특수문자를 포함할 수 없습니다.");
        return map_ret;
      }
      try
      {
        try
        {
          this.grpCodeService.insert(map);
        }
        catch (DataIntegrityViolationException e)
        {
          if (e.getRootCause().getMessage().indexOf("UNIQUE constraint violation") >= 0)
          {
            map_ret.put("session", Integer.valueOf(0));
            map_ret.put("msg", "이미 등록된 코드입니다.");
            return map_ret;
          }
          System.out.println(e.getRootCause());
          this.logger.error("insert DataIntegrityViolationException : {}", new Object[] { e.getMessage() });
        }
        catch (UncategorizedSQLException e)
        {
          if (e.getCause().getMessage().indexOf("JDBC-590730") >= 0)
          {
            map_ret.put("session", Integer.valueOf(0));
            map_ret.put("msg", "그룹아이디를 다시 확인 후 등록해주세요.");
            return map_ret;
          }
          System.out.println(e.getCause());
          this.logger.error("insert UncategorizedSQLException : {}", new Object[] { e.getMessage() });
        }
        catch (Exception e)
        {
          e.printStackTrace();
          this.logger.error("insert Exception : {}", new Object[] { e.getMessage() });
        }
        map_ret.put("session", Integer.valueOf(1));
        map_ret.put("msg", "저장이 완료되었습니다.");
      }
      catch (Exception e)
      {
        map_ret.put("session", Integer.valueOf(0));
        map_ret.put("msg", "알수 없는 에러입니다.");
        this.logger.error("insert Exception : {}", new Object[] { e.getMessage() });
      }
      return map_ret;
    }
    
    @RequestMapping({"/wrks/sstm/grp/code/update.do"})
    @ResponseBody
    public Map<String, Object> update(ModelMap model, HttpServletRequest request, HttpServletResponse response)
      throws Exception
    {
      LoginVO lgnVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
      String sesUserId = lgnVO.getUserId();
      
      Map<String, Object> map = new HashMap<String, Object>();
      
      map.put("GRP_ID", request.getParameter("grpId"));
      map.put("DSTRT_CD", request.getParameter("dstrtCd"));
      map.put("GRP_NM_KO", request.getParameter("grpNmKo"));
      map.put("GRP_NM_EN", request.getParameter("grpNmEn"));
      map.put("GRP_DSCRT", request.getParameter("grpDscrt"));
      map.put("USE_TY_CD", request.getParameter("useTyCd"));
      map.put("GRP_ID_BAK", request.getParameter("grpIdBak"));
      map.put("UPD_USER_ID", sesUserId);
      
      Map<String, Object> map_ret = new HashMap<String, Object>();
      if (!CommonUtil.checkDataFilterObj(map))
      {
        map_ret.put("session", Integer.valueOf(1));
        map_ret.put("msg", "특수문자를 포함할 수 없습니다.");
        return map_ret;
      }
      this.grpCodeService.update(map);
      
      map_ret.put("session", Integer.valueOf(1));
      map_ret.put("msg", "수정이 완료되었습니다.");
      
      return map_ret;
    }
    
    @RequestMapping({"/wrks/sstm/grp/code/delete.do"})
    @ResponseBody
    public Map<String, Object> delete(ModelMap model, HttpServletRequest request, HttpServletResponse response)
      throws Exception
    {
      LoginVO lgnVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
      String sesUserId = lgnVO.getUserId();
      
      Map<String, Object> map = new HashMap<String, Object>();
      
      map.put("GRP_ID_BAK", request.getParameter("grpIdBak"));
      map.put("UPD_USER_ID", sesUserId);
      
      this.grpCodeService.delete(map);
      
      Map<String, Object> map_ret = new HashMap<String, Object>();
      
      map_ret.put("session", Integer.valueOf(1));
      map_ret.put("msg", "삭제가 완료되었습니다.");
      
      return map_ret;
    }  
    @RequestMapping({"/wrks/sstm/grp/code/deleteMulti.do"})
    @ResponseBody
    public Map<String, Object> deleteMulti(ModelMap model, HttpServletRequest request, HttpServletResponse response)
      throws Exception
    {
      LoginVO lgnVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
      String sesUserId = lgnVO.getUserId();
      
      String[] grpIds = request.getParameterValues("grpId");
      
      new HashMap<String, Object>();
      
      List<Map<String, String>> list = new ArrayList<Map<String, String>>();
      for (int i = 0; i < grpIds.length; i++)
      {
        Map<String, String> map_id = new HashMap<String, String>();
        
        map_id.put("GRP_ID_BAK", grpIds[i]);
        map_id.put("UPD_USER_ID", sesUserId);
        
        list.add(map_id);
      }
      this.grpCodeService.deleteMulti(list);
      
      Map<String, Object> map_ret = new HashMap<String, Object>();
      
      map_ret.put("session", Integer.valueOf(1));
      map_ret.put("msg", "삭제가 완료되었습니다.");
      
      return map_ret;
    }
    
    @RequestMapping({"/wrks/sstm/grp/user/list_group.do"})
    @ResponseBody
    public Map<String, Object> list_group(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, HttpServletResponse response, ModelMap model)
      throws Exception
    {
      String dstrtCd = request.getParameter("dstrtCd");
      String grpNm = request.getParameter("grpNm");
      String pageNo = request.getParameter("page");
      String sidx = request.getParameter("sidx");
      String sord = request.getParameter("sord");
      
      Map<String, String> args = new HashMap();
      
      args.put("DSTRT_CD", dstrtCd);
      args.put("GRP_NM", grpNm);
      args.put("sidx", sidx);
      args.put("sord", sord);
      
      Map<String, Object> map = new HashMap();
      List<Map<String, String>> result_rows = this.grpCodeService.getCM_GROUP(args);
      
      map.put("page", pageNo);
      map.put("rows", result_rows);
      
      return map;
    }
    
    @RequestMapping({"/wrks/sstm/grp/user/list_user.do"})
    @ResponseBody
    public Map<String, Object> list_user(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, HttpServletResponse response, ModelMap model)
      throws Exception
    {
      String grpId = request.getParameter("grpId");
      String userId = request.getParameter("userId");
      String userNm = request.getParameter("userNm");
      String userNmKo = request.getParameter("userNmKo");
      String moblNo = request.getParameter("moblNo");
      String sidx = request.getParameter("sidx");
      String sord = request.getParameter("sord");
      
      Map<String, String> args = new HashMap();
      
      args.put("GRP_ID", grpId);
      args.put("USER_ID", userId);
      args.put("USER_NM", userNm);
      args.put("USER_NM_KO", userNmKo);
      args.put("MOBL_NO", moblNo);
      args.put("sidx", sidx);
      args.put("sord", sord);
      
      List<Map<String, String>> result_rows = this.grpCodeService.getCM_GRP_USER(args);
      
      Map<String, Object> map = new HashMap();
      
      map.put("rows", result_rows);
      return map;
    }    
    
    
}
