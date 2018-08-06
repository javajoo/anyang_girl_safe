<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ page isELIgnored="false"%>
<spring:eval expression="@config" var="configProp" scope="request" />
<c:set var="rootPath" value="${pageContext.request.contextPath}" scope="request" />
<c:set var="exeEnv" value="${configProp['configure.exeEnv']}" scope="request" />
<c:set var="dstrtCd" value="${configProp['configure.dstrtCd']}" scope="request" />
<c:set var="ucpId" value="${configProp['Globals.SiteId']}" scope="request" />
<script type="text/javascript" src="<c:url value='/js/socket/socket.io.js' />"></script>
<!-- Socket 통신 -->
<script>
	var contextRoot = '<c:out value="${pageContext.request.contextPath}" />';

	$(function() {
		try 
		{
			/* var socket = io.connect('http://121.140.40.52:10023'); */
			var socket = io.connect('http://127.0.0.1:10023');
			socket.on('response', function(evt) {
				console.log('[EVENT] Event Received : ' + JSON.stringify(evt));
				var sensorId = evt.sensorId; 
				var emergency = evt.emergency;
				

				var sPath = window.location.pathname;
				var sPage = sPath.substring(sPath.lastIndexOf('/') + 1);

				console.log('[EVENT] authority check.' + contextRoot + ':' + sensorId);
				jsonObj = {};
				jsonObj.sensorId = sensorId; 
				 $.ajax(
				{
					type       : "POST",
					url        : "${pageContext.request.contextPath}/select/girlSafe.getHwInfo/action.do",
					dataType   : "json",
					data       : {"param" : JSON.stringify(jsonObj)},
					async      : false,
					beforeSend : function(xhr)
					{
					    // 전송 전 Code
					}
				}).done(function (result) {
					var audio = new Audio(contextRoot + '/sound/siren.mp3');
					audio.play();
					layerClean(eventLayer);
					search_home();
					map.setCenter(new OpenLayers.LonLat(result[0].pointX, result[0].pointY).transform(new OpenLayers.Projection("EPSG:4326"),new OpenLayers.Projection("EPSG:900913")));
				}).fail(function (xhr) {
					alert("실패");
				}).always(function() {
				
				});
				
			});
		}
		catch (err) 
		{
			console.log('io.connect(url) - error :  ' + err);
		}
	});
</script>