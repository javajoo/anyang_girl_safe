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
<link rel="stylesheet" type="text/css" href="./css/style.css?ver=1">
<!-- <link rel="stylesheet" type="text/css" href="./css/image_manage.css"> -->
<link rel="stylesheet" type="text/css" href="./css/jquery.jqplot.min.css">
<link rel="stylesheet" type="text/css" href="./css/c3.css">
<link rel="stylesheet" type="text/css" href="./css/c3.set.css">
<script type="text/javascript" src="./js/jquery.min.js"></script>
<script type="text/javascript" src="./js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="./js/datagrid-bufferview.js"></script>
<script type="text/javascript" src="./js/OpenLayers.js"></script>
<script type="text/javascript" src="./js/javascript.util.min.js"></script>
<script type="text/javascript" src="./js/jsts.min.js"></script>
<script type="text/javascript" src="./js/DFMSMap.js"></script>
<script type="text/javascript" src="./js/map_control.js"></script>
<script type="text/javascript" src="./js/proj4js-compressed.js"></script>
<script type="text/javascript" src="./js/image_manage.js"></script>
<script type="text/javascript" src="./js/html2canvas.js"></script>
<script type="text/javascript" src="./js/html2canvas.svg.js"></script>
<script type="text/javascript" src="./js/jspdf.debug.js"></script>
<script type="text/javascript" src="./js/packages.js"></script>
<script type="text/javascript" src="./js/west_iot.js"></script>
<script type="text/javascript" src="./js/d3.v3.min.js" charset="utf-8"></script>
<script type="text/javascript" src="./js/c3.min.js"></script> 

