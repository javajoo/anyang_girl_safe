package com.danusys.platform.code.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.danusys.platform.code.service.CodeVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * @Class Name : CodeDAO.java
 * @Description : Code DAO Class
 * @Modification Information
 *
 * @author 김하울
 * @since 2017-12-13
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("codeDAO")
public class CodeDAO extends EgovAbstractDAO {
    /**
     * Event 목록을 조회한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return notice 목록
     * @exception Exception
     */
    @SuppressWarnings("unchecked")
    public List<CodeVO> selectCode(CodeVO vo) throws Exception {
        return (List<CodeVO>) list("codeDAO.selectCode", vo);
    }

    /**
     * Code 총 갯수를 조회한다.
     * @param searchMap - 조회할 정보가 담긴 Map
     * @return code 총 갯수
     * @exception
     */
    //public int selectCodeListTotCnt(CodeVO vo) {
    //    return (Integer)select("codeDAO.selectCodeListTotCnt", vo);
    //}
    /**
     * Code을 등록한다.
     * @param vo - 등록할 정보가 담긴 CodeVO
     * @return 등록 결과
     * @exception Exception
     */
    public String insertCode(CodeVO vo) throws Exception {
        return (String)insert("codeDAO.insertCode", vo);
    }

    /**
     * Code을 수정한다.
     * @param vo - 수정할 정보가 담긴 CodeVO
     * @return void형
     * @exception Exception
     */
    public void updateCode(CodeVO vo) throws Exception {
        update("codeDAO.updateCode", vo);
    }

    /**
     * Code을 삭제한다.
     * @param vo - 삭제할 정보가 담긴 CodeVO
     * @return void형 
     * @exception Exception
     */
    public void deleteCode(CodeVO vo) throws Exception {
        delete("codeDAO.deleteCode", vo);
    }
}
