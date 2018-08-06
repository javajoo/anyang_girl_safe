package com.danusys.platform.west.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.danusys.platform.west.service.EsEventService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("esEventService")
public class EsEventServiceImpl extends EgovAbstractServiceImpl implements EsEventService{
	static Logger logger = LoggerFactory.getLogger(EsEventServiceImpl.class);
	
	@Resource(name = "esEventDAO")
	EsEventDAO esEventDAO;

	public int insertEvent(EgovMap paramEgovMap)
			throws Exception {
		return esEventDAO.insertEvent(paramEgovMap);
	}

	public int selectEventEsTypeCount(String eventType) throws Exception {
		return esEventDAO.selectEventEsTypeCount(eventType);
	}

	public List<?> selectFoaForestMap() throws Exception {
		return esEventDAO.selectFoaForestMap();
	}

	public List<?> selectHrfRfhr() throws Exception {
		return esEventDAO.selectHrfRfhr();
	}

	public List<?> selectKhcAcc() throws Exception {
		return esEventDAO.selectKhcAcc();
	}

	public List<?> selectKmaAws10M() throws Exception {
		return esEventDAO.selectKmaAws10M();
	}

	public List<?> selectKmaDfsShrt() throws Exception {
		return esEventDAO.selectKmaDfsShrt();
	}

	public List<?> selectKmaEarthInfm() throws Exception {
		return esEventDAO.selectKmaEarthInfm();
	}

	public List<?> selectKmaInform() throws Exception {
		return esEventDAO.selectKmaInform();
	}

	public List<?> selectNemEmre() throws Exception {
		return esEventDAO.selectNemEmre();
	}

	public List<?> selectNemFirs() throws Exception {
		return esEventDAO.selectNemFirs();
	}

	public List<?> selectRtsaOccurid() throws Exception {
		return esEventDAO.selectRtsaOccurid();
	}
	
	public void insertAllEsEvent(String key) throws Exception {
		this.insertFoaForestMap(key);
		this.insertHrfRfhr(key);
		this.insertKhcAcc(key);
		this.insertKmaAws10M(key);
		this.insertKmaDfsShrt(key);
		this.insertKmaEarthInfm(key);
		this.insertKmaInform(key);
		this.insertNemEmre(key);
		this.insertNemFirs(key);
		this.insertRtsaOccurid(key);
	}
	
	public void insertFoaForestMap(String key) throws Exception {
		List<?> list = esEventDAO.selectFoaForestMap();
		
		for (EgovMap map : (List<EgovMap>)list) {
			map.put("key", key);
			esEventDAO.insertEvent(map);
		}
	}
	
	public void insertHrfRfhr(String key) throws Exception {
		List<?> list = esEventDAO.selectHrfRfhr();
		
		for (EgovMap map : (List<EgovMap>)list) {
			map.put("key", key);
			esEventDAO.insertEvent(map);
		}
	}
	
	public void insertKhcAcc(String key) throws Exception {
		List<?> list = esEventDAO.selectKhcAcc();
		
		for (EgovMap map : (List<EgovMap>)list) {
			map.put("key", key);
			esEventDAO.insertEvent(map);
		}
	}
	
	public void insertKmaAws10M(String key) throws Exception {
		List<?> list = esEventDAO.selectKmaAws10M();
		
		for (EgovMap map : (List<EgovMap>)list) {
			map.put("key", key);
			esEventDAO.insertEvent(map);
		}
	}
	
	public void insertKmaDfsShrt(String key) throws Exception {
		List<?> list = esEventDAO.selectKmaDfsShrt();
		
		for (EgovMap map : (List<EgovMap>)list) {
			map.put("key", key);
			esEventDAO.insertEvent(map);
		}
	}
	
	public void insertKmaEarthInfm(String key) throws Exception {
		List<?> list = esEventDAO.selectKmaEarthInfm();
		
		for (EgovMap map : (List<EgovMap>)list) {
			map.put("key", key);
			esEventDAO.insertEvent(map);
		}
	}
	
	public void insertKmaInform(String key) throws Exception {
		List<?> list = esEventDAO.selectKmaInform();
		
		for (EgovMap map : (List<EgovMap>)list) {
			map.put("key", key);
			esEventDAO.insertEvent(map);
		}
	}
	
	public void insertNemEmre(String key) throws Exception {
		List<?> list = esEventDAO.selectNemEmre();
		
		for (EgovMap map : (List<EgovMap>)list) {
			map.put("key", key);
			esEventDAO.insertEvent(map);
		}
	}
	
	public void insertNemFirs(String key) throws Exception {
		List<?> list = esEventDAO.selectNemFirs();
		
		for (EgovMap map : (List<EgovMap>)list) {
			map.put("key", key);
			esEventDAO.insertEvent(map);
		}
	}
	
	public void insertRtsaOccurid(String key) throws Exception {
		List<?> list = esEventDAO.selectRtsaOccurid();
		
		for (EgovMap map : (List<EgovMap>)list) {
			map.put("key", key);
			esEventDAO.insertEvent(map);
		}
	}
}