<script type="text/javascript">
	$(document).ready(function(){
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
	
	var map;        
	var gisBase2012Url = "http://xdworld.vworld.kr:8080/2d/Base/201612/"; // 기본지도(TMS) 경로
	var gisAir2012Url = "http://xdworld.vworld.kr:8080/2d/Satellite/201612/"; // 기본지도(TMS) 경로
	
	var gisDFMSUrl = "${config.gisDfmsUrl}";
	var gisDFMSWFSUrl = "${config.gisDfmswfsUrl}";
	
	var maxExtent = new OpenLayers.Bounds(-20037508.34, -20037508.34, 20037508.34, 20037508.34);
	
	var eventLayer;		//이벤트 표출
	var facilityLayer;	//시설물 표출
	
	var _bounds;
	
	var selectedImageLayer;	//선택 레이어
	
	var endCheck = false;
	var prnSeq = 0;
	
	var projectionGroup = new Object();
	
	//var eventM;	//이벤트 모니터링 setInterval
	
	var eventMills; // 이벤트 발생 시간을 저장하기 위한 변수
	var viewLogSeqId = 0; // 영상시청로그에 대한 praimary key값
	
	var isOpenCctv = false;

	var mousePointerStyle = 'default';
	
	var MOUSE_POINTER_STYLES = {
	    'OpenLayers.Control.DragPan': 'move',
	    'OpenLayers.Control.ZoomBox': 'crosshair',
	    'none': 'default'
	}
	
	var mycolumns = [[
	                  {field:'name',title:'항목',width:100},
	                  	{field:'value',title:'',width:250,resizable:false}
	                ]];
	
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
	var authflag = 'flag=<c:out value="${admin.authority}"/>';
	jQuery.download = function(url, data, method) {
	    if (url && data) {
	    	data = typeof data == 'string' ? data : jQuery.param(data);
	        var inputs = '';
	        jQuery.each(data.split('&'), function() {
	            var pair = this.split('=');
	            inputs += '<input type="hidden" name="' + pair[0] +
	                '" value="' + pair[1] + '" />';
	        });
	        jQuery('<form action="' + url +
	                '" method="' + (method || 'post') + '">' + inputs + '</form>')
	            .appendTo('body').submit().remove();
	    };
	};

	
	/* 대메뉴선택 */
	function menuDisplay(flag){
		//select 이벤트
		$(".gnb_next li a").removeClass("selected");
		$('#'+flag+"_cont1_tit").addClass("selected");
		
		$('.gnb_next').hide();	//전체 소메뉴 hide
		$('#'+flag).show();		//선택 소메뉴 show
		
		$('.west_cont').hide();			//기존 import jsp hide
		$('#'+flag+"_cont1").show();	//선택 import jsp show
		//console.log('menuDisplay:'+flag);
		if(flag == 'menu_iot') changeMenuIoT('menu_iot_cont1');
		else if(flag == 'menu_stat') changeMenuStat('menu_stat_cont1');
		else changeMenuIoT();

	}	
	var menuNm;	//메뉴 값 저장
	/* 상황관제 소메뉴선택 */
	function changeMenuIoT(flag){
		$("map").show();
		mapMoveControl();
		
		//select 이벤트
		$(".gnb_next li a").removeClass("selected");
		$('#'+flag+"_tit").addClass("selected");
		
		//소메뉴 별 크기 조정
		if(flag == 'menu_iot_cont1') changeWidth(flag);
		else changeWidth();
		//console.log('chageMenuIoT:'+flag)	
		$('.west_cont').hide();	//전체 import jsp hide
		$('#'+flag).show();		//선택 import jsp show
		
		layerClean(eventLayer);
		layerClean(facilityLayer);
		//clearInterval(eventM);
		
		if(flag == 'menu_iot_cont1'){	//이벤트 모니터링
			search_iotM();	//모니터링
			//eventM = setInterval("search_iotM()",1*20*1000);		//20초
			menuNm = 'iotM';
		}
		else {
			search_iotH();	//이벤트히스토리
			menuNm = 'iotH';
		}
		
		$('#west-iot-panel .datagrid-view1 td>div').text('순번');
		
		iot_graph('hide','calc(100% - 44px)');
		//iot_graph('show','calc(100% - 300px)');
	}

	/* 상황통계 소메뉴선택 */
	function changeMenuStat(flag){
	    //$('#map').hide();
	    //mapMoveControl();
	    
	    //select 이벤트
	    $(".gnb_next li a").removeClass("selected");
	    $('#'+flag+"_tit").addClass("selected");
	    
	    //소메뉴 별 크기 조정
	    changeWidthStat(flag);
	        
	    $('.west_cont').hide();    //전체 import jsp hide
	    $('#'+flag).show();        //선택 import jsp show
	    
	    layerClean(eventLayer);
	    layerClean(facilityLayer);
	    //clearInterval(eventM);
	    $('#west-iot-panel .gnb_next').css('width','100%');
	}    
	
	
	/* 영상표출 부분을 감추고, flag 값에 따라 우측 레이어나 좌측 리스트 표출 부분을 조정하는 Method */
	function changeWidth(flag) {
		
		$('#cctv_area').hide();
		$('.map_btn_area').show();
		
		var width;
		var width1;
		var width2;
		//console.log('changeWidth:'+flag);
		if(flag == 'menu_iot_cont1'){
			width = '560px';
			width1 = '40px';
			width2 = '520px';
		}else if(flag == 'menu_stat_cont1'){
			width = '100%';
			width1 = '40px';
			width2 = '520px';
		}else if(flag == 'menu_stat_cont2'){
			width = '100%';
			width1 = '40px';
			width2 = '520px';
		}else {
			width = '480px';
			width1 = '40px';
			width2 = '440px';
		}
		$('.iot_graph_area').css('width','calc(100% - '+width+')');
		$('.iot_graph_area').css('left',width)
		
		resizeMap(width,'calc(100% - '+width+')','calc(100% - 44px)');
		$('#west-iot-panel').css('width',width);
		$('#west-iot-panel .gnb_next').css('width',width);
		$('#west-iot-panel .datagrid').css('width',width);
		$('#west-iot-panel .datagrid-wrap').css('width',width);
		$('#west-iot-panel .datagrid-view').css('width',width);
		$('#west-iot-panel .datagrid-view1').css('width',width1);
		$('#west-iot-panel .datagrid-view1 .datagrid-header').css('width',width1);
		$('#west-iot-panel .datagrid-view1 .datagrid-body').css('width',width1);
		$('#west-iot-panel .datagrid-view1 .datagrid-footer').css('width',width1);
		$('#west-iot-panel .datagrid-view2').css('width',width2);
		$('#west-iot-panel .datagrid-view2 .datagrid-header').css('width',width2);
		$('#west-iot-panel .datagrid-view2 .datagrid-body').css('width',width2);
		$('#west-iot-panel .datagrid-view2 .datagrid-footer').css('width',width2);
	}
	
	function changeWidthStat(flag) {
		
		$('#cctv_area').hide();
		$('.map_btn_area').show();
		
		var width;
		var width1;
		var width2;
		//console.log(flag);
		if(flag == 'menu_stat_cont1'){
			width = '100%';
			width1 = '40px';
			width2 = '520px';
		}else if(flag == 'menu_stat_cont2'){
			width = '100%';
			width1 = '40px';
			width2 = '520px';
		}else {
			width = '480px';
			width1 = '40px';
			width2 = '440px';
		}
		$('.iot_graph_area').css('width','calc(100% - '+width+')');
		$('.iot_graph_area').css('left',width)
		
		//resizeMap(width,'calc(100% - '+width+')','calc(100% - 44px)');
		$('#west-iot-panel').css('width',width);
	}
	function init_iot() {
		$('.datebox-black .combo-arrow').removeClass("combo-arrow").addClass("combo-arrow_sel");
		$('.datebox').removeClass("datebox").addClass("datebox-black");
		$('.datebox-calendar-inner').parent().addClass("datebox-calendar-div");
		$('.datebox-calendar-inner').parent().parent().addClass("datebox-calendar-panel");
		$('#printdlg').parents().first().addClass('print_box');
		$(".calendar-close").on("click", function() {
			$(this.parentElement.parentElement.target).combo("hidePanel");
		});

		Proj4js.defs["EPSG:4019"] = "+proj=longlat +ellps=GRS80 +no_defs";
		Proj4js.defs["EPSG:5179"] = "+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +units=m +no_defs";
		Proj4js.defs["EPSG:5181"] = "+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=500000 +ellps=GRS80 +units=m +no_defs";
		Proj4js.defs["EPSG:5186"] = "+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=600000 +ellps=GRS80 +units=m +no_defs";
		Proj4js.defs["EPSG:900913"] = "+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs";

		projectionGroup["google"] = new OpenLayers.Projection('EPSG:900913');
		projectionGroup["utmk"] = new OpenLayers.Projection('EPSG:5186');
		projectionGroup["daum"] = new OpenLayers.Projection('EPSG:5181');
		projectionGroup["naver"] = new OpenLayers.Projection('EPSG:5179');
		projectionGroup["grs80"] = new OpenLayers.Projection('EPSG:4019');

		map = new Map("map", { //"map"은 지도를 표출할 div 아이디명
			displayProjection : new OpenLayers.Projection("EPSG:900913"), // 표출 좌표계
			projection : new OpenLayers.Projection("EPSG:900913"), // 기본 좌표계
			maxResolution : 156543.0339, // 최대 해상도 (구글이나 Vworld 사용시 고정값)
			maxExtent : this.maxExtent, // 최대 영역
			numZoomLevels : 19, // 줌의 갯수 (구글이나 Vworld 사용시 고정값)
			unit : "m", // 단위
			eventListeners : {
				"moveend" : moveIndexMapPointer
			}
		});

		addAirTMS(); // TMS 기본지도 추가
		addBaseTMS(); // TMS 기본지도 추가

		//map.setCenter(new OpenLayers.LonLat(14119381.7398256, 4530853.78757956), 15);
		//위경도 시
		var centerLonlat = new OpenLayers.LonLat(128.980592, 35.21242);
		centerLonlat.transform(new OpenLayers.Projection("EPSG:4326"),
				new OpenLayers.Projection("EPSG:900913"));
		map.setCenter(centerLonlat, 14);

		map.addControl(new OpenLayers.Control.MousePosition());
		map.addControl(new OpenLayers.Control.Attribution({
			separator : " "
		}));

		var polyOptions = {
			sides : 4,
			irregular : true
		};

		var scalebar = new OpenLayers.Control.ScaleLine();
		map.addControl(scalebar);

		initMouseControl();

		map.isValidZoomLevel = function(zoomLevel) {
			return (zoomLevel >= 10) && (19 > zoomLevel); // 12레벨 이상 19미만으로 설정
		}

		var sketchSymbolizers = {
			"Point" : {
				pointRadius : 4,
				graphicName : "square",
				fillColor : "white",
				fillOpacity : 1,
				strokeWidth : 1,
				strokeOpacity : 1,
				strokeColor : "#f3c"
			},
			"Line" : {
				strokeWidth : 3,
				strokeOpacity : 1,
				strokeColor : "#f33",
				strokeDashstyle : "solid"
			},
			"Polygon" : {
				strokeWidth : 2,
				strokeOpacity : 1,
				strokeColor : "#f33",
				fillColor : "#fa5",
				fillOpacity : 0.3
			}
		};

		var style = new OpenLayers.Style();
		style.addRules([ new OpenLayers.Rule({
			symbolizer : sketchSymbolizers
		}) ]);
		var styleMap = new OpenLayers.StyleMap({
			"default" : style
		});

		var DFMSPathHandler = OpenLayers.Class(OpenLayers.Handler.Path, {
			addPoint : function(pixel) {
				// 툴팁 초기화
				if (endCheck) {
					for (var i = 0; i < prnSeq; i++)
						document.body.removeChild(document
								.getElementById('mprn' + i));

					if (document.getElementById('mprn-1') != null)
						document.body.removeChild(document
								.getElementById('mprn-1'));

					prnSeq = 0;
					endCheck = false;
				}
				this.layer.removeFeatures([ this.point ]);
				var lonlat = this.layer.getLonLatFromViewPortPx(pixel);
				this.point = new OpenLayers.Feature.Vector(
						new OpenLayers.Geometry.Point(lonlat.lon, lonlat.lat));
				this.line.geometry.addComponent(this.point.geometry,
						this.line.geometry.components.length);
				this.layer.addFeatures([ this.point ]);
				this.callback("point", [ this.point.geometry,
						this.getGeometry() ]);
				this.callback("modify",
						[ this.point.geometry, this.getSketch() ]);
				this.drawFeature();
				delete this.redoStack;
			},

			finishGeometry : function() {
				endCheck = true;
				var index = this.line.geometry.components.length - 1;
				this.line.geometry
						.removeComponent(this.line.geometry.components[index]);
				this.removePoint();
				this.finalize();
			}
		});

		$('#map').css('cursor', 'move');

		eventLayer = new OpenLayers.Layer.Vector("Marker Layer"); //이벤트 표출
		facilityLayer = new OpenLayers.Layer.Vector("Marker Layer"); //시설물 표출
		selectedImageLayer = new OpenLayers.Layer.Vector("Select Image Layer");
		map.addLayer(eventLayer);
		map.addLayer(facilityLayer);
		map.addLayer(selectedImageLayer);
		
		//changeMenuIoT('menu_iot_cont1');
		menuDisplay('menu_iot');
		
		search_iotM(); //이벤트모니터링-조회
		setInterval("search_iotM()",1*20*1000);	//20초
	}
	
	function getAbsPos(obj) {
		var curleft = curtop = 0;
		if (obj.offsetParent) {
			do {
				curleft += obj.offsetLeft;
				curtop += obj.offsetTop;
			} while (obj = obj.offsetParent);
		}
		return [ curleft, curtop ];
	}

	function layerClean(layer) {
		if (layer == null)
			return;
		layer.removeAllFeatures();
		layer.redraw({
			force : true
		});
	}

	function getLayerStyle(str) {
		var style = OpenLayers.Util.extend({},
				OpenLayers.Feature.Vector.style[str]);
		return style;
	}

	function getFieldByTitle(dgName, title) {
		var opts = $('#' + dgName).datagrid("getColumnFields");

		for (var i = 0; i < opts.length; i++) {
			if ($('#' + dgName).datagrid("getColumnOption", opts[i]).title == title) {
				return opts[i];
			}
		}
	}

	function lpad(ContentToSize, PadLength, PadChar) {
		var PaddedString = ContentToSize.toString();
		for (var i = ContentToSize.length + 1; i <= PadLength; i++) {
			PaddedString = PadChar + PaddedString;
		}
		return PaddedString;
	}

	function addWMS(tlayers) { // WMS 레이어 추가
		var tmp = null;

		var isDone = false;
		while (!isDone) {
			try {
				tmp = map.getLayersByName("BOUNDARY");
				isDone = true;
			} catch (ecp) {
				isDone = false;
			}
		}
		if (tmp.length > 0) {
			map.removeLayer(tmp[0]);
		}

		if (tlayers == "")
			return;

		var layer = new OpenLayers.Layer.WMS("BOUNDARY", // 임의의 레이어 명칭     				
		gisDFMSUrl, // WMS 경로      				
		{
			layers : tlayers, // 호출할 레이어 명      				
			styles : "", // 스타일 지정 가능      					
			format : "image/png", // 리턴 받을 이미지 타입
			exceptions : "text/xml", // 예외 처리 타입 
			version : "1.3.0", // WMS 버전      					
			crs : "EPSG:900913", // 불러올 좌표계
			transparent : true
		// 배경을 투명하게 불러올 지 여부
		}, {
			singleTile : true, // 하나의 이미지로 가져올지 여부
			transitionEffect : "resize", // 지도 이동/축소/확대시 표현 효과 
			ratio : 1
		// 비율
		});
		map.addLayer(layer); // 생성한 WMS 레이어 추가
		map.setLayerIndex(eventLayer, map.layers.length);
		map.setLayerIndex(facilityLayer, map.layers.length);
	}

	$(function() {
		/* 일반-위성 */
		$('#map_air').linkbutton({
			onClick : function() {
				var baseLayer = map.getLayersByName("baseLayer")[0]; // 기본도
				var airLayer = map.getLayersByName("airLayer")[0]; // 위성

				baseLayer.setVisibility(false);
				airLayer.setVisibility(true);
				$("#map_base").removeClass("btn_ty");
				$('#map_air').addClass("btn_ty");
			}
		});
		$('#map_base').linkbutton({
			onClick : function() {
				var baseLayer = map.getLayersByName("baseLayer")[0]; // 기본도
				var airLayer = map.getLayersByName("airLayer")[0]; // 위성

				airLayer.setVisibility(false);
				baseLayer.setVisibility(true);
				$("#map_air").removeClass("btn_ty");
				$('#map_base').addClass("btn_ty");
			}
		});
	});

	/* 로그아웃 함수 - 로그아웃 성공시 부모창이 존재하면 현재창을 닫고 부모창을 새로고침 하고, 부모창이 없으면 현재창을 새로고침 한다.  */
	function logout() {
		$.ajax({
			url : encodeURI("/danu/com/platform/logout.do"),
			type : "get",
			success : function(datas, textStatus, jQxhr) {
				//console.log("logout! opener.closed:"+opener.closed);
				if (opener && !opener.closed) {	// 부모창 존재 확인
					opener.parent.location.reload();
					window.close();
				} else {
					window.location.reload();
				}
			},
			error : function(jqXhr, textStatus, errorThrown) {
				alert("로그아웃 하는데 실패했습니다.");
			}
		});
	}
	/* 인덱스맵호출 */
	indexMap();
</script>
</head>
<body onload="init_iot()" id="bodyIot">
	<div class="title_area" data-options="region:'north'">
        	<div class="logo_tit"></div>
        	<h2 class="logo_tit_text">IoT환경 서비스</h2>
        	<header>
				<div class="cont">
					<nav class="gnb">
					    <ul class="gnb_ul">
							<li><a id="topmenu_monitoring" href="javascript:menuDisplay('menu_iot')" class="selected">상황관제</a></li>
                            <!-- <li><a id="topmenu_history" href="#">상황이력</a></li> -->
                            <li><a id="topmenu_stat" href="javascript:menuDisplay('menu_stat')">상황통계</a></li>
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
	<div id="gis_layout" class="easyui-layout" style="width: 100%;">
		<div id="west-iot-panel">
    		<div class="cont">
				<div class="gnb_next" id="menu_iot"><!-- IoT상황관제 -->
				    <ul>
						<li><a id="menu_iot_cont1_tit" href="javascript:changeMenuIoT('menu_iot_cont1')" class="selected">모니터링</a></li>
						<li><a id="menu_iot_cont2_tit" href="javascript:changeMenuIoT('menu_iot_cont2')">이벤트히스토리</a></li>
				    </ul>
				</div>
				<div class="gnb_next" id="menu_stat"><!-- IoT상황통계 -->
				    <ul>
						<li><a id="menu_stat_cont1_tit" href="javascript:changeMenuStat('menu_stat_cont1')" class="selected">실시간모니터링</a></li>
						<li><a id="menu_stat_cont2_tit" href="javascript:changeMenuStat('menu_stat_cont2')">기간검색</a></li>
				    </ul>
				</div>
			</div>
    		<div id="west_area" class="west_area">
    			<!-- 상황관제 -->
    			<div class="west_cont" id="menu_iot_cont1">
				    <jsp:include page="include/iot_monitoring.jsp" />
				</div>
				<div class="west_cont" id="menu_iot_cont2">
				    <jsp:include page="include/iot_history.jsp" />
				</div>
				<!-- 상황통계 -->
    			<div class="west_cont" id="menu_stat_cont1">
				    <jsp:include page="include/iot_stat_monitoring.jsp" />
				</div>
				<div class="west_cont" id="menu_stat_cont2">
				    <jsp:include page="include/iot_stat_history.jsp" />
				</div>
			</div>
			<object border="0" id="AthenaStream" classid="CLSID:7A872C47-B95A-4F1E-A921-80A9D005A57D" CODEBASE="./activex/AthenaStream.cab#version=1,0,0,6"></object>
		</div>
    	
		<div id="map">
			<!-- map_btn_area -->
			<ul class="map_btn_area">
				<li>
				    <a href="#" id="map_undo" onclick="mapHistPrev();" class="easyui-linkbutton" data-options="iconCls:'icon-undo',toggle:false">이전</a>
					<a href="#" id="map_redo" onclick="mapHistNext();" class="easyui-linkbutton" data-options="iconCls:'icon-redo',toggle:false">이후</a>
				</li>
				<li>
				    <a href="#" id="map_zoomin" onclick="mapZoomIn();" class="easyui-linkbutton" data-options="iconCls:'icon-zoomin',toggle:true">확대</a>
					<a href="#" id="map_zoomout" onclick="mapZoomOut();" class="easyui-linkbutton" data-options="iconCls:'icon-zoomout',toggle:true">축소</a>
					<a href="#" id="map_move" onclick="mapMoveControl();" class="easyui-linkbutton" data-options="iconCls:'icon-move',toggle:true,selected:true">이동</a>
				</li>
				<li>
				    <a href="#" id="map_measure_len" onclick="mapCalcLen();" class="easyui-linkbutton" data-options="iconCls:'icon-measurelen',toggle:true">거리측정</a>
					<a href="#" id="map_measure_area" onclick="mapCalcArea();" class="easyui-linkbutton" data-options="iconCls:'icon-measurearea',toggle:true">면적측정</a>
				</li>
				<li>
					<a href="#" id="map_fullextent" onclick="mapFullExtent();" class="easyui-linkbutton" data-options="iconCls:'icon-all',toggle:false">전체영역</a>
				    <a href="#" id="map_measure_print" onclick="showPrintMap();" class="easyui-linkbutton" data-options="iconCls:'icon-print',toggle:false">출력</a>
				</li>
				<li class="btn_ty_a">
				    <a href="#" id="map_base" class="easyui-linkbutton btn_ty" data-options="iconCls:'icon-normal',toggle:true">일반</a>
				    <a href="#" id="map_air" class="easyui-linkbutton" data-options="iconCls:'icon-satellite',toggle:true">위성</a>
				</li>
			</ul>
		</div>
		
		<div class="iot_graph_area">
			<div class="iot_graph">
				<div class="iot_graph_top">
					<div class="iot_graph_tit">
						<em>시설물명: </em>
						<p id="iot_event_adres">부산도시가스 (부산광역시 연제구 중앙대로 1001)</p>
					</div>
					<div class="iotM_graph_text" id="iotM_graph_text">
						<div id="search_iotM_graph_tab" class="easyui-panel" style="position: absolute;z-index: 9;top: 60px; left: 34px; width: 560px; background-color: inherit;">
							<a href="#" onclick="iotM_graph_chenge2(1)" class="easyui-linkbutton" data-options="toggle:true,group:'g1',plain:true,selected:true"><img alt="악취 (OU/㎥)" src="/images/icons/iot_graph_btn1.png"></a> 
						    <a href="#" onclick="iotM_graph_chenge2(2)" class="easyui-linkbutton" data-options="toggle:true,group:'g1',plain:true"><img alt="온도 (ºC)" src="/images/icons/iot_graph_btn2.png"></a> 
						    <a href="#" onclick="iotM_graph_chenge2(3)" class="easyui-linkbutton" data-options="toggle:true,group:'g1',plain:true"><img alt="습도 (%)" src="/images/icons/iot_graph_btn3.png"></a> 
						    <a href="#" onclick="iotM_graph_chenge2(4)" class="easyui-linkbutton" data-options="toggle:true,group:'g1',plain:true"><img alt="풍속 (m/s)" src="/images/icons/iot_graph_btn4.png"></a>  
						</div>
						<!-- <select id="search_iotM_graph_gbn" class="easyui-combobox" data-options="onSelect:iotM_graph_chenge" style="width:140px;">
							<option value="1">악취농도 (OU/㎥)</option>
							<option value="2">온도 (ºC)</option>
							<option value="3">습도 (%)</option>
							<option value="4">풍속 (m/s)</option>
						</select> -->
						<p id="iotM_event_de">현재시간기준(24시간)</p>
						<p id="iotM_event_term">2018년 01월 11일 PM 03:09 ~ 2018년 01월 12일 PM 03:09</p>
						
					</div>
					<div class="iotH_graph_text" id="iotH_graph_text">
						<p id="iotH_event_de">2018년 01월 12일 AM 03:09</p>| 검색시간기준(앞/뒤 12시간)
						<p id="iotH_event_term">2018년 01월 11일 PM 03:09 ~ 2018년 01월 12일 PM 03:09</p>
					</div>
					<div class="iotM_graph_unit" id="iotM_graph_unit">
						<div class="unit_area">
							<div class="unit_area_up">
								<img src="images/icons/iot_graph_up.png" /> 상한임계치
								<p id="unit_up">+8</p>
								<em>ºC</em>
							</div>
							<hr>
							<div class="unit_area_down">
								<img src="images/icons/iot_graph_down.png" /> 하한임계치
								<p id="unit_down">-8ºC</p>
								<em>ºC</em>
							</div>
						</div>
						<div class="unit_now" id="unit_now">
							<em>현재악취</em>
							<p id="unit_now_value">+11</p>
							<p id="unit_now_tag">OU/㎥</p>
						</div>
					</div>
					<div class="iotH_graph_unit" id="iotH_graph_unit">
						<div class="unit_area">
							<div class="unit_area_up">
								<img src="images/icons/iot_graph_up.png" /> 상한임계치
								<p id="unit_up">+8</p>
								<em>ºC</em>
							</div>
							<hr>
							<div class="unit_area_down">
								<img src="images/icons/iot_graph_down.png" /> 하한임계치
								<p id="unit_down">-8</p>
								<em>ºC</em>
							</div>
						</div>
					</div>
				</div>
				<div class="iot_graph_bottom"><div class='chart'><div id='chart'></div></div>
				</div>
			</div>
			<a href="#" onclick="iot_graph('hide','calc(100% - 44px)')" class="iot_graph_open"></a>
		</div>
		
		<div id="layer_area" style="display: none;">
			<div class="layer">
				<h2>레이어관리</h2>
				<div id="layer_tree" class="easyui-tree" 
					data-options="animate:true,
					checkbox:true,
					onlyLeafCheck:true,
					url:'selectCctvTreeList.do?flag=iot',
					loadFilter:convertTreeData,
					onLoadSuccess:mapLateChange,
					onCheck:mapChange
					">
				</div>
			</div>
		</div>
	</div>
		
	<div id="footer">
		<jsp:include page="include/iot_footer.jsp" /><!-- 푸터 -->
	</div>
	
    <div id="printdlg" class="easyui-dialog" title="출력"
            data-options="resizable:false,modal:true,closed:true">
        <iframe id="printmap"></iframe>
    </div>
	
	<div class="account_setting">
		<span id="logout" class="logout"><a href="javascript:logout()">Logout</a></span>
	</div>

<script type="text/javascript" src="./js/c3.set.js"></script> 
<script type="text/javascript" src="./js/c3.data.js"></script> 
</body>
</html>
