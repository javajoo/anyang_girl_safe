<!-- 이벤트내역 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="cont_area">
	<div id="girl_safe" title="" style="height:100%; width:100%">
		<ul class="list_condi">
			<li class="list">
				<div>
					<em>가입일 : </em>
					<input id="search_user_timeS" data-options="formatter:myformatter,parser:myparser,prompt:'시작일 입력'">
					&nbsp;~ 
					<input id="search_user_timeE" data-options="formatter:myformatter,parser:myparser,prompt:'종료일 입력'">
				</div>
			</li>
			<li class="list">
				<em>검색조건 : </em>
				<select id="user_flag_box" class="easyui-combobox" style="width: 80px; height: 27px;"></select>
				<div class="list_cont">
					<input type="text" id="search_eventR_tot" class="easyui-textbox" style="width:200px;"/>
					<a href="#" id="search_eventR" class="eventR_button_list" onclick="reload()">조회</a>
				</div>
			</li>
		</ul>
		
		<ul class="list_ty" style="height:calc(100% - 129px);">
			<li class="table_title">
				<em>조회결과</em>
				<!-- <span class="list_tot" id="search_eventR_tot" name="search_eventR_tot">0</span><label for="search_eventR_tot">건</label> -->
			</li>
			<li>
				<table id="userList_table" data-options="onClickRow:selectEeventMGIS">
				</table>
			</li>
		</ul>
	</div>
</div>

<script>

$(document).ready(function(){
	$('#search_user_timeS').datebox({
		requeired:true
	});
	$('#search_user_timeE').datebox({
		requeired:true
	});
	
	$('#user_flag_box').combobox({
	    valueField:'value',
	    textField:'label',
	    data: [{
	    	label: '이름',
	    	value: 'name',
	    	"selected":true
	    },
	    {
	    	label: '생년월일',
	    	value: 'birth'
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
	
	$('.datebox-black .combo-arrow').removeClass("combo-arrow").addClass("combo-arrow_sel");
	$('.datebox').removeClass("datebox").addClass("datebox-black");
	$('.datebox-calendar-inner').parent().addClass("datebox-calendar-div");
	$('.datebox-calendar-inner').parent().parent().addClass("datebox-calendar-panel");
	
	reload();
});

function reload(){
	const jsonObj = {};
	jsonObj.userTimeS = $("#search_user_timeS").datebox('getValue').replace(/\//g, '');
	jsonObj.userTimeE = $("#search_user_timeE").datebox('getValue').replace(/\//g, '');
	jsonObj.totSearch = $("#search_eventR_tot").val();
	jsonObj.searchType = $("#user_flag_box").combobox('getValue');
	$('#userList_table').datagrid({
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
	        {field:'num',title:'No',width:50,align:'center'},
			{field:'name',title:'이름',width:80,align:'center'},
			{field:'birth',title:'생년월일',width:70,align:'center'},
			{field:'phoneNumber',title:'번호',width:60,align:'center'},
			{field:'address',title:'주소',width:100,align:'center'},
			{field:'sensorId',title:'단말기번호',width:70,align:'center'}
	    ]],
	    onLoadSuccess:function(data){
			if($('#userList_table').datagrid('getData').rows=='sessionOut'){
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
				createIcon("userList");
			}
		}
	});
}

</script>
