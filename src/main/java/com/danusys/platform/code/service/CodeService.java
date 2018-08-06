package com.danusys.platform.code.service;

import java.util.List;

/**
 * @Class Name : CodeService.java
 * @Description : Code Business class
 * @Modification Information
 *
 * @author 김하울
 * @since 2017-12-13
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface CodeService {
    
    /**
     * CodeVO 목록을 조회한다.
     * @param searchVO - 조회할 정보가 담긴 CodeVO
     * @return code 목록
     * @exception Exception
     */
    List<CodeVO> selectCode(CodeVO vo) throws Exception;
    
    /**
     * CodeVO 총 갯수를 조회한다.
     * @param searchVO - 조회할 정보가 담긴 CodeVO
     * @return code 총 갯수
     * @exception
     */
    //int selectCodeListTotCnt(CodeVO vo);
    
    /**
     * CodeVO을 등록한다.
     * @param vo - 등록할 정보가 담긴 EventVO
     * @return 등록 결과
     * @exception Exception
     */
    String insertCode(CodeVO vo) throws Exception;
    
    /**
     * CodeVO을 수정한다.
     * @param vo - 수정할 정보가 담긴 CodeVO
     * @return void형
     * @exception Exception
     */
    void updateCode(CodeVO vo) throws Exception;
    
    /**
     * CodeVO을 삭제한다.
     * @param vo - 삭제할 정보가 담긴 CodeVO
     * @return void형 
     * @exception Exception
     */
    void deleteCode(CodeVO vo) throws Exception;
    
}
