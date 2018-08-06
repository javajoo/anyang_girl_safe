package com.danusys.platform.gis.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;




import com.danusys.platform.gis.service.CctvTreeService;
import com.danusys.platform.gis.service.CctvTreeVO;
import com.danusys.platform.gis.service.impl.CctvTreeDAO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : CctvTreeServiceImpl.java
 * @Description : CctvTree Business Implement class
 * @Modification Information
 *
 * @author 신대영
 * @since 2016-08-03
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("cctvTreeService")
public class CctvTreeServiceImpl extends EgovAbstractServiceImpl implements
        CctvTreeService {
        
    //private static final Logger LOGGER = LoggerFactory.getLogger(CctvTreeServiceImpl.class);

    @Resource(name="cctvTreeDAO")
    private CctvTreeDAO cctvTreeDAO;
    
    /**
	 * cctv_tree을 조회한다.
	 * @param vo - 조회할 정보가 담긴 CctvTreeVO
	 * @return 조회한 cctv_tree
	 * @exception Exception
	 */
    public List<?> selectCctvTree(CctvTreeVO vo) throws Exception {
        return  this.selectCctvTreeSel(vo);
    }
    private List<?> selectCctvTreeSel(CctvTreeVO vo) throws Exception {
        return  cctvTreeDAO.selectCctvTree(vo);
    }

    /**
     * 로그기록
     */
	@Override
	public void getMgtPrintPageLog() {
		System.out.println("printPage");		
	}
    
}
