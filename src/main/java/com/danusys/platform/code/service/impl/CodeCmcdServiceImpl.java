package com.danusys.platform.code.service.impl;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import com.danusys.platform.code.service.CodeCmcdService;
import org.springframework.stereotype.Service;

@Service("codeCmcdService")
public class CodeCmcdServiceImpl
  implements CodeCmcdService
{
  @Resource(name="codeCmcdDAO")
  private CodeCmcdDAO codeCmcdDAO;
  
  public List<Map<String, String>> grpList(Map<String, Object> map)
    throws Exception
  {
    return this.codeCmcdDAO.grpList(map);
  }
  
  public List<Map<String, String>> sysList(Map<String, Object> map)
    throws Exception
  {
    return this.codeCmcdDAO.sysList(map);
  }
  
  public List<Map<String, String>> view(Map<String, String> map)
    throws Exception
  {
    return this.codeCmcdDAO.view(map);
  }
  
  public int insert(Map<String, Object> map)
    throws Exception
  {
    return this.codeCmcdDAO.insert(map);
  }
  
  public int delete(Map<String, Object> map)
    throws Exception
  {
    return this.codeCmcdDAO.delete(map);
  }
  
  public int update(Map<String, Object> map)
    throws Exception
  {
    return this.codeCmcdDAO.update(map);
  }
  
  public int deleteMulti(List<Map<String, String>> list)
    throws Exception
  {
    return this.codeCmcdDAO.deleteMulti(list);
  }
  
  public String getCurrentDay()
    throws Exception
  {
    return this.codeCmcdDAO.getCurrentDay();
  }
}
