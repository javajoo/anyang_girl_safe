package com.danusys.platform.excel.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.danusys.platform.excel.service.ExcelDownloadService;

@Controller
public class ExcelDownloadController {
	
	@Resource(name="excelDownloadService")
	private ExcelDownloadService service;
	
	@RequestMapping("excel/download.do")
	public ModelAndView excelDownload(@RequestParam("excelData") String excelData) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("excel_download");
		mav.addObject("filename", "검색결과");
		mav.addObject("excel", excelData);
		
		// 로그기록
		service.excelDownload();
		
		return mav;
	}
	
	@RequestMapping("excel/download2.do")
	public void excelDownload2() {
		// 로그기록
		service.excelDownload();
	}
}
