<!-- 시설물현황조회 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="hwStatus_list" class="cont_inner" title="" style="height:99%; width: 97%;">
		<ul class="list_condi_full">
			<li class="list">
				<div>
					<em>최종접속일 : </em>
					<input id="search_last_timeS" data-options="formatter:myformatter,parser:myparser,prompt:'시작일 입력'" style="width:175px;">
					&nbsp;~ 
					<input id="search_last_timeE" data-options="formatter:myformatter,parser:myparser,prompt:'종료일 입력'" style="width:175px;">
				</div>
			</li>
			<li class="list">
				<div class="list_cont">
					<em>배터리 상태 : </em>
					<select id="bat_status_box" style="width: 90px; height: 27px; display: none;">
					</select>
				</div>
				<div class="list_cont">
					<em>센서 상태 : </em>
					<select id="hw_status_box" style="width: 90px; height: 27px; display: none;">
					</select>
				</div>
				<!-- 2019.05.13 KMH 여성안심서비스 미비사항 수정(스테이션연결 상태, 센서연결 상태 추가) -->
				<div class="list_cont">
					<em>스테이션연결 상태 : </em>
					<select id="station_connect_status_box" style="width: 90px; height: 27px; display: none;">
					</select>
				</div>
				<div class="list_cont">
					<em>센서연결 상태 : </em>
					<select id="sensor_connect_status_box" style="width: 90px; height: 27px; display: none;">
					</select>
				</div>
				<div class="list_cont">
					<em>검색 조건 : </em>
					<select id="search_type_box" class="easyui-combobox" style="width: 80px; height: 27px;"></select>
					<input type="text" id="search_eventR_tot" class="easyui-textbox" style="width:200px;" onkeypress="if(event.keyCode==13){reload();}"/>
					<a href="#" id="search_eventR" class="eventR_button_list" onclick="reload()">조회</a>
					<a href="#" class="eventR_button_list" onclick="searchInit()">초기화</a>
				</div>
			</li>
		</ul>
		<ul class="list_ty_full" style="width:100%;height:200px;">
			<li class="table_title">
				<em>센서 상태 리스트</em>
			</li>
			<li>
				<table id="hwStatus_table" title="" style="width:100%;height:calc(100%-129px);" data-options="onClickRow:selectEeventMGIS">
				</table>
			</li>
			<li class="btn_list">
				<a href="#" id="excel_download_btn" class="eventR_button_list">엑셀 다운로드</a> 
				<a href="#" id="moveMap_button" class="eventR_button_list" onclick="moveMap()">지도 이동</a>
			</li>
		</ul>
	</div>
</div>
<script>
function setStationId(rows) {
	var length = rows.length;
	var maxLength = 4;
	
	for (var i = 0; i < length; i++) {
		var smartId = rows[i].smartId;
		var idLength = maxLength - smartId.length;
		for (var j = 0; j < idLength; j++) {
			smartId = '0' + smartId;
		}
		rows[i].smartId = 'SA-S' + smartId;
		$('#eventList_table').datagrid('refreshRow', i);
	}
}

function searchInit() {
	$('#search_last_timeS').datebox({
		requeired:true
	});
	$('#search_last_timeE').datebox({
		requeired:true
	});
	
	$('#search_type_box').combobox({
	    valueField:'value',
	    textField:'label',
	    data: [{
	    	label: '센서번호',
	    	value: 'sensor'
	    },
	    {
	    	label: '스테이션번호',
	    	value: 'smart',
	    	"selected":true
	    },
	    {
	    	label: '이름',
	    	value: 'name',
	    	"selected":true
	    },
	    {
	    	label: '연락처',
	    	value: 'phon'
	    },
	    {
	    	label: '주소',
	    	value: 'address'
	    }]
	});
	
	$("#bat_status_box").combobox({
		valueField:'value',
	    textField:'label',
	    data: [{
	    	label: '전체',
	    	value: ''
	    },
	    {
	    	label: '좋음',
	    	value: '0'
	    },
	    {
	    	label: '양호',
	    	value: '1'
	    },
	    {
	    	label: '나쁨',
	    	value: '2'
	    }]
	});
	
	$("#hw_status_box").combobox({
		valueField:'value',
	    textField:'label',
	    data: [{
	    	label: '전체',
	    	value: ''
	    },
	    /* 2019.05.13 KMH 여성안심서비스 미비사항 수정(센서상태 ON/OFF를 정상 비정상으로 변경) */
	    {
	    	label: '정상',
	    	value: '0'
	    },
	    {
	    	label: '비정상',
	    	value: '1'
	    }
	    /* {
	    	label: 'ON',
	    	value: '0'
	    },
	    {
	    	label: 'OFF',
	    	value: '1'
	    } */]
	});
	
	$("#station_connect_status_box").combobox({
		valueField:'value',
	    textField:'label',
	    data: [{
	    	label: '전체',
	    	value: ''
	    },
	    /* 2019.05.13 KMH 여성안심서비스 미비사항 수정(스테이션연결 상태 추가) */
	    {
	    	label: '미연결',
	    	value: '0'
	    },
	    {
	    	label: '연결',
	    	value: '1'
	    }]
	});
	
	$("#sensor_connect_status_box").combobox({
		valueField:'value',
	    textField:'label',
	    data: [{
	    	label: '전체',
	    	value: ''
	    },
	    /* 2019.05.13 KMH 여성안심서비스 미비사항 수정(센서연결 상태 추가) */
	    {
	    	label: '미연결',
	    	value: '0'
	    },
	    {
	    	label: '연결',
	    	value: '1'
	    }]
	});
	$('#search_eventR_tot').val('');
}

