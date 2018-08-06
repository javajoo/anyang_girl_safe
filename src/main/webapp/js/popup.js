var handleEventNo;

/* 상황처리-전체조회 */
function search_pop(flag, eventNo){
	changeWidth();
	if(eventNo != null) handleEventNo = eventNo;
	else handleEventNo = null;
	
	$('#total_result').datagrid('loadData', {"total":0,"rows":[]});		//상황처리 리스트 초기화
	$('#total_result_state').datagrid('loadData', {"total":0,"rows":[]});		//상황처리 상태 리스트 초기화
	pop_disable(true);
	$('#pop_type').combobox('setValue','');
	$('#pop_rating').combobox('setValue','');
	$("#pop_dateS").datebox('setValue','');
	$("#pop_dateE").datebox('setValue','');
	$("#pop_place").val('');
	$("#pop_accept_cont").val('');
	$("#pop_lon").val('');
	$("#pop_lat").val('');
	$("#pop_alt").val('');
	$("#pop_accept_type").combobox('setValue','');
	$("#pop_info_nm").val('');
	$("#pop_event_no").val('');
	$("#pop_zone").val('');
	$("#pop_facility").val('');
	$("#pop_memo").val('');
	
	var eventType;
	var comboState;
	// var comboState = $('#pop_search_state').combobox('getValue');
	var eventDeS;
	var eventDeE;
	if(flag == 'EVENT_STATE_1'){
		eventType = $('#pop_search_type_1').combobox('getValue');
		eventDeS = $("#pop_search_timeS_1").datebox('getValue').replace(/\//g, '');
		eventDeE = $("#pop_search_timeE_1").datebox('getValue').replace(/\//g, '');
	}
	else if(flag == 'EVENT_STATE_2'){
		eventType = $('#pop_search_type_2').combobox('getValue');
		eventDeS = $("#pop_search_timeS_2").datebox('getValue').replace(/\//g, '');
		eventDeE = $("#pop_search_timeE_2").datebox('getValue').replace(/\//g, '');
	}
	else if(flag == 'EVENT_STATE_4'){
		eventType = $('#pop_search_type_3').combobox('getValue');
		eventDeS = $("#pop_search_timeS_3").datebox('getValue').replace(/\//g, '');
		eventDeE = $("#pop_search_timeE_3").datebox('getValue').replace(/\//g, '');
	}
	else {
		comboState = $('#pop_search_state').combobox('getValue');
		eventType = $('#pop_search_type_0').combobox('getValue');
		eventDeS = $("#pop_search_timeS_0").datebox('getValue').replace(/\//g, '');
		eventDeE = $("#pop_search_timeE_0").datebox('getValue').replace(/\//g, '');
	}
	$('#total_result').datagrid('options').url = "com/danusys/platform/selectEventList.do"; 
	$('#total_result').datagrid('options').pageNumber = 1;
	$('#total_result').datagrid('load', {
		pageSize:7,
		state:flag,	//탭 별 state
		eventType: eventType,
		comboState: comboState,	//콤보 박스 선택 state
		eventDeS: eventDeS,
		eventDeE: eventDeE,
		eventNo : handleEventNo
    });
	
	/*if(eventNo == null){
		search_eventM();
		//$('#eventM_table').datagrid('reload');
		console.log('이벤트 리스트 리로딩');
	}*/
}

/* 상황처리-리스트선택 */
function selectPopRow(row, data){
	$('#pop_type').combobox('setValue',data.eventType);
	$('#pop_rating').combobox('setValue',data.eventRating);
	$("#pop_dateS").datebox('setValue',data.eventDe);
	$("#pop_dateE").datebox('setValue',data.endDe);
	$("#pop_place").val(data.eventPlace);
	$("#pop_accept_cont").val(data.acceptCont);
	$("#pop_lon").val(data.longitude);
	$("#pop_lat").val(data.latitude);
	$("#pop_alt").val(data.altitude);
	$("#pop_accept_type").combobox('setValue',data.acceptType);
	$("#pop_info_nm").val(data.infoNm);
	$("#pop_event_no").val(data.eventNo);
	$("#pop_zone").val(data.zone);
	$("#pop_facility").val(data.facilityId);
	
	
	$.ajax({
		url : encodeURI("/com/danusys/platform/selectEventEtcCont.do"),
		type : "get",
		data : {
			eventNo : data.eventNo
		},
		success : function(resultData, textStatus, jQxhr) {
			$('#pop_memo').html(resultData.etcCont);
		}
	});
	
	if(data.acceptType == 'ACCEPT_TYPE_1'){	//자동 입력일 경우
		pop_disable(true);
		if(data.state == 'EVENT_STATE_1' || data.state == 'EVENT_STATE_2'){	//종료가 아닐 경우
			$("#pop_memo").attr("disabled", false);
			$("#search_pop_upd").show();
			$("#search_pop_end").show();
		}
	}
	else{	//수기 입력일 경우
		pop_disable(false);
		if(data.state == 'EVENT_STATE_4' || data.state == 'EVENT_STATE_5'){	//종료일 경우
			pop_disable(true);
		}
	}
	
	$('#total_result_state').datagrid('options').url = "com/danusys/platform/selectEventState.do"; 
	$('#total_result_state').datagrid('options').pageNumber = 1;
	$('#total_result_state').datagrid('load', {
		eventNo:data.eventNo
    });
}

/* 상황처리-신규등록버튼 클릭 */
function search_pop_new(){
	$("#total_result").datagrid('clearSelections');
	pop_disable(false);
	$("#search_pop_upd").hide();
	$("#search_pop_end").hide();
	$("#search_pop_save").show();
	var authority = $('#authority').val();
	if(authority == "P") $('#pop_type').combobox('setValue','EVENT_TYPE_3');
	else if(authority == "F") $('#pop_type').combobox('setValue','EVENT_TYPE_4');
	else if(authority == "W") $('#pop_type').combobox('setValue','EVENT_TYPE_2');
	else if(authority == "S") $('#pop_type').combobox('setValue','EVENT_TYPE_1');
	else if(authority == "C") $('#pop_type').combobox('setValue','EVENT_TYPE_7');
	else $('#pop_type').combobox('setValue','');
	$('#pop_rating').combobox('setValue',1);
	
	var date = new Date();
	var y = date.getFullYear();
    var m = zeroPad(date.getMonth()+1);
    var d = zeroPad(date.getDate());
    var h = zeroPad(date.getHours());
    var mi = zeroPad(date.getMinutes());
    var se = zeroPad(date.getSeconds());
	
	$("#pop_dateS").datebox('setValue',y+'-'+m+'-'+d+' '+h+':'+mi+':'+se);
	$("#pop_dateE").datebox('setValue','');
	$("#pop_place").val('');
	$("#pop_accept_cont").val('');
	$("#pop_lon").val('');
	$("#pop_lat").val('');
	$("#pop_alt").val('');
	$("#pop_accept_type").combobox('setValue','ACCEPT_TYPE_2');
	$("#pop_accept_type").combobox('disable');
	$("#pop_info_nm").val('');
	$("#pop_event_no").val('');
	$("#pop_zone").val('');
	$("#pop_facility").val('');
	$('#memo').hide();
}

function pop_data(){
	var data = new Object();
	$.ajax({
		url: encodeURI("http://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=ko&address=부산시 강서구 "+$("#pop_place").val()),
		type: "get",
		async: false,
		data: authflag,
		success: function(datas, textStatus, jQxhr){
			data.longitude = datas.results[0].geometry.location.lng;
			data.latitude = datas.results[0].geometry.location.lat;
		}
	});
	data.eventNo = $("#pop_event_no").val();
	data.eventType = $('#pop_type').combobox('getValue');
	data.eventDe = $("#pop_dateS").datebox('getValue');
	data.eventRating = $('#pop_rating').combobox('getValue');
	data.eventPlace = $("#pop_place").val();
	data.acceptType = $("#pop_accept_type").combobox('getValue');
	data.acceptCont = $("#pop_accept_cont").val();
	data.infoNm = $("#pop_info_nm").val();
	data.zone = $("#pop_zone").val();
	data.facilityId = $("#pop_facility").val();
	data.eventCont = $("#pop_memo").val();
	
	return data;
}

/* 상황처리-신규등록 저장 */
function search_pop_save(){
	if (!nullCheck($("#pop_place").val())) {
		$.messager.alert("경고", "발생장소가 입력되지 않았습니다.",'warning');
		return false;
	}
	var data = pop_data();
	if (!nullCheck(data.eventType)) {
		$.messager.alert("경고", "이벤트 유형이 입력되지 않았습니다.",'warning');
		return false;
	}
	if (!nullCheck(data.eventNo)) {
		$.messager.alert("경고", "신고/접수번호가 입력되지 않았습니다.",'warning');
		return false;
	}
	if (!nullCheck(data.eventDe)) {
		$.messager.alert("경고", "발생일시가 입력되지 않았습니다.",'warning');
		return false;
	}
	
	var dg = $('#total_result').datagrid('getSelected');
	if(dg =! null){
		data.seqNo = dg.seqNo;
	}
	
	$.post( "com/danusys/platform/insertEvent.do", data)
	.done(function(json) {
		if(json.stat == "sucess"){
			$('#event_monitoring_handle').dialog('close');
			$('#eventM_table').datagrid('reload');
			
			setTimeout(search_event_confm(),1000);
			
			var object = new Object();
			object.encryptLongitude = data.longitude;
			object.encryptLatitude = data.latitude;
			object.isEvent = true;
			object.eventDe = data.eventDe;
			search_radius(object);
			
			setTimeout(function(){$('#eventM_table').datagrid('selectRow',0);},1000);
		}else{
			$.messager.alert("에러", json.stat,'error');
		}
 	});
}

/*중간저장, 처리완료 버튼 클릭*/
function search_pop_upd(state){
	var data = pop_data();
	data.seqNo = $('#total_result').datagrid('getSelected').seqNo;
	if(state == "upd") {	//중간저장
		data.flag = state;
		data.state = 'EVENT_STATE_2';
	}
	else {	//처리완료
		data.flag = state;
		data.state = 'EVENT_STATE_4';
	}
	var eventFlag;
	if($('.tabs-selected .tabs-title').text() == "발생") eventFlag = 'EVENT_STATE_1';
	else if($('.tabs-selected .tabs-title').text() == "처리중") eventFlag = 'EVENT_STATE_2';
	else if($('.tabs-selected .tabs-title').text() == "종료") eventFlag = 'EVENT_STATE_4';
	else eventFlag = 0;
	$.post( "com/danusys/platform/updateEvent.do", data)
	.done(function(json) {
		if(json.stat == "sucess"){
			search_pop(eventFlag,handleEventNo);
			if(handleEventNo != null) {
				$('#event_monitoring_handle').dialog('close');
				$('#eventM_table').datagrid('reload');
			}
			$.messager.alert("정보", "저장되었습니다.",'info');
		}else{
			$.messager.alert("에러", json.stat,'error');
		}
 	});
}

/* null 체크 */
function nullCheck(data) {
	if (data === null || data === undefined || data === "") return false;   	
	return true;
}

/* 상황처리 disable 처리 */
function pop_disable(flag){
	$('#memo').show();
	if(flag){
		$('#pop_type').combobox('disable');
		$('#pop_rating').combobox('disable');
		$("#pop_dateS").datebox('disable');
		$("#pop_dateE").datebox('disable');
		$("#pop_place").attr("disabled", true);
		$("#pop_accept_cont").attr("disabled", true);
		$("#pop_lon").attr("disabled", true);
		$("#pop_lat").attr("disabled", true);
		$("#pop_alt").attr("disabled", true);
		$("#pop_accept_type").combobox('disable');
		$("#pop_info_nm").attr("disabled", true);
		$("#pop_event_no").attr("disabled", true);
		$("#pop_zone").attr("disabled", true);
		$("#pop_facility").attr("disabled", true);
		$("#pop_memo").attr("disabled", true);
		$("#search_pop_upd").hide();
		$("#search_pop_end").hide();
		$("#search_pop_save").hide();
	}
	else{
		$('#pop_type').combobox('enable');
		$('#pop_rating').combobox('enable');
		$("#pop_dateS").datebox('enable');
		//$("#pop_dateE").datebox('enable');
		$("#pop_place").attr("disabled", false);
		$("#pop_accept_cont").attr("disabled", false);
		$("#pop_lon").attr("disabled", false);
		$("#pop_lat").attr("disabled", false);
		$("#pop_alt").attr("disabled", false);
		$("#pop_accept_type").combobox('enable');
		$("#pop_info_nm").attr("disabled", false);
		$("#pop_event_no").attr("disabled", false);
		$("#pop_zone").attr("disabled", false);
		$("#pop_facility").attr("disabled", false);
		$("#pop_memo").attr("disabled", false);
		$("#search_pop_upd").show();
		$("#search_pop_end").show();
		$("#search_pop_save").hide();
	}
}

function change_type(){
	var eventType = $("#pop_search_type_0").combobox('getValue');
	var url = 'com/danusys/platform/selectCode.do?codeGroup=EVENT_STATE&sysCd=Y&codeCd=' + eventType;
	if (eventType == '') {
		url = 'com/danusys/platform/selectCode.do?codeGroup=EVENT_STATE&all=Y';
	}
	$("#pop_search_state").combobox({
		url: url,
		method:'get',
		valueField:'codeCd',
		textField:'codeNm'
	})
}
