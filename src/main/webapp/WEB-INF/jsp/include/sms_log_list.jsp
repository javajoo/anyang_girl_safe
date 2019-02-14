<!-- 시설물현황조회 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="event_list" class="cont_inner" title="" style="height:99%; width: 97%;">
		<ul class="list_condi_full">
			<li class="list">
				<em>가입일 : </em>
				<input id="search_eventR_timeS" data-options="formatter:myformatter,parser:myparser,prompt:'시작일 입력'">
				&nbsp;~ 
				<input id="search_eventR_timeE" data-options="formatter:myformatter,parser:myparser,prompt:'종료일 입력'">
			</li>
			<li class="list">
				<div id="search_type_box_wrap" class="list_cont">
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
				<em>가입자 리스트</em>
			</li>
			<li>
				<table id="smsLogList_table" title="" style="width:100%;height:calc(100%-129px);">
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
	
	$('#search_type_box').combobox({
	    valueField:'value',
	    textField:'label',
	    data: [{
	    	label: '이름',
	    	value: 'name',
	    	"selected":true
	    },
	    {
	    	label: '연락처',
	    	value: 'phon'
	    }]
	});
	
	$('#search_eventR_tot').val('');
}

$(document).ready(function(){
	$('#excel_download_btn').click(function() {
		var url = "/excelDownload/girlSafe.getSmsLogList/action.do";
		var fileName = "girlSafeSmsLog";
		var data ={
				userTimeS : $("#search_eventR_timeS").datebox('getValue').replace(/\//g, ''),
				userTimeE : $("#search_eventR_timeE").datebox('getValue').replace(/\//g, ''),
				searchType : $("#search_type_box").combobox('getValue'),
				totSearch : $("#search_eventR_tot").val()
		};
		excelDownLoad($('#alarmList_table'), url, fileName, data);
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
	jsonObj.totSearch = $("#search_eventR_tot").val();
	$('#smsLogList_table').datagrid({
	    url:'/selectList/girlSafe.getSmsLogList/action.do',
	    pagination:true,
	    pageSize:12,
	    scrollOnSelect:false,
	    queryParams : {
	    	pageSize:12,
			param : JSON.stringify(jsonObj),
			state: '0',
	    },
	    columns:[[
	        {field:'num',title:'No',width:'5%',align:'center'},
			{field:'name',title:'이름',width:'15%',align:'center'},
			{field:'phoneNumber',width:'20%',title:'연락처',align:'center'},
			{field:'sName',title:'보호자이름',width:'15%',align:'center'},
			{field:'sPhoneNumber',title:'보호자연락처',width:'20%',align:'center'},
			{field:'insertDate',title:'발송일',width:'25%',align:'center'}
	    ]],
	    onLoadSuccess:function(data){
	    	
	    	var rows = $('#smsLogList_table').datagrid('getRows');
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
		}
	});
}
</script>

