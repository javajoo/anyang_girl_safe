/* 초기 화면  */
function search_home(){
	var url = "/select/girlSafe.getUserList/action.do";
	const jsonObj = {};
	$.ajax({
		type : "POST"
		, url : url
		, dataType : "json"
		, data : {"param" : JSON.stringify(jsonObj)}
		, success:function(data)
		{
			for(var i=0; i<data.length; i++){
				var result = data[i];
				createFeature(result);
			}	
		}
		, error:function(e){
			alert(e.responseText);
		}
	});
}

/* 가입자 현황 -조회 */
function search_list(page){
	$("#path").val(page);
	$(".gnb ul.gnb_ul").children("li").removeClass("active");
	$(this).addClass("active");
    $("#menu_cont").html("");
    $("#menu_cont").load("/action/page.do", { path : page }, function() {
    	
    });
}

/* 가입자 현황 -조회 */
function search_userList(){
	var page = '/include/user_list'; 
	$("#path").val(page);
	$(".gnb ul.gnb_ul").children("li").removeClass("active");
	$(this).addClass("active");
    $("#menu_cont").html("");
    $("#menu_cont").load("/action/page.do", { path : page }, function() {
    	
    });
}

/* 이벤트 검색  화면  */
function search_eventList(){
	var page = '/include/event_list'; 
	$("#path").val(page);
	$(".gnb ul.gnb_ul").children("li").removeClass("active");
	$(this).addClass("active");
    $("#menu_cont").html("");
    $("#menu_cont").load("/action/page.do", { path : page }, function() {
    	
    });
}


function search_hwStatus(){
	var page = '/include/hw_status';
	$("#path").val(page);
	$(".gnb ul.gnb_ul").children("li").removeClass("active");
	$(this).addClass("active");
    $("#menu_cont").html("");
    $("#menu_cont").load("/action/page.do", { path : page }, function() {
    	
    });
}


function createIcon(flag){
	//console.log('이벤트 아이콘 생성');
	layerClean(eventLayer);
	var rows = $('#'+flag+'_table').datagrid('getData').rows;
	for(var i=0; i<rows.length; i++){
		var data = rows[i];
		createFeature(data);
	}	
}
/*이벤트 리스트 기준 지도 표출*/
function createFeature(data){
	var iconcls;
	if(eventLayer == null){
		return;;
	}
	
	if(data.chkStatus < 1 && data.chkBat < 2 && data.emergency < 1){
		iconcls = 'images/icons/woman_nor.png';
	}
	else{
		iconcls = 'images/icons/woman_emr.png';
	}
	if(data.pointY > 0){
		var feature = new OpenLayers.Feature.Vector(
	            new OpenLayers.Geometry.Point(data.pointX,data.pointY).transform(projectionGroup["grs80"], projectionGroup["google"]),
	            {sensorId:data.sensorId, name:data.name, age:data.age, gpsX:data.pointX, gpsY:data.pointY, 
	            	phoneNumber: data.phoneNumber, sPhoneNumber: data.sPhoneNumber, address: data.address, status: data.status,
	            	bat: data.bat, emergency: data.emergency
	            } ,
	            {externalGraphic: iconcls, graphicHeight: 70, graphicWidth: 40, graphicXOffset:-35, graphicYOffset:-20}
	            );
		eventLayer.addFeatures(feature);
		//eventLayer.removeFeatures(feature);
		
	}
}

/*이벤트 리스트 기준 지도 삭제*/
function removeFeature(data){
	layerClean(eventLayer);
	if(eventLayer == null){
		return;;
	}
	if(data.pointY > 0){
		var feature = new OpenLayers.Feature.Vector(
	            new OpenLayers.Geometry.Point(data.pointX,data.pointY).transform(projectionGroup["grs80"], projectionGroup["google"]),
	            {hwSerial:data.hwSerial, name:data.name, age:data.age, gpsX:data.pointX, gpsY:data.pointY, 
	            	phoneNumber: data.phoneNumber, sPhoneNumber: data.sPhoneNumber, address: data.address, status: data.status,
	            	bat: data.bat, emergency: data.emergency
	            } ,
	            {externalGraphic: 'images/icons/EVENT_TYPE_6_L.png', graphicHeight: 70, graphicWidth: 40, graphicXOffset:-13, graphicYOffset:-13}
	            );
		eventLayer.removeFeatures(feature);
		//eventLayer.removeFeatures(feature);
		
	}
}

