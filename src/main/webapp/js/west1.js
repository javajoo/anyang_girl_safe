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
			layerClean(eventLayer);
			popupClear();
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
	popupClear();
	var rows = $('#'+flag+'_table').datagrid('getData').rows;
	for(var i=0; i<rows.length; i++){
		var data = rows[i];
		createFeature(data);
	}	
}
/*이벤트 리스트 기준 지도 표출*/
function createFeature(data){
	var iconcls;
	var pointX;
	var pointY;
	if(eventLayer == null){
		return;;
	}
	 

	if(data.sensorConn > 0){
		pointX = data.pointX;
		pointY = data.pointY;
		//if(data.chkStatus < 1 && data.chkBat < 2 && data.emergency < 1){
		if(data.emergency < 1){
			iconcls = 'images/icons/woman_nor.png';
		}
		else{
			iconcls = 'images/icons/woman_emr.png';
			setEmergencyControl(data);
		}
	}
	else{
		pointX = data.mPointX;
		pointY = data.mPointY;
		
			//if(data.chkStatus < 1 && data.chkBat < 2 && data.emergency < 1){
			if(data.emergency < 1){
				iconcls = 'images/icons/woman_nor.png';
			}
			else{
				iconcls = 'images/icons/woman_emr.png';
				setEmergencyControl(data);
			}
		
	}

	
	if(pointY > 0){
		var feature = new OpenLayers.Feature.Vector(
	            new OpenLayers.Geometry.Point(pointX,pointY).transform(projectionGroup["grs80"], projectionGroup["google"]),
	            {sensorId:data.sensorId, name:data.name, age:data.age, gpsX:pointX, gpsY:pointY, 
	            	phoneNumber: data.phoneNumber, sPhoneNumber: data.sPhoneNumber, address: data.address, status: data.status,
	            	bat: data.bat, emergency: data.emergency
	            } ,
	            {externalGraphic: iconcls, graphicHeight: 30, graphicWidth: 30, graphicXOffset:-15, graphicYOffset:-15}
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

function popupClear() {
    //alert('number of popups '+map.popups.length);
    while( map.popups.length ) {
         map.removePopup(map.popups[0]);
    }
}

/*리스트 클릭 시-= 지도아이콘 표출*/
function selectEeventMGIS(row, data){
	var pointX;
	var pointY;
	layerClean(selectedImageLayer);
	if(data.sensorConn > 0){
		pointX = data.pointX;
		pointY = data.pointY;
	}
	else{
		pointX = data.mPointX;
		pointY = data.mPointY;
	}
	if(pointY > 0){
		var feature = new OpenLayers.Feature.Vector(
		        new OpenLayers.Geometry.Point(pointX,pointY).transform(projectionGroup["grs80"], projectionGroup["google"]),
		        {} ,
		        {externalGraphic: 'images/icons/selected.png', graphicHeight: 32, graphicWidth: 32, graphicXOffset:-16, graphicYOffset:-16  }
		    );
		selectedImageLayer.addFeatures(feature);
		
		map.setCenter(new OpenLayers.LonLat(pointX,pointY).transform(new OpenLayers.Projection("EPSG:4326"),new OpenLayers.Projection("EPSG:900913")));
	}
	//else $.messager.alert("경고", "좌표값이 없습니다.",'warning');
}

function setEmergencyPopup(data) {
	
	var name = data.name;
	var age = data.age;
	var phoneNumber = data.phoneNumber;
	var address = data.address;
	var sPhoneNumber = data.sPhoneNumber;
				
	var info = ""; 
	
	info += "<div class='event_popup'>";
	info += "<div id=\"popup_right_area\" class=\"popup_right_area\">";
	info += "<table class=\"event_popup_table\">";
	info += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">이름</div></td>";
	info += "<td><div class=\"event_popup_col\" id=\"event_popup_event_name\">" + name + "</div></td></tr>";
	info += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">나이</div></td>";
	info += "<td><div class=\"event_popup_col\" id=\"event_popup_event_age\">" + age + "</div></td></tr>";
	info += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">번호</div></td>";
	info += "<td><div class=\"event_popup_col\" id=\"event_popup_event_phoneNumber\">" + phoneNumber + "</div></td></tr>";
	info += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">주소</div></td>";
	info += "<td><div class=\"event_popup_col\" id=\"event_popup_event_address\">" + address + "</div></td></tr>";
	info += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">보호자 번호</div></td>";
	info += "<td><div class=\"event_popup_col\" id=\"event_popup_event_sPhoneNumber\">" + sPhoneNumber + "</div></td></tr>";
	info += "</table></div>";
	info += "</div>";

	return info;
}


function setEmergencyControl(data) {
		
	
	if(data.sensorConn > 0){
		pointX = data.pointX;
		pointY = data.pointY;
		
	}
	else{
		pointX = data.mPointX;
		pointY = data.mPointY;
						
	}
	
		
	// 벡터 아이콘 선택시, 선택된 feature를 인자로 받음
		var centerLonlat = new OpenLayers.LonLat(pointX, pointY);
		centerLonlat.transform(new OpenLayers.Projection("EPSG:4326"),
		new OpenLayers.Projection("EPSG:900913"));
    	console.log(data);
        divId = 'eventPopup'+Math.floor(Math.random() * 100000);
        // 팝업생성
        eventPopup = new OpenLayers.Popup.FramedCloud("chicken", 
        		centerLonlat,
            new OpenLayers.Size(405,330), setEmergencyPopup(data),
            null, true);
        eventPopup.autoSize=true;
        // 맵에 팝업 추가
        map.addPopup(eventPopup);
        
        return true;

 
};