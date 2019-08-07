
var mapMarkers = [];
var facilityMarkers = [];
var numMarkers = [];
var clusterer = new kakao.maps.MarkerClusterer();
var clusterer1 = new kakao.maps.MarkerClusterer();
var clusterer2 = new kakao.maps.MarkerClusterer();
var clusterer3 = new kakao.maps.MarkerClusterer();
var clusterer4 = new kakao.maps.MarkerClusterer();
var clusterer5 = new kakao.maps.MarkerClusterer();
var clusterer6 = new kakao.maps.MarkerClusterer();
var clusterer7 = new kakao.maps.MarkerClusterer();
var clusterer8 = new kakao.maps.MarkerClusterer();
var clusterer9 = new kakao.maps.MarkerClusterer();
var clusterer10 = new kakao.maps.MarkerClusterer();
var clusterer11 = new kakao.maps.MarkerClusterer();
var clusterer12 = new kakao.maps.MarkerClusterer();
var clusterer13 = new kakao.maps.MarkerClusterer();
var clusterer14 = new kakao.maps.MarkerClusterer();
var clusterer15 = new kakao.maps.MarkerClusterer();
var customOverlay = new kakao.maps.CustomOverlay();
var selectedCctvData;
var selectedCctvDatas = [];
var selectedMarker;
var nearFacilityList = [];
var selectedMarkerOverlay;
var pointedMarkerOverlaies = [];

function getMarker(data) {
	for (var i in mapMarkers) {
		if (mapMarkers[i].marker.getTitle() == data.phoneNumber) {
			return mapMarkers[i];
		}
	}
	
	return null;
}

function setMapMarker(map) {
	setMapMarkers(map);
}
function setMapMarkers(map) {
	for (var i = 0; i < mapMarkers.length; i++) {
		mapMarkers[i].marker.setMap(map);
	}
}

function setFacilityMarker(map) {
	setMapFacilityMarkers(map);
}

function setMapFacilityMarkers(map) {
	for (var i = 0; i < facilityMarkers.length; i++) {
		facilityMarkers[i].setMap(map);
	}
	facilityMarkers = [];
}

function setNumMarker(map) {
	setMapNumMarkers(map);
}
function setMapNumMarkers(map) {
	for (var i = 0; i < numMarkers.length; i++) {
		numMarkers[i].setMap(map);
	}
	numMarkers = [];
}

function setPopup(map) {
	if (popupOverlay) {
		popupOverlay.setMap(map);
	}
}

function mapEventClear() {
	setMapMarker(null);	//마커 클리어
	//setFacilityMarker(null);	//마커 클리어
	//setNumMarker(null);
	clusterer.clear();	//클러스터 클리어
	for(var i=1; i<=15; i++) {
		eval("clusterer"+i).clear();	//클러스터 클리어
	}
	
	closeOverlay();		//오버레이 클리어
	//$('.gis_cctv5_popup:parent').remove();
	//$('.gis_cctv9_popup:parent').remove();
}

//마커에 클릭이벤트 : cctv 영역 표출
function makeClickListener(map, marker, size, data, type) {
	return function() {
		if (popupOverlay) {
			popupOverlay.setMap(null);
		}
		
		if(type != 'P' || type != 'E') {
			setSelectedMarkerImage(data);
		}
		
		if (type != 'P' && type != 'ERF') {
			getNearFacility(data.lat, data.lon, type);
		}
		
		popupOverlay = createPopupOverlay(marker, data, type);
		
		if (type == 'F') {
			createFacilityMarker(data);
			openCctv(data.lat,data.lon);
			setCctvInfo(data);
			getSiteList(data.lat, data.lon);
	    	oVmsSC.facility(data);
		} else if(type.indexOf('api_') > -1) {
			//아무것도 안뜨게
		} else if(type == 'P') {
			createFacilityMarker(data);
		} else if(type == 'ER') {
			openCctv(data.lat, data.lon, 5, 'none');
			data.layer='#cctv5';
			oVmsSC.hist(data);
		} else if(type == 'C' || type == 'EF') {
			openCctv(data.lat, data.lon, size);
			data.layer = '#cctv5';
			oVmsSC.cast(data);
		} else if(type == 'E') {
			openCctv(data.lat, data.lon, size);
			data.layer = '#cctv5';
			oVmsSC.castPreset(data);
		}
	};
}

