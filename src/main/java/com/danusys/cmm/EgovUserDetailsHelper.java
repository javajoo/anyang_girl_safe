package com.danusys.cmm;

import egovframework.rte.fdl.string.EgovObjectUtil;
import java.util.ArrayList;
import java.util.List;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

public class EgovUserDetailsHelper
{
  public static Object getAuthenticatedUser()
  {
    return (LoginVO)RequestContextHolder.getRequestAttributes().getAttribute("LoginVO", 1) == null ? 
      new LoginVO() : (LoginVO)RequestContextHolder.getRequestAttributes().getAttribute("LoginVO", 1);
  }
  
  public static List<String> getAuthorities()
  {
    List<String> listAuth = new ArrayList();
    if (EgovObjectUtil.isNull((LoginVO)RequestContextHolder.getRequestAttributes().getAttribute("LoginVO", 1))) {
      return null;
    }
    return listAuth;
  }
  
  public static Boolean isAuthenticated()
  {
    if (EgovObjectUtil.isNull((LoginVO)RequestContextHolder.getRequestAttributes().getAttribute("LoginVO", 1))) {
      return Boolean.FALSE;
    }
    return Boolean.TRUE;
  }
}
