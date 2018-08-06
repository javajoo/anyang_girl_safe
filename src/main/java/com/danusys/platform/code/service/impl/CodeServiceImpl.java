package com.danusys.platform.code.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.danusys.platform.code.service.CodeService;
import com.danusys.platform.code.service.CodeVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : CodeServiceImpl.java
 * @Description : Code Business Implement class
 * @Modification Information
 *
 * @author 김하울
 * @since 2017-12-13
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("codeService")
public class CodeServiceImpl extends EgovAbstractServiceImpl implements CodeService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(CodeServiceImpl.class);

    @Resource(name="codeDAO")
    private CodeDAO codeDAO;
    
    /**
     * Code 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 CodeVO
     * @return code 목록
     * @exception Exception
     */
    public List<CodeVO> selectCode(CodeVO vo) throws Exception {
        return codeDAO.selectCode(vo);
    }

    /**
     * Code 총 갯수를 조회한다.
     * @param searchVO - 조회할 정보가 담긴CodeVO
     * @return code 총 갯수
     * @exception
     */
    //public int selectCodeListTotCnt(CodeVO vo) {
    //    return codeDAO.selectCodeListTotCnt(vo);
    //}
    
    /**
     * Code을 등록한다.
     * @param vo - 등록할 정보가 담긴 CodeVO
     * @return 등록 결과
     * @exception Exception
     */
    public String insertCode(CodeVO vo) throws Exception {
        LOGGER.debug(vo.toString());
        
        codeDAO.insertCode(vo);
        //TODO 해당 테이블 정보에 맞게 수정     
        return null;
    }

    /**
     * Code을 수정한다.
     * @param vo - 수정할 정보가 담긴 CodeVO
     * @return void형
     * @exception Exception
     */
    public void updateCode(CodeVO vo) throws Exception {
        codeDAO.updateCode(vo);
    }

    /**
     * Code을 삭제한다.
     * @param vo - 삭제할 정보가 담긴 CodeVO
     * @return void형 
     * @exception Exception
     */
    public void deleteCode(CodeVO vo) throws Exception {
        codeDAO.deleteCode(vo);
    }
}
