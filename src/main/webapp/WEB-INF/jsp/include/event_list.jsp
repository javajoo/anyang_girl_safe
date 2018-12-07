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
				<div class="list_cont">
					<em>검색 조건 : </em>
					<select id="search_type_box" class="easyui-combobox" style="width: 80px; height: 27px;">
					</select>
				</div>
				<div id="end_yn_box_wrap" class="list_cont">
					<em>종료여부 : </em>
					<select id="end_yn_box" style="width: 90px; height: 27px; display: none;">
					</select>
				</div>
				<div class="list_cont2">
					<input type="text" id="search_eventR_tot" class="easyui-textbox" style="width:200px;"/>
					<a href="#" id="search_eventR" class="eventR_button_list" onclick="reload()">조회</a>
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
$(document).ready(function(){
	$('#excel_download_btn').click(function() {
		var url = "/excelDownload/girlSafe.getEventList/action.do";
		var fileName = "girlSafeEvent";
		excelDownLoad($('#eventList_table'), url, fileName);
	});
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
	    	label: '전체',
	    	value: ''
	    },
	    {
	    	label: '이름',
	    	value: 'name'
	    },
	    {
	    	label: '생년월일',
	    	value: 'age'
	    },
	    {
	    	label: '번호',
	    	value: 'phon'
	    },
	    {
	    	label: '주소',
	    	value: 'address'
	    },
	    {
	    	label: '단말기번호',
	    	value: 'sensor'
	    }]
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
	jsonObj.totSearch = $("#search_eventR_tot").val();
	jsonObj.searchType = $("#search_type_box").combobox('getValue');
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
	        {field:'num',title:'No',width:'5%',align:'center'},
			{field:'name',title:'이름',width:'10%',align:'center'},
			{field:'birth',title:'생년월일',width:'5%',align:'center'},
			{field:'phoneNumber',title:'번호',width:'10%',align:'center'},
			{field:'address',title:'주소',width:'30%',align:'center'},
			{field:'startTime',title:'발생일',width:'15%',align:'center'},
			{field:'endTime',title:'종료일',width:'15%',align:'center'},
			{field:'endYN',title:'종료여부',width:'5%',align:'center'},
			{field:'sensorId',title:'단말기번호',width:'5%',align:'center'}
	    ]],
	    onLoadSuccess:function(data){
			if($('#eventList_table').datagrid('getData').rows=='sessionOut'){
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
			}
		}
	});	
}
</script>

