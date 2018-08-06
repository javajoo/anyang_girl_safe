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

<link rel="stylesheet" type="text/css" href="/css/font.css">
<link rel="stylesheet" type="text/css" href="/css/common.css">
<link rel="stylesheet" type="text/css" href="/css/layout.css">
<link rel="stylesheet" type="text/css" href="/css/easyui.css">
<link rel="stylesheet" type="text/css" href="/css/icon.css">
<link rel="stylesheet" type="text/css" href="/css/-gis.css">

<link rel="stylesheet" type="text/css" href="/css/top.css">
<link rel="stylesheet" type="text/css" href="/css/west.css">
<link rel="stylesheet" type="text/css" href="/css/bottom.css">
<style>
#center_layout{
	margin: 0;
	padding: 0;
	width: 100%;
	height: calc(100% - 80px);
	overflow:hidden;
	background: #f8f8f8;
	/* background: #323335; */
	top: 80px;
}
#center_panel {
	width: 100%;
    height: 100%;
    overflow: hidden;
    position: absolute;
    /* top: 80px; */
	z-index: 1;
	border: 1px solid #c4c4c4;
}
</style>

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
		var open = window.open("/MainPage.do", "_blank", "channelmode=1,scrollbars=1,status=0,titlebar=0,toolbar=0,resizable=1");
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
	function changeMenu__(flag){
		
		//select 이벤트
		$(".gnb_next li a").removeClass("selected");
		$('#'+flag+"_tit").addClass("selected");
		
		//소메뉴 별 크기 조정
		if(flag == 'menu_eventR_cont2' || flag == 'menu_eventR_cont3') changeWidth('west');
		else if(flag == 'menu_facility_cont2') changeWidth('full');
		else changeWidth();
			
		$('.west_cont').hide();	//전체 import jsp hide
		$('#'+flag).show();		//선택 import jsp show
		
		//clearInterval(eventM);
		
		if(flag == 'menu_eventM_cont1'){	//이벤트 모니터링
			search_eventM();
			//eventM = setInterval("search_eventM()",1*20*1000);		//20초
		}
		else if(flag == 'menu_eventM_cont2'){
			mapInfo();
			search_castingN();	//투망감시
		}
		else if(flag == 'menu_eventR_cont1') search_eventR();	//이벤트내역
		else if(flag == 'menu_eventR_cont2') search_accessR();	//접속이력조회
		else if(flag == 'menu_eventR_cont3') search_statsR();	//통계
		else if(flag == 'menu_facility_cont1') search_facilityM();	//시설물관리조회
		else if(flag == 'menu_facility_cont2') search_facilityR();	//시설물현황
	}
	/* 상황통계 소메뉴선택 */
	function changeMenu(flag){
	    //$('#map').hide();
	    //mapMoveControl();
	    
	    //select 이벤트
	    $(".gnb_next li a").removeClass("selected");
	    $('#'+flag+"_tit").addClass("selected");
	    
	    //소메뉴 별 크기 조정
	    changeWidthNew(flag);
	        
	    $('.west_cont').hide();    //전체 import jsp hide
	    $('#'+flag).show();        //선택 import jsp show

	    $('#west-panel .gnb_next').css('width','100%');
	}    
	function changeWidthNew(flag) {
		
		$('.map_btn_area').show();
		
		var width;
		var width1;
		var width2;
		console.log(flag);
		if(flag == 'menu_setting_cont1'){
			width = '100%';
			width1 = '40px';
			width2 = '520px';
		}else if(flag == 'menu_setting_cont2'){
			width = '100%';
			width1 = '40px';
			width2 = '440px';
		}else {
			width = '100%';
			width1 = '40px';
			width2 = '440px';
		}
		$('#west-panel').css('width','100%');
		$('.gnb_next').css('width','100%');
		var widthChange = width.replace('px','')-415+'px';
		$('.center_cont .datagrid').css('width',widthChange);
		$('.center_cont .datagrid').css('left','15px');
		$('.center_cont .datagrid-wrap').css('width',widthChange);
		$('.center_cont .datagrid-view').css('width',widthChange);
		$('.center_cont .datagrid-view2').css('width',widthChange);
		$('.center_cont .datagrid-view2 .datagrid-header').css('width',widthChange);
		$('.center_cont .datagrid-view2 .datagrid-body').css('width',widthChange);
		$('.center_cont .datagrid-view2 .datagrid-footer').css('width',widthChange);
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
	
	var authflag = 'flag=<c:out value="${admin.authority}"/>';
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

	menuDisplay('menu_setting');
	changeMenu('menu_setting_cont1');	
	
	
	</script>
</head>

<body onload="init()" id="bodyDefault">
	<div class="title_area" data-options="region:'north'">
			<%-- <div class="logo_tit"></div>
        	<h2 class="logo_tit_text">
        	<c:choose>
        		<c:when test="${admin.authority=='P'}">112긴급 영상지원</c:when>
        		<c:when test="${admin.authority=='F'}">119긴급 영상지원</c:when>
        		<c:when test="${admin.authority=='W'}">사회적 약자 영상지원 </c:when>
        		<c:when test="${admin.authority=='S'}">안심귀가 영상지원</c:when>
        		<c:when test="${admin.authority=='D'}">긴급재난 영상지원</c:when>
        		<c:otherwise>여성 안심서비스</c:otherwise>
        	</c:choose>
        	</h2> --%>
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
					    		</c:when>
					    		<c:otherwise>
					    			<li><a id="topmenu_monitoring" href="javascript:openWindowCode()">상황관제</a></li>
					    			<li><a id="topmenu_history" href="/situationHistory.do">상황이력</a></li>
					    			<li><a id="topmenu_stats" href="/situationStats.do">상황통계</a></li>
					    			<li><a id="topmenu_cop" href="/cop.do">커뮤니티</a></li>
					    			<li><a id="topmenu_setting" href="/setting.do" class="selected">시스템</a></li>
					    		</c:otherwise>
					    	</c:choose>
					    </ul>
					</nav>
				</div>
			</header>
        	<div class="account_area">
				<div class="account">${admin.USER_NM_KO}</div>
				<div id="login_pop" class="login_pop_down"></div>
				<span class="login_image"></span>
			</div>
    </div> 	
	
	<div id="center_layout" class="easyui-layout">
		<div id="center_panel">
    		<div class="cont">

				<!-- <div class="gnb_next" id="menu_facility">시설물관제
				    <ul>
						<li><a id="menu_facility_cont1_tit" href="javascript:changeMenu('menu_facility_cont1')">시설물관리</a></li>
						<li><a id="menu_facility_cont2_tit" href="javascript:changeMenu('menu_facility_cont2')">시설물현황조회</a></li>
				    </ul>
				</div> -->
				<!-- <div class="gnb_next" id="menu_eventR">정보현황
				    <ul>
						<li><a id="menu_eventR_cont1_tit" href="javascript:changeMenu('menu_eventR_cont1')">이벤트내역</a></li>
						<li><a id="menu_eventR_cont2_tit" href="javascript:changeMenu('menu_eventR_cont2')">접속이력조회</a></li>
						<li><a id="menu_eventR_cont3_tit" href="javascript:changeMenu('menu_eventR_cont3')">통계</a></li>
				    </ul>
				</div> -->
				<div class="gnb_next" id="menu_setting"><span class="setting_image"></span><span class="setting_text">환경설정</span>
				    <ul>
						<li><a id="menu_setting_cont1_tit" href="javascript:changeMenu('menu_setting_cont1')"></a></li>
				    </ul>
				</div>
			</div>
    		<div id="west_area" class="west_area">
				
				<!-- 시설물관제 -->
				<%-- <div class="west_cont" id="menu_facility_cont1">
				    <jsp:include page="include/facility_manage.jsp" />
				</div>
				<div class="west_cont" id="menu_facility_cont2">
				    <jsp:include page="include/facility_result.jsp" />
				</div> --%>
				
				<!-- 정보현황 -->
				<%-- <div class="west_cont" id="menu_eventR_cont1">
				    <jsp:include page="include/event_result.jsp" />
				</div>
				<div class="west_cont" id="menu_eventR_cont2">
				    <jsp:include page="include/access_result.jsp" />
				</div>
				<div class="west_cont" id="menu_eventR_cont3">
				    <jsp:include page="include/stats_result.jsp" />
				</div> --%>
				<!-- 환경설정 -->
				<div class="west_cont" id="menu_setting_cont1">
				    <jsp:include page="include/admin_setting.jsp" />
				</div>
			</div>
		</div>
 	
		
	</div>
	
	<div id="footer">
		<div class="footer_text">@ 여성 안심서비스</div><!-- 푸터 -->
	</div>		
			
	<div class="account_setting">
		<span id="logout" class="logout"><a href="/danu/com/platform/logout.do">Logout</a></span>
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