/*리스트 클릭 시-= 지도아이콘 표출*/
function selectEeventMGIS(row, data){
	layerClean(selectedImageLayer);
	if(data.pointY > 0){
		var feature = new OpenLayers.Feature.Vector(
		        new OpenLayers.Geometry.Point(data.pointX,data.pointY).transform(projectionGroup["grs80"], projectionGroup["google"]),
		        {} ,
		        {externalGraphic: 'images/icons/selected.png', graphicHeight: 32, graphicWidth: 32, graphicXOffset:-16, graphicYOffset:-16  }
		    );
		selectedImageLayer.addFeatures(feature);
		
		map.setCenter(new OpenLayers.LonLat(data.pointX,data.pointY).transform(new OpenLayers.Projection("EPSG:4326"),new OpenLayers.Projection("EPSG:900913")));
	}
	//else $.messager.alert("경고", "좌표값이 없습니다.",'warning');
}

/* 이벤트모니터링 더블클릭시 - 저장 영상표출 */
function selectEeventMRow(row, data){
	//document.AthenaStream.DAS_Storage_Stop(0);
	document.AthenaStream.DAS_DisconnectVideoStream();
	closeCctv();
	var object = new Object();
	object.encryptLongitude = data.longitude;
	object.encryptLatitude = data.latitude;
	object.isEvent = true;
	object.eventDe = data.eventDe;
	search_radius(object);
}

/* 투망감시 더블클릭시 - 실시간 영상표출 */
function selectCastingNRow(row, data){
	document.AthenaStream.DAS_DisconnectVideoStream();
	closeCctv();
	var object = new Object();
	object.encryptLongitude = data.longitude;
	object.encryptLatitude = data.latitude;
	object.isEvent = false;
	search_radius(object);
}

/* 이벤트모니터링-상황처리 */
function search_eventM_handle(){
	$('#pop_tabs').show();
	search_pop(0);
	$('#event_monitoring_handle').dialog('open');
}
var modal;
/* 이벤트모니터링-처리 */
function row_handle(eventNo){
	$('#pop_tabs').hide();
	//var row = $('#eventM_table').datagrid('getSelected');
	//var eventNo = row.eventNo;
	search_pop(0,eventNo);
	$('#event_monitoring_handle').dialog('open');
	modal = '#event_monitoring_handle';
	$(document).keyup(function (e) {
        if (e.keyCode == 27) {
            $(modal).dialog('close');
        }
    });
}

function addr_search(){
	var addr = $('#map_addr_search_text').val();
	
	if (addr == "" || addr == null) {
		return;
	}
	
	$.ajax({
		url: encodeURI("http://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=ko&address= " + addr),
		type: "get",
		async: true,
		data: authflag,
		success: function(datas, textStatus, jQxhr){
			if (datas.status == "ZERO_RESULTS") {
				alert("주소를 찾을수 없습니다.");
				return;
			}
			lon = datas.results[0].geometry.location.lng;
			lat = datas.results[0].geometry.location.lat;
			var centerLonlat = new OpenLayers.LonLat(lon, lat);
			centerLonlat.transform(new OpenLayers.Projection("EPSG:4326"),
					new OpenLayers.Projection("EPSG:900913"));
			var zoom = map.getZoom();
			map.setCenter(centerLonlat, zoom);
		}
	});
}