//인포윈도우를 표시하는 클로저를 만드는 함수입니다
function makeOverListener(map, marker, infowindow) {
	return function() {
		infowindow.open(map, marker);
	};
}

// 인포윈도우를 닫는 클로저를 만드는 함수입니다
function makeOutListener(infowindow) {
	return function() {
		infowindow.close();
	};
}

function addSelectedCctvData(data) {
	for (var i in selectedCctvDatas) {
		if (selectedCctvDatas[i].ch == data.ch) {
			selectedCctvDatas[i] = data;
			return true;
		}
	}
	
	return false;
}

function setCctvArea(lat, lon, num) {
	setFacilityMarker(null);
	console.log("cctv area : "+num);
	var data = selectedCctvData;
	data.layer = '#cctv5';
	data.ch = num;
	if (!addSelectedCctvData(data)) {
		selectedCctvDatas.push(data);
	}
	//runCctvCast(row);
	if ($('#cctv5').is(':visible') == false) {
		openCctv(lat, lon, 5);
	}
	oVmsSC.select(data);
	setTimeout(function() {
		createSelectCctvMarkers();
	}, 200);
	
	//oVmsAX.disconnectVideoStream();
	/*setTimeout(function() {
		var oInfo = new Object();
		oInfo.nodeId = selectedCctvData.nodeId;
		oInfo.nodeIp = selectedCctvData.nodeIp;
		oInfo.nodePort = selectedCctvData.nodePort;

		oInfo.cctvNm = selectedCctvData.fcltNm;
		oInfo.cctvNum = 5;
		oInfo.encryptLongitude = selectedCctvData.lon;
		oInfo.encryptLatitude = selectedCctvData.lat;
		oInfo.svrIp = selectedCctvData.vmsSvrIp;
		if(oInfo.svrIp==null){oInfo.svrIp = "10.1.3.111";}
		
		var elapsedSec = (typeof oInfo.eventDe != 'undefined') ? oVmsView.elapsedToSec(oVmsView.timeStampToDate(oInfo.eventDe)) : 0;
		oInfo.isRealtime = (!oInfo.isEvent) || (elapsedSec < 60);
		console.log('===== viewCameras >>>> oEventInfo.isRealtime : ',oInfo.isRealtime);
		oVmsView.setCamera(oInfo, selectedCctvData, num);
	}, 300);*/
}

//마커에 클릭이벤트 : cctv 선택 숫자 표출
function makeClickNumber5Listener(map, marker, size, data, type) {
	return function() {
		if (popupOverlay) {
			popupOverlay.setMap(null);
		}
		setSelectedMarkerImage(data);
		popupOverlay = createPopupOverlay(marker, data, type);
		openCctvSitePopup(data.lat, data.lon);
	};
}

function setCircularCctv(num, id, name) {
	if($('#circularS_dtl_management').css('display') == "none") {
		return;
	}
	
	$('#circular_cctv_'+num).val(id);
	$('#circular_cctv_name_'+num).val(name);
}

