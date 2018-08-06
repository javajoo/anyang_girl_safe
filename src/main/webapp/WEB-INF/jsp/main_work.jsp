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
<title>상황이력</title>



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
	$.manuHandler('8098e79a-e2bc-41ce-9491-36c85d556155', '');

	$.jqGrid($('#grid'), {
		//  url : '/wrks/info/his/cctvPtzHisListData.json'
		  url : '/wrks/info/state/calamityCctvListData.json'
		, datatype : "json"
		, postData :
		{ 
			  clmtNo : $("#clmtNo").val()
			, cctvNm : $("#cctvNm").val()
			, strDateStart : $("#strDateStart").val()
			, strDateEnd : $("#strDateEnd").val()
		}
		, colNames :
		[
		 	  '발생번호'
			, '유형(상세내용)'
			, '카메라명'
			, '접속일시'
		]
		, colModel :
		[
			  { name : 'EVT_OCR_NO', width:150, align:'center'}
			, { name : 'EVT_DTL', width:340, align:'center'}
			, { name : 'FCLT_NM', width:340, align:'center'}
			, { name : 'CONN_DATE', width:150, align:'center'}
		]
		, pager : '#pager'
		, rowNum : $('#rowPerPageList').val()
		, sortname: 'EVT_OCR_NO'
		, sortorder: 'DESC'
		, viewrecords:true
		, multiselect: false
		, loadonce:false
		, jsonReader:
		{
			  id: "EVT_OCR_NO"
			, root: function(obj) { return obj.rows; }
			, page: function(obj) { return 1; }
			, total: function(obj)
			{
				if(obj.rows.length > 0) {
					var page  = obj.rows[0].ROWCNT / rowNum;
					if( (obj.rows[0].ROWCNT % rowNum) > 0)
						page++;
					return page;
				} else {
					return 1;
				}
			}
			, records: function(obj) { return $.showCount(obj); }
		}
/* 
		, onCellSelect: function(rowid, iCol, cellcontent, e)
		{
			if(iCol == 0) {
				return false;
			} else if(iCol == 1) {
				var list = jQuery("#grid").getRowData(rowid);
				$("#dFcltId").html(list.FCLT_ID);
				
				$.showDetail();	
			}
		}
*/
		, beforeRequest: function()
		{
			$.loading(true);
			rowNum = $('#rowPerPageList').val();
		}
		, beforeProcessing: function(data, status, xhr)
		{
			$.loading(false);
			if(typeof data.rows != "undefine" || data.row != null) {
				$.makePager("#grid", data, $("#grid").getGridParam('page'), $('#rowPerPageList').val());
			}
		}
	});

	$(".btnS").bind("click",function(){
		if ($.validate(".tableTypeHalf.seachT") == false) return;
		$("#grid").setGridParam({rowNum : $('#rowPerPageList').val()});
		var myPostData = $("#grid").jqGrid('getGridParam', 'postData');
		
		//검색할 조건의 값을 설정한다.
			myPostData.clmtNo = $("#clmtNo").val()
			myPostData.cctvNm = $("#cctvNm").val()
			myPostData.strDateStart = $("#strDateStart").val();
			myPostData.strDateEnd = $("#strDateEnd").val();
			
		$("#grid").trigger("reloadGrid");
	});
});

</script>

