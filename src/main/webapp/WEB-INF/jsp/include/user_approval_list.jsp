<!-- 시설물현황조회 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="event_list" title="" style="height:99%; width: 97%;">
		<ul class="list_condi">
			<li class="list">
				<input id="search_eventR_timeS" data-options="formatter:myformatter,parser:myparser,prompt:'시작일 입력'" style="width:175px;">
				&nbsp;~ 
				<input id="search_eventR_timeE" data-options="formatter:myformatter,parser:myparser,prompt:'종료일 입력'" style="width:175px;">
			</li>
			<li class="list">
				<input type="text" id="search_eventR_tot" class="easyui-textbox" style="width:200px;"/>
				<a href="#" id="search_eventR" class="eventR_button_list" onclick="reload()">조회</a>
			</li>
		</ul>
		<ul class="list_ty" style="width:100%;height:200px;">
			<div class="table_title" style="margin-left: 30px;">
				<em>가입자 승인 리스트</em>
			</div>
			<table id="userApprovalList_table" title="" style="width:100%;height:calc(100%-129px);">

			</table>
			<a href="#" id="approval_button" class="eventR_button_list" onclick="approval()">승인</a>
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
function approval(){
	var row = $('#userApprovalList_table').datagrid('getSelected');
	if (row){
		const jsonObj = {};

        jsonObj.phoneNumber = row.phoneNumber;

        $.ajax(
            {
                type       : "POST",
                url        : "${pageContext.request.contextPath}/ajax/update/girlSafe.updateApproval/action.do",
                dataType   : "json",
                data       : {
                    "param" : JSON.stringify(jsonObj)
                },
                async      : false,
                beforeSend : function(xhr) {
                    // 전송 전 Code
                }
            }).done(function (result) {
            if (result == "SUCCESS")
            {
                alert("승인 완료");
                $('#userApprovalList_table').datagrid('reload');
            }
            else
            {
                alert("수정 실패");
            }
        }).fail(function (xhr) {
            alert("수정 실패");
        }).always(function() {

        });
	}
}
function reload(){
	const jsonObj = {};
	jsonObj.eventDeS = $("#search_eventR_timeS").datebox('getValue').replace(/\//g, '');
	jsonObj.eventDeE = $("#search_eventR_timeE").datebox('getValue').replace(/\//g, '');
	jsonObj.totSearch = $("#search_eventR_tot").val();
	jsonObj.approval = '1';
	$('#userApprovalList_table').datagrid({
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
			{field:'age',title:'나이',width:70,align:'center'},
			{field:'phoneNumber',title:'번호',width:100,align:'center'},
			{field:'address',title:'주소',width:200,align:'center'},
			{field:'sensorId',title:'단말기번호',width:80,align:'center'},
			{field:'approval',title:'승인여부',width:70,align:'center'}
	    ]],
	    onLoadSuccess:function(data){
			if($('#userApprovalList_table').datagrid('getData').rows=='sessionOut'){
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

