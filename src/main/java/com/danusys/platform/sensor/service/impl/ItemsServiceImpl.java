package com.danusys.platform.sensor.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import com.danusys.platform.sensor.service.ItemsService;
import com.danusys.platform.sensor.service.ItemsVO;
import com.danusys.platform.sensor.service.impl.ItemsDAO;

/**
 * @Class Name : ItemsServiceImpl.java
 * @Description : Items Business Implement class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-01-18
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("itemsService")
public class ItemsServiceImpl extends EgovAbstractServiceImpl implements
        ItemsService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(ItemsServiceImpl.class);

    @Resource(name="itemsDAO")
    private ItemsDAO itemsDAO;
    
    /** ID Generation */
    //@Resource(name="{egovItemsIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * items을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ItemsVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertItems(ItemsVO vo) throws Exception {
    	LOGGER.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	LOGGER.debug(vo.toString());
    	
    	itemsDAO.insertItems(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * items을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ItemsVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateItems(ItemsVO vo) throws Exception {
        itemsDAO.updateItems(vo);
    }

    /**
	 * items을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ItemsVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteItems(ItemsVO vo) throws Exception {
        itemsDAO.deleteItems(vo);
    }

    /**
	 * items을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ItemsVO
	 * @return 조회한 items
	 * @exception Exception
	 */
    public ItemsVO selectItems(ItemsVO vo) throws Exception {
        ItemsVO resultVO = itemsDAO.selectItems(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }
    
    /**
	 * 모든 items data를 가져온다.
	 * @param
	 * @return 조회한 items
	 * @exception Exception
	 */
    public List<ItemsVO> selectAllItems() throws Exception {
        return itemsDAO.selectAllItems();
    }

    /**
	 * items 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return items 목록
	 * @exception Exception
	 */
    public List<?> selectItemsList(ItemsVO searchVO) throws Exception {
        return itemsDAO.selectItemsList(searchVO);
    }

    /**
	 * items 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return items 총 갯수
	 * @exception
	 */
    public int selectItemsListTotCnt(ItemsVO searchVO) {
		return itemsDAO.selectItemsListTotCnt(searchVO);
	}
    
}
