<!-- 이벤트내역 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="" title="" style="height:100%; width:100%">
		<ul class="list_condi">
			<li class="list">
				<em>검색조건 : </em>
				<select id="user_flag_box" class="easyui-combobox" style="width: 80px; height: 27px;">
				</select>
				<div class="list_cont">
					<input type="text" id="search_eventR_tot" class="easyui-textbox" style="width:200px;" onkeypress="if(event.keyCode==13){reload();}"/>
					<a href="#" id="search_eventR" class="eventR_button_list" onclick="reload()">조회</a>
				</div>
			</li>
		</ul>
		
		<ul class="list_ty" style="height:calc(100% - 129px);">
			<li class="table_title">
				<em>조회결과</em>
			</li>
			<li>
				<table id="userEmergencyList_table" data-options="onClickRow:selectEeventMGIS">
				</table>
			</li>
		</ul>
	</div>
</div>

<script>

$(document).ready(function(){
	$('#user_flag_box').combobox({
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
	    	label: '주소',
	    	value: 'adres'
	    },
	    {
	    	label: '번호',
	    	value: 'phon'
	    }]
	});
	
	reload();
});

function reload(){
	const jsonObj = {};
	jsonObj.searchType = $("#user_flag_box").combobox('getValue');
	jsonObj.totSearch = $("#search_eventR_tot").val();
	jsonObj.emergency = '1';
	$('#userEmergencyList_table').datagrid({
	    url:'/selectList/girlSafe.getUserList/action.do',
	    pagination:true,
	    pageSize:10,
	    scrollOnSelect:false,
	    queryParams : {
	    	pageSize:10,
			param : JSON.stringify(jsonObj),
			state: '0',
	    },
	    columns:[[
  	        {field:'num',title:'No',width:30,align:'center'},
			{field:'name',title:'이름',width:60,align:'center'},
			{field:'birthAge',title:'생년월일(나이)',width:100,align:'center'},
			{field:'phoneNumber',title:'번호',width:60,align:'center'},
			{field:'address',title:'주소',width:100,align:'center'},
			{field:'sensorId',title:'단말기번호',width:70,align:'center'}
	    ]],
	    onLoadSuccess:function(data){
			if(data.rows=='sessionOut'){
				sCnt++;
				if(sCnt == 1){
					alert('세션아웃 됐습니다.');
					//location.href="/";
					closeWindow();
				}
			}
		}
	});
}

</script>
