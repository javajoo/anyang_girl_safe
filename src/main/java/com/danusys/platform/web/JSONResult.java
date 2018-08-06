package com.danusys.platform.web;

import java.util.Map;

public class JSONResult {
	public String code;
	public String message;
	public Object data;
	
	public JSONResult(Object data){
		code = "ok";
		message = "";
		this.data = data;
	}

	public JSONResult(String message, Object data){
		code = "ok";
		this.message = message;
		this.data = data;
	}

	public JSONResult(String code, String message, Object data){
		this.code = code;
		this.message = message;
		this.data = data;
	}

	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
}
