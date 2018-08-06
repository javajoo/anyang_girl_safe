package com.danusys.platform.sensor.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.danusys.platform.sensor.service.DatasVO;
import com.danusys.platform.sensor.service.GsonDto;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;


/**
 * @Class Name : DatasDAO.java
 * @Description : Datas DAO Class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-01-18
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("datasDAO")
public class DatasDAO extends EgovComSensorDAO {

    /**
	 * datas을 조회한다.
	 * @param vo - 조회할 정보가 담긴 DatasVO
	 * @return 조회한 datas
	 * @exception Exception
	 */
    public List<?> selectDatas(DatasVO vo) throws Exception {
        return list("datasDAO.selectDatas_S", vo);
    }
    public List<?> selectDatasHS(DatasVO vo) throws Exception {
        return list("datasDAO.selectDatas_HS", vo);
    }
    public List<?> selectDatasMS(DatasVO vo) throws Exception {
        return list("datasDAO.selectDatas_MS", vo);
    }
/*    public List<GsonDto> selectDatasMT() throws Exception {
        // TODO Auto-generated method stub
        return (List<GsonDto>) list("datasDAO.selectDatas_T");
        //return map("datasDAO.selectDatas_T", null, "hh", "ou");
    }
    
    public List<GsonDto> selectDatasMT(GsonDto searchVO) throws Exception {
        // TODO Auto-generated method stub
        return (List<GsonDto>) list("datasDAO.selectDatas_T", searchVO);
    }    */
}
