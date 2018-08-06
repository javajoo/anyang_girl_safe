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
<title>상황정보</title>



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

	$(document).ready(function()
	{
		$.manuHandler('3ee9fe57-b4df-4d1e-b761-29486cb544dd', '1c777054-fbf5-4f93-a55e-84574d51375e');
		// 업무일지 목록 리스트 그리드
		$.jqGrid($('#grid'), {
			  url : "/wrks/wrkmng/wrkrpt/mngsj/list.json"
			, datatype : "json"
			, postData : 
			{ 
				  workYmdStart : $("#workYmdStart").val().replace(/\-/g,'')
				, workYmdEnd : $("#workYmdEnd").val().replace(/\-/g,'')
				, workTeam : $("#workTeamList option:selected").val()
				, workShift : $("#workShiftList option:selected").val()
			}
			, colNames :
			[
				  '업무적용일자'
				, '근무교대구분'
				, '근무팀'
				, '근무시작일시'
				, '근무종료일시'
				, '작성완료일시'
				, '조장'
				, '담당경찰'
				, '담당공무원'
				// 히든값
				, 'WORK_LOG_ID'
				, 'WORK_SHIFT'
				, 'WORK_TEAM'
				, 'WORK_FR_YMD_HM'
				, 'WORK_TO_YMD_HM'
				, 'WORK_DATE_GITA'
				, 'STEP'
				
			]
			, colModel :
			[
				  { name : 'WORK_DATE', width:150, cellattr: function(){ return 'style="width:150px;"'}, align:'center'}
				, { name : 'WORK_SHIFT_NM', width:150, cellattr: function(){ return 'style="width:150px;"'}, align:'center'}
				, { name : 'WORK_TEAM', width:100, cellattr: function(){ return 'style="width:100px;"'}, align:'center'}
				, { name : 'WORK_FR_DATE', width:150, cellattr: function(){ return 'style="width:150px;"'}, align:'center'}
				, { name : 'WORK_TO_DATE', width:150, cellattr: function(){ return 'style="width:150px;"'}, align:'center'}
				, { name : 'WORK_LOG_RPT_DATE', width:150, cellattr: function(){ return 'style="width:150px;"'}, align:'center'}
				, { name : 'WORK_LEADER_USER_NM', width:120, cellattr: function(){ return 'style="width: 120px;"'}, align:'center'}
				, { name : 'WORK_PLC_USER_NM', width:120, cellattr: function(){ return 'style="width: 120px;"'}, align:'center'}
				, { name : 'WORK_PUB_USER_NM', width:120, cellattr: function(){ return 'style="width: 120px;"'}, align:'center'}
				// hidden
				, { name : 'WORK_LOG_ID', hidden:true}
				, { name : 'WORK_SHIFT', hidden:true}
				, { name : 'WORK_TEAM', hidden:true}
				, { name : 'WORK_FR_YMD_HM', hidden:true}
				, { name : 'WORK_TO_YMD_HM', hidden:true}
				, { name : 'WORK_DATE_GITA', hidden:true}
				, { name : 'STEP', hidden:true}
			]
			, pager : '#pager'
			, rowNum : $('#rowPerPageList').val()
			, sortname: 'WORK_YMD'
			, sortorder: 'DESC'
			, sortable: false
			, viewrecords:true
			, multiselect: false
			, shrinkToFit: true
			, scrollOffset: 0
			, autowidth: true
			, loadonce:false
			, jsonReader: {
				  id: ""
				, root: function(obj) { return obj.rows; }
				, page: function(obj) { return 1; }
				, total: function(obj)
				{
					if(obj.rows.length > 0) {
						var page  = obj.rows[0].ROWCNT / rowNum;
						if( (obj.rows[0].ROWCNT % rowNum) > 0)
							page++;
						return page;
					} else
						return 1; 
				}
				, records: function(obj) { return $.showCount(obj); }
			}
			, onCellSelect : function(rowid, iCol, cellcontent, e)
			{
				
				var list = jQuery("#grid").getRowData(rowid);
				var workLogId = list.WORK_LOG_ID;
				var workDate = list.WORK_DATE_GITA;
				var workTeam = list.WORK_TEAM;
				$("#hWorkLogId").val(workLogId);
				$("#hWorkDate").val(workDate);
				$("#hWorkTeam").val(workTeam);

				$("#dWorkYmd").html(list.WORK_DATE);
				$("#dWorkShift").html(list.WORK_SHIFT_NM);
				$("#dWorkTeam").html(workTeam + ' 팀');
				$("#dWorkDate").html(list.WORK_FR_DATE +  ' ~ ' + list.WORK_TO_DATE);
				$("#dWorkTeamAdm").html('담당경찰 : ' + list.WORK_PLC_USER_NM + '  -  담당공무원 : ' + list.WORK_PUB_USER_NM);

				// 수기업무내역 셋팅
				fn_gitaContInit();    // 수기업무내역 입력란 초기화
				fn_TeamUser();        // 수기업무 처리자 세팅
				$("#dEtcWorkYmd").val(workDate);    // 수기업무 처리일시 초기화
				if (parseInt(list.STEP) == 0) {     // 수기업무 완료, 조정, 확정에 따른 버튼 활성화
					$('#gitaBtn').show();
				} else {
					$('#gitaBtn').hide();
				}

				// 시스템 처리내역 조회
				var userAuth = 'MNT';
				$("#grid_event").setGridParam({url:"/wrks/wrkmng/wrkrpt/mngsj/workLogList.json"});
				var eventData = $("#grid_event").jqGrid('getGridParam', 'postData');
				eventData.workLogId = workLogId;
				eventData.userAuth = userAuth;
				eventData.workFrYmdhm = list.WORK_FR_YMD_HM;
				eventData.workToYmdhm = list.WORK_TO_YMD_HM;
				$("#grid_event").trigger("reloadGrid");

				// 수기업무내역 조최
				fn_gitaReloadGrid(workLogId, userAuth)

				$.showDetail();
			}
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
			, loadComplete : function (data) {
			}
		});  //

		// 업무일지 시스템처리내역
		$.jqGrid($('#grid_event'), {
			  datatype : "json"
			, postData : { 
			}
			, colNames :
			[
				  '일시'
				, '처리자'
				, '상황분류'
				, '상황내용'
				, 'CCTV명'
				, '출동내용'
				, '추가처리내용'
				, '처리내용'
				, '처리구분'
				, '장소'
				, '교대구분'
				, '구분'
				// hidden
				, '업무일지타입'
				, '업무처리자아이디'
				, '상황분류아이디'
				, '상황세부분류아이디'
				, '시설물아이디'
				, '이벤트발생번호'
				, '상황발생일자시각'
				, 'P_WORK_LOG_ID'
				, 'P_SEQ_NO'
				, 'P_EVT_OCR_NO'
			]
			, colModel :
			[
				  { name : 'ACTION_YMD_HMS', width:120, align:'center', sortable: false}
				, { name : 'ACTION_USER_NM', width:100, align:'center', sortable: false}
				, { name : 'EVT_NM', width:150, align:'center', sortable: false}
				, { name : 'EVT_DTL', width:120, align:'center', editable: true, edittype: "text", sortable: false}
				, { name : 'FCLT_LBL_NM', width:200, align:'left', sortable: false}
				, { name : 'REMARK', width:100, align:'left', editable: true, edittype: "text", sortable: false}
				, { name : 'ETC', width:100, align:'left', editable: true, edittype: "text", sortable: false}
				, { name : 'ACTION_CONTS', width:80, align:'center', sortable: false}
				, { name : 'EVT_PRGRS_NM', width:100, align:'center', sortable: false}
				, { name : 'ROAD_ADRES_NM', width:200, align:'left', sortable: false}
				, { name : 'WORK_SHIFT', width:70, align:'center', sortable: false}
				, { name : 'TAG', width:100, align:'center', sortable: false}
				// hidden
				, { name : 'WORK_TYPE', hidden:true}
				, { name : 'WORK_USER_ID', hidden:true}
				, { name : 'EVT_ID', hidden:true}
				, { name : 'EVT_ID_SUB_CD', hidden:true}
				, { name : 'FCLT_ID', hidden:true}
				, { name : 'EVT_OCR_NO', hidden:true}
				, { name : 'ACTION_YMDHMS', hidden:true}
				, { name : 'P_WORK_LOG_ID', hidden:true}
				, { name : 'P_SEQ_NO', hidden:true}
				, { name : 'P_EVT_OCR_NO', hidden:true}
			]
			, pager : '#pager'
			, rowNum : 1000
			, sortname: 'WORK_YMD'
			, sortorder: 'DESC'
			, viewrecords: true
			, multiselect: false
			//, shrinkToFit: true
			//, autowidth: true
			, loadonce:false
			, sortable: false
			, beforeRequest: function() {
				$.loading(true);
			}
			, beforeProcessing: function(data, status, xhr) {
				$.loading(false);
			}
			, ondblClickRow: function (rowid, iRow, iCol) {
				fn_editRow("#grid_event", rowid, iRow, iCol);
			}
			, afterInsertRow: function(rowid) {
				fn_gridCellCss("#grid_event", rowid);
			}
		});  // End =>  $.jqGrid($('#grid_event')

		$.jqGrid($('#grid_gita'), {
			  datatype : "json"
			, postData : { 
			}
			, colNames :
			[
				  '일시'
				, '처리자'
				, '상황구분'
				, '상황내용'
				, '처리내용'
				, 'CCTV명'
				, '교대구분'
				, '구분'
				, '상황분류'
				, '처리구분'
				// hidden
				, 'WORK_LOG_PRCS_YMD'
				, 'WORK_LOG_PRCS_HH'
				, 'WORK_LOG_PRCS_MI'
				, 'WORK_LOG_TY_SUB_CD'
				, 'ACTION_USER_ID'
				, 'FCLT_LBL_NM'
				, 'SEQ_NO'
				, 'WORK_LOG_TY_CD'
			]
			, colModel :
			[
				  { name : 'WORK_LOG_PRCS_DATE', width:120, cellattr: function(){ return 'style="width:120px;"'}, align:'center', sortable: false}
				, { name : 'ACTION_USER_NM', width:100, cellattr: function(){ return 'style="width:100px;"'}, align:'center', sortable: false}
				, { name : 'WORK_LOG_TY_SUB_NM', width:120, cellattr: function(){ return 'style="width:120px;"'}, align:'center', sortable: false}
				, { name : 'EVT_CONTS', width:200, cellattr: function(){ return 'style="width:200px;"'}, align:'left', sortable: false}
				, { name : 'ETC', width:200, cellattr: function(){ return 'style="width:200px;"'}, align:'left', sortable: false}
				, { name : 'CCTV_NM', width:100, cellattr: function(){ return 'style="width:100px;"'}, align:'center', sortable: false}
				, { name : 'WORK_SHIFT_NM', width:150, cellattr: function(){ return 'style="width:150px;"'}, align:'center', sortable: false}
				, { name : 'TAG', width:100, cellattr: function(){ return 'style="width:100px;"'}, align:'center', sortable: false}
				, { name : 'WORK_LOG_TY_NM', width:100, cellattr: function(){ return 'style="width:100px;"'}, align:'center', sortable: false}
				, { name : 'EVT_PRGRS_NM', width:100, cellattr: function(){ return 'style="width:100px;"'}, align:'center', sortable: false}
				// hidden
				, { name : 'WORK_LOG_PRCS_YMD', hidden:true}
				, { name : 'WORK_LOG_PRCS_HH', hidden:true}
				, { name : 'WORK_LOG_PRCS_MI', hidden:true}
				, { name : 'WORK_LOG_TY_SUB_CD', hidden:true}
				, { name : 'ACTION_USER_ID', hidden:true}
				, { name : 'FCLT_LBL_NM', hidden:true}
				, { name : 'SEQ_NO', hidden:true}
				, { name : 'WORK_LOG_TY_CD', hidden:true}
			]
			, pager : '#pager'
			, rowNum : 1000
			, sortname: 'WORK_YMD'
			, sortorder: 'DESC'
			, viewrecords:true
			, multiselect: false
			, shrinkToFit: true
			, scrollOffset: 0
			, autowidth: true
			, loadonce:false
			, jsonReader: {
				  root: function(obj) { return obj.rows; }
				, page: function(obj) { return 1; }
				, total: function(obj)
				{
					if(obj.rows.length > 0) {
						var page  = obj.rows[0].ROWCNT / rowNum;
						if( (obj.rows[0].ROWCNT % rowNum) > 0)
							page++;
						return page;
					} else
						return 1; 
				}
				, records: function(obj) { return $.showCount(obj); }
			}
			, onCellSelect : function(rowid, iCol, cellcontent, e)
			{
				var list = jQuery("#grid_gita").getRowData(rowid);
				var workLogId = list.WORK_LOG_ID;
				$("#ghWorkLogId").val(workLogId);
				$("#ghSeqNo").val(list.SEQ_NO);
				$("#ghWorkLogTyCd").val(list.WORK_LOG_TY_CD);
				$("#dEtcWorkYmd").val(list.WORK_LOG_PRCS_YMD);
				$("#dEtcWorkH").val(list.WORK_LOG_PRCS_HH);
				$("#dEtcWorkM").val(list.WORK_LOG_PRCS_MI);
				$.selectBarun('#dWorkLogTy', list.WORK_LOG_TY_SUB_CD);
				$.selectBarun('#dWorkTeamUser', list.ACTION_USER_ID);
				//$("#dWorkLogTy").val(list.WORK_LOG_TY_CD);
				//$("#dWorkTeamUser").val(list.ACTION_USER_ID);
				$("#dCctvNm").val(list.FCLT_LBL_NM);
				$("#dEvtConts").val(list.EVT_CONTS);
				$("#dEtc").val(list.ETC);
			}
			, beforeRequest: function() {
				$.loading(true);
			}
			, beforeProcessing: function(data, status, xhr) {
				$.loading(false);
			}
			, loadComplete : function (data) {
			}
		});  // End => $.jqGrid($('#grid_gita')
		// 검색버튼동작
		$(".btnS").bind("click",function()
		{
			if ($.validate(".tableTypeHalf.seachT") == false) {
				return false;
			}
			$("#grid").setGridParam({rowNum : $('#rowPerPageList').val()});
			var myPostData = $("#grid").jqGrid('getGridParam', 'postData');
			
			//검색할 조건의 값을 설정한다.
			myPostData.workYmdStart = $("#workYmdStart").val().replace(/\-/g,'');
			myPostData.workYmdEnd = $("#workYmdEnd").val().replace(/\-/g,'');
			myPostData.workTeam = $("#workTeamList option:selected").val();
			myPostData.workShift = $("#workShiftList option:selected").val();
			$("#grid").trigger("reloadGrid");
		});  // End $(".btnS")
		// 수기업무내역 신규
		$(".btnGi").bind("click",function() {
			fn_gitaContInit();
		});  // End $(".btnGi")
		// 수기업무내역 저장
		$(".btnGs").bind("click",function()
		{
			fn_GitaDml("INSERT");
		});  // End $(".btnGs")
		// 수기업무내역 삭제
		$(".btnGd").bind("click",function()
		{
			var workLogId = $("#ghWorkLogId").val();
			var seqNo = $("#ghSeqNo").val();
			if (workLogId == '' || seqNo == '') {
				alert('선택된 수기업무 내역이 존재 하지 않습니다.');
				return;
			} else {
				fn_GitaDml("DELETE");
			}
		});  // End $(".btnGd")
	});  //  End $(document).ready

	function fn_gitaReloadGrid(id, auth)
	{
		$("#grid_gita").setGridParam({url:"/wrks/wrkmng/wrkrpt/mngsj/workLogGitaList.json"});
		var gitaData = $("#grid_gita").jqGrid('getGridParam', 'postData');
		gitaData.workLogId = id;
		gitaData.userAuth = auth;
		$("#grid_gita").trigger("reloadGrid");
	}
	// 그리드 편집
	function fn_editRow(dGrid, rowid, iRow, iCol)
	{
		var colModels = $(dGrid).getGridParam('colModel');
		var colName = colModels[iCol].name;
		if ( 'REMARK' == colName || 'ETC' == colName)
		{
			$(dGrid).setRowData(rowid, false, {background:"#FFD9EC"});
			$(dGrid).editRow(iRow, false);
			setTimeout(function(){$("#" + iRow + "_" + colName).focus();}, 10);
			$("#" + iRow + "_" + colName).blur(function() {
				$(dGrid).saveRow(iRow);
				$(dGrid).restoreRow(iRow);
				fn_workLogChange(dGrid, rowid);
			});
		}
	}
	// 그리드 색 지정
	function fn_gridCellCss(grid, rowid)
	{
		$(grid).setCell(rowid, 'REMARK', '', {background: '#99FF99'});
		$(grid).setCell(rowid, 'ETC', '', {background: '#99FF99'});
	}

	// 시스템처리내역 변경
	function fn_workLogChange(sGrid, rowId)
	{
		var list = jQuery(sGrid).getRowData(rowId);
		var params = "";
			params += "&workLogId=" + encodeURIComponent(list.P_WORK_LOG_ID);
			params += "&seqNo=" + encodeURIComponent(list.P_SEQ_NO);
			params += "&evtOcrNo=" + encodeURIComponent(list.P_EVT_OCR_NO);
			params += "&remark=" + encodeURIComponent(list.REMARK);
			params += "&etc=" + encodeURIComponent(list.ETC);

		$.ajaxEx($(sGrid),
		{
			  url : "/wrks/wrkmng/wrkrpt/mngsj/workLogEtc.json"
			, dataType : "json"
			, data: params
			, success:function(data)
			{
				$(sGrid).trigger("reloadGrid");
				//alert(data.msg);
			}
			, error:function(e){
				alert(e.responseText);
			}
		});
	}
	// 수기업무 처리자 세팅
	function fn_TeamUser()
	{
		$.selectBarun('#dWorkTeamUser', 'test');
		console.log('MNT');
/**
		if ("MNT" == 'MNT') {
			$.selectBarun('#dWorkTeamUser', 'test');
		} else {
			$("#dWorkTeamUser option:eq(0)").attr("selected", "selected");
		}
*/
	}
	// 수기업무 초기화
	function fn_gitaContInit()
	{
		$("#ghWorkLogId").val('');
		$("#ghSeqNo").val('');

		$("#dEtcWorkYmd").val($("#hWorkDate").val());
		$("#dEtcWorkH").val('');
		$("#dEtcWorkM").val('');
		$("#dWorkLogTy option:eq(0)").attr("selected", "selected");
		$("#dCctvNm").val('');
		$("#dEvtConts").val('');
		$("#dEtc").val('');
		fn_TeamUser();
	}
	// 수기업무 등록, 삭제
	function fn_GitaDml(type)
	{
		var url = "/wrks/wrkmng/wrkrpt/mngsj/workLogGita.json";
		var params  = '&gitaType='  + type;
			if ( type == "INSERT" ) {
				params += '&workLogId=' + $("#hWorkLogId").val();
				params += '&workLogPrcsYmdHms=' + $("#dEtcWorkYmd").val().replace(/\-/g,'') + $("#dEtcWorkH").val() + $("#dEtcWorkM").val() + '00';
				params += '&workLogTyCd=' + 'WORKLOG1';
				params += '&workLogTySubCd=' + $("#dWorkLogTy option:selected").val();
				params += '&actionUserId=' + $("#dWorkTeamUser option:selected").val();
				params += '&evtConts=' + encodeURIComponent($("#dEvtConts").val());
				params += '&etc=' + encodeURIComponent($("#dEtc").val());
				params += '&fcltId=' + $("#ghFcltId").val();
			} else {
				params += '&workLogId=' + $("#ghWorkLogId").val();
				params += '&seqNo=' + $("#ghSeqNo").val();
			}

		$.ajaxEx($(grid),
		{
			  url : url
			, dataType : "json"
			, data: params
			, success:function(data)
			{
				fn_gitaReloadGrid(workLogId, 'MNT');
				fn_gitaContInit();
				alert(data.msg);
			}
			, error:function(e){
				alert(data.msg);
			}
		});  // End ajaxEx
	}
	// 엑셀파일 다운로드
	function excelDownAction()
	{
		document.excelDownFrm.eWorkLogId.value = $("#dWorkLogId").val();
		document.excelDownFrm.dWorkShift.value = $("#dWorkShift").val();
		document.excelDownFrm.eWorkYmd.value = $("#dWorkYmd").val().replace(/\-/g,'');
		document.excelDownFrm.action = "/wrks/wrkmng/wrkrpt/mngsj/list.excel";
		document.excelDownFrm.submit();
	}

