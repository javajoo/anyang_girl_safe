<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="./js/common.js"></script>
<div class="cont_area">
	<div id="board_list" class="cont_inner" title="" style="height:99%; width: 97%;">
		<ul class="list_condi_full">
			<li class="list">
				<div>
					<em>등록일 : </em>
					<input id="search_board_timeS" data-options="formatter:myformatter,parser:myparser,prompt:'시작일 입력'" style="width:175px;">
					&nbsp;~ 
					<input id="search_board_timeE" data-options="formatter:myformatter,parser:myparser,prompt:'종료일 입력'" style="width:175px;">
				</div>
			</li>
			<li class="list">
				<div class="list_cont">
					<em>푸시여부 : </em>
					<select id="push_yn_box" class="easyui-combobox" style="width: 80px; height: 27px;">
					</select>
				</div>
				<div class="list_cont">
					<em>검색조건 : </em>
					<select id="search_type_box" class="easyui-combobox" style="width: 80px; height: 27px;">
					</select>
					<input type="text" id="search_eventR_tot" class="easyui-textbox" style="width:200px;" onkeypress="if(event.keyCode==13){reload();}"/>
					<a href="#" id="search_eventR" class="eventR_button_list" onclick="reload()">조회</a>
					<a href="#" class="eventR_button_list" onclick="searchInit()">초기화</a>
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
					<a href="#" id="pPush_button" class="eventR_button_list" onclick="pPushBoard()">강제푸시</a>
				</div>
				<div class="list_cont">
					<a href="#" id="push_button" class="eventR_button_list" onclick="pushBoard()">푸시</a>
				</div>
				<div class="list_cont">
					<a href="#" id="write_button" class="eventR_button_list">글쓰기</a>
				</div>
				<div class="list_cont">
					<a href="#" id="delete_button" class="delete_button" onclick="deleteBoard_list()">삭제</a>
				</div>
			</li>
		</ul>
		
	</div>
</div>
<script>
function searchInit() {
	$('#search_board_timeS').datebox({
		requeired:true
	});
	$('#search_board_timeE').datebox({
		requeired:true
	});
	
	$('#search_type_box').combobox({
	    valueField:'value',
	    textField:'label',
	    data: [{
	    	label: '제목',
	    	value: 'title',
	    	"selected":true
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
	    	label: '전체',
	    	value: ''
	    },
	    {
	    	label: 'Y',
	    	value: 'Y'
	    },
	    {
	    	label: 'N',
	    	value: 'N'
	    }]
	});
	
	$('#search_eventR_tot').val('');
}

$(document).ready(function(){
	$('#push_button').css('display', 'none');	
	$('#pPush_button').css('display', 'none');	
	
	searchInit();
	
	$('.datebox-black .combo-arrow').removeClass("combo-arrow").addClass("combo-arrow_sel");
	$('.datebox').removeClass("datebox").addClass("datebox-black");
	$('.datebox-calendar-inner').parent().addClass("datebox-calendar-div");
	$('.datebox-calendar-inner').parent().parent().addClass("datebox-calendar-panel");
	
	reload();
});

$("#write_button").off("click").on({
	"click": function (){
		const path = "include/board_write";
		console.log(path);
		common.openDialogPopPosition("", "글쓰기", "1024", "470", "true", "/action/page.do", {path: path}, path.split("/")[1]);
	}
});

function getBoardOne(row, data) {
	var url = "/select/girlSafe.getBoardOne/action.do";
	const path = "include/board_detail";
	const id = path.split("/")[1];
	const jsonObj = {};
	jsonObj.no = data.no;
	jsonObj.path = path;
       common.openDialogPopPosition(id, "상세보기", "1024", "470", true, "/action/page.do", jsonObj, id);
}

function updateCount(row, data) {
	var url = "/ajax/update/girlSafe.updateBoard/action.do";
	const jsonObj = {};
	jsonObj.no = data.no;
	jsonObj.count = "count";
	$.ajax({
		type : "POST"
		, url : url
		, dataType : "json"
		, data : {"param" : JSON.stringify(jsonObj)}
		, success:function(data)
		{
			console.log(data);
		}
		, error:function(e){
			alert(e.responseText);
		}
	});
}

function pushBoard(no) {
	if(confirm("푸시 하시겠습니까?")== false) return false;
	var row = $('#boardList_table').datagrid('getSelected');
	var url = "/boardPush.do";
	const jsonObj = {};
	if(no != null && no != '' &&no != 'undefined'){
		jsonObj.no = no;	
	}else{
		jsonObj.no = row.no;
	}
	jsonObj.pushYN = "Y";
	jsonObj.pushKind = "N";
	jsonObj.adminId = "${admin.id}";
	jsonObj.adminName = "${admin.name}";
	
	$.ajax({
		type : "POST"
		, url : url
		, dataType : "json"
		, data : {"param" : JSON.stringify(jsonObj)}
		, success:function(data)
		{
			console.log(data);
			$.ajax({
				type : "POST"
				, url : "/ajax/update/girlSafe.updateBoard/action.do"
				, dataType : "json"
				, data : {"param" : JSON.stringify(jsonObj)}
				, success:function(data)
				{
					alert('발송되었습니다.');
					reload();
					reload_detail();
				}
				, error:function(e){
					alert(e.responseText);
				}
			});
		}
		, error:function(e){
			alert(e.responseText);
		}
	});
}