/* 투망감시-조회 */
function search_castingN(flag,lat,lon){
	if (!lat) {
		lat = 0;
	}
	if (!lon) {
		lon = 0;
	}
	document.AthenaStream.DAS_DisconnectVideoStream();
	closeCctv();
	layerClean(selectedImageLayer);
	if(flag=='map'){
		map.setCenter(new OpenLayers.LonLat(lon, lat).transform(new OpenLayers.Projection("EPSG:4326"),
				new OpenLayers.Projection("EPSG:900913")));
	}
	else {
		if($('#search_castingN_chk').is(":checked")) {
			flag = 'adres';
			$.ajax({
				url: encodeURI("http://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=ko&address="+$('#search_castingN_tot').val()),
				type: "get",
				async: true,
				data: authflag,
				success: function(datas, textStatus, jQxhr){
					lon = datas.results[0].geometry.location.lng;
					lat = datas.results[0].geometry.location.lat;
					var centerLonlat = new OpenLayers.LonLat(lon, lat);
					centerLonlat.transform(new OpenLayers.Projection("EPSG:4326"),
							new OpenLayers.Projection("EPSG:900913"));
					map.setCenter(centerLonlat, 14);
				}
			});
		}
	}
	
	$('#castingN_table').datagrid('options').url = "com/danusys/platform/selectFacilityList.do";
	$('#castingN_table').datagrid('options').pageNumber = 1;
	$('#castingN_table').datagrid('load', {
		pageSize: 18,
		totSearch: $('#search_castingN_tot').val(),
		flag: flag,
		encryptLatitude: lat,
		encryptLongitude: lon		
    });
	$('#castingN_table').datagrid({
		onLoadSuccess:function(){
			layerClean(facilityLayer);
			var png = 1;
			if(flag != null){
				var data = $('#castingN_table').datagrid('getData');
				var chklon;
				var chklat;
				
				for(var i = 0; i < 6; i++){
					console.log(data.rows[i]);
					var facility = data.rows[i];
					if(facility.nodeIp=="" || facility.nodePort=="" || facility.nodeId=="" 
						|| facility.nodeIp==null || facility.nodePort==null || facility.nodeId==null){
						
					} else { // 투망영상
						console.log("facility: "+facility.nodeId+", i:"+i);
						document.AthenaStream.DAS_ConnectVideoStream(facility.nodeIp, facility.nodePort, facility.nodeId, i, (null==facility.cctvNm)?"":facility.cctvNm);
						openCctvDiv(); // 영상표출 영역 보여줌.
						
						isOpenCctv = true;
					}
					
					if(chklat == data.rows[i].latitude && chklon == data.rows[i].longitude){
						png++;
					}
					else {
						chklat = data.rows[i].latitude;
						chklon = data.rows[i].longitude;
						
						if(facilityLayer == null){
							return;
						}
						if(data.rows[i].longitude > 0){
							var feature = new OpenLayers.Feature.Vector(
						            new OpenLayers.Geometry.Point(data.rows[i].longitude,data.rows[i].latitude).transform(projectionGroup["grs80"], projectionGroup["google"]),
						            {gpsX:data.rows[i].longitude, gpsY:data.rows[i].latitude} ,
						            {externalGraphic: 'images/icons/'+png+'.png', graphicHeight: 32, graphicWidth: 32, graphicXOffset:-16, graphicYOffset:-16}
						            );
							facilityLayer.addFeatures(feature);
						}
						png++;
					}
				}
			}
		}});
}

/* 시설물 사용유형 종류 목록을 가져온다. */
function selectUsedTyList() {
	$('#selectM_management').show();
	$('#selectM_management_dtl').hide();
	$('#selectM_table').datagrid('loadData', {"total":0,"rows":[]});
	$('#selectM_table').datagrid('options').url = "com/danusys/platform/selectFacilityMList.do";
	$('#selectM_table').datagrid('options').pageNumber = 1;
	$('#selectM_table').datagrid('load', {
		pageSize: 15
		//,facilityGbn: $("#search_facilityM_gbn").combobox('getValue')
	});	
}
/* 시설물관제>시설물관리 더블클릭시 - 실시간 영상표출 */
function selectMRow(row, data){
	//document.AthenaStream.DAS_ConnectVideoStreamSingle("172.20.20.103", 10000, 20467, 0, "윤일로");
	document.AthenaStream.DAS_ConnectVideoStreamSingle("192.168.3.200", 554, 20467, 0, "윤일로");
	//document.AthenaStream.DAS_ConnectVideoStreamSingle(data.nodeIp, data.nodePort, data.nodeId, 0, data.cctvNm);
}

/* 순환감시 목록을 가져온다. */
function cycleUsedTyList(){
	
}

/* 112이벤트-조회 */
function search_112eventM(){
	$('#112eventM_table').datagrid('loadData', {"total":0,"rows":[]});
	$('#112eventM_table').datagrid('options').url = "com/danusys/platform/selectEventList.do";
	$('#112eventM_table').datagrid('options').pageNumber = 1;
	$('#112eventM_table').datagrid('load', {
		pageSize: 18,
		state: 'EVENT_STATE_1',
		eventType: 'EVENT_TYPE_3'
    });
	$('#112eventM_table').datagrid({
		onLoadSuccess:function(data){
			if($('#112eventM_table').datagrid('getData').rows=='sessionOut'){
				sCnt++;
				if(sCnt == 1){
					alert('세션아웃 됐습니다.');
					//location.href="/";
					closeWindow();
				}
			}
			if(data && data.total > 0) {				
				selectEeventMGIS(0, data.rows[0]);	// 발생된 이벤트 선택 및 지도 표출.
				$(this).datagrid('selectRow',0);
				createIcon();
			}
		}});
}


