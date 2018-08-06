package com.danusys.platform.sensor.service.impl;

import javax.annotation.Resource;

import com.ibatis.sqlmap.client.SqlMapClient;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

public class EgovComSensorDAO extends EgovAbstractDAO {
	@Override
	@Resource(name = "egov.sqlMapClientSENSOR")
	public void setSuperSqlMapClient(SqlMapClient sqlMapClient) {
		super.setSuperSqlMapClient(sqlMapClient);
	}
}
