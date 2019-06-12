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
					<em>연락처</em>
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
					<em>소속</em>
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
						<option value="4">게스트</option>
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
					<a href="#" id="admin_delete_btn" class="eventR_button_list"  onclick="deleteAdmin()" style="display: none;">삭제</a>
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
	$('#admin_delete_btn').css('display', 'inline-block');
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
	var checkName = $('#admin_name_box').val();
	
	if(password != '') {
		if(password != password2) {
			alert("비밀번호가 일치 하지 않습니다.");
			return false;
		}
		else jsonObj.password = $('#admin_password_box').val();
	}
	
	if(!fn_pw_check(password)) {
		return false;
	}
	
	if(checkName == '' || checkName == 'undefined')
	{
		alert("이름을 입력해 주세요");
		return false;
	}
	
	jsonObj.singleInsertSid = "girlSafe.updateAdmin";
	jsonObj.seqNo = $('#admin_seq_no').val();
	jsonObj.id = $('#admin_id_box').val();
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

function deleteAdmin() {
	const jsonObj = {};
	
	jsonObj.singleDeleteSid = "girlSafe.deleteAdmin";
	jsonObj.seqNo = $('#admin_seq_no').val();
	
    $.ajax({
            type       : "POST",
            url        : "/multiAjax/action.do",
            dataType   : "json",
            data : {"param" : JSON.stringify(jsonObj)},
            async      : false,
            beforeSend : function(xhr) {
                // 전송 전 Code
            }
        }).done(function (result) {
        if (result == "SUCCESS") {
            $('#userApprovalList_table').datagrid('reload');
            alert("삭제 완료");
        }
        else {
            alert("삭제 실패");
        }
        closePopup();
    }).fail(function (xhr) {
        alert("삭제 실패");
    }).always(function() {

    });
}

function saveAdmin() {
	const jsonObj = {};
	
	var password = $('#admin_password_box').val();
	var password2 = $('#admin_password2_box').val();
	var checkName = $('#admin_name_box').val();
	var checkId = $('#admin_id_box').val();
	
	if(checkId.length < 5){
		alert("아이디를 5자리 이상 입력해 주세요");
		return false;
	}
	
	if(password != '') {
		if(password != password2) {
			alert("비밀번호가 일치 하지 않습니다.");
			return false;
		}
		else jsonObj.password = $('#admin_password_box').val();
	}
	
	if(!fn_pw_check(password)) {
		return false;
	}
	
	if(checkName == '' || checkName == 'undefined')
	{
		alert("이름을 입력해 주세요");
		return false;
	}
	
	const chekcDId =  (function() {
        let rtnVal;
        const jsonObj = {};
        jsonObj.id = $('#admin_id_box').val();
        
        $.ajax(
            {
                type       : "POST",
                url        : "/select/girlSafe.getCheckAdminId/action.do",
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
	
	if(chekcDId > 0){
		alert("이미 존재하는 아이디 입니다.");
		return false;
	}

	
	
	jsonObj.singleInsertSid = "girlSafe.insertAdmin";
	jsonObj.seqNo = $('#admin_seq_no').val();
	jsonObj.id = $('#admin_id_box').val();
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

function fn_pw_check(passWord) {
    var pw = passWord; //비밀번호
   

    pw_passed = true;


    var pattern1 = /[0-9]/;
    var pattern2 = /[a-zA-Z]/;
    var pattern3 = /[~!@\#$%<>^&*]/;     // 원하는 특수문자 추가 제거
    var pw_msg = "";

   if(!pattern1.test(pw)||!pattern2.test(pw)||!pattern3.test(pw)||pw.length<8||pw.length>50){
        alert("영문+숫자+특수기호 8자리 이상으로 구성하여야 합니다.");
        return false;

       
    }          

       var SamePass_0 = 0; //동일문자 카운트
    var SamePass_1 = 0; //연속성(+) 카운드
    var SamePass_2 = 0; //연속성(-) 카운드



    for(var i=0; i < pw.length; i++) {
         var chr_pass_0;
         var chr_pass_1;
         var chr_pass_2;
 
         if(i >= 2) {
             chr_pass_0 = pw.charCodeAt(i-2);
             chr_pass_1 = pw.charCodeAt(i-1);
             chr_pass_2 = pw.charCodeAt(i);
             
              //동일문자 카운트
             if((chr_pass_0 == chr_pass_1) && (chr_pass_1 == chr_pass_2)) {
                SamePass_0++;
              } 
              else {
               SamePass_0 = 0;
               }

              //연속성(+) 카운드
             if(chr_pass_0 - chr_pass_1 == 1 && chr_pass_1 - chr_pass_2 == 1) {
                 SamePass_1++;
              }
              else {
               SamePass_1 = 0;
              }
      
              //연속성(-) 카운드
             if(chr_pass_0 - chr_pass_1 == -1 && chr_pass_1 - chr_pass_2 == -1) {
                 SamePass_2++;
              } 
              else {
               SamePass_2 = 0;
              }  
         }     
          
        if(SamePass_0 > 0) {
           alert("동일문자를 3자 이상 연속 입력할 수 없습니다.");
           pw_passed=false;

          
         }



        if(SamePass_1 > 0 || SamePass_2 > 0 ) {
           alert("영문, 숫자는 3자 이상 연속 입력할 수 없습니다.");
           pw_passed=false;

          
         } 
         
         if(!pw_passed) {             
              return false;
              break;
        }
    }
    return true;
}
/* 2019.05.14 KMH 여성안심서비스 미비사항 수정 (관리자 권한에 따른 툴팁삽입 문제시 삭제) */
$(function() {
	$("#admin_rank_box").val(1).tooltip({
		position: 'right',
		content: '모든 기능을 사용하는 관리자입니다.'
	})
	$("#admin_rank_box").change(function(){
		if($("#admin_rank_box").val() == 1){
			$("#admin_rank_box").tooltip({
				position: 'right',
		    	content: '모든 기능을 사용하는 관리자입니다.'
		    });
		};
		if($("#admin_rank_box").val() == 2){
			$("#admin_rank_box").tooltip({
				position: 'right',
		    	content: '관리자 설정을 제외한 기능을 사용하는 관리자입니다.'
		    });
		};
		if($("#admin_rank_box").val() == 3){
			$("#admin_rank_box").tooltip({
				position: 'right',
		    	content: '가입자 관리, 공지사항, 관리자 설정을 제외한 기능을 사용하는 관리자입니다.'
		    });
		};
		if($("#admin_rank_box").val() == 4){
			$("#admin_rank_box").tooltip({
				position: 'right',
		    	content: '서비스 이력, SMS이력을 열람할 수 있는 게스트입니다.'
		    });
		};
	})
});

</script>