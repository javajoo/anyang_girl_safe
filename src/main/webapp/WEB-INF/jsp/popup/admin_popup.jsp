<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area" id="user_popup">
	<div class="cont_inner" title="">
		<ul class="popup_list_condi">
			<li class="list">
				<div class="popup_list_title">
					<em>아이디</em>
				</div>
				<div class="popup_list_cont">
					<input type="hidden" id="admin_seq_no">
					<input type="text" id="admin_id_box" class="easyui-textbox" 
						placeholder="내용을 입력해 주세요."/>
				</div>
			</li>
			<li class="list">
				<div class="popup_list_title">
					<em>패스워드</em>
				</div>
				<div class="popup_list_cont">
					<input type="password" id="admin_password_box" class="easyui-textbox" 
						placeholder="내용을 입력해 주세요."/>
				</div>
			</li>
			<li class="list">
				<div class="popup_list_title">
					<em>패스워드 확인</em>
				</div>
				<div class="popup_list_cont">
					<input type="password" id="admin_password2_box" class="easyui-textbox" 
						placeholder="내용을 입력해 주세요."/>
				</div>
			</li>
			<li class="list">
				<div class="popup_list_title">
					<em>이름</em>
				</div>
				<div class="popup_list_cont">
					<input type="text" id="admin_name_box" class="easyui-textbox" 
						placeholder="내용을 입력해 주세요."/>
				</div>
			</li>
			<li class="list">
				<div class="popup_list_title">
					<em>생년월일</em>
				</div>
				<div class="popup_list_cont">
					<input type="text" id="admin_birthday_box" class="easyui-textbox" 
						placeholder="내용을 입력해 주세요."/>
				</div>
			</li>
			<li class="list" id="user_age_area">
				<div class="popup_list_title">
					<em>번호</em>
				</div>
				<div class="popup_list_cont">
					<input type="text" id="admin_phoneNumber_box" class="easyui-textbox"
						placeholder="내용을 입력해 주세요."/>
				</div>
			</li>
			<li class="list">
				<div class="popup_list_title">
					<em>메일</em>
				</div>
				<div class="popup_list_cont">
					<input type="text" id="admin_email_box" class="easyui-textbox"
						placeholder="내용을 입력해 주세요."/>
				</div>
			</li>
			<li class="list">
				<div class="popup_list_title">
					<em>주소</em>
				</div>
				<div class="popup_list_cont">
					<input type="text" id="admin_address_box" class="easyui-textbox"
						placeholder="내용을 입력해 주세요."/>
				</div>
			</li>
			<li class="list">
				<div class="popup_list_title">
					<em>등급</em>
				</div>
				<div class="popup_list_cont">
					<select class="easyui-combobox" id="admin_rank_box">
						<option value="1">최고 관리자</option>
						<option value="2">관리 담당자</option>
						<option value="3">운영자</option>
					</select>
				</div>
			</li>
		</ul>
		<ul class="popup_list_ty_full">
			<li class="btn_list">
				<div class="list_cont">
					<a href="#" id="user_cancel_btn" class="eventR_button_list" onclick="closePopup()">취소</a>
				</div>
				<div class="list_cont">
					<!-- <a href="#" id="admin_update_btn" class="eventR_button_list" 
						onclick="onAdminUpdatePopup()" style="display: none;">수정</a> -->
					<a href="#" id="admin_update_btn" class="eventR_button_list"  onclick="updateAdmin()" style="display: none;">수정</a>
					<a href="#" id="admin_save_btn" class="eventR_button_list" onclick="saveAdmin()">저장</a>
				</div>
			</li>
		</ul>
	</div>
</div>
<script>
$(document).ready(function(){
	$('#popup_area')[0].style.overflow = 'hidden';
	console.log(selectedData);
	if (typeof(selectedData) != 'undefined' && selectedData != '') {
		setAdminDetailData(selectedRow, selectedData);
	}
});

function setAdminDetailData(row, data) {
	var row = data[row];
	
	$('#admin_id_box').attr('disabled', true);
	
	$('#admin_seq_no').val(data.seqNo);
	$('#admin_id_box').val(data.id);
	//$('#admin_password_box').val(data.password);
	$('#admin_name_box').val(data.name);
	$('#admin_birthday_box').val(data.birthday);
	$('#admin_phoneNumber_box').val(data.phoneNumber);
	$('#admin_email_box').val(data.email);
	$('#admin_address_box').val(data.address);
	$('#admin_rank_box').val(data.rank);
	$('#admin_update_btn').css('display', 'inline-block');
	$('#admin_save_btn').css('display', 'none');
}


function closePopup() {
	clearPopup();
    $('#popup_area').dialog('close');
}

function updateAdmin() {
	const jsonObj = {};
	
	var password = $('#admin_password_box').val();
	var password2 = $('#admin_password2_box').val();
	if(password != '') {
		if(password != password2) {
			alert("비밀번호가 일치 하지 않습니다.");
			return false;
		}
		else jsonObj.password = $('#admin_password_box').val();
	}
	jsonObj.singleInsertSid = "girlSafe.updateAdmin";
	jsonObj.seqNo = $('#admin_seq_no').val();
    jsonObj.name = $('#admin_name_box').val();
	jsonObj.birthday = $('#admin_birthday_box').val();
	jsonObj.phoneNumber = $('#admin_phoneNumber_box').val();
	jsonObj.email = $('#admin_email_box').val();
	jsonObj.address = $('#admin_address_box').val();
	jsonObj.rank = $('#admin_rank_box').val();

    $.ajax(
        {
            type       : "POST",
            url        : "/multiAjax/action.do",
            dataType   : "json",
            data : {"param" : JSON.stringify(jsonObj)},
            async      : false,
            beforeSend : function(xhr) {
                // 전송 전 Code
            }
        }).done(function (result) {
        if (result == "SUCCESS")
        {
            $('#userApprovalList_table').datagrid('reload');
            alert("수정 완료");
        }
        else
        {
            alert("수정 실패");
        }
        closePopup();
    }).fail(function (xhr) {
        alert("수정 실패");
    }).always(function() {

    });
}

function saveAdmin() {
	const jsonObj = {};
	
	var password = $('#admin_password_box').val();
	var password2 = $('#admin_password2_box').val();
	if(password != '') {
		if(password != password2) {
			alert("비밀번호가 일치 하지 않습니다.");
			return false;
		}
		else jsonObj.password = $('#admin_password_box').val();
	}
	
	jsonObj.singleInsertSid = "girlSafe.insertAdmin";
	jsonObj.seqNo = $('#admin_seq_no').val();
    jsonObj.name = $('#admin_name_box').val();
	jsonObj.birthday = $('#admin_birthday_box').val();
	jsonObj.phoneNumber = $('#admin_phoneNumber_box').val();
	jsonObj.email = $('#admin_email_box').val();
	jsonObj.address = $('#admin_address_box').val();
	jsonObj.rank = $('#admin_rank_box').val();

    $.ajax(
        {
            type       : "POST",
            url        : "/multiAjax/action.do",
            dataType   : "json",
            data : {"param" : JSON.stringify(jsonObj)},
            async      : false,
            beforeSend : function(xhr) {
                // 전송 전 Code
            }
        }).done(function (result) {
        if (result == "SUCCESS")
        {	
        	$('#userApprovalList_table').datagrid('reload');
        	alert("등록 완료");
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