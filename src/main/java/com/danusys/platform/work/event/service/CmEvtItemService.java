package com.danusys.platform.work.event.service;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : CmEvtItemService.java
 * @Description : CmEvtItem Business class
 * @Modification Information
 *
 * @author 이인의
 * @since 2018-05-15
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface CmEvtItemService {
	
	public List<Map<String, String>> view(Map<String, String> paramMap) throws Exception;
		  
	public int insert(Map<String, Object> paramMap) throws Exception;
		  
	public int update(Map<String, Object> paramMap) throws Exception;
		  
	public int delete(Map<String, Object> paramMap) throws Exception;
		  
	public int deleteMulti(List<Map<String, String>> paramList) throws Exception;
    
}
