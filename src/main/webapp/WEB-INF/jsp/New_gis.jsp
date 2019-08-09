<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>여성 안심서비스</title>
<link rel="shortcut icon" href="images/layout/favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="./css/style.css?ver=1">
<link rel="stylesheet" type="text/css" href="./css/jquery.jqplot.min.css">
<link rel="stylesheet" type="text/css" href="./css/map.css">
<script type="text/javascript" src="./js/jquery.min.js"></script>
<script type="text/javascript" src="./js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="./js/datagrid-bufferview.js"></script>
<script type="text/javascript" src="./js/javascript.util.min.js"></script>
<script type="text/javascript" src="./js/jsts.min.js"></script>
<script type="text/javascript" src="./js/proj4js-compressed.js"></script>
<script type="text/javascript" src="./js/image_manage.js"></script>
<script type="text/javascript" src="./js/html2canvas.js"></script>
<script type="text/javascript" src="./js/html2canvas.svg.js"></script>
<script type="text/javascript" src="./js/jspdf.debug.js"></script>
<script type="text/javascript" src="./js/packages.js"></script>
<script type="text/javascript" src="./js/excel.js"></script>
<script type="text/javascript" src="./js/west1.js"></script>
<script type="text/javascript" src="./js/common.js"></script>
<script type="text/javascript" src="./js/image_manage.js"></script>
<script type="text/javascript" src="./js/custom/main.js"></script>

<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	init();
	
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

function addr_search(){
	new daum.Postcode({
    	showMoreHName: true,
        oncomplete: function(data) {
            var geocoder = new daum.maps.services.Geocoder();
            geocoder.addressSearch(data.address, function(results, status) {
                // 정상적으로 검색이 완료됐으면
                if (status == daum.maps.services.Status.OK) {
                	var result = results[0];
                	var moveLatLon = new kakao.maps.LatLng(result.y, result.x)
            		map.setCenter(moveLatLon);
                }
            });
        }
    }).open({
    	autoClose :false
    });
}

var rank = ${admin.rank};
$(function() {
	var period = ${admin.period};
	if (period > 0) {
		var c = confirm("비밀번호 변경기간이 3개월이 지났습니다. 변경하시겠습니까?");
		if(c == true) {
			var modal = document.getElementById('passwordModal');
			window.open("/updatePassword.do", "팝업", "left=20, top=20, width=500, height=180");
		}
    }
	rankDisplay(rank);
});

function init() {
	menuDisplay('menu_home');
};

/* 대메뉴선택 */
function menuDisplay(flag){
	if(selectedMarker) selectedMarker.setMap(null);
	
	$('.combo-p').remove();
	
	//select 이벤트
	$(".gnb_next li a").removeClass("selected");
	$('#'+flag+"_cont1_tit").addClass("selected");
	
	if(flag == 'menu_setting'){ 
		changeWidth('admin');
		$(".gnb_left li a").removeClass("selected");
		$(".gnb_left li a:eq(0)").addClass("selected");
		$(".gnb .gnb_ul li a").removeClass("selected");
	}else changeWidth();
	
	$("#west-panel").show();
	$('#left-panel').hide();
	$('#layer_area').hide();
	$('#map').hide();
	
	if(flag == 'menu_home'){
		changeWidth();
		$('#map').show();
		$('#map').css('cursor', 'move');
		
		search_list("/include/userEmergency_list");	
		$('#layer_area').show();
		setStatus();
	}
	else if(flag == 'menu_approvalList') {
		changeWidth("full");
		search_list("/include/user_approval_list");	
	}
	else if(flag == 'menu_evnetList'){
		changeWidth("full");
		search_list("/include/event_list");
	}
	else if(flag == 'menu_hwStatus'){
		changeWidth("full");
		search_list("/include/hw_status");
	}
	else if(flag == 'menu_alarmList'){
		changeWidth("full");
		search_list("/include/alarm_list");
	}
	else if(flag == 'menu_smsLogList'){
		changeWidth("full");
		search_list("/include/sms_log_list");
	}
	else if(flag == 'menu_board'){
		changeWidth("full");
		search_list("/include/board_list");
	}
	else if(flag == 'menu_pushLogList'){
		changeWidth("full");
		search_list("/include/push_log_list");
	}
	else if(flag == 'menu_setting'){
		$('#left-panel').show();
		settingMenuChange('menu_adminSetting');
	}
}

