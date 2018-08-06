<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
	//탑메뉴 범용 스크립트
	//로그아웃
	function ucp_logout(){
			if(typeof(opener)!="undefined") {
				//opener.parent.cm_logout();
				location.href = "/danu/com/platform/logout.do";
			} else {
				location.href = "/danu/com/platform/logout.do";
			}
	}  
</script>
<c:set var="mc11" scope="request" value="test"/>
	<div class="topbar">
        <div class="logo">
			<c:if test="${admin.authority ne 'A'}"><a href="/main.do"></c:if>
			<c:choose>
	    		<c:when test="${admin.authority=='P'}"><img alt="112긴급지원" src="/images/layout/logo_112.png"></c:when>
	    		<c:when test="${admin.authority=='F'}"><img alt="119긴급지원" src="/images/layout/logo_119.png"></c:when>
	    		<c:when test="${admin.authority=='W'}"><img alt="사회적약자" src="/images/layout/logo_disadvantaged.png"></c:when>
	    		<c:when test="${admin.authority=='S'}"><img alt="안심귀가" src="/images/layout/logo_safe.png"></c:when>
	    		<c:when test="${admin.authority=='D'}"><img alt="재난긴급지원" src="/images/layout/logo_disaster.png"></div></c:when>
	    		<c:when test="${admin.authority=='E'}"><img alt="환경IoT" src="/images/layout/logo_iot.png"></c:when>
	    		<c:otherwise><img alt="U-City통합플랫폼" src="/images/layout/logo_control.png"></c:otherwise>
	    	</c:choose>            		
			<c:if test="${admin.authority ne 'A'}"></a></c:if>
        </div>
        <div class="navbar">
            <ul>
           	<c:if test="${admin.authority ne 'A'}"><!-- 특정권한 -->
                <li<c:if test="${param.mc=='1'}"> class="on"</c:if>><a id="topmenu_monitoring" href="javascript:openWindowCode()">상황관제</a></li>
				<li<c:if test="${param.mc=='2'}"> class="on"</c:if>><a id="topmenu_history" href="/situationHistory.do">상황이력</a></li>
			</c:if>
				
			<c:if test="${admin.authority eq 'A'}"><!-- 전체권한 -->
				<li<c:if test="${param.mc=='6'}"> class="on"</c:if>><a id="topmenu_info" href="/situationInfo.do">상황정보</a></li>
				<li<c:if test="${param.mc=='7'}"> class="on"</c:if>><a id="topmenu_pocess" href="/workProcess.do">업무처리</a></li>
			</c:if>
				<li<c:if test="${param.mc=='3'}"> class="on"</c:if>><a id="topmenu_stats" href="/situationStats.do">상황통계</a></li>
				<li<c:if test="${param.mc=='4'}"> class="on"</c:if>><a id="topmenu_cop" href="/cop.do">커뮤니티</a></li>
				<li<c:if test="${param.mc=='5'}"> class="on"</c:if>><a id="topmenu_system" href="/system.do">시스템</a></li>
				
             </ul>
        </div>
        <div class="user">
           <a href="#"><span>${admin.USER_NM_KO}</span></a>
           <ul class="userMenu">
                <li><a href="/wrks/lgn/myinfo.do" class="popwin" width="850" height="730">사용자정보</a></li>
                <li><a href="/wrks/lgn/changepwd.do" class="popwin" width="850" height="380">비밀번호변경</a></li>
                <li><a href="javascript: ucp_logout()">Logout</a></li>
            </ul>
        </div>
    </div>