$(document).ready(function(){
	rankDisplay(rank);
	$('#excel_download_btn').click(function() {
		var url = "/excelDownload/girlSafe.getUserList/action.do";
		var fileName = "girlSafeSensor";
		var data ={
				lastTimeS : $("#search_last_timeS").datebox('getValue').replace(/\//g, ''),
				lastTimeE : $("#search_last_timeE").datebox('getValue').replace(/\//g, ''),
				totSearch : $("#search_eventR_tot").val(),
				searchType : $("#search_type_box").combobox('getValue'),
				batStatus : $("#bat_status_box").combobox('getValue'),
				hwStatus : $("#hw_status_box").combobox('getValue')
		};
		excelDownLoad($('#hwStatus_table'), url, fileName, data);
	});
	
	searchInit();
	
	$('.datebox-black .combo-arrow').removeClass("combo-arrow").addClass("combo-arrow_sel");
	$('.datebox').removeClass("datebox").addClass("datebox-black");
	$('.datebox-calendar-inner').parent().addClass("datebox-calendar-div");
	$('.datebox-calendar-inner').parent().parent().addClass("datebox-calendar-panel");
	
	reload();
});

function moveMap(){
	rankDisplay(rank);
	$('#west-panel').hide();
}

function setBatIcons() {
	var rows = $('#hwStatus_table').datagrid('getRows');
	var length = rows.length;
	console.log(length);
	
	for (var i = 0; i < length; i++) {
		var imgUrl = 'url(../images/icons/BAT_' + rows[i].bat + '.png)';
		var info = "<div class='grid_image_box' style='background-image:" + imgUrl +";'>"; 
		info += "</div><span class='grid_image_text_box'>" + rows[i].krBat + "</span>";
		rows[i].bat = info;
		$('#hwStatus_table').datagrid('refreshRow', i);
	}
}

function reload(){
	const jsonObj = {};
	jsonObj.lastTimeS = $("#search_last_timeS").datebox('getValue').replace(/\//g, '');
	jsonObj.lastTimeE = $("#search_last_timeE").datebox('getValue').replace(/\//g, '');
	jsonObj.totSearch = $("#search_eventR_tot").val();
	jsonObj.searchType = $("#search_type_box").combobox('getValue');
	jsonObj.batStatus = $("#bat_status_box").combobox('getValue');
	jsonObj.hwStatus = $("#hw_status_box").combobox('getValue');
	jsonObj.smartConnKr = $("#station_connect_status_box").combobox('getValue');
	jsonObj.sensorConnKr = $("#sensor_connect_status_box").combobox('getValue');
	$('#hwStatus_table').datagrid({
	    url:'/selectList/girlSafe.getUserList/action.do',
	    pagination:true,
	    pageSize:12,
	    pageNumber:1,
	    queryParams : {
	    	param : JSON.stringify(jsonObj),
			pageSize : 12,
			state: '0',
	    },
	    columns:[[
	        {field:'num',title:'No',width:'5%',align:'center'},
	        {field:'sensorId',title:'센서번호',width:'10%',align:'center'},
	        {field:'smartId',title:'스테이션번호',width:'10%',align:'center'},
	        {field:'name',title:'이름',width:'10%',align:'center'},
	        {field:'phoneNumber',title:'연락처',width:'10%',align:'center'},
	        {field:'address',title:'주소',width:'20%',align:'center'},
			{field:'updateDate',title:'최종접속체크일',width:'15%',align:'center'},
			{field:'bat',title:'배터리',width:'5%',align:'center'},
			{field:'status',title:'상태',width:'5%',align:'center'},
			{field:'smartConnKr',title:'스테이션연결',width:'5%',align:'center'},
			{field:'sensorConnKr',title:'센서연결',width:'5%',align:'center'},
			{field:'krBat',hidden:true,align:'center'}
	    ]],
	    onLoadSuccess:function(data){
	    	var rows = $('#hwStatus_table').datagrid('getRows');
			if(data.rows=='sessionOut'){
				sCnt++;
				if(sCnt == 1){
					alert('세션아웃 됐습니다.');
					//location.href="/";
					closeWindow();
				}
			}
		 	else {
				setStationId(rows);
			}
			if(data && data.total > 0) {
				setBatIcons();
				selectEeventMGIS(0, data.rows[0]);	// 발생된 이벤트 선택 및 지도 표출.
				$(this).datagrid('selectRow',0);
				createIcon("hwStatus");
			}
		}
	});	
}
</script>

