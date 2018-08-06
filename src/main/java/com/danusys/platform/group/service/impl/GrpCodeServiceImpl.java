package com.danusys.platform.group.service.impl;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import com.danusys.platform.group.service.GrpCodeService;
import org.springframework.stereotype.Service;

@Service("grpCodeService")
public class GrpCodeServiceImpl
  extends EgovAbstractServiceImpl
  implements GrpCodeService
{
  @Resource(name="grpCodeDAO")
  private GrpCodeDAO grpCodeDAO;
  
  public List<Map<String, String>> getDstrtList(Map<String, String> args)
    throws Exception
  {
    List<Map<String, String>> list = this.grpCodeDAO.getDstrtList(args);
    
    return list;
  }
  
  public List<Map<String, String>> getList(Map<String, String> args)
    throws Exception
  {
    List<Map<String, String>> list = this.grpCodeDAO.getList(args);
    
    return list;
  }
  
  public int insert(Map<String, Object> args)
    throws Exception
  {
    int ret = this.grpCodeDAO.insert(args);
    
    return ret;
  }
  
  public int update(Map<String, Object> args)
    throws Exception
  {
    int ret = this.grpCodeDAO.update(args);
    
    return ret;
  }
  
  public int delete(Map<String, Object> args)
    throws Exception
  {
    int ret = this.grpCodeDAO.delete(args);
    
    return ret;
  }
  
  public int deleteMulti(List<Map<String, String>> args)
    throws Exception
  {
    int ret = this.grpCodeDAO.deleteMulti(args);
    
    return ret;
  }
  
  public List<Map<String, String>> getCM_DSTRT_CD_MNG(Map<String, String> map) throws Exception
  {
      return this.grpCodeDAO.getCM_DSTRT_CD_MNG(map);
  }
        
  public List<Map<String, String>> getCM_GROUP(Map<String, String> map) throws Exception
  {
      return this.grpCodeDAO.getCM_GROUP(map);
  }

  public List<Map<String, String>> getCM_GRP_USER(Map<String, String> map) throws Exception
  {
      return this.grpCodeDAO.getCM_GRP_USER(map);
  }
  
}
