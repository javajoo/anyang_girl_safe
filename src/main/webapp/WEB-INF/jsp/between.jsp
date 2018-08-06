<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import ="egovframework.com.cmm.LoginVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	LoginVO resultVO = (LoginVO)request.getSession().getAttribute("LoginVO");
%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>여성 안심서비스</title>

<link rel="shortcut icon" href="images/layout/favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="./css/style.css?ver=2">
<link rel="stylesheet" type="text/css" href="/css/between.css?ver=2">

<script type="text/javascript" src="./js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="./js/jquery-ui-1.8.18.custom.min.js"></script>
<script type="text/javascript" src="./js/jquery.easyui.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		$('#dlgSetting').window('close');
		$(".gnb .gnb_ul li a").click(function(event){
			$(".gnb .gnb_ul li a").removeClass("selected");
			$(event.target).addClass("selected");
		});
		
		$("#login_pop").click(function(){ //슬라이드2
			$(".account_setting").slideToggle('slow');
			if ($(".login_pop_down").is(":visible") == true) {
				$('.login_pop_down').removeClass("login_pop_down").addClass("login_pop_up");
			}
			else {
				$('.login_pop_up').removeClass("login_pop_up").addClass("login_pop_down");
			}
		});
		
		$(".account_setting").mouseleave(function(){
			$('.account_setting').slideUp();
			$('.login_pop_up').removeClass("login_pop_up").addClass("login_pop_down");
		});
	});
	
	var openWindowCode = function() {
		var open = window.open("/MainPage.do", "mnt", "channelmode=1,scrollbars=1,status=0,titlebar=0,toolbar=0,resizable=1");
		if(open==null){
			alert("팝업을 허용해 주세요.")
		}else{
			//open.moveTo(0,0); //메인모니터 이동
			//open.resizeTo(screen.width, screen.availHeight);
			//open.window.outerWidth = screen.availWidth;
        	//open.window.outerHeight = screen.availHeight;
			open.focus();
		}
	};
	var openWork = function() {
		var open = window.open("/mainWork.do", "wrk", "width=1300,top=1,scrollbars=1,status=0,titlebar=0,toolbar=0,resizable=1,location=1");
		if(open==null){
			alert("팝업을 허용해 주세요.")
		}else{
			//open.moveTo(0,0); //메인모니터 이동
			//open.resizeTo(screen.width, screen.availHeight);
			//open.window.outerWidth = screen.availWidth;
        	//open.window.outerHeight = screen.availHeight;
			open.focus();
		}
	};	
	var tabFunction = function(index,row){
		var pg = $(this);
		var ed = pg.propertygrid('getEditors', index)[0];
		var t = $(ed.target);
		var t = $(ed.target).hasClass('textbox-f') ? $(ed.target).textbox('textbox') : $(ed.target);
		t.unbind('.propertygrid').bind('keydown.propertygrid', function(e){
			if (e.keyCode == 9){
				var tr = pg.propertygrid('options').finder.getTr(pg[0], index+1, 'body', 2);
				tr.find('.datagrid-cell').trigger('click');
				return false;
			}
		})
	};
	
	/* 대메뉴선택 */
	function menuDisplay(flag){
		//select 이벤트
		$(".gnb_next li a").removeClass("selected");
		$('#'+flag+"_cont1_tit").addClass("selected");
		
	}
	
	function init() {
		/* $.extend($.fn.validatebox.defaults.rules, {
			ip : {// Verify that the IP address
				validator : function(value) {
					return /\d+\.\d+\.\d+\.\d+/.test(value);
				},
				message : '유효한 IP 주소가 아닙니다.'
			}
		}); */
		runAX();
	}
	
	$(function(){
		$('#datepicker').datepicker({
			inline: true,
			//nextText: '&rarr;',
			//prevText: '&larr;',
			showOtherMonths: true,
			//dateFormat: 'dd MM yy',
			dayNamesMin: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
			//showOn: "button",
			//buttonImage: "img/calendar-blue.png",
			//buttonImageOnly: true,
		});
	});
	function runAX() {
		try{
		    var axObj = null;
		    axObj = new ActiveXObject("ATHENASTREAM.AthenaStreamCtrl.1");
		    if(axObj){
		    	axObj2 = new ActiveXObject("ATHENAMGR.AthenaMgrCtrl.1");
		    	if(axObj2){
		    		console.log('VMS 모든 프로그램이 정상적으로 작동중입니다.');
		    	}else{
		    		console.log('VMSMGR 프로그램이 작동하지 않습니다.');
		    	}
		    }
		}catch(e){
			var agent = navigator.userAgent.toLowerCase();
			if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
				runExe();
			}else{
				alert('CCTV 기능은 Internet Explorer 11 버전를 권장합니다.');
			}
		}
	}
	function runExe() {
		var fileName = "/activex/ActiveX_Setup.msi"; //설치파일 경로
		var param = "v=1.0.5";
		var method = "post";

	    $.download(fileName,param,method);
    	$('#dlgSetting').dialog('open')
	    $("#dlgSetting").focus();
		/* try{
			var fileObj = new ActiveXObject("Scripting.FileSystemObject");
			if(fileObj.FileExists(fileName)){
		 		var sh = new ActiveXObject("WScript.Shell");
		 		sh.Run(fileName);
			}else{
		 		alert("프로그램이 존재하지 않아 다운로드를 시작합니다.\n\n 확인버튼 클릭 후 브라우저 하단의 실행(R)을 클릭해주세요.");
		 		$.download('/activex/ActiveX_Setup.msi','v=1.0.5','post');	
			}
		}catch(e){

			
		} */
	}
	jQuery.download = function(url, data, method){
	    if( url && data ){ 
	        data = typeof data == 'string' ? data : jQuery.param(data);
	        var inputs = '';
	        jQuery.each(data.split('&'), function(){ 
	            var pair = this.split('=');
	            inputs+='<input type="hidden" name="'+ pair[0] +'" value="'+ pair[1] +'" />'; 
	        });
	        jQuery('<form action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>')
	        .appendTo('body').submit().remove();
	    }else{
	    	window.location.assign(url);
	    };
	};
	</script>
