<!-- 시설물현황조회 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="./js/ckeditor/ckeditor.js"></script>
<div class="cont_area">
	<div id="event_list" title="" style="height:99%; width: 97%;">
		
		<textarea name="editor1" id="editor1" row="10" cols="80">
		df
		</textarea>
		
	</div>
</div>
<script>
CKEDITOR.replace('editor1');
$(document).ready(function(){

		reload();
});

function reload(){
	
}
</script>

