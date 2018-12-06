<!-- 시설물현황조회 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="event_list" class="cont_inner" title="" style="height:99%; width: 97%;">
		<ul class="list_ty_middle">
			<li class="list">
				<div class="list_title">
					<em>WEB 설정</em>
				</div>
				<div class="list_cont_full">
					<input type="text" id="web_name_box" class="easyui-textbox" 
						placeholder="내용을 입력해 주세요."/>
				</div>
			</li>
			<li class="list">
				<div class="list_title">
					<em>로고 설정</em>
				</div>
				<div class="list_cont_full">
					<input type="text" id="web_name_box" class="easyui-textbox" 
						placeholder="내용을 입력해 주세요."/>
				</div>
			</li>
			<li class="list">
				<div class="list_title">
					<em>소리 설정</em>
				</div>
				<div class="list_cont_full">
					<select id="sound_box" class="easyui-combobox">
					</select>
				</div>
			</li>
			<li class="btn_list">
				<a href="#" id="approval_button" class="eventR_button_list" onclick="">적용</a>
				<a href="#" id="approval_button" class="eventR_button_list" onclick="">취소</a>
			</li>
		</ul>
	</div>
</div>
<script>
$(document).ready(function(){
	$('#sound_box').combobox({
	    valueField:'value',
	    textField:'label',
	    data: [
	    {
	    	label: '사이렌',
	    	value: '0'
	    },
	    {
	    	label: '비상벨',
	    	value: '1'
	    }]
	});
	
	reload();
});

function reload(){
	const jsonObj = {};
	// jsonObj.approval = $("#approval_box").combobox('getValue');
}
</script>

