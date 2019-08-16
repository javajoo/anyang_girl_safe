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
			for(var i=0; i<data.length; i++){
				var result = data[i];
				createMarker(result);
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

/*이벤트 리스트 기준 지도 표출*/
function createMarker(data){
	var iconcls;
	var pointX;
	var pointY;
	/*if(eventLayer == null){
		return;;
	}*/
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
	
	if(pointY > 0){
		var imageSrc = iconcls, // 마커이미지의 주소입니다    
	    imageSize = new kakao.maps.Size(30, 30), // 마커이미지의 크기입니다
	    imageOption = {}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	      
		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
		    markerPosition = new kakao.maps.LatLng(pointY, pointX); // 마커가 표시될 위치입니다
	
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition, 
		    image: markerImage, // 마커이미지 설정
		    Title: data.name
		});
		var dataMarker = {
			marker : marker,
			data : data
		}
		//마커를 클릭했을 때 커스텀 오버레이를 표시합니다
		kakao.maps.event.addListener(marker, 'click', function() {
			closePopupOverlay();
			map.relayout();
			map.setLevel(5);
			//마커 위에 커스텀오버레이를 표시합니다
			//마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
			openMarkerListPopup(marker, dataMarker);
			var lng = markerPosition.getLng();
			var	lat = markerPosition.getLat();
			map.setCenter(new kakao.maps.LatLng(lat + 0.008, lng));
		});
		mapMarkers.push(dataMarker);
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
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
	if(selectedMarker) selectedMarker.setMap(null);
	
	var pointX;
	var pointY;
	if(data.sensorConn > 0){
		pointX = data.pointX;
		pointY = data.pointY;
	}
	else{
		pointX = data.mPointX;
		pointY = data.mPointY;
	}
	map.setLevel(5);
	
	if(data.pointX == null) return;
	
	map.setCenter(new kakao.maps.LatLng(data.pointY, data.pointX));
	
	var imageSrc  = 'images/icons/selected.png';
	var imageSize = new kakao.maps.Size(30, 30);
	var imageOption = {};
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
	selectedMarker = new kakao.maps.Marker({
	    position: map.getCenter(), 
	    image: markerImage
	});
	
	selectedMarker.setMap(map);
}


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
        mapChange();
        reloadEmergencyList();
        closePopupOverlay();
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