</head>
<body user-context-root="/">
<div id="wrapper">
	<!-- topbar -->
	<jsp:include page="include/topMenu.jsp" >
	<jsp:param name="mc" value=""/>
	</jsp:include>
	<!-- //topbar -->
	<!-- container -->
	<div class="container">
		<!-- leftMenu -->
		




        <div class="leftMenu">
			<ul>
        
			                <li class="has-sub on"><a style='background: url("/images/menu/menu_icon_on.png") no-repeat left top;' href="" off-image="/images/menu/menu_icon_off.png" on-image="/images/menu/menu_icon_on.png">이력관리</a>
			                    <ul style="display: block;">
		
						<li class="user-select"><a href="/wrks/info/state/calamityCctvList.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&amp;left=f8358de2-4534-4d14-8aab-7b9a7cd3d1a4">재난번호별 CCTV접속현황</a></li>
						
						<li><a href="/wrks/info/his/cctvPtzHisList.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&amp;left=6951f0b3-2702-44db-8813-8ae32f471a3f">재난번호별 CCTV제어현황</a></li>
						
						<li><a href="/wrks/info/his/calamityUserList.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&amp;left=46feaeac-8537-454a-b169-2b2e3f4126cf">관제요청현황</a></li>
						
						<li><a href="/wrks/info/his/connHisList.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&amp;left=35da7d58-80e9-4ee5-a0f8-028bbf9d7ad7">사용자접속현황</a></li>
						
						<li><a href="/wrks/info/his/eventAskHis.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&amp;left=987c97ff-c1f1-4201-a98b-daa7e4b9b406">사건신고이력</a></li>
						    
	    		</ul>
	    		</li>
	        </ul>
        <!--
		
			
			
			
			
			
	            <ul>
	                <li><a href="" id="" class="ic_code">코드관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/code/cmcd.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=0">공통코드그룹</a></li>
	                        <li><a href="/wrks/sstm/code/dtcd.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=0">코드상세</a></li>
	                        <li><a href="/wrks/sstm/code/sycd.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=0">시스템코드</a></li>
	                        <li><a href="/wrks/sstm/code/sggcd.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=0">시군구코드</a></li>
	                        <li><a href="/wrks/sstm/code/dst.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=0">지구코드</a></li>
	                        <li><a href="/wrks/sstm/code/area.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=0">지역코드</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_user">사용자관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/usr/info.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=1">사용자관리</a></li>
	                        <li><a href="/wrks/sstm/usr/area.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=1">지역별사용자</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_group">그룹정보</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/grp/code.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=2">그룹관리</a></li>
	                        <li><a href="/wrks/sstm/grp/user_acc.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=2">그룹별이벤트(사용자권한)</a></li>
	                        <li><a href="/wrks/sstm/grp/user.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=2">그룹별사용자조회</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">모바일</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/mbl/grp.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=3">그룹관리</a></li>
	                        <li><a href="/wrks/sstm/mbl/info.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=3">계정정보</a></li>
	                        <li><a href="/wrks/sstm/mbl/version.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=3">버젼정보관리</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">이벤트관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/evnt/base.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=4">이벤트기본정보</a></li>
	                        <li><a href="/wrks/sstm/evnt/item.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=4">이벤트세부항목</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">메뉴관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/menu/info.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=5">프로그램정보</a></li>
	                        <li><a href="/wrks/sstm/menu/menu.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=5">프로그램메뉴</a></li>
	                        <li><a href="/wrks/sstm/menu/grp.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=5">그룹별프로그램메뉴</a></li>
	                        <li><a href="/wrks/sstm/menu/user.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=5">사용자별프로그램메뉴</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">상황처리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/evtctl/info.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=7">상황관리</a></li>
	                        <li><a href="/wrks/sstm/evtctl/trans_recv.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=7">상황전달수신자관리</a></li>
	                        <li><a href="/wrks/sstm/evtctl/disp_mbl.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=7">표출단말관리</a></li>
	                        <li><a href="/wrks/sstm/evtprc/info.do?top=8098e79a-e2bc-41ce-9491-36c85d556155&left=7">상황처리</a></li>
	                    </ul>
	                </li>
	            </ul>
			
		
		-->
        </div>

		<!-- //leftMenu -->
		<!-- content -->
		<div class="contentWrap">
			<div class="topArea">
				<a class="btnOpen" href="#"><img alt="열기/닫기" src="/images/btn_on_off.png"></a>
				



        
                <h2 class="tit">상황이력</h2> 
                <div class="location">
                    <span>Home</span>  &gt; <span>이력관리</span>
                </div>
	    <!--
                <h2 class="tit">시스템</h2> 
                <div class="location">
                    <span>Home</span> &gt; <span>코드관리</span> &gt; <span>시스템코드</span>
                </div>
	    -->
			</div>
			<!-- 재난발생 -->
			<div class="content">
				<div class="titArea">
					<h3 class="tit">재난번호별 CCTV접속현황</h3>
				</div>
				<div class="tableTypeHalf seachT">
					<table>
					<caption>CCTV접속현황</caption>
					<colgroup>
						<col style="width: 100px;">
						<col style="width: 150px;">
						<col style="width: 100px;">
						<col style="width: 150px;">
						<col style="width: 100px;">
						<col>
					</colgroup>
					<tbody>
					<tr>
						<th>발생번호</th>
						<td>
							<input name="clmtNo" class="txtType txtType100 searchEvt" id="clmtNo" style="-ms-ime-mode: active;" type="text" maxlength="100">
						</td>
						<th>카메라명</th>
						<td>
							<input name="cctvNm" class="txtType txtType100 searchEvt" id="cctvNm" style="-ms-ime-mode: active;" type="text" maxlength="100">
						</td>
						<th>기간</th>
						<td>
							<input class="date8Type datepicker1 hasDatepicker" id="strDateStart" required="required" type="text" readonly="readonly" value="2018-03-27" user-ref-id="strDateEnd" user-data-type="betweendate" user-title="시작일자"><img title="..." class="ui-datepicker-trigger" alt="..." src="/images/icon_calendar.png">
							<span class="bl">~</span>
							<input class="date8Type datepicker2 hasDatepicker" id="strDateEnd" required="required" type="text" readonly="readonly" value="2018-04-03" user-title="종료일자"><img title="..." class="ui-datepicker-trigger" alt="..." src="/images/icon_calendar.png">
							<a class="btnRight btnS searchBtn" href="javascript:;">검색</a>
						</td>
					</tr>
					</tbody>
					</table>
				</div>

				<div class="searchArea">
					<div class="page fL">
						<span class="txt">페이지당</span>
						<div class="selectBox">
						<select name="rowPerPageList" class="selectType1 selectBox" id="rowPerPageList" style="display: none;">
						
							<option value="10">10</option>
						
							<option value="15">15</option>
						
							<option value="30">30</option>
						
							<option value="45">45</option>
						
							<option value="60">60</option>
						
						</select><a tabindex="0" title="" class="selectBox selectType1 selectBox-dropdown" style="width: 36px; display: inline-block;"><span class="selectBox-label" style="width: 56px;">10</span><span class="selectBox-arrow"></span></a>
						</div>
						<span class="totalNum">전체<em id="rowCnt">0</em>건</span>
					</div>
				</div>
				<div class="tableType1" style="-ms-overflow-x: hidden; -ms-overflow-y: hidden;">
					<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" id="gbox_grid" style="width: 1000px;" dir="ltr"><div class="ui-widget-overlay jqgrid-overlay" id="lui_grid"></div><div class="loading ui-state-default ui-state-active" id="load_grid" style="display: none;"></div><div class="ui-jqgrid-view" id="gview_grid" style="width: 1000px;"><div class="ui-jqgrid-titlebar ui-jqgrid-caption ui-widget-header ui-corner-top ui-helper-clearfix" style="display: none;"><a class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton" role="link" style="right: 0px;"><span class="ui-icon ui-icon-circle-triangle-n"></span></a><span class="ui-jqgrid-title"></span></div><div class="ui-state-default ui-jqgrid-hdiv" style="width: 1000px;"><div class="ui-jqgrid-hbox"><table class="ui-jqgrid-htable" role="grid" aria-labelledby="gbox_grid" style="width: 982px;" border="0" cellspacing="0" cellpadding="0"><thead><tr class="ui-jqgrid-labels" role="rowheader"><th class="ui-state-default ui-th-column ui-th-ltr" id="grid_EVT_OCR_NO" role="columnheader" style="width: 147px;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span><div class="ui-jqgrid-sortable" id="jqgh_grid_EVT_OCR_NO">발생번호<span class="s-ico"><span class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr" sort="asc"></span><span class="ui-grid-ico-sort ui-icon-desc ui-icon ui-icon-triangle-1-s ui-sort-ltr" sort="desc"></span></span></div></th><th class="ui-state-default ui-th-column ui-th-ltr" id="grid_EVT_DTL" role="columnheader" style="width: 334px;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span><div class="ui-jqgrid-sortable" id="jqgh_grid_EVT_DTL">유형(상세내용)<span class="s-ico" style="display: none;"><span class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr" sort="asc"></span><span class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr" sort="desc"></span></span></div></th><th class="ui-state-default ui-th-column ui-th-ltr" id="grid_FCLT_NM" role="columnheader" style="width: 334px;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span><div class="ui-jqgrid-sortable" id="jqgh_grid_FCLT_NM">카메라명<span class="s-ico" style="display: none;"><span class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr" sort="asc"></span><span class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr" sort="desc"></span></span></div></th><th class="ui-state-default ui-th-column ui-th-ltr" id="grid_CONN_DATE" role="columnheader" style="width: 147px;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span><div class="ui-jqgrid-sortable" id="jqgh_grid_CONN_DATE">접속일시<span class="s-ico" style="display: none;"><span class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr" sort="asc"></span><span class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr" sort="desc"></span></span></div></th></tr></thead></table></div></div><div class="ui-jqgrid-bdiv" style="width: 1000px; height: 150px;"><div style="position: relative;"><div></div><table tabindex="0" class="ui-jqgrid-btable" id="grid" role="grid" aria-multiselectable="false" aria-labelledby="gbox_grid" style="width: 982px;" border="0" cellspacing="0" cellpadding="0"><tbody><tr class="jqgfirstrow" role="row" style="height: auto;"><td role="gridcell" style="width: 147px; height: 0px;"></td><td role="gridcell" style="width: 334px; height: 0px;"></td><td role="gridcell" style="width: 334px; height: 0px;"></td><td role="gridcell" style="width: 147px; height: 0px;"></td></tr></tbody></table></div></div></div><div class="ui-jqgrid-resize-mark" id="rs_mgrid">&nbsp;</div></div>
				</div>
				<div class="paginate"></div>
			</div>
		<!-- //content -->
		</div>
	<!-- //container -->
	</div>
</div>
<!--  footer -->
<div id="footwrap">
	<div id="footer">
<div class="footerbar">
	<div id="info">
		<input id="gUserId" type="hidden" value="${admin.id}">
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

<ul class="selectBox-dropdown-menu selectBox-options selectType1-selectBox-dropdown-menu" style="display: none;">
	<li><a rel="10">10</a></li>
	<li><a rel="15">15</a></li>
	<li><a rel="30">30</a></li>
	<li><a rel="45">45</a></li>
	<li><a rel="60">60</a></li>
</ul>
<div class="ui-datepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all" id="ui-datepicker-div">
</div>
</body>
</html>