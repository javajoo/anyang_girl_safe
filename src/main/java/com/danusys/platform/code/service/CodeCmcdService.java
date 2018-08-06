package com.danusys.platform.code.service;

import java.util.List;
import java.util.Map;

public abstract interface CodeCmcdService
{
  public abstract List<Map<String, String>> grpList(Map<String, Object> paramMap)
    throws Exception;
  
  public abstract List<Map<String, String>> sysList(Map<String, Object> paramMap)
    throws Exception;
  
  public abstract List<Map<String, String>> view(Map<String, String> paramMap)
    throws Exception;
  
  public abstract int insert(Map<String, Object> paramMap)
    throws Exception;
  
  public abstract int delete(Map<String, Object> paramMap)
    throws Exception;
  
  public abstract int update(Map<String, Object> paramMap)
    throws Exception;
  
  public abstract int deleteMulti(List<Map<String, String>> paramList)
    throws Exception;
  
  public abstract String getCurrentDay()
    throws Exception;
}

