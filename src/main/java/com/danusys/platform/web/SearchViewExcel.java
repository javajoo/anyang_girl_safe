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

import java.io.ByteArrayOutputStream;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import egovframework.rte.fdl.excel.util.AbstractPOIExcelView;

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
	protected void buildExcelDocument(Map<String, Object> model, XSSFWorkbook wb, HttpServletRequest request, HttpServletResponse response) throws Exception {
		//response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		//response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		Calendar calendar = Calendar.getInstance();
        java.util.Date date = calendar.getTime();
        String today = (new SimpleDateFormat("yyyyMMddHHmmss").format(date));
		String fileName = request.getParameter("fileName") + today;
		
        response.setHeader("Content-Disposition", "attachment; filename="+ fileName +".xlsx");
        setContentType("application/download; utf-8");
        
        
        XSSFCell cell = null;

        log.debug("### buildExcelDocument start !!!");

        XSSFSheet sheet = wb.createSheet(fileName);
        
        //cell 테두리 + 가운데 정렬
        final XSSFCellStyle style = wb.createCellStyle();
        style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
        style.setBorderRight(XSSFCellStyle.BORDER_THIN);
        style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
        style.setBorderTop(XSSFCellStyle.BORDER_THIN);
        style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
        style.setWrapText(true);
        style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
        
        
        List<Map<String, String>> headers =  (List<Map<String, String>>) model.get("headerList");
		
		int inx = 0;

        for (int i = 0; i < headers.size(); i++) {
            sheet.setColumnWidth(i, 30*128);
        	Map<String, String> headerMap = headers.get(i);
        	String headerText = headerMap.get("headerText");
        	headerText = URLDecoder.decode(headerText,"UTF-8");
        	System.out.println(headerMap.get("headerField"));
        	System.out.println(headerText);
		    cell = getCell(sheet, 0, inx++);
		    cell.setCellStyle(style);
			setText(cell, headerText);
		}
        

		List<Map<String, Object>> list = (List<Map<String, Object>>) model.get("result");

		for (int i = 0; i < list.size(); i++) {
	        inx = 0;
			
	        Map<String, Object> listMap = list.get(i);
	        
			for (int j = 0; j < headers.size(); j++) {
				Map<String, String> header = headers.get(j);
			    String field = header.get("headerField");
				
				String value = "";
				if(listMap.get(field) != null){
					value = listMap.get(field).toString();
				}

				if (field.equals("smartId")) {
					value = convertSmartId(listMap.get(field).toString());
				} else if (field.equals("bat")) {
					value = convertBatVal(listMap.get(field).toString());
				}

				cell = getCell(sheet, 1 + i, inx++);
				cell.setCellStyle(style);
				setText(cell, value);
			}
		}
		
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		wb.write(baos);
		byte[] temp = baos.toByteArray();
		
        OutputStream out = response.getOutputStream();
        out.write(temp);
        
		out.close();
		baos.close();

    }
	
	private String convertBatVal(String bat) {
		String result = "";
		
		switch (bat) {
		case "0":
			result = "좋음";
			break;
		case "1":
			result = "양호";
			break;
		case "2":
			result = "나쁨";
			break;
		case "3":
			result = "OFF";
			break;
		default:
			result = "none";
			break;
		}
		
		return result;
	}
	
	private String convertSmartId(String smartId) {
		String result = "SA-S";
		String id = addZero(smartId, 4);
		
		result += id;
		
		return result;
	}
	
	private String addZero(String id, int length) {
		int idLength = id.length();
		if (length > idLength) {
			id = "0" + id;
			return addZero(id, length);
		}
		return id;
	}
}
