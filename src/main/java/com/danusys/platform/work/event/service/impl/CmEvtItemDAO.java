package com.danusys.platform.work.event.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * @Class Name : CmEvtItemDAO.java
 * @Description : CmEvtItem DAO Class
 * @Modification Information
 *
 * @author 이인의
 * @since 2018-05-15
 * @version 1.0
 * @see Copyright (C) All right reserved.
 */

@Repository("cmEvtItemDAO")
public class CmEvtItemDAO extends EgovAbstractMapper {

	public List<Map<String, String>> view(Map<String, String> args) {
		return selectList("work_event_item.list", args);
	}

	public int insert(Map<String, Object> args) {
		return insert("work_event_item.insert", args);
	}

	public int update(Map<String, Object> args) {
		return update("work_event_item.update", args);
	}

	public int delete(Map<String, Object> args) {
		return delete("work_event_item.delete", args);
	}

	public int deleteMulti(List<Map<String, String>> args) {
		int result = 0;
		for (int i = 0; i < args.size(); i++) {
			Map<String, String> arg = (Map) args.get(i);
			result += delete("work_event_item.delete", arg);
		}
		return result;
	}

}
