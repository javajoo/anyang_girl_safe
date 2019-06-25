/* 초기 화면  */
function search_home(id){	
	var url = "/select/girlSafe.getUserList/action.do";
	const jsonObj = {};
	var selectState = [];
	var k ='';
	k = id.split(',');
	for(var i=0;i<k.length;i++){
		selectState.push(k[i]);  
	}
	jsonObj.selectState = selectState;
	
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
	        reloadEmergencyList();
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
	if(data.selectState == 'woman_nor_'){
		pointX = data.pointX;
		pointY = data.pointY;
		iconcls = 'images/icons/woman_nor_.png';
	}
	if(data.selectState == 'woman_emr_'){
		pointX = data.pointX;
		pointY = data.pointY;
		iconcls = 'images/icons/woman_emr_.png';
	}
	if(data.selectState == 'woman_stat_dis'){
		pointX = data.mPointX;
		pointY = data.mPointY;
		iconcls = 'images/icons/woman_stat_dis.png';
	}
	if(data.selectState == 'woman_stat_emr'){
		pointX = data.mPointX;
		pointY = data.mPointY;
		iconcls = 'images/icons/woman_stat_emr.png';
	}
	if(data.selectState == 'woman_stat_nor'){
		pointX = data.mPointX;
		pointY = data.mPointY;
		iconcls = 'images/icons/woman_stat_nor.png';
	}
	
	/*
	if(data.sensorConn > 0){
		pointX = data.pointX;
		pointY = data.pointY;
		//if(data.chkStatus < 1 && data.chkBat < 2 && data.emergency < 1){
		if(data.emergency < 1){
			iconcls = 'images/icons/woman_nor_.png';
		}
		else{
			iconcls = 'images/icons/woman_emr_.png';
			setEmergencyControl(data);
		}
	}
	else{
		pointX = data.mPointX;
		pointY = data.mPointY;
		
		//if(data.chkStatus < 1 && data.chkBat < 2 && data.emergency < 1){
		if(data.emergency < 1){
			if(data.smartConn < 1){
				iconcls = 'images/icons/woman_stat_dis.png';
			}
			else{
				iconcls = 'images/icons/woman_stat_nor.png';
			}
		}
		else{
			iconcls = 'images/icons/woman_stat_emr.png';
			setEmergencyControl(data);
		}
	}*/
	
	if(pointY > 0){
		var feature = new OpenLayers.Feature.Vector(
	            new OpenLayers.Geometry.Point(pointX,pointY).transform(projectionGroup["grs80"], projectionGroup["google"]),
	            {sensorId:data.sensorId, name:data.name, birthAge:data.birthAge, gpsX:pointX, gpsY:pointY, 
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
	            {hwSerial:data.hwSerial, name:data.name, birth:data.birth, gpsX:data.pointX, gpsY:data.pointY, 
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
	var birthAge = data.birthAge;
	var phoneNumber = data.phoneNumber;
	var address = data.address;
	var sPhoneNumber = data.sPhoneNumber;
	var sensorId = data.sensorId;
				
	var info = ""; 
	
	info += "<div class='event_popup'>";
	info += "<div id=\"popup_right_area\" class=\"popup_right_area\">";
	info += "<table class=\"event_popup_table\">";
	info += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">이름</div></td>";
	info += "<td><div class=\"event_popup_col\">" + name + "</div></td></tr>";
	info += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">생년월일(나이)</div></td>";
	info += "<td><div class=\"event_popup_col\">" + birthAge + "</div></td></tr>";
	info += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">연락처</div></td>";
	info += "<td><div class=\"event_popup_col\">" + phoneNumber + "</div></td></tr>";
	info += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">주소</div></td>";
	info += "<td><div class=\"event_popup_col\">" + address + "</div></td></tr>";
	info += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">보호자 연락처</div></td>";
	info += "<td><div class=\"event_popup_col\">" + sPhoneNumber + "</div></td></tr>";
	info += "</table></div>";
	info += "<div class=\"popup_btn_area\">";
	if(rank <= 2){
	info += "<a href=\"#\" class=\"eventR_button_list\" onclick=\"updateEventEnd('" + sensorId + "')\">응급상황 종료</a>"
	}
	info += "</div>";
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
        map.setCenter(centerLonlat);
        
        return true;

 
};

function reloadEmergencyList() {
	var menu = $('#topmenu_home');
	
	if (menu.hasClass('selected')) {
		$('#userEmergencyList_table').datagrid('reload');
	}
}

function updateEventEnd(sensorId) {
	var url = "/select/girlSafe.getLastEvent/action.do";
	var no;
	
	if (typeof sensorId == 'undefined') {
		sensorId = $('#popup_sensor_id').text();
	}
	
	const jsonObj = {};
	
	jsonObj.sensorId = sensorId;
	
	$.ajax({
		type : "POST"
		, url : url
		, dataType : "json"
		, data : {"param" : JSON.stringify(jsonObj)}
		, async : false
		, success:function(data)
		{
			no = data[0].no;
		}
		, error:function(e){
			alert(e.responseText);
		}
	});
	

	const jsonArray1 = [];
	const jsonArray2 = [];
	const jsonArray3 = [];
	const jsonArray4 = [];
	
	const jsonObj1 = {};

    jsonObj1.rowStatus = "U";
	jsonObj1.no = no;
	
	const jsonObj2 = {};

    jsonObj2.rowStatus = "U";
	jsonObj2.sensorId = sensorId;
	jsonObj2.emergency = '0';
	
    jsonArray1[0] = jsonObj1;
    jsonArray2[0] = jsonObj2;

    $.ajax(
        {
            type       : "POST",
            url        : "/multiTransaction/girlSafe.updateEventEnd/girlSafe.updateEmergency/sqlid3/sqlid4/action.do",
            dataType   : "json",
            data       : {
            	"param1" : JSON.stringify(jsonArray1),
                "param2" : JSON.stringify(jsonArray2),
                "param3" : JSON.stringify(jsonArray3),
                "param4" : JSON.stringify(jsonArray4)
            },
            async      : false,
            beforeSend : function(xhr) {
                // 전송 전 Code
            }
        }).done(function (result) {
        if (result == "SUCCESS")
        {
            alert("상황종료 성공");
        }
        else
        {
            alert("상황종료 실패");
        }
        search_home();
        reloadEmergencyList();
    }).fail(function (xhr) {
        alert("상황종료 실패");
    }).always(function() {

    });
}

function getAge(dateString) {
    var today = new Date();
    var birthDate = new Date(dateString);
    var age = today.getFullYear() - birthDate.getFullYear();
   /* var m = today.getMonth() - birthDate.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
        age--;
    }*/
    return age;
}

function setBirthToAge(listTable) {
	var rows = $(listTable).datagrid('getRows');
	var length = rows.length;
	var maxLength = 4;
	
	for (var i = 0; i < length; i++) {
		var birth = rows[i].birth;
		birth = getAge(birth);
		rows[i].birth = birth;
		$(listTable).datagrid('refreshRow', i);
	}
}

function loadEditor(id){
    var instance = CKEDITOR.instances[id];
    if(CKEDITOR.instances.instance){
        CKEDITOR.instances.instance.destroy();
    }
    CKEDITOR.replace(id, {removePlugins: "wordcount"});
}

function settingMenuChange(flag) {
	$(".gnb_left li a").click(function(event){
		$(".gnb_left li a").removeClass("selected");
		$(event.target).addClass("selected");
	});
	
	if(flag == 'menu_adminSetting'){
		changeWidth("west_full");
		changeSettingPage("/include/admin_setting");	
	}
	else if(flag == 'menu_webSetting') {
		changeWidth("west_full");
		changeSettingPage("/include/web_setting");	
	}
	else if(flag == 'menu_accessLog') {
		changeSettingPage("/include/access_log");
	}
	else if(flag == 'menu_userActionLog'){
		changeSettingPage("/include/user_action_log");
	}
}
function changeSettingPage(page){
	$("#path").val(page);
	$(".gnb_left ul").children("li").removeClass("active");
	$(this).addClass("active");
    $("#menu_cont").html("");
    $("#menu_cont").load("/action/page.do", { path : page }, function() {
    	
    });
}

function rankDisplay(rank) {
	/* 2019.05.14 KMH 여성거주지 안심서비스 (등급별 변경)*/
	if(rank >= 2) {
		$('#setting_btn').hide();			//환경설정
	}
	if(rank >= 3) {
		$('#topmenu_board').hide();			//공지사항
		$('#topmenu_approvalList').hide();	//가입자 관리
		$('#topmenu_stats').hide();			//통계자료
		$('#excel_download_btn').hide(); 	//엑셀다운로드
		$('#moveMap_button').hide();		//지도이동
	}
	if(rank == 4) {
		$('#topmenu_hwStatus').hide();		//센서 상태 체크
	}
}

function excelDownLoad(table_obj, path, fileName, data) {
	var url = path;
	
	var data = data;

	var opts = $(table_obj).datagrid("getColumnFields");
	var cnt = 0;
	for (i = 0; i < opts.length; i++) {
//		var flag = $(table_obj).datagrid(
//				"getColumnOption", opts[i]).hidden;
//		if (!flag) {
			data["headerField" + cnt] = opts[i];
			data["headerText" + cnt] = $(table_obj).datagrid(
					"getColumnOption", opts[i]).title;
			cnt++;
//		}
	}
	
	data["headerCnt"] = cnt;
	data["fileName"] = fileName;
	
	$.download(url, data, "POST");
}

function setStatus() {
	const jsonObj = {};
	
	var url = "/select/girlSafe.getStatus/action.do";
	$.ajax({
		type : "POST"
		, url : url
		, dataType : "json"
		, data : {"param" : JSON.stringify(jsonObj)}
		, success:function(data) {
			$('.stat_area .status_total span').text(Number(data[0].total));
			$('.stat_area .status_2 span').text(Number(data[0].normal));
			$('.stat_area .status_1 span').text(Number(data[0].total-data[0].normal));
		}
		, error:function(e) {
			alert(e.responseText);
		}
	});
}

function openStatusPopup() {
	var page = '/popup/status_popup'; 
    $("#popup_area").html("");
    $("#popup_area").load("/action/page.do", { path : page }, function() {
    	
    });
    
    $('#popup_area').dialog({
        title: '상태정보',
        width: 765,
        /* 2019.05.13 KMH 여성안심서비스 미비사항 수정 (대시보드 수정) */
        /*height: 175,*/
        height: 200,
        closed: false,
        cache: false,
        modal: true,
		onClose: function() {
			
		}
    });
    $('#popup_area').dialog('open');
}