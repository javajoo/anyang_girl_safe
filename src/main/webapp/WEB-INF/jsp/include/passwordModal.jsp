<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="<c:url value='../css/passwordModal.css' />" type="text/css">
<title></title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<script>
$(document).ready(function() {
    $("#btnReset").click(function() {
    	window.open("about:blank","_self").close();
         $("#passwordBoard").each(function() {
            this.reset();
         });
    });
});

function fn_egov_modify_password(){
	var orgPw = $("#orgPassword").val().trim();
	var newPw = $("#newPassword").val().trim();
	var confmPw = $("#confmPassword").val().trim();
	
	if(orgPw.trim() == ""){
		alert("기존비밀번호를 입력해주세요.");
		$("#orgPassword").focus();
		return;
	}
	if(newPw.trim() == ""){
		alert("변경비밀번호를 입력해주세요.");
		$("#newPassword").focus();
		return;
	}
	if(confmPw.trim() == ""){
		alert("변경비밀번호를 입력해주세요.");
		$("#newPassword").focus();
		return;
	}
	if(orgPw.trim() == newPw.trim()){
		alert("기존비밀번호와 변경비밀번호를 다르게 입력해주세요.");
		$("#newPassword").focus();
		return;
	}
	if(newPw.trim() != confmPw.trim()){
		alert("변경비밀번호가 일치하지 않습니다.");
		$("#confmPassword").focus();
		return;
	}
	if(newPw.length < 9){
		alert("9자리 이상 입력해주십시오.");
		$("#sPassword").focus();
		return;
	}
	if(newPw.search(/\s/) != -1){
		alert("비밀번호는 공백업이 입력해주십시오.");
		$("#sPassword").focus();
		return;
	}
	var num = newPw.search(/[0-9]/g);
	var eng = newPw.search(/[a-z]/ig);
	var spe = newPw.search(/[`~!@@#$%^&*|\\\'\";:\/?]/gi);
	if( (num < 0 || eng < 0 || spe < 0)){
		alert("영문,숫자,특수문자를 혼합하여 입력해주십시오.");
		$("#sPassword").focus();
		return;
	}
	var orgCnt;
	var jsonObj = {};
	jsonObj.orgPassword = $('#orgPassword').val();
	jsonObj.newPassword = $('#newPassword').val();
	
	$.ajax({
		type : "POST",
		url: "/uat/uia/passCheck.do",
		dataType : "json",
		data : {
               "param" : JSON.stringify(jsonObj)
           },
		async  : false,
		success: function(data){
			orgCnt=data.cnt;
		}
           , error:function(e){
   			alert(e.responseText);
   		}
	});

	
	if(orgCnt < 1){
		alert("기존비밀번호를 정확하게 입력해 주세요");
		$("#newPassword").focus();
		return;
	}
	
	if (confirm('<spring:message code="common.update.msg" />')) {
		$.ajax({
			type : "POST",
			url: "/uat/uia/updatePassword.do",
			dataType : "json",
			data : {
	               "param" : JSON.stringify(jsonObj)
	           },
			async  : false,
			success: function(data){
				if(data.cnt > 0){
					alert("수정이 완료 되었습니다.");
					window.open("about:blank","_self").close();
				}
				else{
					alert("수정실패");
					window.open("about:blank","_self").close();
				}
			}
	           , error:function(e){
	   			alert(e.responseText);
	   		}
		});
	}
}

function password_later() {
	var jsonObj = {};
	jsonObj.passFlag = 'later';
	$.ajax({
		type : "POST",
		url: "/uat/uia/updatePassword.do",
		dataType : "json",
		data : {
            "param" : JSON.stringify(jsonObj)
        },
		async  : false,
		success: function(data){
			window.open("about:blank","_self").close();
		}
	});
}
</script>
</head>
<body>
  <div class="modal" id="passwordModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close icon_close" data-dismiss="modal" aria-label="Close" id="btnReset"><span class="sr-only">닫기</span></button>
				<h1 class="modal-title">비밀번호 수정</h1>
			</div>
			<div class="modal-body">
				<form id="passwordBoard" name="passwordBoard" method="post" enctype="multipart/form-data" class="table_cnt form-horizontal text-center" onsubmit="return false;">				
					<table class="table">
						<caption class="sr-only"></caption>
						<tbody>
							<tr>
								<th scope="row">
									<label for="title" class="control-label">기존비밀번호</label>
								</th>
								<td>
									<input type="password" class="form-control" id="orgPassword" name="orgPassword" maxlength="20" value=''>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="title" class="control-label">변경비밀번호</label>
								</th>
								<td>
									<input type="password" class="form-control" id="newPassword" name="newPassword" maxlength="20" value=''>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="title" class="control-label">비밀번호확인</label>
								</th>
								<td>
									<input type="password" class="form-control" id="confmPassword" name="confmPassword" maxlength="20" value=''>
								</td>
							</tr>
						</tbody>
					</table>
					
					<button type="button" class="btn mt15 bg_sky" onclick="fn_egov_modify_password();">비밀번호 수정</button>
					<button type="button" data-dismiss="modal" class="btn mt15" onclick="passwordBoard.reset();">다시하기</button>
					<button type="button" data-dismiss="modal" class="btn mt15" onclick="password_later();">다음에변경하기</button>  
				</form>
			</div>
		</div>
	</div>
</div>
<%-- <input name="resultFlag" id="resultFlag" type="hidden" value="${loginVO.resultFlag}"/> --%>
</body>
</html>

