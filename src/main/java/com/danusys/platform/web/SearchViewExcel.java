/*
 * Copyright 2011 MOPAS(Ministry of Public Administration and Security).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.danusys.platform.web;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.danusys.platform.service.ExcelHeaderVO;

import egovframework.rte.fdl.excel.util.AbstractPOIExcelView;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public class SearchViewExcel extends AbstractPOIExcelView {

	private static final Logger log  = LoggerFactory.getLogger(SearchViewExcel.class);

	/**
	 * 엑셀파일을 설정하고 생성한다.
	 * @param model
	 * @param wb
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	protected void buildExcelDocument(Map<String, Object> model, XSSFWorkbook wb, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        XSSFCell cell = null;

        log.debug("### buildExcelDocument start !!!");

        XSSFSheet sheet = wb.createSheet("검색결과");
        sheet.setColumnWidth(0, 30*256);
        sheet.setColumnWidth(1, 30*256);
        sheet.setColumnWidth(2, 30*256);
        sheet.setColumnWidth(3, 30*256);
        
        //cell 테두리 + 가운데 정렬
        final XSSFCellStyle style = wb.createCellStyle();
        style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
        style.setBorderRight(XSSFCellStyle.BORDER_THIN);
        style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
        style.setBorderTop(XSSFCellStyle.BORDER_THIN);
        style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
        style.setWrapText(true);
        
        List<ExcelHeaderVO> headers = (List<ExcelHeaderVO>) model.get("headerList");

        int inx = 0;
        for (int i = 0; i < headers.size(); i++) {
			ExcelHeaderVO headerVO = headers.get(i);

			if(headerVO.getHeaderUse()){
			    cell = getCell(sheet, 0, inx++);
			    cell.setCellStyle(style);
				setText(cell, URLDecoder.decode(headerVO.getHeaderText(),"UTF-8"));
			}
		}
        
        log.debug("### buildExcelDocument cast");

        List<?> list = (List<?>) model.get("result");

		for (int i = 0; i < list.size(); i++) {
	        inx = 0;
			
	        EgovMap cctv = (EgovMap)list.get(i);
	        
			for (int j = 0; j < headers.size(); j++) {
				ExcelHeaderVO headerVO = headers.get(j);

				if(headerVO.getHeaderUse()){
				    String field = headerVO.getHeaderField();
					
					String value = "";
					if(cctv.get(field) != null)
						value = cctv.get(field).toString();
					
					value = value.replaceAll("<br>", "\n");

					cell = getCell(sheet, 1 + i, inx++);
					cell.setCellStyle(style);
					setText(cell, value);
				}
			}
		}
    }

}
