package com.danusys.platform.login.service;

import javax.servlet.http.HttpServletRequest;

import com.danusys.platform.vo.AdminVo;

import java.util.List;

public interface LoginService {
	public AdminVo login(HttpServletRequest request, String id, String pwd) throws Exception ;
	
	List<?> adminList(AdminVo vo) throws Exception;
	
	String insertAdminList(AdminVo vo) throws Exception;
	
	String chkAdminPwd(AdminVo vo) throws Exception;
	
	void updateAdminList(AdminVo vo) throws Exception;
	
	void deleteAdminList(AdminVo vo) throws Exception;
}
