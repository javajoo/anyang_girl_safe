package com.danusys.platform.sensor.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import com.danusys.platform.sensor.service.DatasService;
import com.danusys.platform.sensor.service.DatasVO;
import com.danusys.platform.sensor.service.GsonDto;
import com.danusys.platform.sensor.service.impl.DatasDAO;

/**
 * @Class Name : DatasServiceImpl.java
 * @Description : Datas Business Implement class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-01-18
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("datasService")
public class DatasServiceImpl extends EgovAbstractServiceImpl implements
        DatasService {
        
    @SuppressWarnings("unused")
    private static final Logger LOGGER = LoggerFactory.getLogger(DatasServiceImpl.class);

    @Resource(name="datasDAO")
    private DatasDAO datasDAO;
    
    /** ID Generation */
    //@Resource(name="{egovDatasIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

    /**
	 * datas을 조회한다.
	 * @param vo - 조회할 정보가 담긴 DatasVO
	 * @return 조회한 datas
	 * @exception Exception
	 */
    public List<?> selectDatas(DatasVO vo) throws Exception {
        return  this.selectDatasSel(vo);
    }
    private List<?> selectDatasSel(DatasVO vo) throws Exception {
        return  datasDAO.selectDatas(vo);
    }
    public List<?> selectDatasHS(DatasVO vo) throws Exception {
        return  datasDAO.selectDatasHS(vo);
    }    
    public List<?> selectDatasMS(DatasVO vo) throws Exception {
        return  datasDAO.selectDatasMS(vo);
    }   
    
    /*    public List<?> selectDatas(DatasVO vo) throws Exception {
        List<?> resultVO = datasDAO.selectDatas(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
        //return datasDAO.selectDatas(vo);`
    }*/
    
/*    public List<?> selectDatasMT() throws Exception {
        return datasDAO.selectDatasMT();
    }   */
}
