package com.danusys.platform.west.service.impl;

import java.net.InetAddress;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.danusys.platform.west.service.LogService;
import com.danusys.platform.west.service.LogVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : LogServiceImpl.java
 * @Description : Log Business Implement class
 * @Modification Information
 *
 * @author 김하울
 * @since 2018-01-03
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
@Service("logService")
public class LogServiceImpl extends EgovAbstractServiceImpl implements LogService {
	
	@Resource(name="logDAO")
	private LogDAO logDAO;

	/**
	 * 로그아웃 로그 기록.
	 * @throws Exception 
	 */
	public void writeLogoutLog(LogVO vo) throws Exception  {
		vo.setLogType("LOGOUT");
        vo.setContent("로그아웃");
        vo.setIp(InetAddress.getLocalHost().getHostAddress().toString());
		logDAO.insertLog(vo);
	}
	
	/**
     * 세션아웃 로그 기록.
     * @throws Exception 
     */
    public void writeSessionoutLog(LogVO vo) throws Exception  {
        vo.setLogType("SESSIONOUT");
        vo.setContent("세션아웃");
        vo.setIp(InetAddress.getLocalHost().getHostAddress().toString());
        logDAO.insertLog(vo);
    }
	
	/*로그 조회-마스터*/
	public List<?> selectLogList(LogVO vo) throws Exception {
	    return logDAO.selectLogList(vo);
    }
    public int selectLogListTotCnt(LogVO vo) {
        return logDAO.selectLogListTotCnt(vo);
    }
}
