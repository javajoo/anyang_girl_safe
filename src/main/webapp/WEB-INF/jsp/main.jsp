<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ page session="false" %>
<!doctype html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>여성안심 서비스</title>
	
	<jsp:include page="/WEB-INF/jsp/include/js.jsp" />
	<jsp:include page="/WEB-INF/jsp/include/css.jsp" />
	<jsp:include page="/WEB-INF/jsp/include/socket.jsp" />

</head>
<body>
	<div class="title_area" data-options="region:'north'">
       	<jsp:include page="/WEB-INF/jsp/include/top.jsp" />
   	</div>
   	<div id="gis_layout" class="easyui-layout" style="">
   		<jsp:include page="/WEB-INF/jsp/map.jsp" />
   	</div>
   	<!-- 푸터 -->
	<div id="footer">
		
	</div>
	
	
</body>
</html>