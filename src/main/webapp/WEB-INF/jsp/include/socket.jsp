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
			//var socket = io.connect('http://121.140.40.52:10027');
			var socket = io.connect('http://172.20.14.5:10027');
			//var socket = io.connect('http://172.20.14.19:10027');
			//var socket = io.connect('http://58.76.192.101:10027');
			//var socket = io.connect('https://home-safety.anyang.go.kr:10027',{secure:true});
			socket.on('response', function(evt) {
				console.log('[EVENT] Event Received : ' + JSON.stringify(evt));
				var sensorId = evt.sensorId; 
				var emergency = evt.emergency;
				var sensorConn = evt.sensorConn;
				var sPath = window.location.pathname;
				var sPage = sPath.substring(sPath.lastIndexOf('/') + 1);

				console.log('[EVENT] authority check.' + contextRoot + ':' + sensorId);
				
					var audio = new Audio(contextRoot + '/sound/siren.mp3');
					var pointX;
					var pointY;
					if(emergency == '1'){
						audio.play();
					}
					layerClean(eventLayer);
					mapChange();
					if(sensorConn > 0){
						pointX = evt.pointX;
						pointY = evt.pointY;
					}
					else{
						pointX = evt.mPointX;
						pointY = evt.mPointY;
					}
					if (emergency > 0) {
						map.relayout();
						map.setLevel(2);
						map.setCenter(new kakao.maps.LatLng(pointY, pointX));					
					}
			});
		}
		catch (err) 
		{
			console.log('io.connect(url) - error :  ' + err);
		}
	});
</script>