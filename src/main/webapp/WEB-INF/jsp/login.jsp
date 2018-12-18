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

<script src="/js/custom/packages.js"></script>
<script src="/js/custom/main.js"></script>
<script src="/js/custom/member.js"></script>

<script type="text/javascript">
	//$(document).ready(function() { }); 은 개발 완료 후 걷어낼 것임.
	$(document).ready(function() {
		var Main = (function() {
			function Main() {
				this.init();
			}
			Main.prototype.init = function() {
				danu.member.Login.init();
				danu.member.Login.setEvents();
			};
			return new Main();
		})();
		danu.main.Main = Main;
	    
		/* $("input[id=password]").keydown(function (key) {
	        if(key.keyCode == 13)loginForm.submit();
	    }); */
	});
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
	        <form name="loginForm" id="loginForm" class="login_form" action ="<c:url value='/danu/com/platform/login.do'/>" method="post">
	            <fieldset>
	                <div class="login_box">
		                <input type="text" id="id" name="id" placeholder="Login ID">
		                <input type="password" id="password" name="pwd" placeholder="Password">
	                </div>
	                <a href="#" class="btn_login" id="login"></a>
	            </fieldset>
	        </form>	
	    </div>
	</div>
	
	<div class="footer"></div>
</body>
</html>