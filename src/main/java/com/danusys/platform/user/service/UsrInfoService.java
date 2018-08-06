package com.danusys.platform.user.service;


import java.util.List;
import java.util.Map;

public abstract interface UsrInfoService
{
  public abstract List<Map<String, String>> getCM_GROUP(Map<String, String> paramMap)
    throws Exception;
  
  public abstract List<Map<String, String>> getCM_GRP_USER(Map<String, String> paramMap)
    throws Exception;
  
  public abstract List<Map<String, String>> getCM_AREA_CD_MNG(Map<String, String> paramMap)
    throws Exception;
  
  public abstract List<Map<String, String>> getCM_USER_AREA(Map<String, String> paramMap)
    throws Exception;
  
  public abstract List<Map<String, String>> list(Map<String, String> paramMap)
    throws Exception;
  
  public abstract int insert(Map<String, Object> paramMap, List<Map<String, String>> paramList1, List<Map<String, String>> paramList2, Map<String, String> paramMap1)
    throws Exception;
  
  public abstract int insertMultiGrpUser(List<Map<String, String>> paramList)
    throws Exception;
  
  public abstract int insertMultiUserArea(List<Map<String, String>> paramList)
    throws Exception;
  
  public abstract int update(Map<String, Object> paramMap, List<Map<String, String>> paramList)
    throws Exception;
  
  public abstract int delete(Map<String, Object> paramMap)
    throws Exception;
  
  public abstract int deleteMulti(List<Map<String, String>> paramList)
    throws Exception;
  
  public abstract int deleteMultiGrpUser(List<Map<String, String>> paramList)
    throws Exception;
  
  public abstract int deleteMultiUserArea(List<Map<String, String>> paramList)
    throws Exception;
  
  public abstract int insertUserDstrt(Map<String, String> paramMap)
    throws Exception;
  
  public abstract int deleteUserDstrt(Map<String, String> paramMap)
    throws Exception;
  
  public abstract List<Map<String, String>> getDstrtCd(Map<String, String> paramMap)
    throws Exception;
  
  public abstract List<Map<String, String>> getGrpId(Map<String, String> paramMap)
    throws Exception;
  
  public abstract List<Map<String, String>> getDstrtCdList(Map<String, String> paramMap)
    throws Exception;
}
