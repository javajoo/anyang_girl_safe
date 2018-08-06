package com.danusys.platform.code.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import com.danusys.platform.code.service.CodeService;
import com.danusys.platform.code.service.CodeVO;

import egovframework.com.cmm.LoginVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;

/**
 * @Class Name : CodeController.java
 * @Description : Code Controller class
 * @Modification Information
 *
 * @author 김하울
 * @since 2017-12-13
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class CodeController {

    @Resource(name = "codeService")
    private CodeService codeService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @RequestMapping("/com/danusys/platform/selectCode.do")
    public @ResponseBody List<?> selectCode(CodeVO vo) throws Exception {
        
        List<CodeVO> list = codeService.selectCode(vo);
        return list;
    }
    
    @RequestMapping("/com/danusys/platform/insertCode.do")
    public @ResponseBody Map<String, String> insertCode(CodeVO vo, SessionStatus status) throws Exception {
        
        Map<String , String> map = new HashMap<String , String>();
        LoginVO user = EgovUserDetailsHelper.isAuthenticated()? (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser():null;
        
        if(EgovUserDetailsHelper.isAuthenticated() && user!=null){ // 인증된 경우는 메인 페이지로 이동
            vo.setInstId(user.getId());
            codeService.insertCode(vo);
            try{
                map.put("stat", "sucess");
            }catch(Exception exx){
                map.put("stat", exx.toString());
            }
        }else{
            map.put("stat", "인증되지 않은 사용자 입니다.");
        }
        status.setComplete();
        return map;
    }

    @RequestMapping("/com/danusys/platform/updateCode.do")
    public @ResponseBody Map<String, String> updateCode(CodeVO vo, SessionStatus status) throws Exception {
        
        Map<String , String> map = new HashMap<String , String>();
        LoginVO user = EgovUserDetailsHelper.isAuthenticated()? (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser():null;
        
        if(EgovUserDetailsHelper.isAuthenticated() && user!=null){ // 인증된 경우는 메인 페이지로 이동
            vo.setUpdId(user.getId());
            codeService.updateCode(vo);
            try{
                map.put("stat", "sucess");
            }catch(Exception exx){
                map.put("stat", exx.toString());
            }
        }else{
            map.put("stat", "인증되지 않은 사용자 입니다.");
        }
        status.setComplete();
        return map;
    }
    
    @RequestMapping("/com/danusys/platform/deleteCode.do")
    public @ResponseBody Map<String, String> deleteCode(HttpServletRequest request)
            throws Exception {
        
        Map<String , String> map = new HashMap<String , String>();
        LoginVO user = EgovUserDetailsHelper.isAuthenticated()? (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser():null;
        
        if(EgovUserDetailsHelper.isAuthenticated() && user!=null){ // 인증된 경우는 메인 페이지로 이동
            int seqNoCnt = Integer.parseInt(request.getParameter("cnt"));
            ArrayList<String> seqNoList = new ArrayList<String>(seqNoCnt);
            
            for(int i = 0; i < seqNoCnt; i++){
                seqNoList.add(request.getParameter("seqNo"+i));
            }
            CodeVO vo = new CodeVO();
            vo.setSeqNoList(seqNoList);
            
            try{
                codeService.deleteCode(vo);
                map.put("stat", "sucess");
            }catch(Exception exx){
                map.put("stat", exx.toString());
            }
        }else{
            map.put("stat", "인증되지 않은 사용자 입니다.");
        }
        return map;
    }
}
