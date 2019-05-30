<!-- 시설물현황조회 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="event_list" class="cont_inner" title="" style="height:99%; width: 97%;">
		<ul class="list_condi_full">
			<li class="list">
				<div>
					<em>발생 일자 : </em>
					<input id="search_event_timeS" data-options="formatter:myformatter,parser:myparser,prompt:'시작일 입력'" style="width:175px;">
					&nbsp;~ 
					<input id="search_event_timeE" data-options="formatter:myformatter,parser:myparser,prompt:'종료일 입력'" style="width:175px;">
				</div>
			</li>
			<li class="list">
				<div id="end_yn_box_wrap" class="list_cont">
					<em>종료여부 : </em>
					<select id="end_yn_box" style="width: 90px; height: 27px; display: none;">
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
				<em>이벤트 로그 리스트</em>
			</li>
			<li>
				<table id="eventList_table" title="" style="width:100%;height:calc(100%-129px);">
				</table>
			</li>
			<li class="btn_list">
				<a href="#" id="excel_download_btn" class="eventR_button_list">엑셀 다운로드</a> 
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
	$('#search_event_timeS').datebox({
		requeired:true
	});
	$('#search_event_timeE').datebox({
		requeired:true
	});
	
	$('#search_type_box').combobox({
	    valueField:'value',
	    textField:'label',
	    data: [{
	    	label: '이름',
	    	value: 'name',
	    	"selected":true
	    },
	    {
	    	label: '나이',
	    	value: 'age'
	    },
	    {
	    	label: '연락처',
	    	value: 'phon'
	    },
	    {
	    	label: '주소',
	    	value: 'adres'
	    },
	    {
	    	label: '센서번호',
	    	value: 'sensor'
	    },
	    {
	    	label: '스테이션번호',
	    	value: 'smart'
	    }
	    ]
	});
	
	$("#end_yn_box").combobox({
		valueField:'value',
	    textField:'label',
	    data: [{
	    	label: '전체',
	    	value: ''
	    },
	    {
	    	label: '발생',
	    	value: 'N'
	    },
	    {
	    	label: '종료',
	    	value: 'Y'
	    }]
	});
	
	$('#search_eventR_tot').val('');
}

