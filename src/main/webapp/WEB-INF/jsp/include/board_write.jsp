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
	<!-- 		<li class="list2 border_none btn_list2">
				<div class="list_cont_super2" style="float:left">
					<div class="list_cont2">
						<input type="radio"name="push" class="push" value="p">푸시
					</div>
					<div class="list_cont2">
						<input type="radio"name="fpush" class="fpush" value="f">강제푸시
					</div>
					<div class="list_cont2">
						<input type="radio"name="dpush" class="dpush" value="d" checked>푸시안함
					</div>
				</div>
			</li> -->
			<li class="btn_list">
				<div class="list_cont">
					<div class="list_cont">
						<a href="#" id="save_button" class="eventR_button_list" onclick="savePosts()">저장</a>
					</div>
					<div class="list_cont">
						<a href="#" id="cancel_button" class="eventR_button_list" onclick="closePopup()">취소</a>
					</div>
				</div>
			</li>
		</ul>
	</div>
</div>
<script>
$(document).ready(function(){
	loadEditor('editor1');
	reload();
});

function closePopup() {
	common.closeDialogPop("board_write");
}

function savePosts() {
/* 	var push = $('#push').val();
	var fpush = $('#fpush').val();
	var dpush = $('#dpush').val();
	
	if(push == 'p'){
		pushBoard();
	}
	 */
	
	var url = "/ajax/insert/girlSafe.insertBoard/action.do";
	
	const checkAttack =  (function() {
        let rtnVal;
        const jsonObj = {};
        jsonObj.title = $("#board_title").val();
        jsonObj.content = CKEDITOR.instances.board_cont.getData();
        
        $.ajax(
            {
                type       : "POST",
                url        : "/select/girlSafe.checkBoard/action.do",
                dataType   : "json",
                data       : {"param" : JSON.stringify(jsonObj)},
                async       : false,
                beforeSend : function(xhr) {
                    // 전송 전 Code
                }
            }).done(function (result) {
            rtnVal = result[0].idKey;
        }).fail(function (xhr) {

        }).always(function() {

        });
        return rtnVal;
    })();
	
	if(checkAttack > 0){
		alert("같은내용의 게시물을 연속해서 입력할 수 없습니다.");
		return false;
	}
	
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
			$.ajax({
				type 		: "POST",
				url  		: "/select/girlSafe.getBoardNo/action.do",
				dataType 	: "json",
				data 		: {"param" : JSON.stringify(jsonObj)},
				success 	:function(data){
					common.closeDialogPop("board_write");
					updateCount("",data[0]);
					getBoardOne("",data[0]);
					reload();
				}
			})
		}
		, error:function(e){
			alert(e.responseText);
		}
	});
}

function checkNull(val){
	var flag = false;
	
	if(val != '' && val != null && typeof val != 'undefined'){
		flag = true;
	}
	return flag;
}

/* 
function reload(){
	
} */
</script>

