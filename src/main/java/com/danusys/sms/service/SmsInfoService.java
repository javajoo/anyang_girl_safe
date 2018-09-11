package com.danusys.sms.service;

import java.util.List;
import java.util.Map;

public abstract interface SmsInfoService
{


  public abstract int send(Map<String, Object> args) throws Exception;
  
}