/* 반경 1km내 cctv 리스트 가져오기 */
function search_radius(data){
	console.log(data);
	layerClean(selectedImageLayer);
	$.ajax({
		url: encodeURI("/com/danusys/platform/selectFacilityRadius.do"),
		type: "get",
		async: true,
		data: data,
		success: function(datas, textStatus, jQxhr){
			console.log(datas);
			console.log("search_radius! datas.length:"+datas.length+", testStatus:"+textStatus);
			var elapsed = 0;
			var isRealtime = true;
			var logObject;
			if(datas.length ==0) {
				changeWidth(); // 반경내 카메라가 없으면 영상표출 영역 감춤
				$.messager.alert("알람", "반경 1Km 내에 카메라가 없습니다.");
			} else {
				for(var i=0; i<datas.length; i++){
					var facility = datas[i];
					if(facility.nodeIp=="" || facility.nodePort=="" || facility.nodeId=="" 
						|| facility.nodeIp==null || facility.nodePort==null || facility.nodeId==null){
						/* To-do : node id, ip, port 번호가 없을 경우에 대한 예외처리 필요! */
					} else {
						if(data.isEvent) { // 이벤트 모니터링
							var now = new Date();
							var startMsec = mysqlTimeStampToDate(data.eventDe);
							var dateMills = startMsec.getTime();
							if (elapsed == 0) { // for문 돌다가 60초를 넘어가는 case를 방지하기 위해, 처음 돌 때의 시간 만 가지고 경과된 시간을 체크한다. 
								elapsed = (now.getTime() - dateMills) / 1000; 
							}
							console.log("elapsed: "+elapsed+"second,  startMsec: "+startMsec);
							if(elapsed < 60){ // 이벤트 발생시점이 1분 이내라면 실시간 영상을 띄워준다.
								document.AthenaStream.DAS_ConnectVideoStream(facility.nodeIp, facility.nodePort, facility.nodeId, i, (null==facility.cctvNm)?"":facility.cctvNm);
								isRealtime = true;
								
							} else { // 이벤트 발생시점에서 1분이 지나면 저장영상을 띄워준다. 
								console.log("isEvent, "+facility.nodeId+", eventDe: "+data.eventDe);
								eventMills = dateMills;
								document.AthenaMgr.DAM_StorageHistoryReq(facility.nodeId);
								isRealtime = false;
							}
						} else { // 투망 영상(실시간)
							console.log("isEvent, "+data.isEvent+", eventDe: "+data.eventDe);
							document.AthenaStream.DAS_ConnectVideoStream(facility.nodeIp, facility.nodePort, facility.nodeId, i, (null==facility.cctvNm)?"":facility.cctvNm);
							isRealtime = true;
						}
						if(facility.encryptLatitude > 0){ // 카메라 위치 표시
							var feature = new OpenLayers.Feature.Vector(
							        new OpenLayers.Geometry.Point(facility.encryptLongitude,facility.encryptLatitude).transform(projectionGroup["grs80"], projectionGroup["google"]),
							        {} ,
							        {externalGraphic: 'images/icons/selected.png', graphicHeight: 32, graphicWidth: 32, graphicXOffset:-16, graphicYOffset:-16  }
							    );
							selectedImageLayer.addFeatures(feature);
						}
					}
				}
				openCctvDiv(); // 영상표출 영역 보여줌.
				isOpenCctv = true;
				insertCctvViewLog(datas, data.isEvent, isRealtime);
			}
			map.setCenter(new OpenLayers.LonLat(data.longitude,data.latitude).transform(
					new OpenLayers.Projection("EPSG:4326"),new OpenLayers.Projection("EPSG:900913")), 15); // 지도 중앙으로 이동.
		},
		error: function(jqXhr, textStatus, errorThrown){
			alert("search_radius! 데이터를 불러오는데 실패했습니다.");
		}
	});
}

function mysqlTimeStampToDate(timestamp) {
    //function parses mysql datetime string and returns javascript Date object
    //input has to be in this format: 2007-06-05 15:26:02
    var regex=/^([0-9]{2,4})-([0-1][0-9])-([0-3][0-9]) (?:([0-2][0-9]):([0-5][0-9]):([0-5][0-9]))?$/;
    var parts=timestamp.replace(regex,"$1 $2 $3 $4 $5 $6").split(' ');
    return new Date(parts[0],parts[1]-1,parts[2],parts[3],parts[4],parts[5]);
}

