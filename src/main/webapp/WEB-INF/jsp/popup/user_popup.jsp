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
			<li class="list" id="user_birth_area">
				<div class="popup_list_title">
					<em>생년월일</em>
				</div>
				<div class="popup_list_cont">
					<input type="text" id="user_birth_box" class="easyui-textbox"
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
					<em>연락처</em>
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
	if (typeof(selectedData) != 'undefined' && selectedData != '') {
		setUserDetailData(selectedData);
	}
});

function onUserUpdatePopup() {
	$('#user_sensor_box').attr('disabled', false);
	$('#user_smart_box').attr('disabled', false);
	$('#user_name_box').attr('disabled', false);
	$('#user_birth_box').attr('disabled', false);
	$('#user_address_box').attr('disabled', false);
	$('#user_phone_box').attr('disabled', false);
	
	$('#user_update_btn').css('display', 'none');
	$('#user_save_btn').css('display', 'inline-block');
}

function setUserDetailData(data) {
	var row = data[0];
	
	var smartId = row.smartId;
	var idLength = 4 - smartId.length;
	for (var j = 0; j < idLength; j++) {
		smartId = '0' + smartId;
	}
	smartId = 'SA-S' + smartId;
	
	$('#user_sensor_box').attr('disabled', true);
	$('#user_smart_box').attr('disabled', true);
	$('#user_name_box').attr('disabled', true);
	$('#user_birth_box').attr('disabled', true);
	$('#user_address_box').attr('disabled', true);
	$('#user_phone_box').attr('disabled', true);
	
	$('#user_sensor_box').val(row.sensorId);
	$('#user_smart_box').val(smartId);
	$('#user_name_box').val(row.name);
	$('#user_birth_box').val((row.birth).replace(/\//g,''));
	$('#user_address_box').val(row.address);
	$('#user_phone_box').val(row.phoneNumber);
	$('#user_update_btn').css('display', 'inline-block');
	$('#user_save_btn').css('display', 'none');
}


function closePopup() {
	clearPopup();
    $('#popup_area').dialog('close');
}

function checkSmartId() {
	var smartId = $('#user_smart_box').val();
	var flag = false;
	var pattern = /^SA-S\d{4}$/;
	
	if (!pattern.test(smartId)) {
		alert("Station ID 형식과 맞지 않습니다.\nID 형식은 아래와 같습니다.\n예)SA-S0000");
		return flag;
	}
	
	const jsonObj = {};
	
	smartId = smartId.replace('SA-S', '');
	
	smartId = parseInt(smartId);

	if (typeof(selectedData) != 'undefined' && selectedData != '' && 
			selectedData[0].smartId == smartId) {
		flag = true;
		return flag;
	}

	jsonObj.smartId = smartId;

    $.ajax(
        {
            type       : "POST",
            url        : "/select/girlSafe.isSmartId/action.do",
            dataType   : "json",
            data       : {
            	"param" : JSON.stringify(jsonObj)
            },
            async      : false,
            beforeSend : function(xhr) {
                // 전송 전 Code
            }
        }).done(function (result) {
        	var cnt = result[0].cnt;
        	if (cnt == 0) {
        		flag = true;
        	} else {
        		alert("이미 사용중인 Station ID 입니다.");
        	}
    }).fail(function (xhr) {
        alert("등록 실패");
    }).always(function() {

    });
    
	return flag;
}

function checkSensorId() {
	var sensorId = $('#user_sensor_box').val();
	var flag = false;
	var pattern = /^SA-I\d{4}$/;
	
	if (!pattern.test(sensorId)) {
		alert("Sensor ID 형식과 맞지 않습니다.\nID 형식은 아래와 같습니다.\n예)SA-I0000");
		return false;
	}
	
	const jsonObj = {};

	if (typeof(selectedData) != 'undefined' && selectedData != '' && 
			selectedData[0].sensorId == sensorId) {
		flag = true;
		return flag;
	}
	
	jsonObj.sensorId = sensorId;
	
    $.ajax(
            {
                type       : "POST",
                url        : "/select/girlSafe.isSensorId/action.do",
                dataType   : "json",
                data       : {
                	"param" : JSON.stringify(jsonObj)
                },
                async      : false,
                beforeSend : function(xhr) {
                    // 전송 전 Code
                }
            }).done(function (result) {
            	var cnt = result[0].cnt;
            	if (cnt == 0) {
            		flag = true;
            	} else {
            		alert("이미 사용중인 Sensor ID 입니다.");
            	}
        }).fail(function (xhr) {
            alert("등록 실패");
        }).always(function() {

        });
	
	return flag;
}

function checkPhoneNumber() {
	var phoneNumber = $('#user_phone_box').val();
	var flag = false;
	var pattern = /^010\d{8}$/;
	
	phoneNumber = phoneNumber.replace(/-/g, "");
	
	if (!pattern.test(phoneNumber)) {
		alert("핸드폰 번호 형식에 맞지 않습니다.\n형식은 아래와 같습니다.\n예)01012345678 또는 010-1234-4382");
		return flag;
	}
	
	const jsonObj = {};

	if (typeof(selectedData) != 'undefined' && selectedData != '' && 
			selectedData[0].phoneNumber == phoneNumber) {
		flag = true;
		return flag;
	}
	
	jsonObj.phoneNumber = phoneNumber;

    $.ajax(
        {
            type       : "POST",
            url        : "/select/girlSafe.isPhoneNumber/action.do",
            dataType   : "json",
            data       : {
            	"param" : JSON.stringify(jsonObj)
            },
            async      : false,
            beforeSend : function(xhr) {
                // 전송 전 Code
            }
        }).done(function (result) {
        	var cnt = result[0].cnt;
        	if (cnt == 0) {
        		flag = true;
        	} else {
        		alert("이미 사용중인 핸드폰 번호 입니다.");
        	}
    }).fail(function (xhr) {
        alert("등록 실패");
    }).always(function() {

    });
	
	return flag;
}

function checkBirth() {
	var birth = $('#user_birth_box').val();
	var flag = false;
	var pattern = /\d{8}$/;
	
	if (!pattern.test(birth)) {
		alert("생년월일 형식에 맞지 않습니다.\n형식은 아래와 같습니다.\n예)19900222");
	} else {
		flag = true;
	}
	
	return flag;
}

function checkNull(val) {
	var flag = false;
	
	if (val != '' && val != null && typeof val != 'undefined') {
		flag = true;
	}
	
	return flag;
}

function modifyUser() {
	var sensorId = $('#user_sensor_box').val();
	var smartId = $('#user_smart_box').val().replace('SA-S', '');
	var name = $('#user_name_box').val();
	var birth = $('#user_birth_box').val();
	var address = $('#user_address_box').val();
	var phoneNumber = $('#user_phone_box').val();
	
	if (!checkSmartId()) {
		return;
	}
	
	if (!checkSensorId()) {
		return;
	}
	
	if (!checkPhoneNumber()) {
		return;
	}
	
	if (!checkBirth()) {
		return;
	}
	
	if (!checkNull(name)) {
		alert("이름을 입력해 주십시오.");
		return;
	}
	
	if (!checkNull(address)) {
		alert("주소를 입력해 주십시오.");
		return;
	}
	
	smartId = parseInt(smartId);
	
	const jsonArray1 = [];
	const jsonArray2 = [];
	const jsonArray3 = [];
	const jsonArray4 = [];
	
	const jsonObj = {};

    jsonObj.rowStatus = "C";
	jsonObj.sensorId = sensorId;
	jsonObj.smartId = smartId;
	jsonObj.name = name;
	jsonObj.birth = birth;
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