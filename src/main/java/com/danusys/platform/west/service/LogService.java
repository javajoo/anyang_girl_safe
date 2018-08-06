package com.danusys.platform.west.service;

import java.util.List;

/**
 * @Class Name : LogVO.java
 * @Description : Log VO class
 * @Modification Information
 *
 * @author 김하울
 * @since 2018-01-03
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface LogService {
    
	void writeLogoutLog(LogVO vo) throws Exception; //로그아웃 로그
	void writeSessionoutLog(LogVO vo) throws Exception; //세션아웃 로그

	/*로그 조회-마스터*/
    List<?> selectLogList(LogVO vo) throws Exception;
    int selectLogListTotCnt(LogVO vo);
}
