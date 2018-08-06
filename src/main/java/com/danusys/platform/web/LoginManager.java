package com.danusys.platform.web;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingListener;
import javax.servlet.http.HttpSessionBindingEvent;
import java.util.Hashtable;

public class LoginManager implements HttpSessionBindingListener{
	
	private static Object obj = new Object();
	private volatile static LoginManager loginManager = null;
	private static Hashtable loginUsers = new Hashtable();	//로그인한 접속자를 담기위한 해시테이블
	
	/*
	 * 싱글톤 패턴 사용
	 */
	public static LoginManager getInstance() {
		if(loginManager == null) {
			synchronized(obj) {
				if (loginManager == null) {
					loginManager = new LoginManager();
				}
			}
		}
		return loginManager;
	}
	
	/* 
	 * 이 메소드는 세션이 연결되었을 때 호출된다.(session.setAttribute('login',this))
	 * Hashtable에 세션과 접속자 아이디를 저장한다.
	 */
	public void valueBound(HttpSessionBindingEvent event) {
		//session put 
		loginUsers.put(event.getSession(), event.getName());
		System.out.println(event.getName() + "님이 로그인 하셨습니다.");
		System.out.println("현재 접속자 수  : " + getUserCount());
	}
	
	/* 
	 * 이 메소드는 세션이 해제되었을때 호출된다. (invalidate)
	 * Hashtable에 저장된 로그인 한 정보를 제거해 준다.
	 */
	public void valueUnbound(HttpSessionBindingEvent event) {
		loginUsers.remove(event.getSession());
		System.out.println(event.getName() + "님이 로그아웃 하셨습니다.");
		System.out.println("현재 접속자 수  : " + getUserCount());
	}
	
	/*
	 * 중복 로그인 막기 위해 아이디 사용중인지 체크
	 * 해당 아이디의 동시 사용을 막기위해서 이미 사용중인 아이디인지 확인
	 * @param userID
	 * @return boolean 이미 사용중 true, 아니면 false
	 */
	public boolean isUsing(String userID) {
		return loginUsers.containsValue(userID);
	}
	
	/*
	 * 로그인을 완료한 사용자의 아이디를 세션에 저장하는 메소드
	 * @param session 세션 객체
	 * @param userID 사용자 아이디
	 */
	public void setSession(HttpSession session, String userID) {
		session.setAttribute(userID, this);
	}
	
	/*
	 * 로그아웃을 완료한 사용자의 아이디를 세션에서 해제하는 메소드
	 * @param session 세션 객체
	 */
	public void setSessionCancel(HttpSession session) {
		session.setAttribute(getUserID(session), null);
	}
	
	/* 
	 * 입력받은 세션Object로 아이디를 리턴한다.
	 * @param session : 접속한 사용자의 session Object
	 * @return String : 접속자 아이디
	 */
	public String getUserID(HttpSession session) {
		return (String)loginUsers.get(session);
	}
	
	/*
	 * 현재 접속한 총 사용자 수
	 * @return int 현재 접속자 수
	 */
	public int getUserCount() {
		return loginUsers.size();
	}
}
