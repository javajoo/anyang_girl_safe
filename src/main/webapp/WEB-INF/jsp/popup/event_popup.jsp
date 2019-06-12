<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area" id="user_popup">
	<div id="girl_safe" class="cont_inner" title="">
		<ul class="popup_list_condi">
			<li class="list">
				<div class="popup_list_title">
					<em id="user_name_title">이름</em>
				</div>
				<div class="popup_list_cont">
					<input type="text" id="user_name_box" disabled/>
				</div>
			</li>
			<li class="list" id="user_birth_area">
				<div class="popup_list_title">
					<em>생년월일</em>
				</div>
				<div class="popup_list_cont">
					<input type="date" id="user_birth_box" min="1900-01-01" max="9999-12-31" disabled/>
				</div>
			</li>
			<li class="list">
				<div class="popup_list_title">
					<em>연락처</em>
				</div>
				<div class="popup_list_cont">
					<input type="text" id="user_phone_box" disabled/>
				</div>
			</li>
			<li class="list">
				<div class="popup_list_title">
					<em>주소</em>
				</div>
				<div class="popup_list_cont">
					<input type="text" id="user_address_box" disabled/>
				</div>
			</li>
			<li class="list">
				<div class="popup_list_title">
					<em>Sensor ID</em>
				</div>
				<div class="popup_list_cont">
					<input type="text" id="user_sensor_box" disabled/>
				</div>
			</li>
			<li class="list">
				<div class="popup_list_title">
					<em>Station ID</em>
				</div>
				<div class="popup_list_cont">
					<input type="text" id="user_smart_box" disabled/>
				</div>
			</li>
			<li class="list">
				<div class="popup_list_title">
					<em>종료사유</em>
				</div>
				<div class="popup_list_cont">
					<input type="text" id="user_remark_box" disabled/>
				</div>
			</li>
			<li class="list">
				<div class="popup_list_title" style="height: 100px">
					<em style="line-height: 100px">추가정보</em>
				</div>
				<div class="popup_list_cont">
					<input type="text" id="user_reason_box" style="height: 100px" disabled/>
				</div>
			</li>
		</ul>
		<ul class="popup_list_ty_full">
			<li class="btn_list">
				<div class="list_cont">
					<a href="#" id="user_cancel_btn" class="eventR_button_list" onclick="closePopup()" style="margin-top: 70px">취소</a>
				</div>
			</li>
		</ul>
	</div>
</div>
<script>
$(document).ready(function(){
	if (typeof(selectedData) != 'undefined' && selectedData != '') {
		setUserDetailData(selectedData);
	}
});

function setUserDetailData(data) {
	var row = data[0];
	
	var smartId = row.smartId;
	var idLength = 4 - smartId.length;
	for (var j = 0; j < idLength; j++) {
		smartId = '0' + smartId;
	}
	smartId = 'SA-S' + smartId;
	
	
	
	$('#user_sensor_box').val(row.sensorId);
	$('#user_smart_box').val(smartId);
	$('#user_name_box').val(row.name);
	$('#user_birth_box').val(row.birth);
	$('#user_address_box').val(row.address);
	$('#user_phone_box').val(row.phoneNumber);
	$('#user_remark_box').val(row.remark);
	$('#user_reason_box').val(row.reason);
}

function closePopup() {
	clearPopup();
    $('#popup_area').dialog('close');
}

</script>