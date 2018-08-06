package com.danusys.platform.group.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;

@Repository("grpCodeDAO")
public class GrpCodeDAO
  extends EgovAbstractMapper
{
  public List<Map<String, String>> getDstrtList(Map<String, String> args)
    throws Exception
  {
    return selectList("wrks_sstm_grp_code.dstrtList", args);
  }
  
  public List<Map<String, String>> getList(Map<String, String> args)
    throws Exception
  {
    return selectList("wrks_sstm_grp_code.list", args);
  }
  
  public int insert(Map<String, Object> args)
    throws Exception
  {
    return update("wrks_sstm_grp_code.insert", args);
  }
  
  public int update(Map<String, Object> args)
    throws Exception
  {
    return update("wrks_sstm_grp_code.update", args);
  }
  
  public int delete(Map<String, Object> args)
    throws Exception
  {
    return update("wrks_sstm_grp_code.delete", args);
  }
  
  public int deleteMulti(List<Map<String, String>> args)
    throws Exception
  {
    for (int i = 0; i < args.size(); i++)
    {
      Map<String, String> arg = (Map)args.get(i);
      
      delete("wrks_sstm_grp_code.delete", arg);
    }
    return 1;
  }
  
  public List<Map<String, String>> getCM_DSTRT_CD_MNG(Map<String, String> map) throws Exception
  {
      return selectList("wrks_sstm_grp_code.list_cm_dstrt_cd_mng", map);
  }

  public List<Map<String, String>> getCM_GROUP(Map<String, String> map) throws Exception
  {
      return selectList("wrks_sstm_grp_code.list_cm_group", map);
  }

  public List<Map<String, String>> getCM_GRP_USER(Map<String, String> map) throws Exception
  {
      return selectList("wrks_sstm_grp_code.list_cm_grp_user", map);
  }
}
