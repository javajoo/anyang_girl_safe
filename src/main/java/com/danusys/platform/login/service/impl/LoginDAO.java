package com.danusys.platform.login.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.danusys.platform.vo.AdminVo;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("adminLoginDAO")
public class LoginDAO extends EgovAbstractDAO {
	public AdminVo login(AdminVo searchVo) {
		AdminVo vo = (AdminVo) this.select("loginDAO.selectLogin", searchVo);
		System.out.println("=====================name: "+vo.getUSER_NM_KO());
		return vo;
	}
    public AdminVo selectLogin(Map<String,String> args) {
        AdminVo vo = (AdminVo) this.select("loginDAO.selectLogin", args);
        System.out.println("=====================name: "+vo.getUSER_NM_KO());
        return vo;
    }	
	public List<?> adminList(AdminVo vo) throws Exception{
		return list("loginDAO.adminList", vo);
	}
	
	public String insertAdminList(AdminVo vo) throws Exception{
		return (String)insert("loginDAO.insertAdminList",vo);
	}
	
	public List<?> chkAdminPwd(AdminVo vo) throws Exception{
		return list("loginDAO.chkAdminPwd", vo);
	}
	
	public void updateAdminList(AdminVo vo) throws Exception{
		update("loginDAO.updateAdminList",vo);
	}
	
	public void deleteAdminList(AdminVo vo) throws Exception{
		delete("loginDAO.deleteAdminList",vo);
	}
}