function pPushBoard(no) {
	if(confirm("강제푸쉬 하시겠습니까?")== false) return false;
	var row = $('#boardList_table').datagrid('getSelected');
	var url = "/boardPush.do";
	const jsonObj = {};
	if(no != null && no != '' &&no != 'undefined'){
		jsonObj.no = no;	
	}else{
		jsonObj.no = row.no;
	}
	jsonObj.pushYN = "Y";
	jsonObj.pushKind = "P";
	jsonObj.adminId = "${admin.id}";
	jsonObj.adminName = "${admin.name}";
	
	$.ajax({
		type : "POST"
		, url : url
		, dataType : "json"
		, data : {"param" : JSON.stringify(jsonObj)}
		, success:function(data)
		{
			console.log(data);
			$.ajax({
				type : "POST"
				, url : "/ajax/update/girlSafe.updateBoard/action.do"
				, dataType : "json"
				, data : {"param" : JSON.stringify(jsonObj)}
				, success:function(data)
				{
					alert('발송되었습니다.');
					reload();
					reload_detail();
				}
				, error:function(e){
					alert(e.responseText);
				}
			});
		}
		, error:function(e){
			alert(e.responseText);
		}
	});
}

function reload(){
	const jsonObj = {};
	jsonObj.boardInsertTimeS = $("#search_board_timeS").datebox('getValue').replace(/\//g, '');
	jsonObj.boardInsertTimeE = $("#search_board_timeE").datebox('getValue').replace(/\//g, '');
	jsonObj.searchType = $("#search_type_box").combobox('getValue');
	jsonObj.totSearch = $("#search_eventR_tot").val();
	jsonObj.pushYN = $("#push_yn_box").combobox('getValue');
	$('#boardList_table').datagrid({
	    url:'/selectList/girlSafe.getBoardList/action.do',
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
			{field:'title',title:'제목',width:'65%',align:'center'},
			{field:'insertDate',title:'등록일',width:'20%',align:'center'},
			{field:'pushYN',title:'푸시',width:'5%',align:'center'},
			{field:'count',title:'조회수',width:'5%',align:'center'},
			{field:'no',title:'번호',hidden:true}
	    ]],
	    onSelect:function(index, row) {
	    	if(rank == '2'){
		    	$('#delete_button').css('display', 'inline-block');
	    	}else if(rank == '1'){
	    		$('#delete_button').css('display', 'inline-block');
				$('#push_button').css('display', 'inline-block');
				$('#pPush_button').css('display', 'inline-block');
	    	}
	    },
	    onUnselect:function(index, row) {
	    	if(rank == '2'){
		    	$('#delete_button').css('display', 'inline-block');
	    	}else if(rank == '1'){
	    		$('#delete_button').css('display', 'inline-block');
				$('#push_button').css('display', 'inline-block');
				$('#pPush_button').css('display', 'inline-block');
	    	}
	    },
	    onDblClickRow: function(row, data) {
	    	if(rank == '2'){
		    	updateCount(row, data);
		    	getBoardOne(row, data);
		    	$('#delete_button').css('display', 'none');
	    	}else if(rank == '1'){
	    		updateCount(row, data);
		    	getBoardOne(row, data);
		    	$('#delete_button').css('display', 'none');
				$('#push_button').css('display', 'none');
				$('#pPush_button').css('display', 'none');
	    	}
	    },
	    onLoadSuccess:function(data){
	    	$('#delete_button').css('display', 'none');
			$('#push_button').css('display', 'none');
			$('#pPush_button').css('display', 'none');
			
			if(data.rows=='sessionOut'){
				sCnt++;
				if(sCnt == 1){
					alert('세션아웃 됐습니다.');
					//location.href="/";
					closeWindow();
				}
			}
			if(data && data.total > 0) {			
				
				selectEeventMGIS(0, data.rows[0]);	// 발생된 이벤트 선택 및 지도 표출.
				//$(this).datagrid('selectRow',0);
			}
		}
	});	
}

function deleteBoard_list() {
	var row = $('#boardList_table').datagrid('getSelected');
	
	const jsonArray1 = [];
	const jsonArray2 = [];
	const jsonArray3 = [];
	const jsonArray4 = [];
	
	const jsonObj = {};
    jsonObj.rowStatus = "D";
    jsonObj.no = row.no;
    
    jsonArray1[0] = jsonObj;
  

    $.ajax({
            type       : "POST",
            url        : "/multiTransaction/girlSafe.deleteBoard/sqlid2/sqlid3/sqlid4/action.do",
            dataType   : "json",
            data       : {
            	"param1" : JSON.stringify(jsonArray1),
                "param2" : JSON.stringify(jsonArray2),
                "param3" : JSON.stringify(jsonArray3),
                "param4" : JSON.stringify(jsonArray4)
            },
            async      : false,
            beforeSend : function(xhr) {
                // 전송 전 Code
            }
        }).done(function (result) {
        if (result == "SUCCESS") {
        	$('#boardList_table').datagrid('reload');
            alert("삭제 완료");
        }
        else {
            alert("삭제 실패");
        }
    }).fail(function (xhr) {
        alert("삭제 실패");
    }).always(function() {

    });
}
</script>

