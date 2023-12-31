<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>여성안심서비스 로그인</title>
<link rel="stylesheet" type="text/css" href="/css/login.css">
<script src="/js/jquery.min.js"></script>

<script type="text/javascript">
</script>
</head>
<body class="login_bg">
	<div class="bg_area">
		<span class="title_1"></span>
		<span class="title_2"></span>
	</div>
	
	<div class="login_area">
	    <div class="login_cont">
	    	<span class="login_logo"></span>
	    	
	    	<input type="hidden" name="message" id="message" value="${message}"/>
	        <form name="loginForm" id="loginForm" class="login_form" action ="<c:url value='/main.do'/>" method="post">
	            <fieldset>
	                <div class="login_box">
                		<div style="position: absolute;background-color: #fff;width:330px; height:100px; top: 120px; left:60px; font-size: 13px;color: red">
	                  		<div>5번이상 잘 못 입력하여 아이디가 잠겼습니다.<br/><br/><br/></div>
							<div>관리자에게 문의바랍니다.</div>
						</div>
	                </div>
	                <a href="/main.do" class="btn_login_back" id="login"></a>
	            </fieldset>
	        </form>	
	    </div>
	</div>
	
	<div class="footer"></div>
</body>
</html>
