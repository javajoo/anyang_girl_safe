package com.danusys.platform.west.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("esEventDAO")
public class EsEventDAO extends EgovAbstractMapper {
	
	public int insertEvent(EgovMap paramEgovMap)
			throws Exception {
		return insert("esEventDAO.insertEvent", paramEgovMap);
	}

	public int selectEventEsTypeCount(String eventType) throws Exception {
		return selectOne("esEventDAO.selectEventEsTypeCount", eventType);
	}

	public List<?> selectFoaForestMap() throws Exception {
		return selectList("esEventDAO.selectFoaForestMap");
	}

	public List<?> selectHrfRfhr() throws Exception {
		return selectList("esEventDAO.selectHrfRfhr");
	}

	public List<?> selectKhcAcc() throws Exception {
		return selectList("esEventDAO.selectKhcAcc");
	}

	public List<?> selectKmaAws10M() throws Exception {
		return selectList("esEventDAO.selectKmaAws10M");
	}

	public List<?> selectKmaDfsShrt() throws Exception {
		return selectList("esEventDAO.selectKmaDfsShrt");
	}

	public List<?> selectKmaEarthInfm() throws Exception {
		return selectList("esEventDAO.selectKmaEarthInfm");
	}

	public List<?> selectKmaInform() throws Exception {
		return selectList("esEventDAO.selectKmaInform");
	}

	public List<?> selectNemEmre() throws Exception {
		return selectList("esEventDAO.selectNemEmre");
	}

	public List<?> selectNemFirs() throws Exception {
		return selectList("esEventDAO.selectNemFirs");
	}

	public List<?> selectRtsaOccurid() throws Exception {
		return selectList("esEventDAO.selectRtsaOccurid");
	}
}
