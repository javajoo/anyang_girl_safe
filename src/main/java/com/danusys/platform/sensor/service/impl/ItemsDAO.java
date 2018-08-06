package com.danusys.platform.sensor.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import com.danusys.platform.sensor.service.ItemsVO;

/**
 * @Class Name : ItemsDAO.java
 * @Description : Items DAO Class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-01-18
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("itemsDAO")
public class ItemsDAO extends EgovAbstractDAO {

	/**
	 * items을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ItemsVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertItems(ItemsVO vo) throws Exception {
        return (String)insert("itemsDAO.insertItems_S", vo);
    }

    /**
	 * items을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ItemsVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateItems(ItemsVO vo) throws Exception {
        update("itemsDAO.updateItems_S", vo);
    }

    /**
	 * items을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ItemsVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteItems(ItemsVO vo) throws Exception {
        delete("itemsDAO.deleteItems_S", vo);
    }

    /**
	 * items을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ItemsVO
	 * @return 조회한 items
	 * @exception Exception
	 */
    public ItemsVO selectItems(ItemsVO vo) throws Exception {
        return (ItemsVO) select("itemsDAO.selectItems_S", vo);
    }
    
    /**
	 * 모든 items data를 가져온다.
	 * @param
	 * @return 조회한 items
	 * @exception Exception
	 */
    public List<ItemsVO> selectAllItems() throws Exception {
        return (List) select("itemsDAO.selectAllItems_S");
    }

    /**
	 * items 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return items 목록
	 * @exception Exception
	 */
    public List<?> selectItemsList(ItemsVO searchVO) throws Exception {
        return list("itemsDAO.selectItemsList_D", searchVO);
    }

    /**
	 * items 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return items 총 갯수
	 * @exception
	 */
    public int selectItemsListTotCnt(ItemsVO searchVO) {
        return (Integer)select("itemsDAO.selectItemsListTotCnt_S", searchVO);
    }

}
