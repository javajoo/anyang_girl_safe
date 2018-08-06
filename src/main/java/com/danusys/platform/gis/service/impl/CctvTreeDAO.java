package com.danusys.platform.gis.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.danusys.platform.gis.service.CctvTreeVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * @Class Name : CctvTreeDAO.java
 * @Description : CctvTree DAO Class
 * @Modification Information
 *
 * @author 신대영
 * @since 2016-08-03
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("cctvTreeDAO")
public class CctvTreeDAO extends EgovAbstractDAO {
    /**
	 * cctv_tree을 조회한다.
	 * @param vo - 조회할 정보가 담긴 CctvTreeVO
	 * @return 조회한 cctv_tree
	 * @exception Exception
	 */
    public List<?> selectCctvTree(CctvTreeVO vo) throws Exception {
        return list("cctvTreeDAO.selectCctvTree_S", vo);
    }
}