//마커에 클릭이벤트 : cctv 선택 숫자 표출
function makeClickNumber9Listener(map, marker, data, type) {
	return function() {
		/*if (customOverlay) {
			customOverlay.setMap(null);
		}
		
		var iwContent = '<div class="gis_cctv9_popup">' +
		'<div class="cctv_number_area">' +
		'<div class="cctv_number_area_close" onclick="closeOverlay()" title="닫기"></div>'+
		'<a class="cctv_number_1" href="javascript:setCircularCctv(1,'+fcltId+')">1</a>'+
		'<a class="cctv_number_2" href="javascript:setCircularCctv(2,'+fcltId+')">2</a>'+
		'<a class="cctv_number_3" href="javascript:setCircularCctv(3,'+fcltId+')">3</a>'+
		'<a class="cctv_number_4" href="javascript:setCircularCctv(4,'+fcltId+')">4</a>'+
		'<a class="cctv_number_5" href="javascript:setCircularCctv(5,'+fcltId+')">5</a>'+
		'<a class="cctv_number_6" href="javascript:setCircularCctv(6,'+fcltId+')">6</a>'+
		'<a class="cctv_number_7" href="javascript:setCircularCctv(7,'+fcltId+')">7</a>'+
		'<a class="cctv_number_8" href="javascript:setCircularCctv(8,'+fcltId+')">8</a>'+
		'<a class="cctv_number_9" href="javascript:setCircularCctv(9,'+fcltId+')">9</a>'+
		'</div>'+
		'</div>';
		
		customOverlay = new kakao.maps.CustomOverlay({
			//map: map,
			position: marker.getPosition(),
			content: iwContent,
			yAnchor: 1
		});

		customOverlay.setMap(map);*/
		
		setSelectedMarkerImage(data);
		
		if (popupOverlay) {
			popupOverlay.setMap(null);
		}
		popupOverlay = createPopupOverlay(marker, data, type);
	};
}
//커스텀 오버레이 닫기
function closeOverlay() {
	customOverlay.setMap(null);
	//$('.gis_cctv5_popup:parent').remove();
	//$('.gis_cctv9_popup:parent').remove();
}

//가까운 CCTV 5개 보이기

function getNearFacility(lat, lon, type) {
	console.log(type);
	if (type == 'E') {
		const jsonObj = {};
		jsonObj.lat = lat;
		jsonObj.lon = lon;
		$.ajax({
			type       : "POST",
			url        : "/select/facility.selectFacilityList/action.do",
			dataType   : "json",
			data       : {
				"param" : JSON.stringify(jsonObj)
			},
			async      : false
		}).done(function(data) {
			console.log(data);
			setFacilityMarker(null);	//마커 클리어
			setNumMarker(null);
			facilities = data;

			setEventFacilityMarkers(data, type);
			selectCctvPreset(lat, lon);
		});
	} else if (type == 'ER') {
		const jsonObj = {};
		jsonObj.lat = lat;
		jsonObj.lon = lon;
		$.ajax({
			type       : "POST",
			url        : "/select/facility.selectFacilityList/action.do",
			dataType   : "json",
			data       : {
				"param" : JSON.stringify(jsonObj)
			},
			async      : false
		}).done(function(data) {
			console.log(data);
			setFacilityMarker(null);	//마커 클리어
			setNumMarker(null);
			facilities = data;

			setEventLogFacilityMarkers(data, type);
		});
	} else {
		const jsonObj = {};
		jsonObj.lat = lat;
		jsonObj.lon = lon;
		$.ajax({
			type       : "POST",
			url        : "/select/facility.selectFacilityList/action.do",
			dataType   : "json",
			data       : {
				"param" : JSON.stringify(jsonObj)
			},
			async      : false
		}).done(function(data) {
			setFacilityMarker(null);	//마커 클리어
			setNumMarker(null);
			facilities = data;
			
			if (type == 'EF' || type == 'ER') {
				setEventFacilityMarkers(data, type);
			} else if (type =='C') {
				setFacilityNumMarkers(data);
			}
		});
	}
}

function changePresetNo(presetNo) {
	if (presetNo > 10) {
		var minusVal = Math.floor(presetNo / 10) * 10;
		presetNo = presetNo - 20;
	}
	return presetNo;
}

function movePreset(data) {
	// 4초 뒤 해당 프리셋으로 이동
	setTimeout(function() {
		var presetNo = parseInt(data.presetNo);
		if (presetNo < 10) {
			document.AthenaMidClient.DAS_Rtsp_PresetMove(data.nodeId, data.pan, data.tilt, data.zoom, data.focus, 60, data.vmsSvrIp);
		} else {
			document.AthenaMidClient.DAS_Rtsp_CamPresetMove(data.vmsSvrIp, data.nodeId, presetNo, 60);
		}
	}, 4000);
}