</script>

</head>
<body user-context-root="/">
<div id="wrapper">
	<!-- topbar -->
	<jsp:include page="include/topMenu.jsp" >
	<jsp:param name="mc" value="7"/>
	</jsp:include>
	<!-- //topbar -->
	<!-- container -->
		




        <div class="leftMenu">
			<ul>
        
			                <li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">업무일지</a>
			                    <ul>
	    
						<li class="user-select"><a href="/workProcess.do">업무일지작성</a></li>
						
						<li class=""><a href="#">업무일지확인</a></li>
						
						<li class=""><a href="#">업무일지상세조회</a></li>
						
						<li class=""><a href="#">근무교대관리</a></li>
						
						<li class=""><a href="#">근무팀관리</a></li>
						
			                </ul>
			                <!-- <li><a href="" id="" class="" style="background: url(/images/menu/f91d2c76-ec11-4cba-9215-76cfd69b2f34_off.png) no-repeat left top;" on-image="/images/menu/f91d2c76-ec11-4cba-9215-76cfd69b2f34_on.png" off-image="/images/menu/f91d2c76-ec11-4cba-9215-76cfd69b2f34_off.png">TO-DO</a>
			                    <ul>
		
						<li class=""><a href="/wrks/wrkmng/calmng/todo.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=551153d9-c0de-4f7c-bef2-65065c8eebce&sys=wrks1">TO-DO관리</a></li>
						
						<li class=""><a href="/wrks/wrkmng/calmng/req_mng.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=6f9caccb-960f-43a2-bf2d-322682b41b7e&sys=wrks1">업무요청</a></li>
						
			                </ul>
			                <li><a href="" id="" class="" style="background: url(/images/menu/3acb4933-be77-45e2-906a-26b3f760a442_off.png) no-repeat left top;" on-image="/images/menu/3acb4933-be77-45e2-906a-26b3f760a442_on.png" off-image="/images/menu/3acb4933-be77-45e2-906a-26b3f760a442_off.png">일정관리</a>
			                    <ul>
		
						<li class=""><a href="/wrks/wrkmng/schd/cal.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=6cf312a6-172d-4dab-94ad-2a216bd6dc51&sys=wrks1">월간일정보기</a></li>
						
						<li class=""><a href="/wrks/wrkmng/schd/mng.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=f52c93a8-e50c-4dd1-bb0f-d6a194ae4819&sys=wrks1">일정관리조회</a></li>
						
			                </ul>
			                <li><a href="" id="" class="" style="background: url(/images/menu/f24bd2a3-369c-469f-a75c-2023f207632d_off.png) no-repeat left top;" on-image="/images/menu/f24bd2a3-369c-469f-a75c-2023f207632d_on.png" off-image="/images/menu/f24bd2a3-369c-469f-a75c-2023f207632d_off.png">쪽지</a>
			                    <ul>
		
						<li class=""><a href="/wrks/wrkmng/msgmng/write.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=b744e4b3-44e4-4cbf-80d2-8dffc3ed94d8&sys=wrks1">쪽지보내기</a></li>
						
						<li class=""><a href="/wrks/wrkmng/msgmng/rcv.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=c2db1aab-bbbe-4685-acb9-9238272009e2&sys=wrks1">받은쪽지</a></li>
						
						<li class=""><a href="/wrks/wrkmng/msgmng/send.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=d4ae8b3e-1136-4559-89b6-14d6d3bbd1e6&sys=wrks1">보낸쪽지</a></li>
						
						<li class=""><a href="/wrks/wrkmng/msgmng/archive.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=5a264561-e977-4d8f-87f2-df3d40dd6a9f&sys=wrks1">쪽지보관함</a></li>
						
			                </ul>
			                <li><a href="" id="" class="" style="background: url(/images/menu/c4d3b536-11d2-45ed-ae7b-393f8751f0c7_off.png) no-repeat left top;" on-image="/images/menu/c4d3b536-11d2-45ed-ae7b-393f8751f0c7_on.png" off-image="/images/menu/c4d3b536-11d2-45ed-ae7b-393f8751f0c7_off.png">비상연락망</a>
			                    <ul>
		
						<li class=""><a href="/wrks/wrkmng/msgmng/contact.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=4d0f855f-1cd1-44aa-a60b-fbdfcd4462e7&sys=wrks1">비상연락망조회</a></li>
						
			                </ul>
			                <li><a href="" id="" class="" style="background: url(/images/menu/64282b70-0d42-4706-8ade-1c048d4f1046_off.png) no-repeat left top;" on-image="/images/menu/64282b70-0d42-4706-8ade-1c048d4f1046_on.png" off-image="/images/menu/64282b70-0d42-4706-8ade-1c048d4f1046_off.png">SMS</a>
			                    <ul>
		
						<li class=""><a href="/wrks/wrkmng/msgmng/sms.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=5768c296-fb12-4074-b744-f97aa4b62516&sys=wrks1">SMS보내기</a></li>
						
			                </ul>
			                <li><a href="" id="" class="" style="background: url(/images/menu/d279f44f-d5f9-4e9d-8919-87375232c639_off.png) no-repeat left top;" on-image="/images/menu/d279f44f-d5f9-4e9d-8919-87375232c639_on.png" off-image="/images/menu/d279f44f-d5f9-4e9d-8919-87375232c639_off.png">메신저</a>
			                    <ul>
		
						<li class=""><a href="javascript:$.openMenuCenter('/wrks/wrkmng/msgmng/messenger.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=6dc573e7-47eb-4cfa-9b6e-d5b0823cd5ce&sys=wrks1','메신저조회',500, 800)">메신저조회</a></li>
						
			                </ul>
			                <li><a href="" id="" class="" style="background: url(/images/menu/1_off.png) no-repeat left top;" on-image="/images/menu/1_on.png" off-image="/images/menu/1_off.png">업무처리현황</a>
			                    <ul>
		
						<li class=""><a href="/wrks/wrkmng/wrksta/ichsts.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=573fb31f-930a-4ecc-bda7-4183f0c1e266&sys=wrks1">담당자별업무일지통계</a></li>
						
						<li class=""><a href="/wrks/wrkmng/wrksta/ctvtrb.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=0b2d6499-de1a-4da3-8315-2909e9d797c5&sys=wrks1">업무일지CCTV고장통계</a></li>
						
			                </ul>
			                <li><a href="" id="" class="" style="background: url(/images/menu/1_off.png) no-repeat left top;" on-image="/images/menu/1_on.png" off-image="/images/menu/1_off.png">가중치항목관리</a>
			                    <ul>
		
						<li class=""><a href="/wrks/wrkmng/witmng/wititem.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=e7df530e-e4ac-49fc-a2b4-d4f23165ae54&sys=wrks1">가중치항목관리</a></li>
						
	    		</ul> -->
	        </ul>
        <!--
		
			
			
			
			
			
	            <ul>
	                <li><a href="" id="" class="ic_code">코드관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/code/cmcd.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=0">공통코드그룹</a></li>
	                        <li><a href="/wrks/sstm/code/dtcd.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=0">코드상세</a></li>
	                        <li><a href="/wrks/sstm/code/sycd.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=0">시스템코드</a></li>
	                        <li><a href="/wrks/sstm/code/sggcd.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=0">시군구코드</a></li>
	                        <li><a href="/wrks/sstm/code/dst.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=0">지구코드</a></li>
	                        <li><a href="/wrks/sstm/code/area.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=0">지역코드</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_user">사용자관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/usr/info.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=1">사용자관리</a></li>
	                        <li><a href="/wrks/sstm/usr/area.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=1">지역별사용자</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_group">그룹정보</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/grp/code.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=2">그룹관리</a></li>
	                        <li><a href="/wrks/sstm/grp/user_acc.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=2">그룹별이벤트(사용자권한)</a></li>
	                        <li><a href="/wrks/sstm/grp/user.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=2">그룹별사용자조회</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">모바일</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/mbl/grp.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=3">그룹관리</a></li>
	                        <li><a href="/wrks/sstm/mbl/info.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=3">계정정보</a></li>
	                        <li><a href="/wrks/sstm/mbl/version.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=3">버젼정보관리</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">이벤트관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/evnt/base.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=4">이벤트기본정보</a></li>
	                        <li><a href="/wrks/sstm/evnt/item.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=4">이벤트세부항목</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">메뉴관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/menu/info.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=5">프로그램정보</a></li>
	                        <li><a href="/wrks/sstm/menu/menu.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=5">프로그램메뉴</a></li>
	                        <li><a href="/wrks/sstm/menu/grp.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=5">그룹별프로그램메뉴</a></li>
	                        <li><a href="/wrks/sstm/menu/user.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=5">사용자별프로그램메뉴</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">상황처리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/evtctl/info.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=7">상황관리</a></li>
	                        <li><a href="/wrks/sstm/evtctl/trans_recv.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=7">상황전달수신자관리</a></li>
	                        <li><a href="/wrks/sstm/evtctl/disp_mbl.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=7">표출단말관리</a></li>
	                        <li><a href="/wrks/sstm/evtprc/info.do?top=3ee9fe57-b4df-4d1e-b761-29486cb544dd&left=7">상황처리</a></li>
	                    </ul>
	                </li>
	            </ul>
			
		
		-->
        </div>

		<div class="contentWrap">    <!-- content -->
			<div class="topArea">
				<a href="#" class="btnOpen"><img src="/images/btn_on_off.png" alt="열기/닫기"></a>
				



        
                <h2 class="tit">업무처리</h2> 
                <div class="location">
                    <span>Home</span>  &gt; <span>업무일지</span>  &gt; <span>업무일지작성</span>
                </div>
	    <!--
                <h2 class="tit">시스템</h2> 
                <div class="location">
                    <span>Home</span> &gt; <span>코드관리</span> &gt; <span>시스템코드</span>
                </div>
	    -->
			</div>
			<!-- content -->
			<div class="content">
				<div class="titArea"><h3 class="tit">업무일지목록</h3></div>
				<div class="tableTypeHalf seachT">
					<table>
					<caption>업무일지관리</caption>
					<colgroup>
						<col style="width:12%;" />
						<col style="width:25%;" />
						<col style="width:8%;" />
						<col style="width:12%;" />
						<col style="width:8%;" />
						<col style="width:10%;" />
						<col style="width:auto;" />
					</colgroup>
					<tbody>
					<tr>
						<th>업무적용일자</th>
						<td colspan="2">
							<input type="text" name="" id="workYmdStart" class="date8Type datepicker1" value="2018-04-21" required="required" user-title="시작일자" user-data-type="betweendate" user-ref-id="workYmdEnd">
							<span class="bl">~</span>
							<input type="text" name="" id="workYmdEnd" class="date8Type datepicker2" value="2018-04-23" required="required" user-title="종료일자">
						</td>
						<th>근무교대구분</th>
						<td>
							<select name="workShiftList" id="workShiftList" class="selectType1">
								<option value="">전체</option>
								
								<option value="1">오전</option>
								
								<option value="2">오후</option>
								
							</select>
						</td>
						<th>근무팀</th>
						<td>
							<select name="workTeamList" id="workTeamList" class="selectType1">
								<option value="">전체</option>
								
								<option value="1" >1</option>
								
								<option value="2" >2</option>
								
								<option value="3" >3</option>
								
								<option value="4" >4</option>
								
							</select>
						</td>
						<td><a href="javascript:;" class="btnRight btnS searchBtn">검색</a></td>
					</tr>
					</tbody>
					</table>
				</div>
				<div class="searchArea">
					<div class="page fL">
						<span class="txt">페이지당</span>
						<div class="selectBox">
							<select name="rowPerPageList" id="rowPerPageList" class="selectType1">
								
								<option value="10" selected>10</option>
								
								<option value="15" >15</option>
								
								<option value="30" >30</option>
								
								<option value="45" >45</option>
								
								<option value="60" >60</option>
								
							</select>
						</div>
						<span class="totalNum">전체<em id="rowCnt"></em>건</span>
					</div>
				</div>
				<div class="tableType1">
					<table id="grid" style="width:100%"></table>
				</div>
				<div class="paginate"></div>
				<div class="btnWrap">
					<a href="#" class="btn btnDt btnRgt">신규등록</a>
				</div>
			</div>
			<!-- //content -->
			<!-- 레이어팝업 -->
			<div class="layer layerDetail wide">
				<div class="tit"><div class="divL"><h4>업무일지 <span id="modetitle">추가</span></h4></div><div class="divR"><a href="#" class="btn btnC">닫기</a></div></div>
				<div class="layerCt">
					<div class="tableTypeWide">
						<input type="hidden" id='hWorkLogId' name='hWorkLogId' />
						<input type="hidden" id='hWorkDate' name='hWorkDate' />
						<input type="hidden" id='hWorkTeam' name='hWorkTeam' />

						<input type="hidden" id='ghWorkLogId' name='ghWorkLogId' />
						<input type="hidden" id='ghSeqNo' name='ghSeqNo' />
						<input type="hidden" id='ghFcltId' name='ghFcltId' />
						<input type="hidden" id='ghWorkLogTyCd' name='ghWorkLogTyCd' />
						<table>
						<caption>업무일지등록 상세</caption>
						<tbody>
						<colgroup>
							<col style="width:10%;">
							<col style="width:30%;">
							<col style="width:10%;">
							<col style="width:20%;">
							<col style="width:10%;">
							<col style="width:20%;">
						</colgroup>
						<tbody>
						<tr>
							<th>업무적용일자</th>
							<td id="dWorkYmd"></td>
							<th>근무교대구분</th>
							<td id="dWorkShift"></td>
							<th>근무팀</th>
							<td id="dWorkTeam"></td>
						</tr>
						<tr>
							<th>근무일시</th>
							<td id="dWorkDate"></td>
							<td colspan="4" id="dWorkTeamAdm"></td>
						</tr>
						</tbody>
						</table>
					</div>
					<div class="boxWrap">
						<div class="tbLeft50"  style="width:100%">
							<div class="tit" style="width:100%; height:31px;  padding:20px 0 0 0"><h2><b>> 시스템처리내역</b><a href="#" class="btn newGridSeach" style="float:right" area="new">시스템처리내역조회</a></h2></div>
							<div class="tableType1 insert" style="height:140px; overflow-y:scroll; overflow-x:scroll">
								<table id="grid_event" style="width:100%"></table>
							</div>
						</div>
					</div>
					<div class="boxWrap">
						<div class="tbLeft50" style="width:100%">
							<div class="tit" style="width:100%; padding:20px 0 0 0"><h2><b>> 수기업무처리내역</b></h2></div>
							<div class="tableType1 insert" style="height:120px; overflow-y:scroll; overflow-x:scroll">
								<table id="grid_gita" style="width:100%"></table>
							</div>
						</div>
					</div>
					<div class="tableType2">
						<table>
						<colgroup>
							<col style="width:12%;">
							<col style="width:40%;">
							<col style="width:12%;">
							<col style="width:auto;">
						</colgroup>
						<tbody>
						<tr>
							<th>처리일시</th>
							<td>
								<input type="text" name="dEtcWorkYmd" id="dEtcWorkYmd" class="date8Type datepicker1" required="required" user-title="처리일자" disabled>
								<input type="text" name="dEtcWorkH" id="dEtcWorkH" class="txtType" maxlength="2" style="width:50px; ime-mode:active" user-data-type="number"> 시
								<input type="text" name="dEtcWorkM" id="dEtcWorkM" class="txtType" maxlength="2" style="width:50px; ime-mode:active" user-data-type="number"> 분
							</td>
							<th>상황구분</th>
							<td>
								<select name="dWorkLogTy" id="dWorkLogTy" class="selectType1">
									
								</select>
							</td>
						</tr>
						<tr>
							<th>처리자</th>
							<td>
								
								
									<select name="dWorkTeamUser" id="dWorkTeamUser" class="selectType1" disabled>
									
									</select>
								
								
								
							</td>
							<th>CCTV명</th>
							<td>
								<input type="text" name="dCctvNm" id="dCctvNm" class="txtType txtType100" style="width:300px; ime-mode:active" disabled>
								<a href="#" class="btn">CCTV찾기</a>
							</td>
						</tr>
						<tr>
							<th>상황내용</th>
							<td colspan="3">
								<input type="text" name="dEvtConts" id="dEvtConts" class="txtType txtType100" style="width:900px; ime-mode:active">
							</td>
						</tr>
						<tr>
							<th>처리내용</th>
							<td colspan="3">
								<input type="text" name="dEtc" id="dEtc" class="txtType txtType100" style="width:900px; ime-mode:active">
							</td>
						</tr>
						</tbody>
						</table>
					</div>

					<div id="gitaBtn" style="width:100%; padding:10px 0 0 0" align="center">
					
					</div>
				</div>
			</div>
			<!-- //레이어팝업 -->
		</div>  <!-- //contentWrap -->
	</div>  <!-- //container -->
</div>
<!-- //wrapper -->
<form name="excelDownFrm" method="post">
	<input type="hidden" name="eWorkLogId" id="eWorkLogId" />
	<input type="hidden" name="eWorkTeam" id="eWorkTeam" />
	<input type="hidden" name="eWorkYmd" id="eWorkYmd" />
</form>
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
		//javascript:$.openMenuCenter('/wrks/wrkmng/msgmng/messenger_chat.do?roomNm='+escape(encodeURIComponent(msg.room))+'&userList='+msg.userid+'&grpSeqNo='+msg.grpSeqNo, 'CHAT', 510, 810);
 		

		
	});



</script></div>
</div>
<!-- //footer -->
</body>
</html>