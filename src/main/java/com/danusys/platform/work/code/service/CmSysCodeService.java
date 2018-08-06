package com.danusys.platform.work.code.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : CmSysCodeService.java
 * @Description : CmSysCode Business class
 * @Modification Information
 *
 * @author 이인의
 * @since 2018-05-14
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface CmSysCodeService {
	
	public List<Map<String, String>> grpList(Map<String, Object> paramMap) throws Exception;
		  
	public List<Map<String, String>> sysList(Map<String, Object> paramMap) throws Exception;
		  
	public List<Map<String, String>> view(Map<String, String> paramMap) throws Exception;
		  
	public int insert(Map<String, Object> paramMap) throws Exception;
		  
	public int delete(Map<String, Object> paramMap) throws Exception;
		  
	public int update(Map<String, Object> paramMap) throws Exception;
		  
	public int deleteMulti(List<Map<String, String>> paramList) throws Exception;
		  
	public String getCurrentDay() throws Exception;
		  
	public String getCalDay(int paramInt) throws Exception;
    
}
