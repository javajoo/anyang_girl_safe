package com.danusys.platform.group.service;

import java.util.List;
import java.util.Map;

public abstract interface GrpCodeService
{
  public abstract List<Map<String, String>> getDstrtList(Map<String, String> paramMap)
    throws Exception;
  
  public abstract List<Map<String, String>> getList(Map<String, String> paramMap)
    throws Exception;
  
  public abstract int insert(Map<String, Object> paramMap)
    throws Exception;
  
  public abstract int update(Map<String, Object> paramMap)
    throws Exception;
  
  public abstract int delete(Map<String, Object> paramMap)
    throws Exception;
  
  public abstract int deleteMulti(List<Map<String, String>> paramList)
    throws Exception;
  
  public abstract List<Map<String, String>> getCM_DSTRT_CD_MNG(Map<String, String> paramMap)
    throws Exception;
  
  public abstract List<Map<String, String>> getCM_GROUP(Map<String, String> paramMap)
    throws Exception;
        
  public abstract List<Map<String, String>> getCM_GRP_USER(Map<String, String> paramMap)
    throws Exception;
}