function changeWidth(flag) {
	$('.map_btn_area').show();
	$('#west-panel').css('left','0');
	
	var width = $('.title_area').css('width');
	if(flag == 'west'){
		
		$('#west-panel').css('width','100%');
		$('.gnb_next').css('width','100%');
		//레이어 숨기기
		$('.layer').hide();
		$('.layer_tool_open').removeClass("layer_tool_open").addClass("layer_tool_close");
		
		$('.datagrid').css('width',width);
		$('.datagrid-wrap').css('width',width);
		$('.datagrid-view').css('width',width);
		$('.datagrid-view2').css('width',width);
		$('.datagrid-view2 .datagrid-header').css('width',width);
		$('.datagrid-view2 .datagrid-body').css('width',width);
		$('.datagrid-view2 .datagrid-footer').css('width',width);
	}
	else if(flag == 'admin'){
		$('#west-panel').css('width','100%');
		$('.gnb_next').css('width','100%');
		//레이어 숨기기
		$('.layer').hide();
		$('.layer_tool_open').removeClass("layer_tool_open").addClass("layer_tool_close");
		
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
	else if(flag == 'layer'){
		if(event.target.classList[0] == 'layer_tool_open'){
			$('.layer').hide();
			$(event.target).removeClass("layer_tool_open").addClass("layer_tool_close");
		}				
		else{
			$('.layer').show();
			$(event.target).removeClass("layer_tool_close").addClass("layer_tool_open");
		}
	}
	else if(flag == 'full'){
		resizeMap('0px','100%','calc(100% - 44px)');
		$('#west-panel').css('width','100%');
		$('.gnb_next').css('width','100%');
		//레이어 숨기기
		$('.layer').hide();
		$('.layer_tool_open').removeClass("layer_tool_open").addClass("layer_tool_close");
		var widthChange = '95%';
		$('#menu_cont .datagrid .easyui-fluid').css('left','30px');
		$('#menu_cont .datagrid').css('width',widthChange);
		$('#menu_cont .datagrid-wrap').css('width',widthChange);
		$('#menu_cont .datagrid-view').css('width',widthChange);
		$('#menu_cont .datagrid-view2').css('width',widthChange);
		$('#menu_cont .datagrid-view2 .datagrid-header').css('width',widthChange);
		$('#menu_cont .datagrid-view2 .datagrid-body').css('width',widthChange);
		$('#menu_cont .datagrid-view2 .datagrid-body').css('overflow','hidden');
		$('#menu_cont .datagrid-view2 .datagrid-footer').css('width',widthChange);
	}
	else if (flag == 'west_full') {
		resizeMap('0px','100%','calc(100% - 44px)');
		$('#left-panel').css('width','10%');
		$('#west-panel').css({
			'width': '90%',
			'left': '10%'
		});
		$('.gnb_next').css('width','100%');
		//레이어 숨기기
		$('.layer').hide();
		$('.layer_tool_open').removeClass("layer_tool_open").addClass("layer_tool_close");
		var widthChange = '95%';
		$('#menu_cont .datagrid .easyui-fluid').css('left','30px');
		$('#menu_cont .datagrid').css('width',widthChange);
		$('#menu_cont .datagrid-wrap').css('width',widthChange);
		$('#menu_cont .datagrid-view').css('width',widthChange);
		$('#menu_cont .datagrid-view2').css('width',widthChange);
		$('#menu_cont .datagrid-view2 .datagrid-header').css('width',widthChange);
		$('#menu_cont .datagrid-view2 .datagrid-body').css('width',widthChange);
		$('#menu_cont .datagrid-view2 .datagrid-body').css('overflow','hidden');
		$('#menu_cont .datagrid-view2 .datagrid-footer').css('width',widthChange);
	}
	else{
		resizeMap('480px','calc(100% - 480px)','calc(100% - 44px)');
		$('#west-panel').css('width','480px');
		$('#west-panel .gnb_next').css('width','480px');
		$('#west-panel .datagrid').css('width','480px');
		$('#west-panel .datagrid-wrap').css('width','480px');
		$('#west-panel .datagrid-view').css('width','480px');
		$('#west-panel .datagrid-view2').css('width','480px');
		$('#west-panel .datagrid-view2 .datagrid-header').css('width','480px');
		$('#west-panel .datagrid-view2 .datagrid-body').css('width','480px');
		$('#west-panel .datagrid-view2 .datagrid-footer').css('width','480px');
	}
}
/* 다음맵 거리, 면적, 지우개 */
$(function() {
	$('#map_measure_len').click(function() {
		changeEventListener('distance');
	});
	
	$('#map_measure_area').click(function() {
		changeEventListener('area');
	});
	
	$('#map_clear').click(function() {
		changeEventListener('clear');
	});
})
/*다음맵 전체영역*/
function mapFullExtent(){
	var moveLatLon = new kakao.maps.LatLng(37.38951588413914, 126.98812045295553);
    
    map.relayout();
    map.setLevel(6);
    map.panTo(moveLatLon); 
}

/* 로그아웃 함수 */
function logout() {
	$.ajax({
		url : encodeURI("/danu/com/platform/logout.do"),
		type : "get",
		success : function(datas, textStatus, jQxhr) {
			closeWindow();
		},
		error : function(jqXhr, textStatus, errorThrown) {
			alert("로그아웃 하는데 실패했습니다.");
		}
	});
}

/* 부모창이 존재하면 현재창을 닫고 부모창을 새로고침 하고, 부모창이 없으면 현재창을 새로고침 한다. */
function closeWindow() {
	if (opener && !opener.closed) {	// 부모창 존재 확인
		opener.parent.location.reload();
		window.close();
	} else {
		window.location.reload();
	}
}
</script>
</head>
<body>
<form id="excelForm" name="excelForm" method="post">
		<input type="hidden" id="excelData" name="excelData">
	</form>
	<div class="title_area" data-options="region:'north'">
        	<div class="logo_tit"></div>
        	<div class="stat_area" onClick="openStatusPopup();">
        		<p class="status_total">총계 : <span></span></p>
				<p class="status_1">정상 : <span></span></p>
				<p class="status_2">비정상 : <span></span></p>
        	</div>
        	<header>
				<div class="cont">
					<nav class="gnb">
					    <ul class="gnb_ul">
					    	<li><a id="topmenu_home" href="javascript:menuDisplay('menu_home')" class="selected">HOME</a></li>
					    	<li><a id="topmenu_approvalList" href="javascript:menuDisplay('menu_approvalList')">가입자 관리</a></li>
							<li><a id="topmenu_evnetList" href="javascript:menuDisplay('menu_evnetList')">이벤트 검색</a></li>
							<li><a id="topmenu_hwStatus" href="javascript:menuDisplay('menu_hwStatus')">센서 상태 체크</a></li>
							<li><a id="topmenu_alarmList" href="javascript:menuDisplay('menu_alarmList')">서비스 이력</a></li>
							<li><a id="topmenu_smsLogList" href="javascript:menuDisplay('menu_smsLogList')">SMS 이력</a></li>
							<li><a id="topmenu_board" href="javascript:menuDisplay('menu_board')">공지사항</a></li>
							<li><a id="topmenu_pushLogList" href="javascript:menuDisplay('menu_pushLogList')">PUSH 이력</a></li>
					    </ul>
					</nav>
				</div>
			</header>
			
        	<div class="account_area">
        		<span class="login_image"></span>
				<div class="account">${admin.name}</div>
				<div id="login_pop" class="login_pop_down"></div>
			</div>
			<a href="#" id="setting_btn" class="setting_btn" onclick="javascript:menuDisplay('menu_setting')"></a>
    	</div>
	<div id="gis_layout" class="easyui-layout" style="">
		<div id="left-panel">
			<nav class="gnb_left">
				<ul>
					<li><a href="javascript:settingMenuChange('menu_adminSetting')" class="selected" id="setting_1">계정 관리</a></li>
					<li><a href="javascript:settingMenuChange('menu_accessLog')">계정이력조회</a></li>
					<li><a href="javascript:settingMenuChange('menu_userActionLog')">사용이력조회</a></li>
				</ul>
			</nav>
		</div>
		<div id="west-panel">
    		<div id="west_area" class="west_area">
    			<div class="west_cont" id="menu_cont">
					
				</div>
			</div>
		</div>
		
		<div id="map">
			<ul class="map_btn_area">
				<li>
				    <a href="#" id="map_zoomin" onclick="zoomIn();" class="easyui-linkbutton" data-options="iconCls:'icon-zoomin',toggle:true">확대</a>
					<a href="#" id="map_zoomout" onclick="zoomOut();" class="easyui-linkbutton" data-options="iconCls:'icon-zoomout',toggle:true">축소</a>
				</li>
				<li>
				    <a href="#" id="map_measure_len" class="easyui-linkbutton" data-options="iconCls:'icon-measurelen',toggle:true">거리측정</a>
					<a href="#" id="map_measure_area" class="easyui-linkbutton" data-options="iconCls:'icon-measurearea',toggle:true">면적측정</a>
					<a href="#" id="map_clear" class="easyui-linkbutton" data-options="iconCls:'icon-mapclear',toggle:true">지우개</a>
				</li>
				<li>
					<a href="#" id="map_fullextent" onclick="mapFullExtent();" class="easyui-linkbutton" data-options="iconCls:'icon-all',toggle:false">전체영역</a>
				    <!-- <a href="#" id="map_measure_print" onclick="printMap1();" class="easyui-linkbutton" data-options="iconCls:'icon-print',toggle:false">출력</a> -->
				</li>
				<li class="btn_ty_a">
				    <a href="#" id="map_base" onclick="setMapType('base');" class="easyui-linkbutton btn_ty" data-options="iconCls:'icon-normal',toggle:true">일반</a>
				    <a href="#" id="map_air" onclick="setMapType('air');" class="easyui-linkbutton" data-options="iconCls:'icon-satellite',toggle:true">위성</a>
				</li>
				<li>
					<div class="btn_ty_a">
						<label>검색</label>
						<a href="#" id="map_addr_search_btn" onclick="addr_search()" class="easyui-linkbutton" data-options="iconCls:'icon-search',toggle:false">주소검색</a>
					</div>
				</li>
			</ul>
		</div>
		
		<div id="layer_area" style='width : 0px'>
			<div class="layer">
				<div class="layer_top">
					<span class="layer_logo"></span>
				</div>
				<div id="layer_tree" class="easyui-tree" 
					data-options="animate:true,
					checkbox:true,
					onlyLeafCheck:false,
					url:'selectCctvTreeList.do',
					loadFilter:convertTreeData,
					onLoadSuccess:mapLateChange,
					onCheck:mapChange
					">
				</div>
			</div>
			<a href="#" onclick="changeWidth('layer');" class="layer_tool_open"></a>
		</div>
	</div>
	<!-- 푸터 -->
	<div class="footer">
	</div>	
    <script type="text/javascript">
	    /** 날짜 포맷 형식 00 또는 0X */
	    function zeroPad(number) {
	    	return ( ( number < 10 ) ? "0" : "" ) + String(number);
	    }
	    
	    /*년도-월-일*/
        function myformatter(date){
            var y = date.getFullYear();
            var m = date.getMonth()+1;
            var d = date.getDate();
            return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
        }
        function myparser(s){
            if (!s) return new Date();
            var ss = (s.split('-'));
            var y = parseInt(ss[0],10);
            var m = parseInt(ss[1],10);
            var d = parseInt(ss[2],10);
            if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
                return new Date(y,m-1,d);
            } else {
                return new Date();
            }
        }
        
        /*년도-월-일 시:분:초*/
        function myformatter_time(date){
            var y = date.getFullYear();
		    var m = zeroPad(date.getMonth()+1);
		    var d = zeroPad(date.getDate());
		    var h = zeroPad(date.getHours());
		    var mi = zeroPad(date.getMinutes());
		    var se = zeroPad(date.getSeconds());
		    return y+'-'+m+'-'+d+' '+h+':'+mi+':'+se;
        }
        function myparser_time(s){
            if (!s) return new Date();
            var ss = s.split(" ")[0].split("-").concat(s.split(" ")[1].split(":"));
			var y = parseInt(ss[0],10);
			var m = parseInt(ss[1],10);
			var d = parseInt(ss[2],10);
			var h = parseInt(ss[3],10);
			var M = parseInt(ss[4],10);
			var S = parseInt(ss[5],10);
			if (!isNaN(y) && !isNaN(m) && !isNaN(d) && !isNaN(h) && !isNaN(M) && !isNaN(S)){
				return new Date(y,m-1,d,h,M,S);
			}
			else {
				return new Date();
			}
        }
		function myformatter2(date){
			if (!date){return new Date().getFullYear();}
			var y = date.getFullYear();
			return y;
		}
		function myparser2(s){
			console.log(s);
			if (!s){return null;}
			var y = parseInt(s,10);
			if (!isNaN(y)){
				return new Date(y,1,1);
			} else {
				return new Date();
			}
		}
    </script>
	
    <!-- <div id="printdlg" class="easyui-dialog" title="출력"
            data-options="resizable:false,modal:true,closed:true">
    </div> -->
    
    <div id="loading"><!-- images/layout/loading.gif -->
		<img src="/images/template/loading.gif">
	</div>
	
	<div class="account_setting">
		<span id="logout" class="logout"><a href="javascript:logout()">Logout</a></span>
	</div>
	
	<div id="popup_area" style="display:none;overflow: hidden;"></div>

	<jsp:include page="include/socket.jsp" />

	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f51fb456778a82b692a61930e5dc1df7&libraries=services,clusterer,drawing"></script>
	<script type="text/javascript" src="./js/map/map_control.js"></script>
	<script type="text/javascript" src="./js/map/map_area_draw.js"></script>
	<script type="text/javascript" src="./js/map/map_circle_draw.js"></script>
	<script type="text/javascript" src="./js/map/map_init.js"></script>
	<script type="text/javascript" src="./js/map/map_line_draw.js"></script>
	<!-- <script type="text/javascript" src="./js/map/map_marker.js"></script> -->
	<script type="text/javascript" src="./js/map/map_popup.js"></script>
</body>
</html>