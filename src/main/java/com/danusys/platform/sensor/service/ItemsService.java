package com.danusys.platform.sensor.service;

import java.util.List;
import com.danusys.platform.sensor.service.ItemsVO;

/**
 * @Class Name : ItemsService.java
 * @Description : Items Business class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-01-18
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface ItemsService {
	
	/**
	 * items을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ItemsVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertItems(ItemsVO vo) throws Exception;
    
    /**
	 * items을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ItemsVO
	 * @return void형
	 * @exception Exception
	 */
    void updateItems(ItemsVO vo) throws Exception;
    
    /**
	 * items을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ItemsVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteItems(ItemsVO vo) throws Exception;
    
    /**
	 * items을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ItemsVO
	 * @return 조회한 items
	 * @exception Exception
	 */
    ItemsVO selectItems(ItemsVO vo) throws Exception;
    

    /**
	 * 모든 items data를 가져온다.
	 * @param
	 * @return 조회한 items
	 * @exception Exception
	 */
    List<ItemsVO> selectAllItems() throws Exception;

    
    /**
	 * items 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return items 목록
	 * @exception Exception
	 */
    List selectItemsList(ItemsVO searchVO) throws Exception;
    
    /**
	 * items 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return items 총 갯수
	 * @exception
	 */
    int selectItemsListTotCnt(ItemsVO searchVO);
    
}