function setMarkerImage(marker, imageSrc) {
	var imageSize = new kakao.maps.Size(30, 30) // 마커이미지의 크기입니다
	var imageOption = {}; // 마커이미지의 옵션입니다.
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
	
	marker.setImage(markerImage);
}

function clearSelectedMarkerImage() {
	if (selectedMarkerOverlay) {
		selectedMarkerOverlay.setMap(null);
	}
}

function setSelectedMarkerImage(data, marker) {
	if (data) {
		clearSelectedMarkerImage();
		
		selectedMarkerOverlay = new kakao.maps.CustomOverlay({
		    content: '<div class="selected_overlay"></div>',
		    position: new kakao.maps.LatLng(data.lat, data.lon),
		    xAnchor: 0.5,
		    yAnchor: 0.75,
		    zIndex: 0
		});
		
		selectedMarkerOverlay.setMap(map);
	}
}

function clearPointedMarkerImage() {
	for (var i in pointedMarkerOverlaies) {
		if (pointedMarkerOverlaies[i]) {
			pointedMarkerOverlaies[i].setMap(null);
		}
	}
	pointedMarkerOverlaies = [];
}

function setPointedMarkerImage(data) {
	if (data) {
		clearPointedMarkerImage();
		
		for (var i in data) {
			var pointedMarkerOverlay = new kakao.maps.CustomOverlay({
			    content: '<div class="pointed_overlay" id="' + data[i].nodeId + '"></div>',
			    position: new kakao.maps.LatLng(data[i].lat, data[i].lon),
			    xAnchor: 0.5,
			    yAnchor: 0.75,
			    zIndex: 0
			});
			
			pointedMarkerOverlay.setMap(map);
			pointedMarkerOverlaies.push(pointedMarkerOverlay);
		}
	}
}

function hidePointedMarkerImage(id) {
	for (var i in pointedMarkerOverlaies) {
		var content = pointedMarkerOverlaies[i].getContent();
		if (content.indexOf(id) > 0) {
			pointedMarkerOverlaies[i].setMap(null);
		} else {
			pointedMarkerOverlaies[i].setMap(map);
		}
	}
}

function getFacility(fcltId) {
	for (var i in facilities) {
		if (fcltId == facilities[i].fcltId) {
			return facilities[i];
		}
	}
}

function getFacilityMarker(fcltId) {
	for (var i in facilityMarkers) {
		var markerTitle = facilityMarkers[i].getTitle();
		if (markerTitle == fcltId) {
			return facilityMarkers[i];
		}
	}
}

function checkCctvPreset(datas) {
	for (var i in facilityMarkers) {
		var markerTitle = facilityMarkers[i].getTitle();
		for (var j in datas) {
			var fcltId = datas[j].fcltId;
			if (markerTitle == fcltId) {
				var data = getFacility(fcltId);
				var presetNo = changePresetNo(datas[j].presetNo);
				var imageSrc = '../../images/icons/cctv_' + data.fcltPurposeCd + '_' + presetNo + '.png';
				setMarkerImage(facilityMarkers[i], imageSrc);
				data.presetNo = datas[j].presetNo;
				data.pan = datas[j].pan;
				data.tilt = datas[j].tilt;
				data.zoom = datas[j].zoom;
				data.focus = datas[j].focus;
				// preset move
				movePreset(data);
				break;
			}
		}
	}
}

function selectCctvPreset(lat, lon) {
	var selectRowId = [];
	for(var i=0; i<facilities.length; i++) {
		selectRowId.push(facilities[i].fcltId);
	}
	
	const jsonObj = {};
	jsonObj.selectRowId = selectRowId;
	jsonObj.lat = lat;
	jsonObj.lon = lon;
	$.ajax({
		type       : "POST",
		url        : "/select/facility.selectFacilityEPresetList/action.do",
		dataType   : "json",
		data       : {
			"param" : JSON.stringify(jsonObj)
		},
		async      : false
	}).done(function(data) {
		checkCctvPreset(data);
	});
}

