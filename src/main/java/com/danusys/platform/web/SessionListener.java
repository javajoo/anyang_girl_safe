package com.danusys.platform.web;

import java.net.InetAddress;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.danusys.platform.west.service.LogService;
import com.danusys.platform.west.service.LogVO;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public class SessionListener implements HttpSessionListener{
    @Autowired
    @Qualifier("logService")
    private LogService service;
    
    @Override
    public void sessionCreated(HttpSessionEvent arg0) {
        // 세션 생성시 호출
        HttpSession session = arg0.getSession();
        System.out.println("세션 생성: "+session);
        long time = session.getCreationTime();
        String id = session.getId();
        System.out.println(time + "에 생성된 세션" + id);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent arg0) {
        // 세션 만료시 호출
        HttpSession session = arg0.getSession();
        //long time = session.getCreationTime();
        long last_time = session.getLastAccessedTime();
        long now_time = System.currentTimeMillis();
        String id = session.getId();
        System.out.println((now_time - last_time)/60000 + "m 만에 세션이 죽음"  + id);
        
        ApplicationContext context =  
                WebApplicationContextUtils.getWebApplicationContext(
                        arg0.getSession().getServletContext()
                );
        this.service = context.getBean("logService", LogService.class);
        
        try {
            LoginManager loginManager = LoginManager.getInstance();
            LogVO vo = new LogVO();
            
            //String sessionS = session.toString();
            //int idx = sessionS.indexOf("@");
            //vo.setSessionId(sessionS.substring(idx+1));
            
            vo.setSessionId(id);
            vo.setRecordCountPerPage(-1);
            List<?> list = service.selectLogList(vo);
            
            for(EgovMap map : (List<EgovMap>)list){
                //vo.setIp((String) map.get("ip"));
                vo.setAdminId((String) map.get("adminId"));
                vo.setAdminNm((String) map.get("adminNm"));
            }
            //vo.setIp(InetAddress.getLocalHost().getHostAddress().toString());
            service.writeSessionoutLog(vo);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
