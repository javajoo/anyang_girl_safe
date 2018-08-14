<!-- 시설물현황조회 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="./js/ckeditor/ckeditor.js"></script>
<div class="cont_area">
	<div id="board_list" class="cont_inner" title="" style="height:99%; width: 97%;">
		<ul class="list_ty_full" style="width:100%;">
			<li class="list">
				<div class="list_cont3">
					<em>제목</em>
				</div>
				<div class="list_cont">
					<input type="text" id="board_title" class="easyui-textbox" style="width: 95%;"/>
				</div>
			</li>
			<li class="list" style="margin: 20px 0;">
				<div class="list_cont4" style="margin: 0 0 10px 0;">
					<em>내용</em>
				</div>
				<div class="list_cont4">
					<textarea name="editor1" id="board_cont" id="editor1" rows="10" cols="80">
					</textarea>
				</div>
			</li>
			<li class="btn_list">
				<div class="list_cont">
					<a href="#" id="save_button" class="eventR_button_list" onclick="savePosts()">저장</a>
				</div>
				<div class="list_cont">
					<a href="#" id="cancel_button" class="eventR_button_list">취소</a>
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

$("#cancel_button").click(function() {
	
});

function savePosts() {
	console.log($("#board_title").val());
	console.log(CKEDITOR.instances.board_cont.getData());
	var url = "/insert/girlSafe.insertBoard/action.do";
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
			
		}
		, error:function(e){
			alert(e.responseText);
		}
	});
}

function reload(){
	
}
</script>

