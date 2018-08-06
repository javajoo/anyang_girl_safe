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
<title>커뮤니티</title>



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



<script type="text/javascript" src="/js/egov/EgovBBSMng.js" ></script>
<script type="text/javascript">
$(document).ready(function(){
	$.manuHandler('08511a9f-f701-4720-913b-9e0cecd3cbf5', '');
});

    function press(event) {
        if (event.keyCode==13) {
            fn_egov_select_noticeList('1');
        }
    }

    function fn_egov_addNotice() {
    	var frm = document.frm;
        frm.action = "/wrks/cop/bbs/addBoardArticle.do";
        frm.submit();
    }
    
    function fn_egov_select_noticeList(pageNo) {
        document.frm.pageIndex.value = pageNo;
        document.frm.action = "/wrks/cop/bbs/selectBoardList.do";
        document.frm.submit();  
    }

	// 게시판 상세 보기
	function fn_egov_inqire_notice(bbsId, nttId)
	{
		//var frm = document.subForm;
		var frm = document.frm;
		frm.nttId.value = nttId;
		frm.bbsId.value = bbsId;
		frm.action = "/wrks/cop/bbs/selectBoardArticle.do";
		frm.submit();
	}
	var openWindowCode = function() {
		var open = window.open("/MainPage.do", "_blank", "channelmode=1,scrollbars=1,status=0,titlebar=0,toolbar=0,resizable=1");
		if(open==null){
			alert("팝업을 허용해 주세요.")
		}else{
			//open.moveTo(0,0); //메인모니터 이동
			//open.resizeTo(screen.width, screen.availHeight);
			//open.window.outerWidth = screen.availWidth;
        	//open.window.outerHeight = screen.availHeight;
			open.focus();
		}
	};
</script>

<title> 목록</title>

<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>

