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
<title>여성안심 서비스</title>


<script type="text/javascript">
	$(document).ready(function(){
		alert("이거부터야?");
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
		
		
		$("#map_addr_search_text").textbox({
			inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents,{
				keyup: function(event){
					if (event.keyCode == 13) {
						addr_search();
					}
				}
			})
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
	
	var facilityPopup;
	var selectedFeature;
	var facilitySelectControl;
	
	var eventPopup;
	
	var _bounds;
	
	var selectedImageLayer;	//선택 레이어
	
	var endCheck = false;
	var prnSeq = 0;
	
	var projectionGroup = new Object();
	
	var eventM;	//이벤트 모니터링 setInterval
	
	var eventMills; // 이벤트 발생 시간을 저장하기 위한 변수
	var viewLogSeqId = 0; // 영상시청로그에 대한 praimary key값
	
	var isOpenCctv = false;

	var mousePointerStyle = 'default';
	
	var sCnt = 0;	//세션 카운트
	
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
		alert(flag);
		mapMoveControl();
		
		
		//select 이벤트
		$(".gnb_next li a").removeClass("selected");
		$('#'+flag+"_cont1_tit").addClass("selected");
		
	/* 	$('.gnb_next').hide();	//전체 소메뉴 hide
		$('#'+flag).show();		//선택 소메뉴 show */
		
		//선택 import jsp show
		
		if(flag == 'menu_setting') changeWidth('admin');
		else changeWidth();

		
		layerClean(eventLayer);
		layerClean(facilityLayer);
		clearInterval(eventM);
		$("#west-panel").show();
		if(flag == 'menu_home'){
			$("#west-panel").hide();
			changeWidth("start");
			search_home();
		}
		else if(flag == 'menu_userList') {
			console.log("asdfa");
			$('.west_cont').hide();			//기존 import jsp hide
			$('#'+flag+"_cont1").show();
			
			search_userList();	
		}
		else if(flag == 'menu_system'){
			$('.west_cont').hide();			//기존 import jsp hide
			$('#'+flag+"_cont2").show();
		}
	}
	/* 소메뉴선택 */
	/* function changeMenu(flag){
		mapMoveControl();
		
		//select 이벤트
		$(".gnb_next li a").removeClass("selected");
		$('#'+flag+"_tit").addClass("selected");
		
		//소메뉴 별 크기 조정
		if(flag == 'menu_eventR_cont2' || flag == 'menu_eventR_cont3') changeWidth('west');
		else if(flag == 'menu_facility_cont2') changeWidth('full');
		else changeWidth();
			
		$('.west_cont').hide();	//전체 import jsp hide
		$('#'+flag).show();		//선택 import jsp show
		
		layerClean(eventLayer);
		layerClean(facilityLayer);
		clearInterval(eventM);
		
		if(flag == 'menu_eventM_cont1'){	//이벤트 모니터링
			search_eventM();
			//eventM = setInterval("search_eventM()",1*20*1000);		//20초
		}
		else if(flag == 'menu_userList'){
			
			
		}
		else if(flag == 'menu_eventM_cont2'){
			mapInfo();
			search_castingN();	//투망감시
		}
		else if(flag == 'menu_eventM_cont3'){
			selectUsedTyList();  // 선택감시 -> 임시로 시설물조회
		}
		else if(flag == 'menu_eventM_cont4'){
			cycleUsedTyList();  // 순환감시
		}
		else if(flag == 'menu_eventM_cont5'){
			search_112eventM();  // 선택감시 -> 임시로 시설물조회
		}
		
		else if(flag == 'menu_eventR_cont1') {
			search_eventR();	//이벤트내역
		}
		else if(flag == 'menu_eventR_cont2') {
			search_accessR();	//접속이력조회
		}
		else if(flag == 'menu_eventR_cont3') {
			search_statsR();	//통계
		}
		else if(flag == 'menu_facility_cont1') {
			search_facilityM();	//시설물관리조회
		}
		else if(flag == 'menu_facility_cont2') {
			search_facilityR();	//시설물현황
		}
	} */
	
	/* 영상표출 부분을 감추고, flag 값에 따라 우측 레이어나 좌측 리스트 표출 부분을 조정하는 Method */
	function changeWidth(flag) {
		//try{document.AthenaStream.DAS_DisconnectVideoStream();}catch(e){}
		
		resizeMap('480px','calc(100% - 480px)','calc(100% - 44px)');
		
		$('.map_btn_area').show();
		
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
			/*var widthChange = width.replace('px','')/2+'px';
			$('#statsR_management .datagrid').css('width',widthChange);
			$('#statsR_management .datagrid-wrap').css('width',widthChange);
			$('#statsR_management .datagrid-view').css('width',widthChange);
			$('#statsR_management .datagrid-view2').css('width',widthChange);
			$('#statsR_management .datagrid-view2 .datagrid-header').css('width',widthChange);
			$('#statsR_management .datagrid-view2 .datagrid-body').css('width',widthChange);
			$('#statsR_management .datagrid-view2 .datagrid-footer').css('width',widthChange);*/
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
			$('#west-panel').css('width','100%');
			$('.gnb_next').css('width','100%');
			//레이어 숨기기
			$('.layer').hide();
			$('.layer_tool_open').removeClass("layer_tool_open").addClass("layer_tool_close");
			var widthChange = '100%';
			$('#faciliyR_management .datagrid').css('width',widthChange);
			$('#faciliyR_management .datagrid').css('left','30px');
			$('#faciliyR_management .datagrid-wrap').css('width',widthChange);
			$('#faciliyR_management .datagrid-view').css('width',widthChange);
			$('#faciliyR_management .datagrid-view2').css('width',widthChange);
			$('#faciliyR_management .datagrid-view2 .datagrid-header').css('width',widthChange);
			$('#faciliyR_management .datagrid-view2 .datagrid-body').css('width',widthChange);
			$('#faciliyR_management .datagrid-view2 .datagrid-body').css('overflow','hidden');
			$('#faciliyR_management .datagrid-view2 .datagrid-footer').css('width',widthChange);
		}
		else if(flag == 'start'){
			resizeMap('0px','100%','calc(100% - 44px)');
		}
		else{
			
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
	
	function init() {
		alert("dd")
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

		$.extend($.fn.validatebox.defaults.rules, {
			ip : {// Verify that the IP address
				validator : function(value) {
					return /\d+\.\d+\.\d+\.\d+/.test(value);
				},
				message : '유효한 IP 주소가 아닙니다.'
			}
		});

		// 이것을 제일 처음 실행 되도록 바꾸어야 하는데...
		$.extend($.fn.datebox.defaults, {
			formatter : function(date) {
				var y = date.getFullYear();
				var m = date.getMonth() + 1;
				var d = date.getDate();
				return y + '-' + (m < 10 ? ('0' + m) : m) + '-'
						+ (d < 10 ? ('0' + d) : d);
			},
			parser : function(s) {
				if (!s)
					return new Date();
				var ss = s.split('-');
				var y = parseInt(ss[0], 10);
				var m = parseInt(ss[1], 10);
				var d = parseInt(ss[2], 10);
				if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
					return new Date(y, m - 1, d);
				} else {
					return new Date();
				}
			}
		});
		alert("여기까지");
		$.fn.datagrid.defaults.editors.empty = {
			init : function(container, options) {
				return $('<div style="padding:0 4px"></div>').appendTo(
						container);
			},
			getValue : function(target) {
				return $(target).html();
			},
			setValue : function(target, value) {
				$(target).html(value);
			}
		};
		$("#west-panel").hide();
		alert("그다름");
		map = new Map("map", { //"map"은 지도를 표출할 div 아이디명
			displayProjection : new OpenLayers.Projection("EPSG:900913"), // 표출 좌표계
			projection : new OpenLayers.Projection("EPSG:900913"), // 기본 좌표계
			maxResolution : 156543.0339, // 최대 해상도 (구글이나 Vworld 사용시 고정값)
			maxExtent : this.maxExtent, // 최대 영역
			numZoomLevels : 20, // 줌의 갯수 (구글이나 Vworld 사용시 고정값)
			unit : "m", // 단위
			eventListeners : {
				"moveend" : moveIndexMapPointer
			}
		});

		addAirTMS(); // TMS 기본지도 추가
		addBaseTMS(); // TMS 기본지도 추가

		//map.setCenter(new OpenLayers.LonLat(14119381.7398256, 4530853.78757956), 15);
		//위경도 시
		// var centerLonlat = new OpenLayers.LonLat(128.980592, 35.21242);
		var centerLonlat = new OpenLayers.LonLat(127.099098, 37.411375);
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
			return (zoomLevel >= 10) && (21 > zoomLevel); // 12레벨 이상 19미만으로 설정
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
		
		menuDisplay('menu_home');
		search_userList(); //이벤트모니터링-조회
		
		$('#event_message').css('display','none');
		
 
		// 관리서버에 연결 시도
		//document.AthenaMgr.DAM_Connect("${config.mgrIp}", "", "${config.mgrPort}");

		//var flag = 'flag=<c:out value="${admin.authority}"/>';
		
		$('#castingN_table').datagrid('loadData', {
			"total" : 0,
			"rows" : []
		}); //투망감시 리스트 초기화
		$('#total_result').datagrid('loadData', {
			"total" : 0,
			"rows" : []
		}); //상황처리 리스트 초기화
		
		setEventLayerControl();
	}
	
	function setEventLayerControl() {
		var eventSelectControl = new OpenLayers.Control.SelectFeature([eventLayer],{
			
		    // 벡터 아이콘 선택시, 선택된 feature를 인자로 받음
		    onSelect: function(feature) {		
		    	console.log(feature);
		        var data = feature.data;
		        var geoX = data.gpsX;
		        var geoY= data.gpsY;
		        
		        if(selectedFeature != undefined) {
		            if(selectedFeature.popup != null) {
		                map.removePopup(selectedFeature.popup);
		                selectedFeature.popup = null;
		           }
		        }
		        
		        divId = 'eventPopup'+Math.floor(Math.random() * 100000);
		        // 팝업생성
		        eventPopup = new OpenLayers.Popup.FramedCloud("chicken", 
		            feature.geometry.getBounds().getCenterLonLat(),
		            new OpenLayers.Size(405,330), setEventPopupUi(data),
		            null, true, onPopupClose);
		        eventPopup.autoSize=true;
		        feature.popup = eventPopup;
		        // 맵에 팝업 추가
		        map.addPopup(eventPopup);
		        
		        selectedFeature = feature;
		        
		        return true;
		    },
		    // 선택해제시
		    onUnselect: function(feature) {
		        if(eventPopup != undefined) {
		            map.removePopup(eventPopup);
		        }
		        _selectedCtvIdn=null;
		        return true;
		    },
		 
		});
		 
		// 닫기 버튼 클릭시
		function onPopupClose(evt) {
		    eventSelectControl.unselectAll();
		    if(eventPopup != undefined) {
		        map.removePopup(eventPopup);
		    }
		    _selectedCtvIdn=null;
		}
		 
		// 맵에 컨트롤 추가
		map.addControl(eventSelectControl);
		// 컨트롤 활성화
		eventSelectControl.activate();
	}
	
	function setEventPopupUi(data) {
	/* 	var eventNo = data.eventNo;
		var seqNo = data.seqNo;
		var state = data.state;
		var eventCont = (data.eventCont == null) ? "" : data.eventCont; */
		
		var name = data.name;
		var age = data.age;
		var phoneNumber = data.phoneNumber;
		var address = data.address;
		var sPhoneNumber = data.sPhoneNumber;
		
/* 		var latitude = (typeof(data.gpsX) == "undefined") ? "0" : data.gpsX;
		var longitude = (typeof(data.gpsY) == "undefined") ? "0" : data.gpsY;
		var eventDe = data.eventDe; */
		var info = ""; 
		
		info += "<div class='event_popup'>";
	/* 	info += "<div class=\"event_popup_title\"><span id=\"event_popup_event_No\">" + eventNo + "</span>";
		info += "<div id=\"event_popup_seq_no\" style=\"display:none;\">" + seqNo +"</div>";
		info += "<div id=\"event_popup_state\" style=\"display:none;\">" + state +"</div>";
		info += "</div>"; */
		info += "<table class=\"event_popup_table\">";
		info += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">이름</div></td>";
		info += "<td><div class=\"event_popup_col\" id=\"event_popup_event_name\">" + name + "</div></td></tr>";
		info += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">생년월일</div></td>";
	    info += "<td><div class=\"event_popup_col\" id=\"event_popup_event_age\">" + age + "</div></td></tr>";
	    info += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">연락처</div></td>";
	    info += "<td><div class=\"event_popup_col\" id=\"event_popup_event_phoneNumber\">" + phoneNumber + "</div></td></tr>";
	    info += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">주소</div></td>";
	    info += "<td><div class=\"event_popup_col\" id=\"event_popup_event_address\">" + address + "</div></td></tr>";
	    info += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">보호자 연락처</div></td>";
	    info += "<td><div class=\"event_popup_col\" id=\"event_popup_event_sPhoneNumber\">" + sPhoneNumber + "</div></td></tr>";
	    /* info += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">발생시간</div></td>";
	    info += "<td><div class=\"event_popup_col\" id=\"event_popup_event_de\">" + eventDe + "</div></td></tr>"; */
	    info += "</table>";
		info += "</div>"
		
		return info;
	}
	
	
	
	function buildInfoControlTextAndVectors(){
	    var info = "<div class=\"info\">";
	    info += "<div class=\"facility_popup\" id=\"facility_popup\">"
	    info += "</div></div>"
	    return info;
	}
	
	function insertEventDB(object) {
		$.ajax({
			url : encodeURI("/com/danusys/platform/insertEvent.do"),
			type : "post",
			data : object,
			/* beforeSend : function() {
				$('#loading').show();
			},
			complete : function() {
				$('#loading').hide();
			}, */
			success : function(datas, textStatus, jQxhr) {
				console.log("insert : "+textStatus);
				if ((object.eventType == "EVENT_TYPE_1") || (object.eventType == "EVENT_TYPE_2")){
					//search_eventM();
					//search_event_confm();
					play_audio("play");
				}
			},
			error : function(jqXhr, textStatus, errorThrown) {
				alert("데이터를 update하는데 실패했습니다.");
			}
		});
	}
	
	function parsingNodeInfo(nodeInfoXML) {
		console.log("parsingNodeInfo!");
		if (window.DOMParser) {
		    parser=new DOMParser();
		    xmlDoc=parser.parseFromString(nodeInfoXML,"text/xml");
		} else {// 인터넷 익스플로러
		    xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
		    xmlDoc.async=false;
		    xmlDoc.loadXML(nodeInfoXML); 
		} 
		var elements = xmlDoc.getElementsByTagName("StreamNodeInfo");
		setFacilityVO(elements);
	}

	function setFacilityVO(elements) {
		console.log("elements length - "+elements.length);
		for (i = 0; i < elements.length; i++) {
			var object = new Object();
			var baseAttr = elements[i].attributes;
			//console.log(elements[i]);
			/* console.log(baseAttr.getNamedItem("Name").nodeValue + " : "
					+ baseAttr.getNamedItem("IP").nodeValue + ", "
					+ baseAttr.getNamedItem("PORT").nodeValue + ", "
					+ baseAttr.getNamedItem("NodeID").nodeValue); */
			
			object.cctvNm = baseAttr.getNamedItem("Name").nodeValue;
			object.nodeIp = baseAttr.getNamedItem("IP").nodeValue;
			object.nodeId = baseAttr.getNamedItem("NodeID").nodeValue;
			object.nodePort = baseAttr.getNamedItem("PORT").nodeValue;
			object.mngCd = baseAttr.getNamedItem("MgrCode").nodeValue;
			//object.usePTZ = usePTZ;
			insertFacilityDuplicateUpdate(object);
		}
	}
	
	function selectFacilityToNodeId(object) {
		$.ajax({
			url : encodeURI("/com/danusys/platform/selectFacilityToNodeId.do"),
			type : "get",
			data : object,
			beforeSend : function() {
				$('#loading').show();
			},
			complete : function() {
				$('#loading').hide();
			},
			success : function(datas, textStatus, jQxhr) {
				//$("#search-result").datagrid('loadData', datas);
				//console.log(datas[0]);
				if(datas.length == 0) {
					insertFacility(object);
				} else {					
					updateFacilityToNodeId(object);
				}
				//console.log(datas);
			},
			error : function(jqXhr, textStatus, errorThrown) {
				alert("데이터를 update하는데 실패했습니다.");
			}
		});
	}
	
	function insertFacilityDuplicateUpdate(object) {
		//console.log("insertFacilityDuplicateUpdate()!!");
		$.ajax({
			url : encodeURI("/com/danusys/platform/insertFacilityDuplicateUpdate.do"),
			type : "post",
			data : object,
			beforeSend : function() {
				$('#loading').show();
			},
			complete : function() {
				$('#loading').hide();
			},
			success : function(datas, textStatus, jQxhr) {
				console.log("insertFacilityDuplicateUpdate() success:"+textStatus);
			},
			error : function(jqXhr, textStatus, errorThrown) {
				alert("데이터를 update하는데 실패했습니다.");
			}
		});
	}

	function updateFacilityToNodeId(object) {
		$.ajax({
			url : encodeURI("/com/danusys/platform/updateFacilityToNodeId.do"),
			type : "get",
			data : object,
			beforeSend : function() {
				$('#loading').show();
			},
			complete : function() {
				$('#loading').hide();
			},
			success : function(datas, textStatus, jQxhr) {
				//$("#search-result").datagrid('loadData', datas);
				//console.log("update : "+textStatus);
			},
			error : function(jqXhr, textStatus, errorThrown) {
				alert("데이터를 update하는데 실패했습니다.");
			}
		});
	}
	function transformCoordinate2(x, y) {

		Proj4js.defs["EPSG:4326"] = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs";
		Proj4js.defs["EPSG:900913"] = "+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs";

		var fromProjection = new Proj4js.Proj("EPSG:900913");
		var toProjection = new Proj4js.Proj("EPSG:4326");
		var point = new Proj4js.Point(x, y);
		var newPoint = Proj4js.transform(fromProjection, toProjection, point);
		return new OpenLayers.LonLat(newPoint.x, newPoint.y);
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
		
		/* $.ajax(
	             {
	                 type       : "POST",
	                 url        : "/select/girlSafe.getUserList/action.do",
	                 dataType   : "json",
	                 async      : false,
	                 beforeSend : function(xhr)
	                 {
	                     // 전송 전 Code
	                 }
	             }).done(function (result) {
	            	 
	            	 alert("Adsfasdf"+JSON.stringify(result));
	            	 options.success(result);
	            	 
	             }).fail(function (xhr) {
	            	 alert("실패"+JSON.stringify(xhr));
	            	 	alert("왜");
	             }).always(function() {

	             }); */
	
		/* $.ajax({
			url : "/select/girlSafe.getUserList/action.do",
			type : "POST",
			data : "",
			/beforeSend : function() {
				$('#loading').show();
			},
			complete : function() {
				$('#loading').hide();
			}, 
			success : function(datas, textStatus, jQxhr) {
				alert(datas.length);
				alert(datas);
				alert(JSON.stringify(datas));
			
				for(var i=0;i<datas.length;i++){
					var data = datas[i];
					alert(tlayers);
					if(tlayers == 'CCTV'){
						removeFeature(data)
					}
					else{
						createFeature(data);
					}
				}	
			},
			error : function(jqXhr, textStatus, errorThrown) {
				alert("데이터를 update하는데 실패했습니다.");
			}
		}); */
	
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

	function customFormat(date, formatString) {
		var YYYY, YY, MMMM, MMM, MM, M, DDDD, DDD, DD, D, hhhh, hhh, hh, h, mm, m, ss, s, ampm, AMPM, dMod, th;
		YY = ((YYYY = date.getFullYear()) + "").slice(-2);
		MM = (M = date.getMonth() + 1) < 10 ? ('0' + M) : M;
		MMM = (MMMM = [ "January", "February", "March", "April", "May", "June",
				"July", "August", "September", "October", "November",
				"December" ][M - 1]).substring(0, 3);
		DD = (D = date.getDate()) < 10 ? ('0' + D) : D;
		DDD = (DDDD = [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
				"Friday", "Saturday" ][date.getDay()]).substring(0, 3);
		th = (D >= 10 && D <= 20) ? 'th' : ((dMod = D % 10) == 1) ? 'st'
				: (dMod == 2) ? 'nd' : (dMod == 3) ? 'rd' : 'th';
		formatString = formatString.replace("#YYYY#", YYYY).replace("#YY#", YY)
				.replace("#MMMM#", MMMM).replace("#MMM#", MMM).replace("#MM#",
						MM).replace("#M#", M).replace("#DDDD#", DDDD).replace(
						"#DDD#", DDD).replace("#DD#", DD).replace("#D#", D)
				.replace("#th#", th);
		h = (hhh = date.getHours());
		if (h == 0) h = 24;
		if (h > 12) h -= 12;
		hh = h < 10 ? ('0' + h) : h;
		hhhh = hhh < 10 ? ('0' + hhh) : hhh;
		AMPM = (ampm = hhh < 12 ? 'am' : 'pm').toUpperCase();
		mm = (m = date.getMinutes()) < 10 ? ('0' + m) : m;
		ss = (s = date.getSeconds()) < 10 ? ('0' + s) : s;
		return formatString.replace("#hhhh#", hhhh).replace("#hhh#", hhh)
				.replace("#hh#", hh).replace("#h#", h).replace("#mm#", mm)
				.replace("#m#", m).replace("#ss#", ss).replace("#s#", s)
				.replace("#ampm#", ampm).replace("#AMPM#", AMPM);
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

	function play_audio(task) {
		var audio = new Audio();
		audio.src='/sound/siren.mp3';
		audio.valume=1.0;
	    if(task == 'play'){
	         audio.play()
	    }
	    if(task == 'stop'){
	         audio.pause();
	         audio.currentTime=0;
	    }
	}
	
</script>
</head>
<body onload="init()" id="bodyDefault">
	<form id="excelForm" name="excelForm" method="post">
		<input type="hidden" id="excelData" name="excelData">
	</form>

	
		<div id="west-panel">
    		<div id="west_area" class="west_area">
    			<div class="west_cont" id="menu_userList_cont1">
				    
				</div>
			 	<div class="west_cont" id="menu_userList_cont2">
			
				</div>
			</div>
		</div>
    	
		<div id="map"> <!-- data-options="region:'center',onResize:function(){resizeMe();}" -->
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
				<li>
					<div class="map_search_box">
						<label>검색</label>
						<input class="easyui-textbox map_addr_search_text" id="map_addr_search_text" onenter="" data-options="prompt:'지번 ,도로명 또는 건물명, 시설명', width:'250px', height:'23px', margin:'0'"/>
						<a href="#" id="map_addr_search_btn" onclick="addr_search()" class="easyui-linkbutton" data-options="iconCls:'icon-search',toggle:false">검색</a>
					</div>
				</li>
			</ul>
		</div>
		
		<div id="layer_area">
			<div class="layer">
				<h2>레이어관리2</h2>
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
	
	<!-- <object id="AthenaMgr" classid="CLSID:DC8A5A7E-AA71-4BA9-B899-DE76960ACA24" CODEBASE="./activex/AthenaMgr.cab#version=1,0,0,6" width="0" height="0"></object> -->
	

	
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
		
		/* 인덱스맵호출 */
		indexMap();
    </script>
	
    <div id="printdlg" class="easyui-dialog" title="출력"
            data-options="resizable:false,modal:true,closed:true">
        <iframe id="printmap"></iframe>
    </div>
    
    <div id="loading"><!-- images/layout/loading.gif -->
		<img src="/images/template/loading.gif">
	</div>
	
	<div class="account_setting">
		<span id="logout" class="logout"><a href="javascript:logout()">Logout</a></span>
	</div>
	
	
	<div id="imgmngdlg" class="easyui-dialog" title="이미지업로드" style="width:800px;height:400px;padding:10px"
	    data-options="resizable:false,modal:true,closed:true">
		<div class="container">
	    	<div class="upload_form_cont">
	        	<form id="upload_form" enctype="multipart/form-data" method="post">
	            	<div>
	                	<div><label for="image_file">이미지를 선택해 주세요.</label></div>
	                	<div><input type="file" name="image_file" id="image_file" onchange="fileSelected();" /></div>
	            	</div>
	            	<div>
	                	<input id="imgFileButton" name="imgFileButton" type="button" value="업로드" onclick="startUploading()" />
	                </div>
	                <div id="fileinfo">
	                    <div id="filename"></div>
	                    <div id="filesize"></div>
	                    <div id="filetype"></div>
	                    <div id="filedim"></div>
	                </div>
	                <div id="error">이미지 파일만 선택이 가능합니다.!</div>
	                <div id="error2">파일 업로드중 에러가 발생했습니다.</div>
	                <div id="abort">업로드가 사용자에 의해 취소되었거나, 인터넷 연결이 끊어졌습니다.</div>
	                <div id="warnsize">파일이 너무 큽니다. 10M 이하의 이미지만 올릴 수 있습니다.</div>
	
	                <div id="progress_info">
	                    <div id="progress"></div>
	                    <div id="progress_percent">&nbsp;</div>
	                    <div class="clear_both"></div>
	                    <div>
	                        <div id="speed">&nbsp;</div>
	                        <div id="remaining">&nbsp;</div>
	                        <div id="b_transfered">&nbsp;</div>
	                        <div class="clear_both"></div>
	                    </div>
	                    <div id="upload_response"></div>
	                </div>
	                <input type=hidden id="fileSeqNo" name="fileSeqNo" value=""/>
	                <input type=hidden id="fileAtchFileId" name="fileAtchFileId" value=""/>
	            </form>
	            <img id="preview" />
	        </div>
	    </div>
	</div>

	<!-- 팝업 div -->
	
	
</body>
</html>