function setEventFacilityMarkers(data, type) {
	var positions = [];
	for(var i=0; i<data.length; i++) {
		var presetNo = changePresetNo(data[i].presetNo);
		var imageSrc = '../../images/icons/cctv_1_0.png';
		if (presetNo == null || presetNo == '' || presetNo == 'null') {
			imageSrc = '../../images/icons/cctv_' + data[i].fcltPurposeCd + '_0.png';
		} else {
			imageSrc = '../../images/icons/cctv_' + data[i].fcltPurposeCd + '_' + presetNo +'.png';
		}
		positions.push({content: data[i].fcltNm, title: data[i].fcltId, imageSrc: imageSrc, latlng: new kakao.maps.LatLng(data[i].lat, data[i].lon)});
	}
	
	for (var i = 0; i < positions.length; i ++) {
		var imageSrc  = positions[i].imageSrc; // 마커이미지의 주소입니다
		var imageSize = new kakao.maps.Size(30, 30) // 마커이미지의 크기입니다
		var imageOption = {}; // 마커이미지의 옵션입니다.
		
		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
		
		var marker = new kakao.maps.Marker({		// 마커를 생성합니다
			map: map, // 마커를 표시할 지도
			position: positions[i].latlng, // 마커의 위치
			image: markerImage,	// 마커이미지 설정
			clickable: true,
			zIndex: 2,
			title: positions[i].title
		});
		
		facilityMarkers.push(marker);
		
		var imageNum = i + 1;
		var offsetImageSrc  = '../../images/icons/' + imageNum + '.png'; // 마커이미지의 주소입니다
		offsetImageSize = new kakao.maps.Size(18, 18), // 마커이미지의 크기입니다
		offsetImageOption = {offset: new kakao.maps.Point(8, 45)}; // 마커이미지의 옵션입니다.
		
		var numMarkerImage = new kakao.maps.MarkerImage(offsetImageSrc, offsetImageSize, offsetImageOption);
		
		var numMarker = new kakao.maps.Marker({		// 마커를 생성합니다
			map: map, // 마커를 표시할 지도
			position: positions[i].latlng, // 마커의 위치
			image: numMarkerImage,	// 마커이미지 설정
			zIndex: 1,
			clickable: false
		});
		
		numMarkers.push(numMarker);
     
		kakao.maps.event.addListener(marker, 'click', makeClickListener(map, marker, 5, data[i], 'EF'));
	}
	
	setPointedMarkerImage(data);
}

function setEventLogFacilityMarkers(data, type) {
	var positions = [];
	for(var i=0; i<data.length; i++) {
		var presetNo = changePresetNo(data[i].presetNo);
		var imageSrc = '../../images/icons/cctv_1_0.png';
		if (presetNo == null || presetNo == '' || presetNo == 'null') {
			imageSrc = '../../images/icons/cctv_' + data[i].fcltPurposeCd + '_0.png';
		} else {
			imageSrc = '../../images/icons/cctv_' + data[i].fcltPurposeCd + '_' + presetNo +'.png';
		}
		positions.push({content: data[i].fcltNm, title: data[i].fcltId, imageSrc: imageSrc, latlng: new kakao.maps.LatLng(data[i].lat, data[i].lon)});
	}
	
	for (var i = 0; i < positions.length; i ++) {
		var imageSrc  = positions[i].imageSrc; // 마커이미지의 주소입니다
		var imageSize = new kakao.maps.Size(30, 30) // 마커이미지의 크기입니다
		var imageOption = {}; // 마커이미지의 옵션입니다.
		
		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
		
		var marker = new kakao.maps.Marker({		// 마커를 생성합니다
			map: map, // 마커를 표시할 지도
			position: positions[i].latlng, // 마커의 위치
			image: markerImage,	// 마커이미지 설정
			clickable: true,
			zIndex: 2,
			title: positions[i].title
		});
		
		facilityMarkers.push(marker);
		
		var imageNum = i + 1;
		var offsetImageSrc  = '../../images/icons/' + imageNum + '.png'; // 마커이미지의 주소입니다
		offsetImageSize = new kakao.maps.Size(18, 18), // 마커이미지의 크기입니다
		offsetImageOption = {offset: new kakao.maps.Point(8, 45)}; // 마커이미지의 옵션입니다.
		
		var numMarkerImage = new kakao.maps.MarkerImage(offsetImageSrc, offsetImageSize, offsetImageOption);
		
		var numMarker = new kakao.maps.Marker({		// 마커를 생성합니다
			map: map, // 마커를 표시할 지도
			position: positions[i].latlng, // 마커의 위치
			image: numMarkerImage,	// 마커이미지 설정
			zIndex: 1,
			clickable: false
		});
		
		numMarkers.push(numMarker);
     
		kakao.maps.event.addListener(marker, 'click', makeClickListener(map, marker, 5, data[i], 'ERF'));
	}
	
	setPointedMarkerImage(data);
}

