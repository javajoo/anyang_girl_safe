<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>시스템</title>



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
	$.manuHandler('44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2', '');
});

	function isNumber(num)
	{
		re = /^[\+-]?[0-9]*[0-9]$/;
		if (re.test(num)) {
			return true;
		}
		return false;
	}

	function fn_cctvRadiusMerge()
	{
		var radsRoute = $("#radsRoute").val();
		var radsClmt = $("#radsClmt").val();
		var mntrLeftWidth = $("#mntrLeftWidth").val();
		var mntrRightWidth = $("#mntrRightWidth").val();
		var mntrBottomHeight = $("#mntrBottomHeight").val();
		var popWidth = $("#popWidth").val();
		var popHeight = $("#popHeight").val();
		var autoEndTime = $("#autoEndTime").val();
		
		var basePlaybacktime = $("#basePlaybacktime").val();
		var maxbfPlaybacktime = $("#maxbfPlaybacktime").val();
		var maxafPlaybacktime = $("#maxafPlaybacktime").val();
		var playTime = $("#playTime").val();
		
		
		$("#gisViewTy").val($("input[name=gisViewKnd]:checked").val());

		if (isNumber(radsRoute) && isNumber(radsClmt) && isNumber(mntrLeftWidth) && isNumber(mntrRightWidth) && isNumber(mntrBottomHeight) && isNumber(popWidth) && isNumber(popHeight) && isNumber(autoEndTime) ) {
			document.frm.action = "/wrks/sstm/rdus/cctvRadiusMerge.do";
			document.frm.submit();
		} else {
			alert("숫자만 입력 가능합니다.");
		}
		
	}

</script>
</head>
<body>
<div id="wrapper">
	<!-- topbar -->
	<jsp:include page="include/topMenu.jsp" >
	<jsp:param name="mc" value="5"/>
	</jsp:include>
	<!-- //topbar -->
	<!-- container -->
	<div class="container">
		<!-- leftMenu -->
		




        <div class="leftMenu">
<ul>
	<li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">환경설정</a>
	<ul>
		<li class="user-select"><a href="/system.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=45b5a59f-e94b-4d2e-aa92-ba1760c595b3">관제화면옵션설정</a></li>
		<!-- <li class=""><a href="/wrks/sstm/rdus/dis_evt.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=2e1e01e9-9fcc-4e32-8e40-2e699fab182f">재난 세부분류별 표출이벤트</a></li>
		<li class=""><a href="/wrks/sstm/rdus/auto_dis.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=35626504-8693-49cb-b194-50eff61ff4db">자동표출이벤트항목관리</a></li> -->
	</ul>
	</li>
	<li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">사용자정보</a>
	<ul>
		<li class=""><a href="/wrks/sstm/usr/info.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=848e773f-8686-4515-8f17-4d5650e36936">사용자관리</a></li>
		<li class=""><a href="/wrks/sstm/usr/area.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=6b9398b2-0047-41bf-9d5b-8af7650d515e">지역별사용자</a></li>
	</ul>
	</li>
	<li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">그룹정보</a>
	<ul>
		<li class=""><a href="/wrks/sstm/grp/code.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=413e7d5e-dad4-4c90-821c-70ee1c14f814">그룹관리</a></li>
		<li class=""><a href="/wrks/sstm/grp/user_acc.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=494b3ae3-1518-42bf-8456-0759c3bfd566">그룹별이벤트(사용자권한)</a></li>
		<li class=""><a href="/wrks/sstm/grp/user.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=2692c263-c575-4c9c-948c-7dd26074210d">그룹별사용자조회</a></li>
		<li class=""><a href="/wrks/sstm/grp/auth.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=199c6208-a977-4977-a096-07aea050b3ed">그룹별권한레벨관리</a></li>
		<li class=""><a href="/wrks/sstm/grp/role.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=18ceb0d3-31af-46ee-92bd-53afca873a90">롤관리</a></li>
		<li class=""><a href="/wrks/sstm/grp/auth_role.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=8b879ee6-9945-4dbe-bc57-6a0d095b0595">그룹권한레벨별롤</a></li>
	</ul>
	</li>
	<!-- <li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">모바일</a>
	<ul>
		<li class=""><a href="/wrks/sstm/mbl/version.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=d438ed42-227a-4e94-9712-e2b163d488a0">모바일앱버젼정보관리</a></li>
		<li class=""><a href="/wrks/sstm/mbl/info.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=e6154242-e44c-422f-8e51-b137dc21a5ac">모바일기기정보</a></li>
	</ul>
	</li> -->
