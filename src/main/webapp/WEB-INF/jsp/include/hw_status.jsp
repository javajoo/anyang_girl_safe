<!-- 시설물현황조회 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="hwStatus_list" title="" style="height:99%; width: 97%;">
		<ul class="list_condi">
			<li class="list">
				<input type="text" id="search_eventR_tot" class="easyui-textbox" style="width:200px;"/>
				<a href="#" id="search_eventR" class="eventR_button_list" onclick="reload()"></a>
			</li>
			<li class="list">
				<input id="search_eventR_timeS" data-options="formatter:myformatter,parser:myparser,prompt:'시작일 입력'" style="width:175px;">
				&nbsp;~ 
				<input id="search_eventR_timeE" data-options="formatter:myformatter,parser:myparser,prompt:'종료일 입력'" style="width:175px;">
			</li>
		</ul>
		<ul class="list_ty" style="width:100%;height:200px;">
			<div class="table_title" style="margin-left: 30px;">
				<em>이벤트 로그 리스트</em>
			</div>
			<table id="hwStatus_table" title="" style="width:100%;height:calc(100%-129px);" data-options="onClickRow:selectEeventMGIS">

			</table>
			<a href="#" id="moveMap_button" class="eventR_button_list" onclick="moveMap()">지도 이동</a>
		</ul>
	</div>
</div>
<script>
$(document).ready(function(){
	$('#search_eventR_timeS').datebox({
		requeired:true
	});
	$('#search_eventR_timeE').datebox({
		requeired:true
	});
		reload();
});
function moveMap(){
	$('#west-panel').hide();
}
function reload(){
	const jsonObj = {};
	jsonObj.eventDeS = $("#search_eventR_timeS").datebox('getValue').replace(/\//g, '');
	jsonObj.eventDeE = $("#search_eventR_timeE").datebox('getValue').replace(/\//g, '');
	jsonObj.totSearch = $("#search_eventR_tot").val();
	$('#hwStatus_table').datagrid({
	    url:'/selectList/girlSafe.getUserList/action.do',
	    pagination:true,
	    pageSize:10,
	    pageNumber:1,
	    queryParams : {
	    	param : JSON.stringify(jsonObj),
			pageSize : 10,
			state: '0',
	    },
	    columns:[[
	        {field:'num',title:'No',width:50,align:'center'},
	        {field:'sensorId',title:'단말기번호',width:70,align:'center'},
	        {field:'name',title:'이름',width:80,align:'center'},
	        {field:'phoneNumber',title:'번호',width:100,align:'center'},
	        {field:'address',title:'주소',width:100,align:'center'},
			{field:'updateDate',title:'최종접속체크일',width:100,align:'center'},
			{field:'bat',title:'배터리',width:100,align:'center'},
			{field:'status',title:'상태',width:100,align:'center'}
	    ]],
	    onLoadSuccess:function(data){
			if($('#hwStatus_table').datagrid('getData').rows=='sessionOut'){
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
				createIcon("hwStatus");
			}
		}
	});	
}
</script>

