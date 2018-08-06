<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="./js/common.js"></script>
<div class="cont_area">
	<div id="board_list" title="" style="height:99%; width: 97%;">
		
		<ul class="list_ty" style="width:100%;height:200px;">
			<div class="table_title" style="margin-left: 30px;">
				<em>게시판</em>
			</div>
			<table id="boardList_table" title="" style="width:90%;height:calc(100%-129px);">

			</table>
			<li class="list">
				<input type="text" id="search_eventR_tot" class="easyui-textbox" style="width:200px;"/>
				<a href="#" id="search_eventR" class="eventR_button_list" onclick="reload()">조회</a>
				<button id="search_button" class="eventR_button_list">글쓰기</button>
			</li>
		</ul>
		
	</div>
</div>
<script>
	$(document).ready(function(){
			reload();
	});
	$("#search_button").off("click").on(
	        {
	            "click": function ()
	            {
	            	const path = "include/board_write";
	                console.log(path);
	                common.openDialogPopPosition("", "글쓰기", "1024", "400", "true", "/action/page.do", {path: path}, path.split("/")[3]);
	            }
	        });
	
	function reload(){
		const jsonObj = {};
		jsonObj.totSearch = $("#search_eventR_tot").val();
		$('#boardList_table').datagrid({
		    url:'/selectList/girlSafe.getBoardList/action.do',
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
				{field:'title',title:'제목',width:200,align:'center'},
				{field:'insertDate',title:'등록일',width:100,align:'center'},
				{field:'pushYN',title:'푸시',width:100,align:'center'},
				{field:'count',title:'조회수',width:100,align:'center'}
		    ]],
		    onLoadSuccess:function(data){
				if($('#boardList_table').datagrid('getData').rows=='sessionOut'){
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