function setFacilityNumMarkers(data) {
	var positions = [];
	for(var i=0; i<data.length; i++) {
		positions.push({content: data[i].fcltN, title: data[i].fcltId, fcltPurposeCd: data[i].fcltPurposeCd, latlng: new kakao.maps.LatLng(data[i].lat, data[i].lon)});
	}
	
	/*var imageSrc  = '../../images/icons/cctv_red_5.png'; // 마커이미지의 주소입니다
	var imageSize = new kakao.maps.Size(25, 25); // 마커이미지의 크기입니다
	var imageOption = {}; // 마커이미지의 옵션입니다.
	
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);*/
	
	for (var i = 0; i < positions.length; i ++) {
		var markerImage = getPurposeMarkerImage(positions[i].fcltPurposeCd);
		
		// marker 번호 표시
		var imageNum = i + 1;
		var offsetImageSrc  = '../../images/icons/' + imageNum + '.png'; // 마커이미지의 주소입니다
		offsetImageSize = new kakao.maps.Size(18, 18), // 마커이미지의 크기입니다
		offsetImageOption = {offset: new kakao.maps.Point(8, 45)}; // 마커이미지의 옵션입니다.
		
		var numMarkerImage = new kakao.maps.MarkerImage(offsetImageSrc, offsetImageSize, offsetImageOption);
		
		var numMarker = new kakao.maps.Marker({		// 마커를 생성합니다
			map: map, // 마커를 표시할 지도
			position: positions[i].latlng, // 마커의 위치
			image: numMarkerImage,	// 마커이미지 설정
			clickable: false,
			zIndex: 1,
			title: positions[i].title
		});
		
		numMarkers.push(numMarker);// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		
		// CCTV 아이콘 표시
		var marker = new kakao.maps.Marker({		// 마커를 생성합니다
			map: map, // 마커를 표시할 지도
			position: positions[i].latlng, // 마커의 위치
			image: markerImage,	// 마커이미지 설정
			clickable: true,
			zIndex: 2,
			title: positions[i].title
		});
		
		facilityMarkers.push(marker);
		
		kakao.maps.event.addListener(marker, 'click', makeClickListener(map, marker, 5, data[i], 'C'));
	}
	
	setPointedMarkerImage(data);
}

var cctvRange;

function drawCctvRange(data, radius) {
	if (cctvRange) {
		cctvRange.setMap(null);
	}
    cctvRange = new kakao.maps.Circle({ 
        center : new kakao.maps.LatLng(data.lat, data.lon), // 원의 중심좌표입니다
        radius: 50, // 원의 반지름입니다 m 단위 이며 선 객체를 이용해서 얻어옵니다
        strokeWeight: 3, // 선의 두께입니다
        strokeColor: '#00a0e9', // 선의 색깔입니다
        strokeOpacity: 0.1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
        strokeStyle: 'solid', // 선의 스타일입니다
        fillColor: '#00a0e9', // 채우기 색깔입니다
        fillOpacity: 0.2  // 채우기 불투명도입니다
    });
    
    var radius = Math.round(cctvRange.getRadius()), // 원의 반경 정보를 얻어옵니다
    content = getTimeHTML(radius); // 커스텀 오버레이에 표시할 반경 정보입니다

    cctvRange.setMap(map); 
}