</ul>
        <!--
		
			
			
			
			
			
	            <ul>
	                <li><a href="" id="" class="ic_code">코드관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/code/cmcd.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=0">공통코드그룹</a></li>
	                        <li><a href="/wrks/sstm/code/dtcd.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=0">코드상세</a></li>
	                        <li><a href="/wrks/sstm/code/sycd.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=0">시스템코드</a></li>
	                        <li><a href="/wrks/sstm/code/sggcd.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=0">시군구코드</a></li>
	                        <li><a href="/wrks/sstm/code/dst.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=0">지구코드</a></li>
	                        <li><a href="/wrks/sstm/code/area.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=0">지역코드</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_user">사용자관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/usr/info.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=1">사용자관리</a></li>
	                        <li><a href="/wrks/sstm/usr/area.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=1">지역별사용자</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_group">그룹정보</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/grp/code.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=2">그룹관리</a></li>
	                        <li><a href="/wrks/sstm/grp/user_acc.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=2">그룹별이벤트(사용자권한)</a></li>
	                        <li><a href="/wrks/sstm/grp/user.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=2">그룹별사용자조회</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">모바일</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/mbl/grp.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=3">그룹관리</a></li>
	                        <li><a href="/wrks/sstm/mbl/info.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=3">계정정보</a></li>
	                        <li><a href="/wrks/sstm/mbl/version.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=3">버젼정보관리</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">이벤트관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/evnt/base.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=4">이벤트기본정보</a></li>
	                        <li><a href="/wrks/sstm/evnt/item.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=4">이벤트세부항목</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">메뉴관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/menu/info.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=5">프로그램정보</a></li>
	                        <li><a href="/wrks/sstm/menu/menu.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=5">프로그램메뉴</a></li>
	                        <li><a href="/wrks/sstm/menu/grp.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=5">그룹별프로그램메뉴</a></li>
	                        <li><a href="/wrks/sstm/menu/user.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=5">사용자별프로그램메뉴</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">상황처리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/evtctl/info.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=7">상황관리</a></li>
	                        <li><a href="/wrks/sstm/evtctl/trans_recv.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=7">상황전달수신자관리</a></li>
	                        <li><a href="/wrks/sstm/evtctl/disp_mbl.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=7">표출단말관리</a></li>
	                        <li><a href="/wrks/sstm/evtprc/info.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=7">상황처리</a></li>
	                    </ul>
	                </li>
	            </ul>
			
		
		-->
        </div>

		<!-- //leftMenu -->
		<!-- content -->
		<div class="contentWrap">
			<div class="topArea">
				<a href="#" class="btnOpen"><img src="/images/btn_on_off.png" alt="열기/닫기"></a>
                <h2 class="tit">시스템</h2> 
                <div class="location">
                    <span>Home</span>  &gt; <span>환경설정</span>
                </div>
	    <!--
                <h2 class="tit">시스템</h2> 
                <div class="location">
                    <span>Home</span> &gt; <span>코드관리</span> &gt; <span>시스템코드</span>
                </div>
	    -->
			</div>
			<div class="content">
				<div class="titArea">
					<h3 class="tit">환경설정</h3>
				</div>
			<br/>
			<form name="frm" action="/wrks/sstm/rdus/cctvRadiusMerge.do" method="post">
			<input type="hidden" id="dstrtCd" name="dstrtCd" value="467" />
			<input type="hidden" id="userId" name="userId" value="user112" />
			<!-- 전자정부 패키지를 사용하기 위하여 메뉴에 대한 정보를 설정 -->
			<input type="hidden" id="child" name="child" value="45b5a59f-e94b-4d2e-aa92-ba1760c595b3" />
			<input type="hidden" id="top" name="top" value="44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2" />
			<input type="hidden" id="left" name="left" value="" />
			<input type="hidden" id="gisViewTy" name="gisViewTy" value="0" />
				<div class="tableTypeFree">
				<div class="tit"><h1>지도보기기준</h1></div>
				<table>
				<caption>지도보기기준</caption>
				<colgroup>
					<col style="width: 180px;" />
					<col style="width: *" />
				</colgroup>
				<tr>
					<th>지도보기기준</th>
					<td>
						<input type="radio" name="gisViewKnd" id="gisViewKnd" value="0" checked="checked" user-title="지도보기기준"/>  일반
						<input type="radio" name="gisViewKnd" id="gisViewKnd" value="1"  user-title="지도보기기준"/>  항공
					</td>
				</tr>
				</table>
				</br>
				<div class="tit"><h1>상황 자동종료 설정</h1></div>
				<table>
				<caption>지도보기기준</caption>
				<colgroup>
					<col style="width: 180px;" />
					<col style="width: *" />
				</colgroup>
				<tr>
					<th>자동종료시간</th>
					<td>
						<input type="text" name="autoEndTime" id="autoEndTime" class="date8Type" maxlength="5" value="0" user-title="자동종료시간"/>  (분)
					</td>
				</tr>
				</table>
				</br>
				<div class="tit"><h1>반경설정</h1></div>
				<table>
				<caption>반경설정</caption>
				<colgroup>
					<col style="width: 180px;" />
					<col style="width: *" />
					<col style="width: 180px;" />
					<col style="width: *" />
				</colgroup>
				<tr>
					<th>경로상 주변 표시 반경</th>
					<td>
						<input type="text" name="radsRoute" id="radsRoute" class="date8Type" maxlength="5" value="500" user-title="경로상 주변 표시 반경"/> (M)
					</td>
					<th>발생위치 주변 표시 반경</th>
					<td>
						<input type="text" name="radsClmt" id="radsClmt" class="date8Type" maxlength="5" value="500" user-title="발생위치 주변 표시 반경"/> (M)
					</td>
				</tr>
				</table>
				</br>
				<div class="tit"><h1>CCTV팝업창크기</h1></div>
				<table>
				<caption>CCTV팝업창크기</caption>
				<colgroup>
					<col style="width: 180px;" />
					<col style="width: *" />
					<col style="width: 180px;" />
					<col style="width: *" />
				</colgroup>
				<tr>
					<th>넓이</th>
					<td>
						<input type="text" name="popWidth" id="popWidth" class="date8Type" maxlength="5" value="1024"  user-title="넓이"/>
					</td>
					<th>높이</th>
					<td>
						<input type="text" name="popHeight" id="popHeight" class="date8Type" maxlength="5" value="768" user-title="높이"/>
					</td>
				</tr>
				</table>
				</br>
				<div class="tit"><h1>관제화면폭설정</h1></div>
				<table>
				<caption>관제화면폭설정</caption>
				<colgroup>
					<col style="width: 180px;" />
					<col style="width: *" />
					<col style="width: 180px;" />
					<col style="width: *" />
					<col style="width: 180px;" />
					<col style="width: *" />
				</colgroup>
				<tr>
					<th>좌측넓이</th>
					<td>
						<input type="text" name="mntrLeftWidth" id="mntrLeftWidth" class="date8Type" maxlength="5" value="400" user-title="좌측넓이"/>
					</td>
					<th>우측넓이</th>
					<td>
						<input type="text" name="mntrRightWidth" id="mntrRightWidth" class="date8Type" maxlength="5" value="400"  user-title="우측넓이"/>
					</td>
					<th>하단높이</th>
					<td>
						<input type="text" name="mntrBottomHeight" id="mntrBottomHeight" class="date8Type" maxlength="5" value="350" user-title="하단높이"/>
					</td>
				</tr>
				</table>
				</br>
				
				
				<div class="tit"><h1>timeback설정</h1></div>
				<table>
				<caption>timeback설정</caption>
				<colgroup>
					<col style="width: 180px;" />
					<col style="width: *" />
				</colgroup>
				<tr>
					<th>기본 playbacktime</th>
					<td>
						<input type="text" name="basePlaybacktime" id="basePlaybacktime" class="date8Type" maxlength="5" value="5" user-title="기본 playbacktime"/>  (분) 발생일시기준.
					</td>
				</tr>
				</table>
				</br>				
				
				
			<table>
				<caption>timeback설정</caption>
				<colgroup>
					<col style="width: 180px;" />
					<col style="width: *" />
				</colgroup>
				<tr>
					<th>최대 playbacktime</th>
					<td>
						<input type="text" name="maxbfPlaybacktime" id="maxbfPlaybacktime" class="date8Type" maxlength="5" value="25" user-title="최대 playbacktime"/>  (분) 발생일시기준, 이전
					</td>
				</tr>
				</table>
			</br>						
				
				
			<table>
				<caption>timeback설정</caption>
				<colgroup>
					<col style="width: 180px;" />
					<col style="width: *" />
				</colgroup>
				<tr>
					<th>최대 playbacktime</th>
					<td>
						<input type="text" name="maxafPlaybacktime" id="maxafPlaybacktime" class="date8Type" maxlength="5" value="25" user-title="최대 playbacktime"/>  (분) 발생일시기준, 이후
					</td>
				</tr>
				</table>
			</br>					
				
				
				
			<table>
				<caption>기본재생시간</caption>
				<colgroup>
					<col style="width: 180px;" />
					<col style="width: *" />
				</colgroup>
				<tr>
					<th>기본재생시간</th>
					<td>
						<input type="text" name="playTime" id="playTime" class="date8Type" maxlength="5" value="5" user-title="최대 playbacktime"/>  (분) 재생시간기준, *0이면 중지시까지.
					</td>
				</tr>
				</table>
			</br>					
				
				
				
				
				

				
				
				
