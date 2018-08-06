package com.danusys.platform.sensor.service;

import java.util.List;
import java.util.Map;

import com.danusys.platform.sensor.service.DatasVO;

/**
 * @Class Name : DatasService.java
 * @Description : Datas Business class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-01-18
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface DatasService {
	
   
    /**
	 * datas을 조회한다.
	 * @param vo - 조회할 정보가 담긴 DatasVO
	 * @return 조회한 datas
	 * @exception Exception
	 */
    List<?> selectDatas(DatasVO vo) throws Exception;
    
    List<?> selectDatasHS(DatasVO vo) throws Exception;
    
    List<?> selectDatasMS(DatasVO vo) throws Exception;    
/*    public List<?> selectDatasMT() throws Exception;*/
}
