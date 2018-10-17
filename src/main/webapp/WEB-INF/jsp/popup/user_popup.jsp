<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area" id="user_popup">
	<div id="girl_safe" class="cont_inner" title="">
		<ul class="popup_list_condi">
			<li class="list">
				<div class="popup_list_title">
					<em>Sensor ID</em>
				</div>
				<div class="popup_list_cont">
					<input type="text" id="user_sensor_box" class="easyui-textbox" value="SA-I"
						placeholder="내용을 입력해 주세요."/>
				</div>
			</li>
			<li class="list">
				<div class="popup_list_title">
					<em>Station ID</em>
				</div>
				<div class="popup_list_cont">
					<input type="text" id="user_smart_box" class="easyui-textbox" value="SA-S"
						placeholder="내용을 입력해 주세요."/>
				</div>
			</li>
			<li class="list">
				<div class="popup_list_title">
					<em id="user_name_title">이름</em>
				</div>
				<div class="popup_list_cont">
					<input type="text" id="user_name_box" class="easyui-textbox" 
						placeholder="내용을 입력해 주세요."/>
				</div>
			</li>
			<li class="list" id="user_age_area">
				<div class="popup_list_title">
					<em>생년월일</em>
				</div>
				<div class="popup_list_cont">
					<input type="text" id="user_age_box" class="easyui-textbox"
						placeholder="내용을 입력해 주세요."/>
				</div>
			</li>
			<li class="list">
				<div class="popup_list_title">
					<em>주소</em>
				</div>
				<div class="popup_list_cont">
					<input type="text" id="user_address_box" class="easyui-textbox"
						placeholder="내용을 입력해 주세요."/>
				</div>
			</li>
			<li class="list">
				<div class="popup_list_title">
					<em>번호</em>
				</div>
				<div class="popup_list_cont">
					<input type="text" id="user_phone_box" class="easyui-textbox"
						placeholder="내용을 입력해 주세요."/>
				</div>
			</li>
		</ul>
		<ul class="popup_list_ty_full">
			<li class="btn_list">
				<div class="list_cont">
					<a href="#" id="user_cancel_btn" class="eventR_button_list" onclick="closePopup()">취소</a>
				</div>
				<div class="list_cont">
					<a href="#" id="user_update_btn" class="eventR_button_list" 
						onclick="onUserUpdatePopup()" style="display: none;">수정</a>
					<a href="#" id="user_save_btn" class="eventR_button_list" onclick="modifyUser()">저장</a>
				</div>
			</li>
		</ul>
	</div>
</div>
<script>
$(document).ready(function(){
	console.log(selectedData);
	if (typeof(selectedData) != 'undefined' && selectedData != '') {
		setUserDetailData(selectedData);
	}
});

function onUserUpdatePopup() {
	$('#user_sensor_box').attr('disabled', false);
	$('#user_smart_box').attr('disabled', false);
	$('#user_name_box').attr('disabled', false);
	$('#user_age_box').attr('disabled', false);
	$('#user_address_box').attr('disabled', false);
	$('#user_phone_box').attr('disabled', false);
	
	$('#user_update_btn').css('display', 'none');
	$('#user_save_btn').css('display', 'inline-block');
}

function setUserDetailData(data) {
	var row = data[0];
	
	$('#user_sensor_box').attr('disabled', true);
	$('#user_smart_box').attr('disabled', true);
	$('#user_name_box').attr('disabled', true);
	$('#user_age_box').attr('disabled', true);
	$('#user_address_box').attr('disabled', true);
	$('#user_phone_box').attr('disabled', true);
	
	$('#user_sensor_box').val(row.sensorId);
	$('#user_smart_box').val('SA-S' + row.smartId);
	$('#user_name_box').val(row.name);
	$('#user_age_box').val(row.age);
	$('#user_address_box').val(row.address);
	$('#user_phone_box').val(row.phoneNumber);
	$('#user_update_btn').css('display', 'inline-block');
	$('#user_save_btn').css('display', 'none');
}


function closePopup() {
	clearPopup();
    $('#popup_area').dialog('close');
}

function checkValidation() {
	
}

function checkStationId() {
	var stationId = $('#user_smart_box').val();
	var pattern = /^SA-S\d{4}$/;
	
	if (!pattern.test(stationId)) {
		alert("Station ID가 틀렷습니다.\nID 형식은 아래와 같습니다.\n예)SA-S0000")
		return false;
	}
	
	return true;
}

function checkSensorId() {
	var sensorId = $('#user_sensor_box').val();
	var pattern = /^SA-I\d{4}$/;
	
	if (!pattern.test(stationId)) {
		alert("Sensor ID가 틀렷습니다.\nID 형식은 아래와 같습니다.\n예)SA-I0000")
		return false;
	}
	
	return true;
}

function modifyUser() {
	var sensorId = $('#user_sensor_box').val();
	var stationId = $('#user_smart_box').val().replace('SA-S', '');
	var name = $('#user_name_box').val();
	var age = $('#user_age_box').val();
	var address = $('#user_address_box').val();
	var phoneNumber = $('#user_phone_box').val();
	
	const jsonArray1 = [];
	const jsonArray2 = [];
	const jsonArray3 = [];
	const jsonArray4 = [];
	
	const jsonObj = {};

    jsonObj.rowStatus = "C";
	jsonObj.sensorId = sensorId;
	jsonObj.stationId = stationId;
	jsonObj.name = name;
	jsonObj.age = age;
	jsonObj.address = address;
    jsonObj.phoneNumber = phoneNumber;
    
    jsonArray1[0] = jsonObj;
    jsonArray2[0] = jsonObj;

    $.ajax(
        {
            type       : "POST",
            url        : "/multiTransaction/girlSafe.insertUser/girlSafe.insertHw/sqlid3/sqlid4/action.do",
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
        if (result == "SUCCESS")
        {
            $('#userApprovalList_table').datagrid('reload');
        }
        else
        {
            alert("등록 실패");
        }
        closePopup();
    }).fail(function (xhr) {
        alert("등록 실패");
    }).always(function() {

    });
}

</script>