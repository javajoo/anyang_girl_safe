package com.danusys.sms.impl;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.danusys.sms.service.SmsInfoService;

import org.springframework.stereotype.Service;

@Service("smsInfoService")
public class SmsInfoServiceImpl extends EgovAbstractServiceImpl
  implements SmsInfoService
{
  @Resource(name="smsInfoDAO")
  private SmsInfoDAO smsInfoDAO;
  

  public int send(Map<String, Object> args) 
		  throws Exception {
	// TODO Auto-generated method stub
	int ret = this.smsInfoDAO.send(args);
	this.egovLogger.debug("smsInfoDAO.send : {}", new Object[] { args });
	return ret;
  }
  

  
}