</head>

<body onload="runAX()">
	<div class="title_area" data-options="region:'north'">
		<c:choose>
    		<c:when test="${admin.authority=='P'}"><div class="logo_tit_112"></div></c:when>
    		<c:when test="${admin.authority=='F'}"><div class="logo_tit_119"></div></c:when>
    		<c:when test="${admin.authority=='W'}"><div class="logo_tit_disadvantaged"></div></c:when>
    		<c:when test="${admin.authority=='S'}"><div class="logo_tit_safe"></div></c:when>
    		<c:when test="${admin.authority=='D'}"><div class="logo_tit_disaster"></div></c:when>
    		<c:when test="${admin.authority=='E'}"><div class="logo_tit_iot"></div></c:when>
    		<c:otherwise><div class="logo_tit_control"></div></c:otherwise>
    	</c:choose>
	
        	

        	<header>
				<div class="cont">
					<nav class="gnb">
					    <ul class="gnb_ul">
					    	<c:choose>
					    		<c:when test="${admin.authority== 'A'}">
					    			<li><a id="topmenu_monitoring" href="javascript:openWindowCode()" class="selected">통합관제</a></li>
					    			<li><a id="topmenu_work" href="javascript:openWork();">통합업무</a></li>
					    			<!-- <li><a id="topmenu_history" href="situationHistory.do">상황이력</a></li>
					    			<li><a id="topmenu_stats" href="situationStats.do">상황통계</a></li>
					    			<li><a id="topmenu_cop" href="cop.do">커뮤니티</a></li>
					    			<li><a id="topmenu_system" href="system.do">시스템</a></li> -->
					    		</c:when>
					    		<c:otherwise>
					    			<li><a id="topmenu_monitoring" href="javascript:openWindowCode()" class="selected">상황관제</a></li>
					    			<li><a id="topmenu_history" href="situationHistory.do">상황이력</a></li>
					    			<li><a id="topmenu_stats" href="situationStats.do">상황통계</a></li>
					    			<li><a id="topmenu_cop" href="cop.do">커뮤니티</a></li>
					    			<li><a id="topmenu_system" href="system.do">시스템</a></li>
					    		</c:otherwise>
					    	</c:choose>
					    </ul>
					</nav>
				</div>
			</header>
        	<div class="account_area">
				<div class="account">${admin.USER_NM_KO}</div>
				<div id="login_pop" class="login_pop_down"></div>
				<span class="login_image"></span><%-- {{${admin.authority}}} --%>
			</div>
    </div> 	
	<div class="account_setting">
		<span id="logout" class="logout"><a href="/danu/com/platform/logout.do">Logout</a></span>
	</div>
	
	
	<div class="between_bg">
		<c:choose>
    		<c:when test="${admin.authority=='P'}"><img src="/images/login/bg_112.jpg" id="bg" /></c:when>
    		<c:when test="${admin.authority=='F'}"><img src="/images/login/bg_119.jpg" id="bg" /></c:when>
    		<c:when test="${admin.authority=='W'}"><img src="/images/login/bg_disadvantaged.jpg" id="bg" /></c:when>
    		<c:when test="${admin.authority=='S'}"><img src="/images/login/bg_safe.jpg" id="bg" /></c:when>
    		<c:when test="${admin.authority=='D'}"><img src="/images/login/bg_disaster.jpg" id="bg" /></c:when>
    		<c:when test="${admin.authority=='E'}"><img src="/images/login/bg_iot.jpg" id="bg" /></c:when>
    		<c:otherwise><img src="/images/login/bg_control.jpg" id="bg" /></c:otherwise>
    	</c:choose>
    <div class="between_area_black">
    	<div class="between_cont_black">
	    	<div class="between_cont_calendar_title">
	    		<img src="/images/login/calendar_title.png" id="bg" />
	    	</div>
	    	<div class="between_cont_calendar">
	    		<div id="datepicker"></div>
	    	</div>
    	
	    	<div class="between_cont_notice_title"></div>
	    	<div class="between_cont_notice"></div>
	    	<div class="between_cont_notice_button_prev"></div>
	    	<div class="between_cont_notice_button_1"></div>
	    	<div class="between_cont_notice_button_next"></div>
    	

	    	<c:choose>
	    		<c:when test="${admin.authority=='P'}">
	    			<div class="between_cont_image1">
	    				<img src="/images/login/image_112_1.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image2">
	    				<img src="/images/login/image_112_2.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image3">
	    				<img src="/images/login/image_112_3.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image4">
	    				<img src="/images/login/image_112_4.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image5">
	    				<img src="/images/login/image_112_5.jpg" id="bg" />
	    			</div>
	    		</c:when>
	    		<c:when test="${admin.authority=='F'}">
	    			<div class="between_cont_image1">
	    				<img src="/images/login/image_119_1.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image2">
	    				<img src="/images/login/image_119_2.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image3">
	    				<img src="/images/login/image_119_3.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image4">
	    				<img src="/images/login/image_119_4.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image5">
	    				<img src="/images/login/image_119_5.jpg" id="bg" />
	    			</div>
	    		</c:when>
	    		<c:when test="${admin.authority=='W'}">
	    			<div class="between_cont_image1">
	    				<img src="/images/login/image_disadvantaged_1.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image2">
	    				<img src="/images/login/image_disadvantaged_2.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image3">
	    				<img src="/images/login/image_disadvantaged_3.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image4">
	    				<img src="/images/login/image_disadvantaged_4.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image5">
	    				<img src="/images/login/image_disadvantaged_5.jpg" id="bg" />
	    			</div>
	    		</c:when>
	    		<c:when test="${admin.authority=='S'}">
	    			<div class="between_cont_image1">
	    				<img src="/images/login/image_safe_1.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image2">
	    				<img src="/images/login/image_safe_2.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image3">
	    				<img src="/images/login/image_safe_3.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image4">
	    				<img src="/images/login/image_safe_4.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image5">
	    				<img src="/images/login/image_safe_5.jpg" id="bg" />
	    			</div>
	    		</c:when>
	    		<c:when test="${admin.authority=='D'}">
	    			<div class="between_cont_image1">
	    				<img src="/images/login/image_disaster_1.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image2">
	    				<img src="/images/login/image_disaster_2.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image3">
	    				<img src="/images/login/image_disaster_3.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image4">
	    				<img src="/images/login/image_disaster_4.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image5">
	    				<img src="/images/login/image_disaster_5.jpg" id="bg" />
	    			</div>
	    		</c:when>
	    		<c:when test="${admin.authority=='E'}">
	    			<div class="between_cont_image1">
	    				<img src="/images/login/image_iot_1.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image2">
	    				<img src="/images/login/image_iot_2.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image3">
	    				<img src="/images/login/image_iot_3.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image4">
	    				<img src="/images/login/image_iot_4.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image5">
	    				<img src="/images/login/image_iot_5.jpg" id="bg" />
	    			</div>
	    		</c:when>
	    		<c:otherwise>
	    		<div class="between_cont_image1">
	    				<img src="/images/login/image_control_1.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image2">
	    				<img src="/images/login/image_control_2.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image3">
	    				<img src="/images/login/image_control_3.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image4">
	    				<img src="/images/login/image_control_4.jpg" id="bg" />
	    			</div>
	    			<div class="between_cont_image5">
	    				<img src="/images/login/image_control_5.jpg" id="bg" />
	    			</div>
	    		</c:otherwise>
	    	</c:choose>

	    	<c:if test="${admin.authority== 'A'}">
	    	<div class="goto_group">
			    <div class="goto_title">
			    <img src="/images/between/arrow.png"/> 
			    <span><strong>통합</strong>연계서비스 </span>
			    </div>
			    <a href="http://70.13.50.13:61120" class="goto_btn" target="_blank" title="112긴급지원 서비스"><img src="/images/between/between_btn01.png" style="padding-top: 4px" /></a>
			    <img src="/images/between/line.png" style="padding: 0 10px 0 10px" />
			    <a href="http://70.13.50.13:61190" class="goto_btn" target="_blank" title="119긴급지원 서비스"><img src="/images/between/between_btn02.png" style="padding-top: 4px" /></a>
			    <img src="/images/between/line.png" style="padding: 0 10px 0 10px" />
			    <a href="http://70.13.50.13:61150" class="goto_btn" target="_blank" title="재난긴급지원 서비스"><img src="/images/between/between_btn03.png" style="padding-top: 4px" /></a>
			    <img src="/images/between/line.png" style="padding: 0 10px 0 10px" />
			    <a href="/danu/com/platform/logout.do" class="goto_btn" title="사회적약자지원 서비스"><img src="/images/between/between_btn04.png" style="padding-top: 4px" /></a>
			    <img src="/images/between/line.png" style="padding: 0 10px 0 10px" />
			    <a href="/danu/com/platform/logout.do" class="goto_btn" title="환경 IOT 서비스"><img src="/images/between/between_btn05.png" style="padding-top: 4px" /></a>
			</div>
			</c:if>
    	</div>   	


	    </div>  

    </div>
    
    
    <div class="between_massenger"></div>
    </div>
		
	<div class="between_footer" >
		<div class="between_footer_text">@ DANU 스마트시티 통합플랫폼</div>
	</div>

	<div id="dlgSetting" class="easyui-dialog" title="VMS 프로그램 설치방법" data-options="iconCls:'icon-save',modal:true" style="width:500px;height:240px;padding:20px;">
	 <div>1. 인터넷옵션(O) > 보안 > 신뢰할수 있는 사이트 > 사이트(S) > <br>
	 &nbsp;&nbsp;&nbsp;이 영역에 있는 모든 사이트에 대해 서버 검증(https:) 필요 의 체크박스 해제 > <br>
	 &nbsp;&nbsp;&nbsp;영역에 웹 사이트 추가(D)의 옆 추가 버튼클릭 > 확인</div><br>
	 <div>2. 이 영역에 적용할 보안 수준(L)의 스크롤바를 최소로 변경 > 확인</div><br>
	 <div>3. 설정완료 후 브라우저 하단 다운로드 버튼으로 설치바랍니다.</div>
	</div>
</body>
</html>