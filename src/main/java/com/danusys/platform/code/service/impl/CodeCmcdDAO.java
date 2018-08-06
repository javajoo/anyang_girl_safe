package com.danusys.platform.code.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;

@Repository("codeCmcdDAO")
public class CodeCmcdDAO
  extends EgovAbstractMapper
{
  public List grpList(Map<String, Object> map)
    throws Exception
  {
    List list = null;
    if (map.get("sysCd") != null) {
      list = list("wrks_sstm_code_cmcd.sysList", map);
    } else {
      list = list("wrks_sstm_code_cmcd.grpList", map);
    }
    return list;
  }
  
  public List sysList(Map<String, Object> map)
    throws Exception
  {
    List list = null;
    
    list = list("wrks_sstm_code_cmcd.list_cm_sys_code", map);
    
    return list;
  }
  
  public List view(Map<String, String> map)
    throws Exception
  {
    return list("wrks_sstm_code_cmcd.list", map);
  }
  
  public int insert(Map<String, Object> map)
    throws Exception
  {
    return insert("wrks_sstm_code_cmcd.insert", map);
  }
  
  public int delete(Map<String, Object> map)
    throws Exception
  {
    return delete("wrks_sstm_code_cmcd.delete", map);
  }
  
  public int update(Map<String, Object> map)
    throws Exception
  {
    return update("wrks_sstm_code_cmcd.update", map);
  }
  
  public int deleteMulti(List<Map<String, String>> args)
    throws Exception
  {
    for (int i = 0; i < args.size(); i++)
    {
      Map<String, String> arg = (Map)args.get(i);
      delete("wrks_sstm_code_cmcd.delete", arg);
    }
    return 1;
  }
  
  public String getCurrentDay()
    throws Exception
  {
    return (String)selectOne("wrks_sstm_code_cmcd.select_current_day", null);
  }
}
