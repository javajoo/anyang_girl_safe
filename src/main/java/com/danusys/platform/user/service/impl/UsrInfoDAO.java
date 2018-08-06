package com.danusys.platform.user.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;

@Repository("usrInfoDAO")
public class UsrInfoDAO
  extends EgovAbstractMapper
{
  public List<Map<String, String>> getCM_GROUP(Map<String, String> args)
  {
    return selectList("wrks_sstm_usr_info.list_cm_group", args);
  }
  
  public List<Map<String, String>> getCM_GRP_USER(Map<String, String> args)
  {
    return selectList("wrks_sstm_usr_info.list_cm_grp_user", args);
  }
  
  public List<Map<String, String>> getCM_AREA_CD_MNG(Map<String, String> args)
  {
    return selectList("wrks_sstm_usr_info.list_cm_area_cd_mng", args);
  }
  
  public List<Map<String, String>> getCM_USER_AREA(Map<String, String> args)
  {
    return selectList("wrks_sstm_usr_info.list_cm_user_area", args);
  }
  
  public List<Map<String, String>> list(Map<String, String> map)
  {
    return selectList("wrks_sstm_usr_info.list", map);
  }
  
  public int insert_bak(Map<String, Object> map, List<Map<String, String>> grplist, List<Map<String, String>> arealist, Map<String, String> dstrtMap)
  {
    int insertResult = 0;
    
    insertResult = insert("wrks_sstm_usr_info.insert", map);
    if (grplist.size() > 0) {
      for (int i = 0; i < grplist.size(); i++)
      {
        Map<String, String> arg = (Map)grplist.get(i);
        insertResult = insert("wrks_sstm_usr_info.insert_cm_grp_user", arg);
      }
    }
    if (arealist.size() > 0) {
      for (int i = 0; i < arealist.size(); i++)
      {
        Map<String, String> arg = (Map)arealist.get(i);
        insertResult = insert("wrks_sstm_usr_info.insert_cm_user_area", arg);
      }
    }
    if (dstrtMap.size() > 0)
    {
      insertResult = delete("wrks_sstm_usr_info.deleteUserDstrt", dstrtMap);
      insertResult = insert("wrks_sstm_usr_info.insertUserDstrt", dstrtMap);
    }
    return insertResult;
  }
  
  public int insert(Map<String, Object> map, List<Map<String, String>> grplist, List<Map<String, String>> arealist, Map<String, String> dstrtMap)
  {
    int insertResult = 0;
    String dbEncryptTag = map.get("dbEncryptTag").toString();
    String insert_sql = "wrks_sstm_usr_info.insertUserInfo" + dbEncryptTag;
    
    insertResult = insert(insert_sql, map);
    if (grplist.size() > 0) {
      for (int i = 0; i < grplist.size(); i++)
      {
        Map<String, String> arg = (Map)grplist.get(i);
        insertResult = insert("wrks_sstm_usr_info.insert_cm_grp_user", arg);
      }
    }
    if (arealist.size() > 0) {
      for (int i = 0; i < arealist.size(); i++)
      {
        Map<String, String> arg = (Map)arealist.get(i);
        insertResult = insert("wrks_sstm_usr_info.insert_cm_user_area", arg);
      }
    }
    if (dstrtMap.size() > 0)
    {
      insertResult = delete("wrks_sstm_usr_info.deleteUserDstrt", dstrtMap);
      insertResult = insert("wrks_sstm_usr_info.insertUserDstrt", dstrtMap);
    }
    return insertResult;
  }
  
  public int insertMultiGrpUser(List<Map<String, String>> args)
  {
    int result = 0;
    for (int i = 0; i < args.size(); i++)
    {
      Map<String, String> arg = (Map)args.get(i);
      result += delete("wrks_sstm_usr_info.insert_cm_grp_user", arg);
    }
    return result;
  }
  
  public int insertMultiUserArea(List<Map<String, String>> args)
  {
    int result = 0;
    for (int i = 0; i < args.size(); i++)
    {
      Map<String, String> arg = (Map)args.get(i);
      result += delete("wrks_sstm_usr_info.insert_cm_user_area", arg);
    }
    return result;
  }
  
  public int update(Map<String, Object> map, List<Map<String, String>> grplist)
  {
    int result = 0;
    String sqlPath = "wrks_sstm_usr_info.updateUserInfo";
    String dbEncryptTag = map.get("dbEncryptTag").toString();
    if (!"".equals(dbEncryptTag)) {
      sqlPath = "wrks_sstm_usr_info.updateUserInfo" + dbEncryptTag;
    }
    System.out.println("=============================="+dbEncryptTag);
    update(sqlPath, map);
    for (int i = 0; i < grplist.size(); i++)
    {
      Map<String, String> arg = (Map)grplist.get(i);
      result += delete("wrks_sstm_usr_info.update_cm_grp_user", arg);
    }
    return result;
  }
  
  public int delete(Map<String, Object> map)
  {
    return delete("wrks_sstm_usr_info.delete", map);
  }
  
  public int deleteMulti(List<Map<String, String>> args)
  {
    for (int i = 0; i < args.size(); i++)
    {
      Map<String, String> arg = (Map)args.get(i);
      delete("wrks_sstm_usr_info.delete", arg);
    }
    return 1;
  }
  
  public int deleteMultiGrpUser(List<Map<String, String>> args)
  {
    int result = 0;
    for (int i = 0; i < args.size(); i++)
    {
      Map<String, String> arg = (Map)args.get(i);
      result += delete("wrks_sstm_usr_info.delete_cm_grp_user", arg);
    }
    return result;
  }
  
  public int deleteMultiUserArea(List<Map<String, String>> args)
  {
    int result = 0;
    for (int i = 0; i < args.size(); i++)
    {
      Map<String, String> arg = (Map)args.get(i);
      result += delete("wrks_sstm_usr_info.delete_cm_user_area", arg);
    }
    return result;
  }
  
  public int insertUserDstrt(Map<String, String> map)
  {
    return insert("wrks_sstm_usr_info.insertUserDstrt", map);
  }
  
  public int deleteUserDstrt(Map<String, String> map)
  {
    return insert("wrks_sstm_usr_info.deleteUserDstrt", map);
  }
  
  public List<Map<String, String>> getDstrtCd(Map<String, String> args)
  {
    return selectList("wrks_sstm_usr_info.getDstrtCd", args);
  }
  
  public List<Map<String, String>> getGrpId(Map<String, String> args)
  {
    return selectList("wrks_sstm_usr_info.getGrpId", args);
  }
  
  public List<Map<String, String>> getDstrtCdList(Map<String, String> map)
  {
    return selectList("wrks_sstm_usr_info.getDstrtCdList", map);
  }
}
