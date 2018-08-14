<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="./js/common.js"></script>
<div class="cont_area">
	<div id="board_list" class="cont_inner" title="" style="height:99%; width: 97%;">
		<ul class="list_condi_full">
			<li class="list">
				<div class="list_cont">
					<em>검색조건 : </em>
					<select id="search_type_box" class="easyui-combobox" style="width: 80px; height: 27px;">
					</select>
				</div>
				<div class="list_cont">
					<em>푸시여부 : </em>
					<select id="push_yn_box" class="easyui-combobox" style="width: 80px; height: 27px;">
					</select>
				</div>
				<div class="list_cont">
					<input type="text" id="search_eventR_tot" class="easyui-textbox" style="width:200px;"/>
					<a href="#" id="search_eventR" class="eventR_button_list" onclick="reload()">조회</a>
				</div>
			</li>
		</ul>
		<ul class="list_ty_full" style="width:100%;height:200px;">
			<li class="table_title">
				<em>게시판</em>
			</li>
			<li>
				<table id="boardList_table" title="" style="width:100%;height:calc(100%-129px);">
				</table>
			</li>
			<li class="btn_list">
				<div class="list_cont">
					<a href="#" id="write_button" class="eventR_button_list">글쓰기</a>
				</div>
				<div class="list_cont">
					<a href="#" id="push_button" class="eventR_button_list">푸시</a>
				</div>
			</li>
		</ul>
		
	</div>
</div>
<script>
	$(document).ready(function(){
		$('#search_type_box').combobox({
		    valueField:'value',
		    textField:'label',
		    data: [{
		    	label: '제목',
		    	value: 'title'
		    },
		    {
		    	label: '내용',
		    	value: 'cont'
		    }]
		});

		$('#push_yn_box').combobox({
		    valueField:'value',
		    textField:'label',
		    data: [{
		    	label: 'Y',
		    	value: 'Y'
		    },
		    {
		    	label: 'N',
		    	value: 'N'
		    }]
		});
		
		reload();
	});
	$("#write_button").off("click").on(
	        {
	            "click": function ()
	            {
	            	const path = "include/board_write";
	                console.log(path);
	                common.openDialogPopPosition("", "글쓰기", "1024", "470", "true", "/action/page.do", {path: path}, path.split("/")[3]);
	            }
	        });
	
	function reload(){
		const jsonObj = {};
		jsonObj.totSearch = $("#search_eventR_tot").val();
		jsonObj.searchType = $("#search_type_box").combobox('getValue');
		jsonObj.pushYN = $("#push_yn_box").combobox('getValue');
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
		        {field:'num',title:'No',width:'5%',align:'center'},
				{field:'title',title:'제목',width:'65%',align:'center'},
				{field:'insertDate',title:'등록일',width:'20%',align:'center'},
				{field:'pushYN',title:'푸시',width:'5%',align:'center'},
				{field:'count',title:'조회수',width:'5%',align:'center'}
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

