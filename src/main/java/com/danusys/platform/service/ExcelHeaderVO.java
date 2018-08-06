package com.danusys.platform.service;

import java.io.Serializable;

/**
 * @Class Name : ExcelHeaderVO.java
 * @Description : 엑셀 헤더를 위한 VO 클래스
 * @Modification Information
 *
 *               수정일 수정자 수정내용 ------- ------- ------------------- 2016. 7. 24.
 *               신대영
 *
 * @author 신대영
 * @since 2016. 7. 24.
 * @version
 * @see
 *
 */
@SuppressWarnings("serial")
public class ExcelHeaderVO implements Serializable {
	/**
	 * 헤더 텍스트
	 */
	public String headerText = "";
	/**
	 * 헤더 필드
	 */
	public String headerField = "";
	/**
	 * 헤더 사용 여부
	 */
	public boolean headerUSe = true;

	/**
	 * headerText attribute를 리턴한다.
	 * 
	 * @return the headerText
	 */
	public String getHeaderText() {
		return headerText;
	}

	/**
	 * headerText attribute 값을 설정한다.
	 * 
	 * @param headerText
	 *            the headerText to set
	 */
	public void setHeaderText(String headerText) {
		this.headerText = headerText;
	}

	/**
	 * headerField attribute를 리턴한다.
	 * 
	 * @return the headerField
	 */
	public String getHeaderField() {
		return headerField;
	}

	/**
	 * headerField attribute 값을 설정한다.
	 * 
	 * @param headerField
	 *            the headerField to set
	 */
	public void setHeaderField(String headerField) {
		this.headerField = headerField;
	}

	/**
	 * headerField attribute를 리턴한다.
	 * 
	 * @return the headerField
	 */
	public boolean getHeaderUse() {
		return headerUSe;
	}

	/**
	 * headerField attribute 값을 설정한다.
	 * 
	 * @param headerField
	 *            the headerField to set
	 */
	public void setHeaderUse(boolean headerUSe) {
		this.headerUSe = headerUSe;
	}
}