</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>    
<div id="wrapper">
	<!-- topbar -->
	<jsp:include page="include/topMenu.jsp" >
	<jsp:param name="mc" value="4"/>
	</jsp:include>
	<!-- //topbar -->
	<!-- container Start -->
	<div class="container">
		<!-- LeftMenu Start -->
		




        <div class="leftMenu">
			<ul>
        
			                <li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_on.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">커뮤니티</a>
			                    <ul>
		
						<li class=""><a href="/cop.do">공지사항</a></li>
						
			                </ul>
			                <!-- <li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">메신저</a>
			                    <ul>
		
						<li class=""><a href="javascript:$.openMenuCenter('/wrks/wrkmng/msgmng/messenger.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=58666281-d291-4826-aba9-003ced3fa053','메신저',500, 800)">메신저</a></li>
						
			                </ul>
			                <li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">웹메신저</a>
			                    <ul>
		
						<li class=""><a href="javascript:$.openMenuCenter('/wrks/msg/websocketMessengerMain.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=175078cc-ec93-431a-9ff9-a977cc9b15b1','웹메신저',500, 800)">웹메신저</a></li> -->
						    
	    		</ul>
	    		</li>
	        </ul>
        <!--
		
			
			
			
			
			
	            <ul>
	                <li><a href="" id="" class="ic_code">코드관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/code/cmcd.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=0">공통코드그룹</a></li>
	                        <li><a href="/wrks/sstm/code/dtcd.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=0">코드상세</a></li>
	                        <li><a href="/wrks/sstm/code/sycd.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=0">시스템코드</a></li>
	                        <li><a href="/wrks/sstm/code/sggcd.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=0">시군구코드</a></li>
	                        <li><a href="/wrks/sstm/code/dst.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=0">지구코드</a></li>
	                        <li><a href="/wrks/sstm/code/area.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=0">지역코드</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_user">사용자관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/usr/info.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=1">사용자관리</a></li>
	                        <li><a href="/wrks/sstm/usr/area.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=1">지역별사용자</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_group">그룹정보</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/grp/code.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=2">그룹관리</a></li>
	                        <li><a href="/wrks/sstm/grp/user_acc.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=2">그룹별이벤트(사용자권한)</a></li>
	                        <li><a href="/wrks/sstm/grp/user.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=2">그룹별사용자조회</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">모바일</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/mbl/grp.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=3">그룹관리</a></li>
	                        <li><a href="/wrks/sstm/mbl/info.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=3">계정정보</a></li>
	                        <li><a href="/wrks/sstm/mbl/version.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=3">버젼정보관리</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">이벤트관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/evnt/base.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=4">이벤트기본정보</a></li>
	                        <li><a href="/wrks/sstm/evnt/item.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=4">이벤트세부항목</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">메뉴관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/menu/info.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=5">프로그램정보</a></li>
	                        <li><a href="/wrks/sstm/menu/menu.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=5">프로그램메뉴</a></li>
	                        <li><a href="/wrks/sstm/menu/grp.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=5">그룹별프로그램메뉴</a></li>
	                        <li><a href="/wrks/sstm/menu/user.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=5">사용자별프로그램메뉴</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">상황처리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/evtctl/info.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=7">상황관리</a></li>
	                        <li><a href="/wrks/sstm/evtctl/trans_recv.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=7">상황전달수신자관리</a></li>
	                        <li><a href="/wrks/sstm/evtctl/disp_mbl.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=7">표출단말관리</a></li>
	                        <li><a href="/wrks/sstm/evtprc/info.do?top=08511a9f-f701-4720-913b-9e0cecd3cbf5&left=7">상황처리</a></li>
	                    </ul>
	                </li>
	            </ul>
			
		
		-->
        </div>

		<!-- LeftMenu End -->
		<!-- contentWrap Start -->
		<div class="contentWrap">
			<div class="topArea">
				<a href="#" class="btnOpen"><img src="/images/btn_on_off.png" alt="열기/닫기"></a>
				



        
                <h2 class="tit">커뮤니티</h2> 
                <div class="location">
                    <span>Home</span>  &gt; <span>커뮤니티</span>
                </div>
	    <!--
                <h2 class="tit">시스템</h2> 
                <div class="location">
                    <span>Home</span> &gt; <span>코드관리</span> &gt; <span>시스템코드</span>
                </div>
	    -->
			</div>
			<!-- content Start -->
			<div class="content">
				<!-- 검색 필드 박스 시작 -->
				<div class="titArea"><h3 class="tit"></h3></div>
				<div class="tableTypeHalf seachT">
					<form name="frm" action ="/wrks/cop/bbs/selectBoardList.do" method="post">
						<input type="hidden" name="bbsId" value="BBS_N_002" />
						<input type="hidden" name="nttId"  value="0" />
						<input type="hidden" name="bbsTyCode" value="" />
						<input type="hidden" name="bbsAttrbCode" value="" />
						<input type="hidden" name="authFlag" value="" />
						<input name="pageIndex" type="hidden" value="1"/>
						<input type="submit" value="실행" onclick="fn_egov_select_noticeList('1'); return false;" id="invisible" class="invisible" />

						<!-- 전자정부 패키지를 사용하기 위하여 메뉴에 대한 정보를 설정 -->
						<input type="hidden" name="child" value="96afbb20-28c0-4014-9a6f-da95888e9067" />
						<input type="hidden" name="top" value="08511a9f-f701-4720-913b-9e0cecd3cbf5" />
						<input type="hidden" name="left" value="" />

					<table>
					<caption>공통코드그룹</caption>
					<tbody>
					<tr>
						<th>
						<label for="search_select"></label>
						<select name="searchCnd" class="selectType1" title="검색조건 선택">
							<option value="0"  >제목</option>
							<option value="1"  >내용</option>
							<option value="2"  >작성자</option>
						</select>
						</th>
						<td>
							<input name="searchWrd" type="text" size="35" class="txtType txtType100 searchEvt"  value='' maxlength="35" onkeypress="press(event);" title="검색어 입력"> 
						</td>
						<td>
							<a href="#noscript" onclick="fn_egov_select_noticeList('1'); return false;" class="btnRight btnS searchBtn">검색 </a>
						</td>
					</tr>
					</tbody>
					</table>
					</form>
					</br></br> 
				</div>
				<!-- //검색 필드 박스 끝 -->
				<div id="page_info"><div id="page_info_align"></div></div>
				<!-- table add start -->
				<div class="tableType1">
					<table summary="번호, 제목, 게시시작일, 게시종료일, 작성자, 작성일, 조회수   입니다" cellpadding="0" cellspacing="0">
					<caption>게시물 목록</caption>
					<colgroup>
						<col width="10%" >
						<col width="44%" >

						

						
						<col width="20%" >
						

						<col width="15%" >
						<col width="8%" >
					</colgroup>
					<thead>
					<tr>
						<th scope="col" class="f_field" nowrap="nowrap">번호</th>
						<th scope="col" nowrap="nowrap">제목</th>

						

						
						<th scope="col" nowrap="nowrap">작성자</th>
						

						<th scope="col" nowrap="nowrap">작성일</th>
						<th scope="col" nowrap="nowrap">조회수</th>
					</tr>
					</thead>
					<tbody>

					
					
					<tr> 
						
						

						
						
						

						
						<td class="listCenter" colspan="5" >자료가 없습니다. 다른 검색조건을 선택해주세요</td>
						
						
						

						
					</tr>
					
					</tbody>
					</table>
				</div>
				<div class="paginate">
					<strong>1</strong>&#160;
  
				</div>
				<div class="btnWrap btnR">
					<a href="#" onclick="fn_egov_addNotice();" class="btn btnDt btnRgt">신규</a>
				</div>
			<!-- //페이지 네비게이션 끝 -->  
			</div>
			<!-- content End -->
		</div>
		<!-- contentWrap End -->
	</div>
	<!-- container End -->
</div>
<!--  footer -->
 <div id="footwrap">
    <div id="footer">
    		
<div class="footerbar">
	<div id="info">
		<input type="hidden" id="gUserId" value="${admin.id}" />
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



</script>
    </div>
 </div>
<!-- //footer --> 
 </body>
</html>