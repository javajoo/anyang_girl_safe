package com.danusys.platform.west.service;

import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public abstract interface EsEventService {
	public abstract int insertEvent(EgovMap paramEgovMap) throws Exception;

	public abstract int selectEventEsTypeCount(String eventType) throws Exception;
	
	public abstract List<?> selectFoaForestMap() throws Exception;
	
	public abstract List<?> selectHrfRfhr() throws Exception;
	
	public abstract List<?> selectKhcAcc() throws Exception;
	
	public abstract List<?> selectKmaAws10M() throws Exception;
	
	public abstract List<?> selectKmaDfsShrt() throws Exception;
	
	public abstract List<?> selectKmaEarthInfm() throws Exception;
	
	public abstract List<?> selectKmaInform() throws Exception;
	
	public abstract List<?> selectNemEmre() throws Exception;
	
	public abstract List<?> selectNemFirs() throws Exception;
	
	public abstract List<?> selectRtsaOccurid() throws Exception;
	
	public abstract void insertAllEsEvent(String key) throws Exception;
}
