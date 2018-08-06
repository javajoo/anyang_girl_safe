package com.danusys.platform.work.event.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * @Class Name : CmEventDAO.java
 * @Description : CmEvent DAO Class
 * @Modification Information
 *
 * @author 이인의
 * @since 2018-05-11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("cmEventDAO")
public class CmEventDAO extends EgovAbstractMapper {

    /**
	 * CM_EVENT 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return CM_EVENT 목록
	 * @exception Exception
	 */
    public List<Map<String, String>> selectCmEventList(Map<String, String> args) throws Exception {
        return selectList("work_event.list", args);
    }
    
    public List<Map<String, String>> evtItemList(Map<String, String> args)
    {
      return selectList("work_event.list_cm_evt_item", args);
    }
    
    public List<Map<String, String>> evtItemInfoList(Map<String, String> args)
    {
      return selectList("work_event.list_cm_evt_item_info", args);
    }
    
    public List<Map<String, String>> evtSubList(Map<String, String> args)
    {
      return selectList("work_event.list_cm_event_sub", args);
    }
    
    public String selectEvtId(Map<String, Object> args)
    {
      return (String)selectOne("work_event.select_evt_id", args);
    }
    
    public int insertCmEvent(Map<String, Object> args, List<Map<String, Object>> list)
    {
      int result = 0;
      result = insert("work_event.insert_cm_event", args);
      for (int i = 0; i < list.size(); i++)
      {
        Map<String, Object> itemMap = (Map)list.get(i);
        result = insert("work_event.insert_cm_evt_item_info", itemMap);
      }
      return result;
    }
    
    public int updateCmEvent(Map<String, Object> args)
    {
      return update("work_event.update_cm_event", args);
    }
    
    public int deleteCmEvent(Map<String, Object> args)
    {
      int result = 0;
      result = update("work_event.delete_cm_event_sub", args);
      result = delete("work_event.delete_cm_evt_item_info", args);
      result = update("work_event.delete_cm_event", args);
      return result;
    }
    
    public int insertCmEvtItemInfo(List<Map<String, String>> args)
    {
      int result = 0;
      for (int i = 0; i < args.size(); i++)
      {
        Map<String, String> arg = (Map)args.get(i);
        result += insert("work_event.insert_cm_evt_item_info", arg);
      }
      return result;
    }
    
    public int updateCmEvtItemInfo(List<Map<String, String>> args)
    {
      int result = 0;
      for (int i = 0; i < args.size(); i++)
      {
        Map<String, String> arg = (Map)args.get(i);
        result += insert("work_event.update_cm_evt_item_info", arg);
      }
      return result;
    }
    
    public int deleteCmEvtItemInfo(List<Map<String, String>> list)
    {
      int result = 0;
      for (int i = 0; i < list.size(); i++)
      {
        Map<String, String> itemMap = (Map)list.get(i);
        result += delete("work_event.delete_cm_evt_item_info", itemMap);
      }
      return result;
    }
    
    public int insertCmEventSub(Map<String, String> args)
    {
      return insert("work_event.insert_cm_event_sub", args);
    }
    
    public int updateCmEventSub(List<Map<String, String>> args)
    {
      int result = 0;
      for (int i = 0; i < args.size(); i++)
      {
        Map<String, String> arg = (Map)args.get(i);
        result += update("work_event.update_cm_event_sub", arg);
      }
      return result;
    }
    
    public int deleteCmEventSub(List<Map<String, String>> args)
    {
      int result = 0;
      for (int i = 0; i < args.size(); i++)
      {
        Map<String, String> arg = (Map)args.get(i);
        result += update("work_event.delete_cm_event_sub", arg);
      }
      return result;
    }
    
    public int selectEventTypeCurrval() {
    	return selectOne("work_event.event_type_seq_currval", null);
    }

}
