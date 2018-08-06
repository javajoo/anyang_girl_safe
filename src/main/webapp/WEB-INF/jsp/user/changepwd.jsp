<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%
 /**
  * @Class Name : changepwd.jsp
  * @Description : changepwd 화면
  * @Modification Information
  * 
  * @author 김동식
  * @since 2018-05-14
  * @version 1.0
  * @see
  *  
  * Copyright (C) All right reserved.
  */
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${admin.USER_NM_KO} 사용자 비밀번호수정</title>

<link href="/css/ucp_style.css" rel="stylesheet" type="text/css">
<link href="/css/jqgrid/ui.jqgrid.barun.css" rel="stylesheet" type="text/css">

<script src="/js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="/js/jquery-ui-1.11.4.custom/jquery-ui.min.js" type="text/javascript"></script>
<script src="/js/jquery.number.min.js" type="text/javascript"></script>
<script src="/js/selectBox.js" type="text/javascript"></script>
<script src="/js/ucp_common.js" type="text/javascript"></script>
<script src="/js/socket/socket.io.js" type="text/javascript"></script>

<script src="/js/jqgrid/jquery.jqGrid.min.js" type="text/javascript"></script>
<script src="/js/jqgrid/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="/js/jqgrid/jquery.jqGrid.min.js" type="text/javascript"></script>
<script src="/js/jqgrid/jquery.tablednd.js" type="text/javascript"></script>
<script src="/js/jqgrid/jquery.contextmenu.js" type="text/javascript"></script>


<script type="text/javascript">
$(document).ready(function(){

	$(".btnOk").bind("click",function(){
		if($("#pwd1").val().trim() != $("#pwd2").val().trim())
		{
			alert("신규 비밀번호가 동일하지 않습니다.");
			return false;
		} 
		var url = "<c:url value='/wrks/lgn/changepwdjson.do'/>";
		var params = "pwdOld=" + $("#pwdOld").val();
			params += "&pwdNew=" + $("#pwd1").val().trim();

		$.ajaxEx(null,
		{
			  url : url
			, dataType : "json"
			, data: params
			, success:function(data){
				alert(data.msg);
				window.close();
			}
			, error:function(e){
				alert(e.responseText);
			}
		});
	});
});
</script>
</head>
<body>
<div id="wrapperPop">
	<!-- container -->
	<div class="container">
		<div class="topArea"></div>
		<!-- content -->
		<div class="content">
			<div class="titArea">
				<h3 class="tit">비밀번호 변경</h3>
			</div>
			<div class="tableType2 mb30">
				<table>
				<caption>비밀번호 변경</caption>
				<colgroup>
					<col style="width: 150px;" />
					<col style="width: *" />
					<col style="width: 150px;" />
					<col style="width: *" />
				</colgroup>
				<tbody>
				<tr>
					<th>기존 비밀번호</th>
					<td><input type="password" name="" id="pwdOld" class="txtType"></td>
				</tr>
				<tr>
					<th>신규 비밀번호</th>
					<td><input type="password" name="" id="pwd1" class="txtType"></td>
				</tr>
					<th>비밀번호 확인</th>
					<td colspan="3"><input type="password" name="" id="pwd2" class="txtType"></td>
				</tr>
				</tbody>
				</table>
			</div>
			<div class="btnWrap btnR">
				<a href="javascript:;" class="btn btnDt btnOk">확인</a>
			</div>
		</div>
		<!-- //content -->
	</div>
	<!-- //container -->
</div>
</body>
</html> 

