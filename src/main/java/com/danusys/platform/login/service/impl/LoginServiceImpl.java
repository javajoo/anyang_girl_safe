package com.danusys.platform.login.service.impl;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;


//import com.danusys.platform.helper.SHAHelper;
import com.danusys.platform.login.service.LoginService;
import com.danusys.platform.vo.AdminVo;
import com.danusys.platform.west.service.LogVO;
import com.danusys.platform.west.service.impl.LogDAO;

import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.let.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("adminLoginService")
public class LoginServiceImpl extends EgovAbstractServiceImpl implements LoginService {
	
    private static final Logger LOGGER = LoggerFactory.getLogger(LoginServiceImpl.class);

    @Resource(name="adminLoginDAO")
    private LoginDAO loginDAO;
    
    @Resource(name="logDAO")
    private LogDAO logDAO;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
	


    
	public AdminVo login(HttpServletRequest request, String id, String pwd) throws Exception {
		return this.loginSel(request, id, pwd);
	}
	
	private AdminVo loginSel(HttpServletRequest request, String id, String pwd) throws Exception {
		/* 로그기록 */
		InetAddress local = null;
		try {
			local = InetAddress.getLocalHost();
		} catch (UnknownHostException e1) {
			e1.printStackTrace();
		}
	    String saltText = this.propertiesService.getString("Globals.SaltText").trim();
	    String dbEncryptTag = this.propertiesService.getString("Globals.DBEncrypt").trim();
	    String userPw;
		String ip = local.getHostAddress();
		;
		//String encPwd = pwd;
		/*try {
			encPwd = SHAHelper.encryptPassword(pwd, saltText);	//암호화
		} catch (Exception e) {
			e.printStackTrace();
		}*/
	      if ("UCP".equals(dbEncryptTag)) {//System.out.println("===========================UCP:"+("UCP".equals(dbEncryptTag)));
	        userPw = EgovFileScrty.encryptPassword(pwd, saltText);
	      } else {
	        userPw = pwd;
	      }
		
		AdminVo searchVo = new AdminVo();
		searchVo.setId(id);
		searchVo.setPwd(userPw);
		System.out.println("============    [1]   ============");
		System.out.println("============    [1]   ============ : "+ ToStringBuilder.reflectionToString(searchVo));
		if ((searchVo.getSessionId() != null) && (!searchVo.getSessionId().equals(""))){
		    System.out.println("============    [1-1]   ============");
		}
		AdminVo vo = loginDAO.login(searchVo);
		System.out.println("============    [2]   ============");
		if(vo != null) {
		    vo.setSessionId(request.getSession().getId());
		} else {
		    
		}
		System.out.println( " ==================== [2] vo >>>> " + ToStringBuilder.reflectionToString(vo) );
		
		LogVO logVO = new LogVO();
		logVO.setIp(ip);
		//String session = request.getSession().toString();
		//int idx = session.indexOf("@");
		//logVO.setSessionId(session.substring(idx+1));
		logVO.setSessionId(request.getSession().getId());
		logVO.setAdminId(id);
		logVO.setAdminNm(vo.getName());
		logVO.setLogType("LOGIN");
		logVO.setContent("로그인");
		
		
		
		if(vo != null) logDAO.insertLog(logVO);
		
		return vo;
	}
	
	public List<?> adminList(AdminVo vo) throws Exception{
		return this.adminListSel(vo);
	}
	private List<?> adminListSel(AdminVo vo) throws Exception{
	    System.out.println( "vo : " + ToStringBuilder.reflectionToString(vo) );
		return loginDAO.adminList(vo);
	}
	
	public String insertAdminList(AdminVo vo) throws Exception{
		return this.insertAdminListIst(vo);
	}
	private String insertAdminListIst(AdminVo vo) throws Exception{
	    String saltText = this.propertiesService.getString("Globals.SaltText").trim();
        String dbEncryptTag = this.propertiesService.getString("Globals.DBEncrypt").trim();
	    String encPwd = null;
        encPwd = EgovFileScrty.encryptPassword(vo.getPwd(), saltText);	//암호화
		
		vo.setPwd(encPwd);
		return loginDAO.insertAdminList(vo);
	}
	
	public String chkAdminPwd(AdminVo vo) throws Exception{
	    String saltText = this.propertiesService.getString("Globals.SaltText").trim();
        String dbEncryptTag = this.propertiesService.getString("Globals.DBEncrypt").trim();
	    AdminVo searchVo = new AdminVo();
		String id = vo.getId();
		String pwd = vo.getOrgPwd();
		String encPwd = EgovFileScrty.encryptPassword(pwd, saltText);	//암호화
		String result = null;
		searchVo.setId(id);
		
		List<?> list = loginDAO.chkAdminPwd(searchVo);
		EgovMap temp = (EgovMap)list.get(0);
		
		if(encPwd.equals((String)temp.get("pwd"))) result = "yes";
		else result = "no";
		
		return result;
	}
	
	public void updateAdminList(AdminVo vo) throws Exception{
		this.updateAdminListUpd(vo);
	}
	private void updateAdminListUpd(AdminVo vo) throws Exception{
	    String saltText = this.propertiesService.getString("Globals.SaltText").trim();
        String dbEncryptTag = this.propertiesService.getString("Globals.DBEncrypt").trim();
	    String encPwd = null;
		if(vo.getPwd().length() > 0)
			encPwd = EgovFileScrty.encryptPassword(vo.getPwd(), saltText);	//암호화
		
		vo.setPwd(encPwd);
		loginDAO.updateAdminList(vo);
	}
	
	public void deleteAdminList(AdminVo vo) throws Exception{
		this.deleteAdminListDel(vo);
	}
	private void deleteAdminListDel(AdminVo vo) throws Exception{
		loginDAO.deleteAdminList(vo);
	}
}
