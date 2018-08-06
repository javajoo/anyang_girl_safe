package com.danusys.platform.sensor.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.danusys.platform.sensor.service.LastsVO;
import com.danusys.platform.sensor.service.OutOfRangeSensorVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * @Class Name : LastsDAO.java
 * @Description : Lasts DAO Class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-01-16
 * @version 1.0
 * @see
 * 
 * 		Copyright (C) All right reserved.
 */

@Repository("lastsDAO")
public class LastsDAO extends EgovComSensorDAO {

	/**
	 * lasts을 조회한다.
	 * @param vo - 조회할 정보가 담긴 LastsVO
	 * @return 조회한 lasts
	 * @exception Exception
	 */
	public List<LastsVO> selectLasts(LastsVO vo) throws Exception {
		return (List<LastsVO>) list("lastsDAO.selectLasts_S", vo);
	}

	/**
	 * lasts에서 범위가 벗어난 것들만 조회 한다.
	 * @param
	 * @return 조회한 lasts
	 * @exception Exception
	 */
	public List<OutOfRangeSensorVO> selectOutOfRange() throws Exception {
		return (List<OutOfRangeSensorVO>) list("lastsDAO.selectOutOfRange");
	}
}