function setApi() {
	$.ajax({
		type       : "POST",
		url        : "/select/api.getAccidentInfo/action.do",
		dataType   : "json",
		data       : {
			"param" : ""
		},
		async      : false,
	}).done(function (result) {
		var markerImage = new kakao.maps.MarkerImage(
				'../../images/icons/accident.png'
				,new kakao.maps.Size(22, 22)
				,'');
		
		$(result).map(function(i, position) {
        	var marker = new kakao.maps.Marker({
        		position : new kakao.maps.LatLng(position.lat, position.lon),
        		image: markerImage,
                clickable : true,
                data: result[i],
                map: map
            });
            kakao.maps.event.addListener(marker, 'click',  makeClickListener(map, marker, '', result[i], 'api_Accident'));
        });
	});
	
	$.ajax({
		type       : "POST",
		url        : "/select/api.getConstructionInfo/action.do",
		dataType   : "json",
		data       : {
			"param" : ""
		},
		async      : false,
	}).done(function (result) {
		var markerImage = new kakao.maps.MarkerImage(
				'../../images/icons/construction.png'
				,new kakao.maps.Size(22, 22)
				,'');
		
		$(result).map(function(i, position) {
        	var marker = new kakao.maps.Marker({
        		position : new kakao.maps.LatLng(position.lat, position.lon),
        		image: markerImage,
                clickable : true,
                data: result[i],
                map: map
            });
            kakao.maps.event.addListener(marker, 'click',  makeClickListener(map, marker, '', result[i], 'api_construction'));
        });
	});
}

function openCctvSitePopup(lat, lon) {
	$('#cctv_site_area2').show();
	setCctvSiteDisplay(1);
	
    const jsonObj = {};
    jsonObj.lat = lat;
    jsonObj.lon = lon;
    jsonObj.samePosition = true;
	jsonObj.pageKind = "manage";
    
	$.ajax({
		type       : "POST",
		url        : "/select/facility.selectFacilityList/action.do",
		dataType   : "json",
		data       : {
			"param" : JSON.stringify(jsonObj)
		},
		async      : false
	}).done(function(data) {
		$('#select_cctv_site_area').html('');
		var content = '';
		siteList = data;
		selectedCctvData = siteList[0];
		
		for (var i in siteList) {
			if (i == 0) {
				content += '<li class="cctv_site selected" onClick="setSelectCctvInfoForSiteList(' + i + ')">';
			} else {
				content += '<li class="cctv_site" onClick="setSelectCctvInfoForSiteList(' + i + ')">';
			}
			content += '<div>' + siteList[i].fcltNm + '</div>';
			content += '</li>';
		}
		
		$('#select_cctv_site_area').append(content);
		
		$('.cctv_site').click(function() {
			$('.cctv_site').removeClass('selected');
			$(this).addClass('selected');
		});
	});
}

function getPurposeMarkerImage(flag, presetNo) {
	if (typeof(presetNo) == 'undefined' || presetNo == '' || presetNo == null) {
		presetNo = 0;
	} 
	var imageSrc  = '../../images/icons/cctv_' + flag + '_' + presetNo + '.png'; // 마커이미지의 주소입니다
	imageSize = new kakao.maps.Size(30, 30), // 마커이미지의 크기입니다
	imageOption = {}; // 마커이미지의 옵션입니다.
	
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
	
	return markerImage;
}

function createFacilityMarker(data, type) {
	setFacilityMarker(null);
	
	var markerImage = getPurposeMarkerImage(data.fcltPurposeCd);
	
	var marker = new kakao.maps.Marker({		// 마커를 생성합니다
		map: map, // 마커를 표시할 지도
		position: new kakao.maps.LatLng(data.lat, data.lon), // 마커의 위치
		image: markerImage,	// 마커이미지 설정
		clickable: true,
		zIndex: 2,
		title: data.fcltId
	});
	
    var infowindow = new kakao.maps.InfoWindow({		// 마커에 표시할 인포윈도우를 생성합니다
		content: data.fcltNo // 인포윈도우에 표시할 내용
	});
    
    if (type != 'P') {
        kakao.maps.event.addListener(marker, 'click', makeClickListener(map, marker, 5, data, 'F'));
    	kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
    	kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
    }
	
	facilityMarkers.push(marker);
}