/*이벤트내역 - 조회*/
function search_eventR(){
	$('#eventR_table').datagrid('loadData', {"total":0,"rows":[]});
	$('#eventR_table').datagrid('options').url = "com/danusys/platform/selectEventList.do";
	$('#eventR_table').datagrid('options').pageNumber = 1;
	$('#eventR_table').datagrid('load', {
		pageSize: 15,
		state: '0',
		eventDeS: $("#search_eventR_timeS").datebox('getValue').replace(/\//g, ''),
		eventDeE: $("#search_eventR_timeE").datebox('getValue').replace(/\//g, ''),
		totSearch: $("#search_eventR_tot").val()
    });
}

/*접속이력 - 조회*/
function search_accessR(){
	$('#accessR_table').datagrid('loadData', {"total":0,"rows":[]});
	$('#accessR_table').datagrid('options').url = "com/danusys/platform/selectLogList.do";
	$('#accessR_table').datagrid('options').pageNumber = 1;
	$('#accessR_table').datagrid('load', {
		pageSize: 15,
		startDate: $("#search_accessR_timeS").datebox('getValue').replace(/\//g, ''),
		endDate: $("#search_accessR_timeE").datebox('getValue').replace(/\//g, ''),
		totSearch: $("#search_accessR_tot").val()
    });
}

/*접속이력 - 조회결과 클릭*/
function selectAccessR(row, data){
	$('#dtl_nm').val(data.adminNm);		//이름
	$('#dtl_role').val('');				//권한등급(아직없음)
	$('#dtl_login').val(data.login);	//로그인
	$('#dtl_logout').val(data.logout);	//로그아웃
	
	
	$('#accessR_dtl_table').datagrid('loadData', {"total":0,"rows":[]});
	$('#accessR_dtl_table').datagrid('options').url = "com/danusys/platform/selectCctvViewLogList.do";
	$('#accessR_dtl_table').datagrid('options').pageNumber = 1;
	$('#accessR_dtl_table').datagrid('load', {
		pageSize: 5,
		sessionId: data.sessionId
    });
}

function insertCctvViewLog(data, isEvent, isRealtime) {
	var object = new Object();
	object.camera1Name = data[0].cctvNm;
	object.camera2Name = data[1].cctvNm;
	object.camera3Name = data[2].cctvNm;
	object.camera4Name = data[3].cctvNm;
	object.camera5Name = data[4].cctvNm;
	object.camera6Name = data[5].cctvNm;
	object.camera1Id = data[0].nodeId;
	object.camera2Id = data[1].nodeId;
	object.camera3Id = data[2].nodeId;
	object.camera4Id = data[3].nodeId;
	object.camera5Id = data[4].nodeId;
	object.camera6Id = data[5].nodeId;
	object.menuType = isEvent ? "EVENT" : "CAST";
	object.videoType = isRealtime ? "R" : "S";
	if (!isRealtime) { // 저장영상 이라면, 영상의 시간을 보내줌.
		var startDate = new Date(eventMills - (25*60*1000));	// 이벤트 발생시점으로 부터 25분 이전
		var endDate = new Date(eventMills + (25*60*1000)); 		// 이벤트 발생시점으로 부터 25분 이후
		object.videoStartTime = customFormat(startDate, "#YYYY#.#MM#.#DD#.#hhhh#.#mm#.#ss#");
		object.videoEndTime = customFormat(endDate, "#YYYY#.#MM#.#DD#.#hhhh#.#mm#.#ss#");
	}
	object.viewStartTime = customFormat(new Date(), "#YYYY#-#MM#-#DD# #hh#:#mm#:#ss#");
	
	console.log("insertCctvViewLog! menuType: "+object.menuType+", videoType: "+object.videoType+", viewStartTime: "+object.viewStartTime);
	console.log("insertCctvViewLog! camera1Name: "+object.camera1Name+", camera1Id: "+object.camera1Id+", camera2Name: "+object.camera2Name+", camera2Id: "+object.camera2Id);
	$.ajax({
		url: encodeURI("/com/danusys/platform/insertCctvViewLog.do"),
		type : "post",
		data : object,
		/* beforeSend : function() {
			$('#loading').show();
		},
		complete : function() {
			$('#loading').hide();
		}, */
		success : function(datas, textStatus, jQxhr) {
			console.log("insertCctvViewLog response!");
			console.log(datas);
			viewLogSeqId = datas.seqId;
		},
		error : function(jqXhr, textStatus, errorThrown) {
			console.log(textStatus);
			console.log(jqXhr);
			alert("데이터를 insert 하는데 실패했습니다.");
		}
	});
}

function updateCctvViewLog(object) {
	$.ajax({
		url : encodeURI("/com/danusys/platform/updateViewEndTime.do"),
		type : "get",
		data : object,
		/* beforeSend : function() {
			$('#loading').show();
		},
		complete : function() {
			$('#loading').hide();
		}, */
		success : function(datas, textStatus, jQxhr) {
			console.log("update : "+textStatus);
			viewLogSeqId = 0;
		},
		error : function(jqXhr, textStatus, errorThrown) {
			alert("데이터를 update 하는데 실패했습니다.");
		}
	});
}

/*시설물관제>시설물관리 - 조회*/
function search_facilityM(){
	$('#facilityM_management').show();
	$('#facilityM_dtl_management').hide();
	$('#facilityM_table').datagrid('loadData', {"total":0,"rows":[]});
	$('#facilityM_table').datagrid('options').url = "com/danusys/platform/selectFacilityMList.do";
	$('#facilityM_table').datagrid('options').pageNumber = 1;
	$('#facilityM_table').datagrid('load', {
		pageSize: 15
		,facilityType: $("#search_facilityM_gbn1").combobox('getValue')
    });	
}

/* 시설물관제>시설물관리 더블클릭시 - 실시간 영상표출 */
function selectFacilityMRow(row, data){
	//document.AthenaStream.DAS_ConnectVideoStreamSingle("172.20.20.103", 10000, 20467, 0, "윤일로");
	document.AthenaStream.DAS_ConnectVideoStreamSingle(data.nodeIp, data.nodePort, data.nodeId, 0, data.cctvNm);
}

/*시설물관제>시설물관리 - 단일등록*/
function add_facility(){
	$('#facility_type').combobox('enable',true);
	
	$('#modify_facility').hide();
	$('#del_facility').hide();
	$('#inst_facility').show();
	$('#back_facility').css('left','75px');
	
	init_facility();

	$('#facilityM_dtl_table_1').show();
	//$('#facilityM_dtl_table_2').hide();
	
	$('#facilityM_management').hide();
	$('#facilityM_dtl_management').show();
}

//시설물 종류 선택
function select_facility_type(obj){
	/*init_facility();
	if(obj.value == 'CENTER'){
		$('#facility_center_type').combobox('setValue',obj.value);
		$('#facilityM_dtl_table_1').hide();
		$('#facilityM_dtl_table_2').show();
	}
	else{
		$('#facility_type').combobox('setValue',obj.value);
		$('#facilityM_dtl_table_1').show();
		$('#facilityM_dtl_table_2').hide();
	}*/
}

//시설물 구분 선택
function select_facility_center_gbn(obj){
	var param = '';
	$.ajax({
		type:"GET"
		,async: true
		,url: "com/danusys/platform/selectCode.do?codeGroup="+obj.codeCd
		,dataType: "json"
		,success: function(json){
			param = json
			$('#facility_center_propos').combobox('loadData',param);
		}
	});
}

/*시설물관제>시설물관리 - 상세정보*/
function dtl_facility(){
	$('#facility_type').combobox('disable',true);
	//임시-start
	$('#facilityM_dtl_table_1').show();
	//$('#facilityM_dtl_table_2').hide();
	//임시-end
	
	$('#inst_facility').hide();
	$('#del_facility').show();
	$('#modify_facility').show();
	$('#back_facility').css('left','145px');
	var row = $('#facilityM_table').datagrid('getSelected');
	if(row != null){
		$.ajax({
			type:"GET"
			,async: true
			,url: "com/danusys/platform/selectCode.do?codeGroup="+row.facilityCenterGbn
			,dataType: "json"
			,success: function(json){
				$('#facility_center_propos').combobox('loadData',json);
				
				$('#facility_id').val(row.seqNo);
				$('#facility_type').combobox('setValue',row.facilityType);
				$('#facility_propos').combobox('setValue',row.purpose);
				$('#facility_nm').val(row.cctvNm);
				$('#facility_lon').val(row.longitude);
				$('#facility_lat').val(row.latitude);
				$('#facility_node_id').val(row.nodeId);
				$('#facility_node_ip').val(row.nodeIp);
				$('#facility_node_port').val(row.nodePort);
				$('#facility_mng_cd').val(row.mngCd);
				
				$('#facility_acpt_ip').val(row.acptIp);
				$('#facility_acpt_port').val(row.acptPort);
				$('#facility_acpt_id').val(row.acptId);
				$('#facility_acpt_pw').val(row.acptPw);
				$('#facility_rtsp_url').val(row.rtspUrl);
				/*if(row.facilityType == 'CENTER'){
					$('#facilityM_dtl_table_1').hide();
					$('#facilityM_dtl_table_2').show();
					
					$('#facility_center_id').val(row.seqNo);
					$('#facility_center_type').combobox('setValue',row.facilityType);
					$('#facility_center_nm').val(row.cctvNm);
					$('#facility_center_gbn').combobox('setValue',row.facilityCenterGbn);
					$('#facility_center_propos').combobox('setValue',row.purpose);
					$('#facility_center_place').val(row.facilityCenterPlace);
				}
				else{
					$('#facilityM_dtl_table_1').show();
					$('#facilityM_dtl_table_2').hide();
					
					$('#facility_id').val(row.seqNo);
					$('#facility_type').combobox('setValue',row.facilityType);
					$('#facility_propos').combobox('setValue',row.purpose);
					$('#facility_nm').val(row.cctvNm);
					$('#facility_lon').val(row.longitude);
					$('#facility_lat').val(row.latitude);
					$('#facility_node_id').val(row.nodeId);
					$('#facility_node_ip').val(row.nodeIp);
					$('#facility_node_port').val(row.nodePort);
					$('#facility_mng_cd').val(row.mngCd);
					
					$('#facility_acpt_ip').val(row.acptIp);
					$('#facility_acpt_port').val(row.acptPort);
					$('#facility_acpt_id').val(row.acptId);
					$('#facility_acpt_pw').val(row.acptPw);
					$('#facility_rtsp_url').val(row.rtspUrl);
				}*/
				
				if(row.facilityType != 'CCTV') $('.facility_hidden').hide();
				else $('.facility_hidden').show();
				
				$('#facilityM_management').hide();
				$('#facilityM_dtl_management').show();
			}
		});
	}
	else {
		$.messager.alert("경고", "리스트가 선택되지 않았습니다.",'warning');	
	}
}
function search_facility_center_propos(a,b){
	
}

/*시설물관제>시설물관리 - 상세정보:단일등록 저장*/
function inst_facility(){
	var data = get_facility_value();
	
	if(data.facilityType != 'CENTER' && data.nodeId.length == 0){
		$.messager.alert("경고", "노드아이디가 입력되지 않았습니다.",'warning');
		return;
	}
	else{
		$.post( "com/danusys/platform/insertFacilityMList.do", data)
		.done(function(json) {
			if(json.stat == "sucess"){
				search_facilityM();
				$('#facilityM_management').show();
				$('#facilityM_dtl_management').hide();
				
				init_facility();
				
				$.messager.alert("정보", "저장되었습니다.",'info');
			}else{
				$.messager.alert("에러", json.stat,'error');
			}
	 	});
	}
}
/*시설물관제>시설물관리 - 상세정보:수정*/
function modify_facility(){
	/*var data = new Object();
	data.seqNo = $('#facility_id').val();
	data.facilityType = $('#facility_type').combobox('getValue');
	data.cctvNm = $('#facility_nm').val();
	data.longitude = $('#facility_lon').val();
	data.latitude = $('#facility_lat').val();
	data.nodeId = $('#facility_node_id').val();
	data.nodeIp = $('#facility_node_ip').val();
	data.nodePort = $('#facility_node_port').val();
	data.mngCd = $('#facility_mng_cd').val();
	
	$('#facility_acpt_ip').val();
	$('#facility_acpt_port').val();
	$('#facility_acpt_id').val();
	$('#facility_acpt_pw').val();
	$('#facility_rtsp_url').val();
	
	if($('#facility_type').combobox('getValue') == 'CCTV'){
		data.purpose = $('#facility_propos').combobox('getValue');
	}
	else if($('#facility_type').combobox('getValue') == 'CENTER'){
		
	}*/
	var data = get_facility_value();
	
	$.post( "com/danusys/platform/updateFacilityMList.do", data)
	.done(function(json) {
		if(json.stat == "sucess"){
			search_facilityM();
			$('#facilityM_management').show();
			$('#facilityM_dtl_management').hide();
			
			init_facility();
			
			$.messager.alert("정보", "저장되었습니다.",'info');
		}else{
			$.messager.alert("에러", json.stat,'error');
		}
 	});
}
/*시설물관제>시설물관리 - 상세정보:삭제*/
function del_facility(){
	var data = new Object();
	data.seqNo = $('#facility_id').val();
	data.facilityType = $('#facility_type').combobox('getValue');
	
	$.post( "com/danusys/platform/deleteFacilityMList.do", data)
	.done(function( json ) {
		search_facilityM();
		$('#facilityM_management').show();
		$('#facilityM_dtl_management').hide();
		
		init_facility();
		
		$.messager.alert("정보", "삭제되었습니다.",'info');
	});
}
/*시설물관제>시설물관리 - 상세정보:목록*/
function back_facility(){
	$('#facilityM_management').show();
	$('#facilityM_dtl_management').hide();
}
/*시설물관제>시설물관리 - 상세정보:getValue*/
function get_facility_value(){
	var data = new Object();
	data.seqNo = $('#facility_id').val();
	data.facilityType = $('#facility_type').combobox('getValue');
	data.cctvNm = $('#facility_nm').val();
	data.longitude = $('#facility_lon').val();
	data.latitude = $('#facility_lat').val();
	data.nodeId = $('#facility_node_id').val();
	data.nodeIp = $('#facility_node_ip').val();
	data.nodePort = $('#facility_node_port').val();
	data.mngCd = $('#facility_mng_cd').val();
	data.purpose = $('#facility_propos').combobox('getValue');
	data.acptIp = $('#facility_acpt_ip').val();
	data.acptPort = $('#facility_acpt_port').val();
	data.acptId = $('#facility_acpt_id').val();
	data.acptPw = $('#facility_acpt_pw').val();
	data.rtspUrl = $('#facility_rtsp_url').val();
	
	return data;
}
/*시설물관제>시설물관리 - 상세정보:초기화*/
function init_facility(){
	$('#facility_id').val('');
	$('#facility_type').combobox('setValue','CCTV');
	$('#facility_propos').combobox('setValue','');
	$('#facility_nm').val('');
	$('#facility_lon').val('0');
	$('#facility_lat').val('0');
	$('#facility_node_id').val('');
	$('#facility_node_ip').val('');
	$('#facility_node_port').val('');
	$('#facility_mng_cd').val('');
	$('#facility_acpt_ip').val('');
	$('#facility_acpt_port').val('');
	$('#facility_acpt_id').val('');
	$('#facility_acpt_pw').val('');
	$('#facility_rtsp_url').val('');
	
	//임시-start
	//$('#facility_center_cd').val('');
	$('#facility_service_nm').val('');
	//$('#facility_zone').val('');
	//$('#facility_si').val('');
	$('#facility_police_zone').val('');
	$('#facility_addres').val('');
	//$('#facility_compl').val('');
	$('#facility_identi').val('');
	$('#facility_use').combobox('setValue',1);
	//$('#facility_func_type').val('');
	$('#facility_pre_state').combobox('setValue',1);
	$('#facility_pre_id').val('');
	$('#facility_center_tel').val('');
	$('#facility_bell_nm').val('');
	//$('#facility_goods_gbn').val('');
	$('#facility_mng_tel').val('');
	$('#facility_acpt_ip').val('');
	$('#facility_acpt_port').val('');
	$('#facility_acpt_id').val('');
	$('#facility_acpt_pw').val('');
	$('#facility_mac').val('');
	$('#facility_gw').val('');
	$('#facility_subnet').val('');
	$('#facility_inst_de').datebox('setValue','');
	$('#facility_server_ip').val('');
	$('#facility_server_port').val('');
	$('#facility_server_id').val('');
	$('#facility_server_pw').val('');
	$('#facility_device_ip').val('');
	$('#facility_device_port').val('');
	$('#facility_device_id').val('');
	$('#facility_device_pw').val('');
	//임시-end
	
	$('#facility_center_id').val('');
	$('#facility_center_type').combobox('setValue','');
	$('#facility_center_nm').val('');
	$('#facility_center_gbn').combobox('setValue','');
	$('#facility_center_propos').combobox('setValue','');
	$('#facility_center_place').val('');
}

/*시설물관제>시설물현황 - 조회*/
function search_facilityR(){
	$('#faciliyR_tot_table').datagrid('loadData', {"total":0,"rows":[]});
	$('#faciliyR_tot_table').datagrid('options').url = "com/danusys/platform/selectFacilityRTotList.do";
	$('#faciliyR_tot_table').datagrid('options').pageNumber = 1;
	$('#faciliyR_tot_table').datagrid('load', {
    });
	
	$('#faciliyR_type_table').datagrid('loadData', {"total":0,"rows":[]});
	$('#faciliyR_type_table').datagrid('options').url = "com/danusys/platform/selectFacilityRTypeList.do";
	$('#faciliyR_type_table').datagrid('options').pageNumber = 1;
	$('#faciliyR_type_table').datagrid('load', {
    });
}

/* 정보현황 > 통계 */
function search_statsR(){
	$('#statsR_table').datagrid('loadData', {"total":0,"rows":[]});
	$('#statsR_table').datagrid('options').url = "com/danusys/platform/selectEventStats.do";
	$('#statsR_table').datagrid('options').pageNumber = 1;
	$('#statsR_table').datagrid('load', {
		eventType: $("#search_statsR_gbn").combobox('getValue'),
		eventDe: $("#search_statsR_year").datetimespinner('getValue')
    });	
}

function refresh_es_event(){
	$.ajax({
		url : encodeURI("/com/danusys/platform/updateEsEvents.do"),
		type : "get",
		beforeSend : function() {
			$('#loading').show();
		},
		complete : function() {
			$('#loading').hide();
		},
		success : function(datas, textStatus, jQxhr) {
			search_eventM();
		},
		error : function(jqXhr, textStatus, errorThrown) {
			alert("데이터를 update하는데 실패했습니다.");
		}
	});
}