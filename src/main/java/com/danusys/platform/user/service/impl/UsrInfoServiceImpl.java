package com.danusys.platform.user.service.impl;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import com.danusys.platform.user.service.UsrInfoService;
import org.springframework.stereotype.Service;

@Service("usrInfoService")
public class UsrInfoServiceImpl
  implements UsrInfoService
{
  @Resource(name="usrInfoDAO")
  private UsrInfoDAO usrInfoDAO;
  
  public List<Map<String, String>> getCM_GROUP(Map<String, String> args)
    throws Exception
  {
    return this.usrInfoDAO.getCM_GROUP(args);
  }
  
  public List<Map<String, String>> getCM_GRP_USER(Map<String, String> args)
    throws Exception
  {
    return this.usrInfoDAO.getCM_GRP_USER(args);
  }
  
  public List<Map<String, String>> getCM_AREA_CD_MNG(Map<String, String> args)
    throws Exception
  {
    return this.usrInfoDAO.getCM_AREA_CD_MNG(args);
  }
  
  public List<Map<String, String>> getCM_USER_AREA(Map<String, String> args)
    throws Exception
  {
    return this.usrInfoDAO.getCM_USER_AREA(args);
  }
  
  public List<Map<String, String>> list(Map<String, String> map)
    throws Exception
  {
    return this.usrInfoDAO.list(map);
  }
  
  public int insert(Map<String, Object> map, List<Map<String, String>> grplist, List<Map<String, String>> arealist, Map<String, String> dstrtMap)
    throws Exception
  {
    return this.usrInfoDAO.insert(map, grplist, arealist, dstrtMap);
  }
  
  public int insertMultiGrpUser(List<Map<String, String>> args)
    throws Exception
  {
    return this.usrInfoDAO.insertMultiGrpUser(args);
  }
  
  public int insertMultiUserArea(List<Map<String, String>> args)
    throws Exception
  {
    return this.usrInfoDAO.insertMultiUserArea(args);
  }
  
  public int update(Map<String, Object> map, List<Map<String, String>> grplist)
    throws Exception
  {
    return this.usrInfoDAO.update(map, grplist);
  }
  
  public int delete(Map<String, Object> map)
    throws Exception
  {
    return this.usrInfoDAO.delete(map);
  }
  
  public int deleteMulti(List<Map<String, String>> list)
    throws Exception
  {
    return this.usrInfoDAO.deleteMulti(list);
  }
  
  public int deleteMultiGrpUser(List<Map<String, String>> args)
    throws Exception
  {
    return this.usrInfoDAO.deleteMultiGrpUser(args);
  }
  
  public int deleteMultiUserArea(List<Map<String, String>> args)
    throws Exception
  {
    return this.usrInfoDAO.deleteMultiUserArea(args);
  }
  
  public int insertUserDstrt(Map<String, String> map)
    throws Exception
  {
    return this.usrInfoDAO.insertUserDstrt(map);
  }
  
  public int deleteUserDstrt(Map<String, String> map)
    throws Exception
  {
    return this.usrInfoDAO.deleteUserDstrt(map);
  }
  
  public List<Map<String, String>> getDstrtCd(Map<String, String> args)
    throws Exception
  {
    return this.usrInfoDAO.getDstrtCd(args);
  }
  
  public List<Map<String, String>> getGrpId(Map<String, String> args)
    throws Exception
  {
    return this.usrInfoDAO.getGrpId(args);
  }
  
  public List<Map<String, String>> getDstrtCdList(Map<String, String> map)
    throws Exception
  {
    return this.usrInfoDAO.getDstrtCdList(map);
  }
}
