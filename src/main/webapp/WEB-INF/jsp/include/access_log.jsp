<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="event_list" class="cont_inner" title="" style="height:99%; width: 97%;">
		<ul class="list_condi_full">
			<li class="list">
				<em>접속일 : </em>
				<input id="search_access_timeS" data-options="formatter:myformatter,parser:myparser,prompt:'시작일 입력'">
				&nbsp;~ 
				<input id="search_access_timeE" data-options="formatter:myformatter,parser:myparser,prompt:'종료일 입력'">
			</li>
			<li class="list">
				<div class="list_cont2">
					<a href="#" id="search_eventR" class="eventR_button_list" onclick="reload()">조회</a>
				</div>
			</li>
		</ul>
		<ul class="list_ty_full" style="width:100%;height:200px;">
			<li class="table_title">
				<em>로그이력 리스트</em>
			</li>
			<li>
				<table id="accessLogList_table" title="" style="width:100%;height:calc(100%-129px);">
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
		var url = "/excelDownload/girlSafe.getAccessLogList/action.do";
		var fileName = "accessLog";
		var data ={
				timeS : $("#search_access_timeS").datebox('getValue').replace(/\//g, ''),
				timeE : $("#search_access_timeE").datebox('getValue').replace(/\//g, '')	
		};
		excelDownLoad($('#accessLogList_table'), url, fileName, data);
	});
	$('#search_access_timeS').datebox({
		requeired:true
	});
	$('#search_access_timeE').datebox({
		requeired:true
	});
	
	//$('.datebox-black .combo-arrow').removeClass("combo-arrow").addClass("combo-arrow_sel");
	//$('.datebox').removeClass("datebox").addClass("datebox-black");
	//$('.datebox-calendar-inner').parent().addClass("datebox-calendar-div");
	//$('.datebox-calendar-inner').parent().parent().addClass("datebox-calendar-panel");
	
	reload();
});

function reload(){
	const jsonObj = {};
	jsonObj.timeS = $("#search_access_timeS").datebox('getValue').replace(/\//g, '');
	jsonObj.timeE = $("#search_access_timeE").datebox('getValue').replace(/\//g, '');
	
	$('#accessLogList_table').datagrid({
	    url:'/selectList/girlSafe.getAccessLogList/action.do',
	    pagination:true,
	    pageSize:12,
	    scrollOnSelect:false,
	    queryParams : {
	    	pageSize:12,
			param : JSON.stringify(jsonObj),
	    },
	    columns:[[
	        {field:'num',title:'No',width:'5%',align:'center'},
	        {field:'id',title:'아이디',width:'15%',align:'center'},
			{field:'name',title:'이름',width:'10%',align:'center'},
			{field:'address',title:'소속',width:'20%',align:'center'},
			{field:'rank',title:'등급',width:'10%',align:'center'},
			{field:'accessS',title:'접속일시간',width:'20%',align:'center'},
			{field:'accessE',title:'종료일시간',width:'20%',align:'center'}
	    ]],
	    onLoadSuccess:function(data){
			if(data.rows=='sessionOut'){
				alert('세션아웃 됐습니다.');
				closeWindow();
			}
		}
	});
}
</script>

