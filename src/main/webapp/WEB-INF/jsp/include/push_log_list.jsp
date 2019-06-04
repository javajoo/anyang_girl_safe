<!-- 시설물현황조회 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="event_list" class="cont_inner" title="" style="height:99%; width: 97%;">
		<ul class="list_condi_full">
			<li class="list">
				<!-- 2019.05.13 KMH 여성안심서비스 미비사항 수정 (가입일을 발송일로 변경) -->
				<em>발송일 : </em>
				<!-- <em>가입일 : </em> -->
				<input id="search_eventR_timeS" data-options="formatter:myformatter,parser:myparser,prompt:'시작일 입력'">
				&nbsp;~ 
				<input id="search_eventR_timeE" data-options="formatter:myformatter,parser:myparser,prompt:'종료일 입력'">
			</li>
			<li class="list">
				<div class="list_cont">
					<em>푸시 종류 : </em>
					<select id="pushKind_box" style="width: 90px; height: 27px; display: none;">
					</select>
				</div>
				<div class="list_cont">
					<em>검색 조건 : </em>
					<select id="search_type_box" class="easyui-combobox" style="width: 90px; height: 27px;"></select>
					<input type="text" id="search_eventR_tot" class="easyui-textbox" style="width:200px;" onkeypress="if(event.keyCode==13){reload();}"/>
					<a href="#" id="search_eventR" class="eventR_button_list" onclick="reload()">조회</a>
					<a href="#" class="eventR_button_list" onclick="searchInit()">초기화</a>
				</div>
			</li>
		</ul>
		<ul class="list_ty_full" style="width:100%;height:200px;">
			<li class="table_title">
				<em>PUSH 이력 리스트</em>
			</li>
			<li>
				<table id="pushLogList_table" title="" style="width:100%;height:calc(100%-129px);">
				</table>
			</li>
			<li class="btn_list">
				<a href="#" id="excel_download_btn" class="eventR_button_list">엑셀 다운로드</a>
			</li>
		</ul>
	</div>
</div>
<script>

var selectedData;

function searchInit() {
	$('#search_eventR_timeS').datebox({
		requeired:true
	});
	$('#search_eventR_timeE').datebox({
		requeired:true
	});
	
	$('#pushKind_box').combobox({
	    valueField:'value',
	    textField:'label',
	    data: [{
	    	label: '전체',
	    	value: '',
	    	"selected":true
	    },
	    {
	    	label: '강제',
	    	value: 'P'
	    },
	    {
	    	label: '일반',
	    	value: 'N'
	    },
	    {
	    	label: '예약',
	    	value: 'R'
	    }]
	});
	
	$('#search_type_box').combobox({
	    valueField:'value',
	    textField:'label',
	    data: [{
	    	label: '전체',
	    	value: '',
	    	"selected":true
	    },
	    {
	    	label: '제목',
	    	value: 'title'
	    },
	    {
	    	label: '관리자ID',
	    	value: 'adminId'
	    },
	    {
	    	label: '관리자이름',
	    	value: 'adminName'
	    }]
	});
	
	$('#search_eventR_tot').val('');
}

$(document).ready(function(){
	rankDisplay(rank);
	$('#excel_download_btn').click(function() {
		var url = "/excelDownload/girlSafe.getPushLogList/action.do";
		var fileName = "girlSafePushLog";
		var data ={
				userTimeS : $("#search_eventR_timeS").datebox('getValue').replace(/\//g, ''),
				userTimeE : $("#search_eventR_timeE").datebox('getValue').replace(/\//g, ''),
				searchType : $("#search_type_box").combobox('getValue'),
				pushKind : $("#pushKind_box").combobox('getValue'),
				totSearch : $("#search_eventR_tot").val()
		};
		excelDownLoad($('#pushLogList_table'), url, fileName, data);
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
	jsonObj.userTimeS = $("#search_eventR_timeS").datebox('getValue').replace(/\//g, '');
	jsonObj.userTimeE = $("#search_eventR_timeE").datebox('getValue').replace(/\//g, '');
	jsonObj.searchType = $("#search_type_box").combobox('getValue');
	jsonObj.pushKind = $("#pushKind_box").combobox('getValue');
	jsonObj.totSearch = $("#search_eventR_tot").val();
	$('#pushLogList_table').datagrid({
	    url:'/selectList/girlSafe.getPushLogList/action.do',
	    pagination:true,
	    pageSize:12,
	    scrollOnSelect:false,
	    queryParams : {
	    	pageSize:12,
			param : JSON.stringify(jsonObj),
			state: '0',
	    },
	    columns:[[
			/* 2019.05.13 KMH 여성안심서비스 미비사항 수정 (그리드리스트의 크기수정 및 내용열 삭제) */
			{field:'num',title:'No',width:'5%',align:'center'},
				{field:'title',title:'제목',width:'40%',align:'center'},
				{field:'pushKind',title:'푸시종류',width:'5%',align:'center'},
				{field:'insertDate',title:'발송일',width:'20%',align:'center'},
				{field:'adminId',title:'관리자ID',width:'15%',align:'center'},
				{field:'adminName',title:'관리자이름',width:'15%',align:'center'}
			
	        /* {field:'num',title:'No',width:'5%',align:'center'},
			{field:'title',title:'제목',width:'15%',align:'center'},
			{field:'content',width:'20%',title:'내용',align:'center'},
			{field:'pushKind',title:'푸쉬종류',width:'15%',align:'center'},
			{field:'insertDate',title:'발송일',width:'20%',align:'center'} */
	    ]],
	    onLoadSuccess:function(data){
	    	
	    	var rows = $('#pushLogList_table').datagrid('getRows');
			if(data.rows=='sessionOut'){
				sCnt++;
				if(sCnt == 1){
					alert('세션아웃 됐습니다.');
					//location.href="/";
					closeWindow();
				}
			} else {
				
			}
		}
	});
}
</script>

