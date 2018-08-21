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
					<em>검색 조건 : </em>
					<select id="search_type_box" class="easyui-combobox" style="width: 80px; height: 27px;">
					</select>
				</div>
				<div class="list_cont">
					<em>배터리 상태 : </em>
					<select id="bat_status_box" style="width: 90px; height: 27px; display: none;">
					</select>
				</div>
				<div class="list_cont">
					<em>단말기 상태 : </em>
					<select id="hw_status_box" style="width: 90px; height: 27px; display: none;">
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
				<em>단말기 상태 리스트</em>
			</li>
			<li>
				<table id="hwStatus_table" title="" style="width:100%;height:calc(100%-129px);" data-options="onClickRow:selectEeventMGIS">
				</table>
			</li>
			<li class="btn_list">
				<a href="#" id="moveMap_button" class="eventR_button_list" onclick="moveMap()">지도 이동</a>
			</li>
		</ul>
	</div>
</div>
<script>
$(document).ready(function(){
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
	    	label: '전체',
	    	value: ''
	    },
	    {
	    	label: '단말기번호',
	    	value: 'sensor'
	    },
	    {
	    	label: '이름',
	    	value: 'name'
	    },
	    {
	    	label: '번호',
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
	    	label: '정상(대)',
	    	value: '0'
	    },
	    {
	    	label: '정상(중)',
	    	value: '1'
	    },
	    {
	    	label: '교체필요',
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
	    {
	    	label: 'ON',
	    	value: '0'
	    },
	    {
	    	label: 'OFF',
	    	value: '1'
	    }]
	});
	
	reload();
});
function moveMap(){
	$('#west-panel').hide();
}
function reload(){
	const jsonObj = {};
	jsonObj.lastTimeS = $("#search_last_timeS").datebox('getValue').replace(/\//g, '');
	jsonObj.lastTimeE = $("#search_last_timeE").datebox('getValue').replace(/\//g, '');
	jsonObj.totSearch = $("#search_eventR_tot").val();
	jsonObj.searchType = $("#search_type_box").combobox('getValue');
	jsonObj.batStatus = $("#bat_status_box").combobox('getValue');
	jsonObj.hwStatus = $("#hw_status_box").combobox('getValue');
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
	        {field:'sensorId',title:'단말기번호',width:'10%',align:'center'},
	        {field:'name',title:'이름',width:'10%',align:'center'},
	        {field:'phoneNumber',title:'번호',width:'10%',align:'center'},
	        {field:'address',title:'주소',width:'35%',align:'center'},
			{field:'updateDate',title:'최종접속체크일',width:'20%',align:'center'},
			{field:'bat',title:'배터리',width:'5%',align:'center'},
			{field:'status',title:'상태',width:'5%',align:'center'}
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

