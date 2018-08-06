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
<!-- <script src="js/jquery.easyui.min.js"></script> -->

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
<img src="/images/login/login_bg.png" id="bg" />
<div class="login_area_black">
    <!-- <h1 class="login_logo">안심귀가관리시스템</h1> -->
    <div class="login_cont_black" id="cont">
    	<span class="login_logo_black"></span>
    	<!-- <h1 class="login_title_black">안전지키미 관리시스템</h1> -->
    	<input type="hidden" name="message" id="message" value="${message}"/>
        <form name="loginForm" id="loginForm" action ="<c:url value='/danu/com/platform/login.do'/>" method="post">
            <fieldset>
            	<h1 class="login_title_black">여성 안심서비스</h1>
                <div class="login_box_black">
                <input type="text" id="id" name="id" placeholder="Username">
                <input type="password" id="password" name="pwd" placeholder="*********">
                  
                </div>
                <a href="#" class="btn_login_black" id="login">LOGIN</a>
            </fieldset>
        </form>	
    </div>
</div>
</body>
</html>