</div>

			</div>

			<div class="btnR">
				<a href="#" onclick="fn_cctvRadiusMerge();" class="btn btnSv">저장</a>
			</div>

			</form>
		</div>
			<!-- //content -->
	</div>
		<!-- //container -->
</div>
<!--  footer -->
<div id="footwrap">
	<div id="footer">
<div class="footerbar">
	<div id="info">
		<input type="hidden" id="gUserId" value="user112" />
	</div>
	<div class="navbar">
		<ul>
			<li>Smart-City</li>
		</ul>
	</div>
</div>



<script>

 //  alert('112' + ':'+ 'user112');
	/* 소켓연결  */
	//var url = $("#msgServerIp").val() + ":" + $("#msgServerPort").val();
	var url = '10.13.50.33';
	var port =  '65520';
	url += ":" + port;

	var socket = io.connect(url);
	//var userId = sesUserId;
	var userId = $('#gUserId').val();
	
	socket.emit('join', {room:userId});
	
	socket.on('invite', function(msg) {
		console.log('MSG Received : ' + JSON.stringify(msg));
		if(confirm(msg.msg) == false) return false;
		
		//roomJoin(roomNm, userList);	
		javascript:$.openMenuCenter('/wrks/wrkmng/msgmng/messenger_chat.do?roomNm='+escape(encodeURIComponent(msg.room))+'&userList='+msg.userid+'&grpSeqNo='+msg.grpSeqNo, 'CHAT', 510, 810);
 		

		
	});



</script></div>
</div>
<!-- //footer -->
</body>
</html>