$(document).ready(function(){
	rankDisplay(rank);
	$('#excel_download_btn').click(function() {
		var url = "/excelDownload/girlSafe.getEventList/action.do";
		var fileName = "girlSafeEvent";
		var data = {
				eventTimeS : $("#search_event_timeS").datebox('getValue').replace(/\//g, ''),
				eventTimeE : $("#search_event_timeE").datebox('getValue').replace(/\//g, ''),
				searchType : $("#search_type_box").combobox('getValue'),
				totSearch : $("#search_eventR_tot").val(),
				endYN : $("#end_yn_box").combobox('getValue')
		};
		excelDownLoad($('#eventList_table'), url, fileName, data);
	});
	
	searchInit();
	
	$('.datebox-black .combo-arrow').removeClass("combo-arrow").addClass("combo-arrow_sel");
	$('.datebox').removeClass("datebox").addClass("datebox-black");
	$('.datebox-calendar-inner').parent().addClass("datebox-calendar-div");
	$('.datebox-calendar-inner').parent().parent().addClass("datebox-calendar-panel");
	
	reload();
});

function reload(){
	const jsonObj = {};
	jsonObj.eventTimeS = $("#search_event_timeS").datebox('getValue').replace(/\//g, '');
	jsonObj.eventTimeE = $("#search_event_timeE").datebox('getValue').replace(/\//g, '');
	jsonObj.searchType = $("#search_type_box").combobox('getValue');
	jsonObj.totSearch = $("#search_eventR_tot").val();
	jsonObj.endYN = $("#end_yn_box").combobox('getValue');
	$('#eventList_table').datagrid({
	    url:'/selectList/girlSafe.getEventList/action.do',
	    pagination:true,
	    pageSize:12,
	    pageNumber:1,
	    fitColumns:true,
	    queryParams : {
	    	param : JSON.stringify(jsonObj),
			pageSize : 12,
			state: '0',
	    },
	    columns:[[

	  		/* 2019.05.13 KMH 여성안심서비스 미비사항 수정(이벤트 종료사유 삽입) */
	  		{field:'num',title:'No',width:'5%',align:'center'},
	        {field:'no',title:'이벤트',hidden:true},
			{field:'name',title:'이름',width:'5%',align:'center'},
			{field:'birthAge',title:'생년월일(나이)',width:'10%',align:'center'},
			{field:'phoneNumber',title:'번호',width:'10%',align:'center'},
			{field:'address',title:'주소',width:'25%',align:'center'},
			{field:'startTime',title:'발생일',width:'10%',align:'center'},
			{field:'endTime',title:'종료일',width:'10%',align:'center'},
			{field:'endYN',title:'종료여부',width:'5%',align:'center'},
			{field:'remark',title:'종료사유',width:'10%',align:'center'},
			{field:'sensorId',title:'센서번호',width:'5%',align:'center'},
			{field:'smartId',title:'스테이션번호',width:'5%',align:'center'},
			{field:'reason',title:'추가정보',hidden:true}
			
	        /* {field:'num',title:'No',width:'5%',align:'center'},
	        {field:'no',title:'이벤트',hidden:true},
			{field:'name',title:'이름',width:'5%',align:'center'},
			{field:'birthAge',title:'생년월일(나이)',width:'10%',align:'center'},
			{field:'phoneNumber',title:'번호',width:'10%',align:'center'},
			{field:'address',title:'주소',width:'25%',align:'center'},
			{field:'startTime',title:'발생일',width:'15%',align:'center'},
			{field:'endTime',title:'종료일',width:'15%',align:'center'},
			{field:'endYN',title:'종료여부',width:'5%',align:'center'},
			{field:'sensorId',title:'센서번호',width:'5%',align:'center'},
			{field:'smartId',title:'스테이션번호',width:'5%',align:'center'},
			{field:'remark',title:'종료사유',hidden:true},
			{field:'reason',title:'추가정보',hidden:true} */
	    ]],
	    onDblClickRow:function(index, row) {
	    	if(${admin.rank} <= 2){
	    		onEventDetailPopup(row);
	    	}
	    },
	    onLoadSuccess:function(data){
	    	var rows = $('#eventList_table').datagrid('getRows');
			if(data.rows=='sessionOut'){
				sCnt++;
				if(sCnt == 1){
					alert('세션아웃 됐습니다.');
					//location.href="/";
					closeWindow();
				}			
		    } else {
				setStationId(rows);
			}
			if(data && data.total > 0) {				
				selectEeventMGIS(0, data.rows[0]);	// 발생된 이벤트 선택 및 지도 표출.
				$(this).datagrid('selectRow',0);
			}
		}
	});	
}

function onEventDetailPopup(row) {
	var page = '/popup/event_popup'; 
    $("#popup_area").html("");
    $("#popup_area").load("/action/page.do", { path : page }, function() {
    	
    });

	const jsonObj = {};
    jsonObj.phoneNumber = (row.phoneNumber).replace(/-/g,"");
    jsonObj.no = row.no;

    $.ajax(
        {
            type       : "POST",
            url        : "/select/girlSafe.getEventDetail/action.do",
            dataType   : "json",
            data       : {
                "param" : JSON.stringify(jsonObj)
            },
            async      : false,
            beforeSend : function(xhr) {
                // 전송 전 Code
            }
        }).done(function (data) {
        	selectedData = data;
            $('#popup_area').dialog({
                title: '이벤트 상세 정보',
                width: 410,
                height: 450,
                closed: false,
                cache: false,
                modal: true,
        		onClose: function() {
        			selectedData = '';
        			clearPopup();
        		}
            });
            $('#popup_area').dialog('open');
    }).fail(function (xhr) {
        alert("수정 실패");
    }).always(function() {

    });
}

function clearPopup() {
	$('#user_sensor_box').val('');
	$('#user_smart_box').val('');
	$('#user_name_box').val('');
	$('#user_birth_box').val('');
	$('#user_address_box').val('');
	$('#user_phone_box').val('');
	$('#user_remark_box').val('');
	$('#user_reason_box').val('');
}
</script>

