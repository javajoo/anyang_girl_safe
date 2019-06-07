<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="./js/ckeditor/ckeditor.js"></script>
<div class="cont_area" id="detail_area">
	<div id="board_list" class="cont_inner cont_container" title="">
		<ul class="list_ty_full">
			<li class="list2">
				<div class="list_cont3">
					<em>제목</em>
				</div>
				<div class="list_cont4">
					<p id="board_detail_title"></p>
				</div>
			</li>
			<li class="list2">
				<div class="list_cont5">
					<em>내용</em>
				</div>
				<div class="list_cont6">
					<div id="board_detail_content">
					</div>
				</div>
			</li>
			<li class="list2">
				<ul>
					<li class="list_cont3">
						<em>조회수</em>
					</li>
					<li class="list_cont3">
						<span id="board_detail_count"></span>
					</li>
					<li class="list_cont3">
						<em>푸시</em>
					</li>
					<li class="list_cont3">
						<span id="board_detail_push"></span>
					</li>
				</ul>
			</li>
			<li class="list2">
				<div class="list_cont3">
					<em>ID</em>
				</div>
				<div class="list_cont3">
					<span id="board_detail_admin_id"></span>
				</div>
				<div class="list_cont3">
					<em>작성자</em>
				</div>
				<div class="list_cont3">
					<span id="board_detail_admin_name"></span>
				</div>
			</li>
			<li class="list2">
				<div class="list_cont3">
					<em>등록일</em>
				</div>
				<div class="list_cont3">
					<span id="board_detail_insert_date"></span>
				</div>
				<div class="list_cont3">
					<em>수정일</em>
				</div>
				<div class="list_cont3">
					<span id="board_detail_update_date"></span>
				</div>
			</li>
			<li class="btn_list">
				<div class="list_cont">
					<a href="#" id="save_button" class="eventR_button_list" onclick="changeView(0)">수정</a>
				</div>
				<div class="list_cont">
					<a href="#" id="cancel_button" class="eventR_button_list" onclick="closePopup()">취소</a>
				</div>
			</li>
		</ul>
	</div>
</div>

<div class="cont_area" id="update_area">
	<div id="board_list" class="cont_inner cont_container" title="">
		<ul class="list_ty_full">
			<li class="list2">
				<div class="list_cont3">
					<em>제목</em>
				</div>
				<div class="list_cont4">
					<input type="text" id="update_board_title" class="easyui-textbox" style="width: 100%;"/>
				</div>
			</li>
			<li class="list2 border_none">
				<div class="list_cont5">
					<em>내용</em>
				</div>
				<div class="list_cont7">
					<textarea name="editor2" id="editor2" rows="10" cols="80">
					</textarea>
				</div>
			</li>
			<li class="btn_list">
				<div class="list_cont">
					<a href="#" id="save_button" class="eventR_button_list" onclick="updatePosts()">저장</a>
				</div>
				<div class="list_cont">
					<a href="#" id="cancel_button" class="eventR_button_list" onclick="closePopup()">취소</a>
				</div>
				<div class="list_cont">
					<a href="#" id="cancel_button" class="eventR_button_list" onclick="changeView(1)">이전</a>
				</div>
			</li>
		</ul>
	</div>
</div>

<script>
$(document).ready(function(){
	loadEditor('editor2');
	$("#update_area").hide();
	reload_detail();
});

function closePopup() {
	common.closeDialogPop("board_detail");
}

function changeView(flag) {
	if (flag == 0) {
		$("#detail_area").hide();
		$("#update_area").show();
	} else if (flag == 1) {
		$("#detail_area").show();
		$("#update_area").hide();
	}
}

function updatePosts() {
	var url = "/ajax/update/girlSafe.updateBoard/action.do";
	var no = "${no}";
	const jsonObj = {};
	jsonObj.title = $("#update_board_title").val();
	jsonObj.content = CKEDITOR.instances['editor2'].getData();
	jsonObj.no = no;
	jsonObj.adminId = "${admin.id}";
	jsonObj.adminName = "${admin.name}";
	
	$.ajax({
		type : "POST"
		, url : url
		, dataType : "json"
		, data : {"param" : JSON.stringify(jsonObj)}
		, success:function(data)
		{
			alert("수정되었습니다.");
			common.closeDialogPop("board_detail");
			$('#boardList_table').datagrid('reload');
		}
		, error:function(e){
			alert(e.responseText);
		}
	});
}

function setBoardValues(data) {
	$("#board_detail_title").text(data.title);
	$("#board_detail_content").html(data.content);
	$("#board_detail_count").text(data.count);
	$("#board_detail_push").text(data.pushYN);
	$("#board_detail_insert_date").text(data.insertDate);
	$("#board_detail_update_date").text(data.updateDate);
	$("#board_detail_admin_id").text(data.adminId);
	$("#board_detail_admin_name").text(data.adminName);
	
	$("#update_board_title").val(data.title);
	
	CKEDITOR.instances['editor2'].setData(data.content, {
		callback: function() {
			CKEDITOR.instances['editor2'].setData(data.content);
			this.checkDirty();
		}
	});
}

function reload_detail(){
	var url = "/select/girlSafe.getBoardOne/action.do";
	var no = "${no}";
	const jsonObj = {};
	jsonObj.no = no;
	$.ajax({
		type : "POST"
		, url : url
		, dataType : "json"
		, data : {"param" : JSON.stringify(jsonObj)}
		, success:function(datas)
		{
			setBoardValues(datas[0]);
		}
		, error:function(e){
			alert(e.responseText);
		}
	});
}
</script>