package com.danusys.platform.west.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.danusys.platform.service.ExcelHeaderVO;
import com.danusys.platform.west.service.LogService;
import com.danusys.platform.west.service.LogVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : LogController.java
 * @Description : Log Controller class
 * @Modification Information
 *
 * @author 김하울
 * @since 2018-01-03
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class LogController {
	private static final Logger LOGGER = LoggerFactory.getLogger(LogController.class);

    @Resource(name = "logService")
    private LogService logService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @RequestMapping(value="/com/danusys/platform/selectLogList.do")
    public @ResponseBody Map<String, Object> selectLogList(LogVO vo) throws Exception {
        
        /** EgovPropertyService.sample */
        vo.setPageUnit(propertiesService.getInt("pageUnit"));
        vo.setPageIndex(vo.getPage());
        
        /** pageing */
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(vo.getPageIndex());
        paginationInfo.setRecordCountPerPage(vo.getPageSize());
        paginationInfo.setPageSize(vo.getPageSize());
        
        vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
        vo.setLastIndex(paginationInfo.getLastRecordIndex());
        vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        List<?> list = logService.selectLogList(vo);
        int totCnt = logService.selectLogListTotCnt(vo);
        paginationInfo.setTotalRecordCount(totCnt);
        
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("rows", list);
        map.put("total", totCnt);
        
        return map;
    }
    
    
    @RequestMapping(value="/com/danusys/platform/selectLogExcel.do")
    public ModelAndView excelSelectLogExcel(LogVO searchVO, HttpServletRequest request) throws Exception {
        searchVO.setRecordCountPerPage(-1);
        List<?> result = new ArrayList<EgovMap>();
        result = (List<EgovMap>) logService.selectLogList(searchVO);
        
        List<ExcelHeaderVO> headerList = new ArrayList<ExcelHeaderVO>();
        
        int headerCnt = Integer.parseInt(request.getParameter("headerCnt"));
        
        for(int i = 0; i < headerCnt; i++){
            ExcelHeaderVO vo = new ExcelHeaderVO();
            vo.setHeaderText(request.getParameter("headerText"+i));
            vo.setHeaderField(request.getParameter("headerField"+i));
            vo.setHeaderUse(Boolean.parseBoolean(request.getParameter("headerUse"+i)));
            headerList.add(vo);
        }

        Map<String, Object> map = new HashMap<String, Object>();

        map.put("result", result);
        map.put("headerList", headerList);
        
        return new ModelAndView("searchLoginLogExcelView", map);
    }
}
