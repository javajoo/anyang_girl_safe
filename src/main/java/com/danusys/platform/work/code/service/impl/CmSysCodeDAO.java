package com.danusys.platform.work.code.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * @Class Name : CmSysCodeDAO.java
 * @Description : CmSysCode DAO Class
 * @Modification Information
 *
 * @author 이인의
 * @since 2018-05-14
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("cmSysCodeDAO")
public class CmSysCodeDAO extends EgovAbstractMapper {

	public List grpList(Map<String, Object> map) throws Exception {
		List list = null;
		if (map.get("sysCd") != null) {
			list = selectList("work_code_cmcd.sysList", map);
		} else {
			list = selectList("work_code_cmcd.grpList", map);
		}
		return list;
	}
		  
	public List sysList(Map<String, Object> map) throws Exception {
		List list = null;
		    
		list = selectList("work_code_cmcd.list_cm_sys_code", map);
		    
		return list;
	}
		  
	public List view(Map<String, String> map) throws Exception {
		return selectList("work_code_cmcd.list", map);
	}
		  
	public int insert(Map<String, Object> map) throws Exception {
		return insert("work_code_cmcd.insert", map);
	}
		  
	public int delete(Map<String, Object> map) throws Exception {
		return delete("work_code_cmcd.delete", map);
	}
		  
	public int update(Map<String, Object> map) throws Exception {
		return update("work_code_cmcd.update", map);
	}
		  
	public int deleteMulti(List<Map<String, String>> args) throws Exception {
		for (int i = 0; i < args.size(); i++) {
			Map<String, String> arg = (Map)args.get(i);
			delete("work_code_cmcd.delete", arg);
		}
		return 1;
	}
		  
	public String getCurrentDay() throws Exception {
		return (String)selectOne("work_code_cmcd.select_current_day", null);
	}
		  
	public String getCalDay(int dayCnt) throws Exception {
		return (String)selectOne("work_code_cmcd.select_cal_day", Integer.valueOf(dayCnt));
	}

}
