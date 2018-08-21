<!-- 시설물현황조회 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="./js/ckeditor/ckeditor.js"></script>
<div class="cont_area">
	<div id="board_list" class="cont_inner cont_container" title="">
		<ul class="list_ty_full">
			<li class="list2">
				<div class="list_cont3">
					<em>제목</em>
				</div>
				<div class="list_cont4">
					<input type="text" id="board_title" class="easyui-textbox" style="width: 100%;"/>
				</div>
			</li>
			<li class="list2 border_none">
				<div class="list_cont5">
					<em>내용</em>
				</div>
				<div class="list_cont7">
					<textarea name="editor1" id="board_cont" id="editor1" rows="10" cols="80">
					</textarea>
				</div>
			</li>
			<li class="btn_list">
				<div class="list_cont">
					<a href="#" id="save_button" class="eventR_button_list" onclick="savePosts()">저장</a>
				</div>
				<div class="list_cont">
					<a href="#" id="cancel_button" class="eventR_button_list" onclick="closePopup()">취소</a>
				</div>
			</li>
		</ul>
	</div>
</div>
<script>
CKEDITOR.replace('editor1');
$(document).ready(function(){
	reload();
});

function closePopup() {
	common.closeDialogPop("board_write");
}

function savePosts() {
	var url = "/ajax/insert/girlSafe.insertBoard/action.do";
	const jsonObj = {};
	jsonObj.title = $("#board_title").val();
	jsonObj.content = CKEDITOR.instances.board_cont.getData();
	$.ajax({
		type : "POST"
		, url : url
		, dataType : "json"
		, data : {"param" : JSON.stringify(jsonObj)}
		, success:function(data)
		{
			alert("저장되었습니다.");
			common.closeDialogPop("board_write");
			$('#boardList_table').datagrid('reload');
		}
		, error:function(e){
			alert(e.responseText);
		}
	});
}

function reload(){
	
}
</script>

