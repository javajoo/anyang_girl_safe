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
var estYn =
[
	  {"CD_ID":"Y", "CD_NM_KO":"필수"}
	, {"CD_ID":"N", "CD_NM_KO":"필수아님"}
];
var witList = JSON.parse('[{"RGS_USER_ID":"SYSTEM","USE_TY_CD":"Y","CD_DSCRT":"0","SORT_ORDR":1,"SYS_CD":"UCP","CD_NM_KO":"0","CD_GRP_ID":"WIT_TY","CD_NM_EN":"0","RGS_DATE":{"nanos":0,"time":1510712666000,"minutes":24,"seconds":26,"hours":11,"month":10,"year":117,"timezoneOffset":-540,"day":3,"date":15},"CD_ID":"0","UPD_USER_ID":"SYSTEM","CD_TY":"C","UPD_DATE":{"nanos":0,"time":1510712666000,"minutes":24,"seconds":26,"hours":11,"month":10,"year":117,"timezoneOffset":-540,"day":3,"date":15}},{"RGS_USER_ID":"SYSTEM","USE_TY_CD":"Y","CD_DSCRT":"0.1","SORT_ORDR":2,"SYS_CD":"UCP","CD_NM_KO":"0.1","CD_GRP_ID":"WIT_TY","CD_NM_EN":"0.1","RGS_DATE":{"nanos":0,"time":1510712666000,"minutes":24,"seconds":26,"hours":11,"month":10,"year":117,"timezoneOffset":-540,"day":3,"date":15},"CD_ID":"0.1","UPD_USER_ID":"SYSTEM","CD_TY":"C","UPD_DATE":{"nanos":0,"time":1510712666000,"minutes":24,"seconds":26,"hours":11,"month":10,"year":117,"timezoneOffset":-540,"day":3,"date":15}},{"RGS_USER_ID":"SYSTEM","USE_TY_CD":"Y","CD_DSCRT":"0.2","SORT_ORDR":3,"SYS_CD":"UCP","CD_NM_KO":"0.2","CD_GRP_ID":"WIT_TY","CD_NM_EN":"0.2","RGS_DATE":{"nanos":0,"time":1510712666000,"minutes":24,"seconds":26,"hours":11,"month":10,"year":117,"timezoneOffset":-540,"day":3,"date":15},"CD_ID":"0.2","UPD_USER_ID":"SYSTEM","CD_TY":"C","UPD_DATE":{"nanos":0,"time":1510712666000,"minutes":24,"seconds":26,"hours":11,"month":10,"year":117,"timezoneOffset":-540,"day":3,"date":15}},{"RGS_USER_ID":"SYSTEM","USE_TY_CD":"Y","CD_DSCRT":"0.3","SORT_ORDR":4,"SYS_CD":"UCP","CD_NM_KO":"0.3","CD_GRP_ID":"WIT_TY","CD_NM_EN":"0.3","RGS_DATE":{"nanos":0,"time":1510712666000,"minutes":24,"seconds":26,"hours":11,"month":10,"year":117,"timezoneOffset":-540,"day":3,"date":15},"CD_ID":"0.3","UPD_USER_ID":"SYSTEM","CD_TY":"C","UPD_DATE":{"nanos":0,"time":1510712666000,"minutes":24,"seconds":26,"hours":11,"month":10,"year":117,"timezoneOffset":-540,"day":3,"date":15}},{"RGS_USER_ID":"SYSTEM","USE_TY_CD":"Y","CD_DSCRT":"0.5","SORT_ORDR":5,"SYS_CD":"UCP","CD_NM_KO":"0.5","CD_GRP_ID":"WIT_TY","CD_NM_EN":"0.5","RGS_DATE":{"nanos":0,"time":1510712666000,"minutes":24,"seconds":26,"hours":11,"month":10,"year":117,"timezoneOffset":-540,"day":3,"date":15},"CD_ID":"0.5","UPD_USER_ID":"SYSTEM","CD_TY":"C","UPD_DATE":{"nanos":0,"time":1510712666000,"minutes":24,"seconds":26,"hours":11,"month":10,"year":117,"timezoneOffset":-540,"day":3,"date":15}},{"RGS_USER_ID":"SYSTEM","USE_TY_CD":"Y","CD_DSCRT":"1","SORT_ORDR":6,"SYS_CD":"UCP","CD_NM_KO":"1","CD_GRP_ID":"WIT_TY","CD_NM_EN":"1","RGS_DATE":{"nanos":0,"time":1510712666000,"minutes":24,"seconds":26,"hours":11,"month":10,"year":117,"timezoneOffset":-540,"day":3,"date":15},"CD_ID":"1","UPD_USER_ID":"SYSTEM","CD_TY":"C","UPD_DATE":{"nanos":0,"time":1510712666000,"minutes":24,"seconds":26,"hours":11,"month":10,"year":117,"timezoneOffset":-540,"day":3,"date":15}},{"RGS_USER_ID":"SYSTEM","USE_TY_CD":"Y","CD_DSCRT":"3","SORT_ORDR":7,"SYS_CD":"UCP","CD_NM_KO":"3","CD_GRP_ID":"WIT_TY","CD_NM_EN":"3","RGS_DATE":{"nanos":0,"time":1510712666000,"minutes":24,"seconds":26,"hours":11,"month":10,"year":117,"timezoneOffset":-540,"day":3,"date":15},"CD_ID":"3","UPD_USER_ID":"SYSTEM","CD_TY":"C","UPD_DATE":{"nanos":0,"time":1510712666000,"minutes":24,"seconds":26,"hours":11,"month":10,"year":117,"timezoneOffset":-540,"day":3,"date":15}}]');

$(document).ready(function(){
	$.manuHandler('6dbf7152-c02a-4a53-84ec-3431adf5dde8', 'f024c2a1-d80a-4a85-b794-5f6a8d437720');
	$.jqGrid($('#grid'),
	{
		  url : "/com/danusys/platform/work/event/CmEventList.do"
		, datatype : "json"
		, postData :
		{ 
			  sysCd : $("#sSysCd").val()
			, usvcGrpCd : $("#sUsvcGrpCd").val()
			, useTyCd : $("#sUseTyCd").val()
		}
		, colNames :
		[
			  '<input type="checkbox" name="hcheckbox" onchange="$.GridHeaderCheckBoxChange(\'#grid\', this, event);">'
			//, '번호'
			, '이벤트아이디'
			, '이벤트명'
			, '서비스그룹'
			, '시스템명'
			, '사용여부'
			// Hidden
			, '시스템코드'
			, '서비스그룹코드'
			//, '연번'
			//, '정렬순서'
			, '이벤트설명'
			//, '긴급도코드'
			//, '긴급도'
			//, '이벤트아이콘표출여부'
			//, '발생위치이동여부'
			//, '경광등작동유형'
			//, '복작이벤트여부'
			//, '이벤트아이콘표출여부명'
			//, '발생위치이동여부명'
			//, '경광등작동유형명'
			//, '복작이벤트여부명'
			//, '이벤트자동전송문장'
			, '사용여부코드'
			, '아이콘URL'
			, '등록자아이디'
			, '수정자아이디'
			, '등록일자'
			, '수정일자'
			//, '자동종료시간'
			, '표준이벤트여부'
			, 'IMG_OCR_PATH'
			, 'IMG_RCZ_PATH'
			, 'IMG_OCR'
			, 'IMG_RCZ'

		]
		, colModel :
		[
			  { name : 'CHECK', width:50, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, sortable: false, formatter: $.GridCheckBox}
			//, { name : 'RK', width:50, align:'center', sortable: false}
			, { name : 'CODE_ID', width:150, align:'center', sortable: false}
			, { name : 'CODE_NM', width:220, align:'center', sortable: false}
			, { name : 'USVC_GRP_NM', width:150, align:'center', sortable: false}
			, { name : 'SYS_NM', width:200, align:'center', sortable: false}
			, { name : 'USE_TY_NM', width:100, align:'center', sortable: false}
			// Hidden
			, { name : 'SYS_CD', hidden:true}
			, { name : 'USVC_GRP_CD', hidden:true}
			//, { name : 'SRL_NO', hidden:true}
			//, { name : 'SORT_ORDR', hidden:true}
			, { name : 'EVT_DSCRT', hidden:true}
			//, { name : 'URGDG_GRAD_CD', hidden:true}
			//, { name : 'URGDG_GRAD_NM', hidden:true}
			//, { name : 'EVT_ICON_DSP_YN', hidden:true}
			//, { name : 'EVT_LC_MOVE_YN', hidden:true}
			//, { name : 'LIGHTBAR_OPER_YN', hidden:true}
			//, { name : 'CMPND_EVT_YN', hidden:true}
			//, { name : 'EVT_ICON_DSP_NM', hidden:true}
			//, { name : 'EVT_LC_MOVE_NM', hidden:true}
			//, { name : 'LIGHTBAR_OPER_NM', hidden:true}
			//, { name : 'CMPND_EVT_NM', hidden:true}
			//, { name : 'EVT_AUTO_TRMS_STC', hidden:true}
			, { name : 'USE_TY_CD', hidden:true}
			, { name : 'ICON_URL', hidden:true}
			, { name : 'INST_ID', hidden:true}
			, { name : 'UPD_ID', hidden:true}
			, { name : 'INST_DE', hidden:true}
			, { name : 'UPD_DE', hidden:true}
			//, { name : 'AUTO_END_TIME', hidden:true}
			, { name : 'STD_EVT_YN', hidden:true}
			, { name : 'IMG_OCR_PATH', hidden:true}
			, { name : 'IMG_RCZ_PATH', hidden:true}
			, { name : 'IMG_OCR', hidden:true}
			, { name : 'IMG_RCZ', hidden:true}
		]
		, pager : '#pager'
		, rowNum : $('#rowPerPageList').val()
		, sortname: 'CODE_ID'
		, sortorder: 'DESC'
		, viewrecords:true
		, multiselect: false
		, shrinkToFit: true
		, scrollOffset: 0
		, autowidth: true
		, loadonce:false
		, jsonReader:
		{
			  id: "CODE_ID"
			, root: function(obj) { return obj.rows; }
			, page: function(obj) { return 1; }
			, total: function(obj)
			{
				if(obj.rows.length > 0) {
					var page  = obj.rows[0].ROWCNT / rowNum;
					if( (obj.rows[0].ROWCNT % rowNum) > 0) { page++; }
					return page;
				} else {
					return 1;
				}
			}
			, records: function(obj) { return $.showCount(obj); }
		}
		, onCellSelect : function(rowid, iCol, cellcontent, e)
		{
			if(iCol == 0) return false;
			
			var list = jQuery("#grid").getRowData(rowid);
			selectUsvcGrpCd(list);
			//fn_setGridData(list);
			$("#hCodeId").val(list.CODE_ID);
			// 상세
			$("#dCodeId").html(list.CODE_ID);
			$("#dEvtNm").html(list.CODE_NM);
			$("#dSysNm").html(list.SYS_NM);
			$("#dUsvcGrpNm").html(list.USVC_GRP_NM);
			$("#dUseTyNm").html(list.USE_TY_NM);
			//$("#dSrlNo").html(list.SEQ_NO);
			//$("#dSortOrdr").html(list.SORT_ORDR);
			$("#dCont").html(list.CONT);
			//$("#dUrgdgGradNm").html(list.URGDG_GRAD_NM);
			//$("#dEvtIconDspNm").html(list.EVT_ICON_DSP_NM);
			//$("#dEvtLcMoveNm").html(list.EVT_LC_MOVE_NM);
			//$("#dLightbarOperNm").html(list.LIGHTBAR_OPER_NM);
			//$("#dCmpndEvtNm").html(list.CMPND_EVT_NM);			
			//$("#dEvtAutoTrmsStc").html(list.EVT_AUTO_TRMS_STC);
			$("#dIconUrl").html(list.ICON_URL);
			$("#dRgsUserId").html(list.INST_ID + " / " + list.INST_DE);
			$("#dUpdUserId").html(list.UPD_ID + " / " + list.UPD_DE);

			var imgOcr = list.IMG_OCR;
			var imgRcz = list.IMG_RCZ;
			var imgOcrPath = list.IMG_OCR_PATH;
			var imgRczPath = list.IMG_RCZ_PATH;
			

			$("#dIconUrl_0_0").empty();
			if(imgOcr != ""){
				$("#dIconUrl_0_0").prepend('<img src="'+ imgOcrPath + '" style="width: 30px; height: 30px" title="'+ imgOcr +'">');
			}
			$("#dIconUrl_0_1").empty();
			if(imgRcz != ""){
				$("#dIconUrl_0_1").prepend('<img src="'+ imgRczPath +'" style="width: 30px; height: 30px" title="'+ imgRcz + '">');
			}
			$("#dAutoEndTime").html(list.AUTO_END_TIME);
			$("#dStdEvtYn").html(list.STD_EVT_YN);
			// 수정
			//$("#uIconUrl00").val(imgOcr);
			//$("#uIconUrl01").val(imgRcz);
		
			//$("#uIconUrl00File").val("");
			//$("#uIconUrl01File").val("");
			//$("#uIconUrl00File").attr("user-data-bak", imgOcrPath);
			//$("#uIconUrl01File").attr("user-data-bak", imgRczPath);

			$("#uAutoEndTime").val(list.AUTO_END_TIME);
			$.selectBarun("#uStdEvtYn", list.STD_EVT_YN);
		
			$("#uCodeId").html(list.CODE_ID);
			$("#uCodeNm").val(list.CODE_NM);
			$.selectBarun("#uUsvcGrpCd", list.USVC_GRP_CD);
			$.selectBarun("#uSysCd", list.SYS_CD);
			//$("#uSrlNo").val(list.SRL_NO);
			//$("#uSortOrdr").val(list.SORT_ORDR);
			$("#uEvtDscrt").val(list.EVT_DSCRT);
			//$.selectBarun("#uUrgdgGradCd", list.URGDG_GRAD_CD);
			//$.selectBarun("#uEvtIconDspYn", list.EVT_ICON_DSP_YN);
			//$.selectBarun("#uEvtLcMoveYn", list.EVT_LC_MOVE_YN);
			//$.selectBarun("#uLightbarOperYn", list.LIGHTBAR_OPER_YN);
			//$.selectBarun("#uCmpndEvtYn", list.CMPND_EVT_YN);
			//$("#uEvtAutoTrmsStc").val(list.EVT_AUTO_TRMS_STC);
			$.selectBarun("#uUseTyCd", list.USE_TY_CD);
			$("#uIconUrl").val(list.ICON_URL);
			$("#uRgsUserId").val(list.RGS_USER_ID);
			$("#uUpdUserId").val(list.UPD_USER_ID);
			$("#uRgsDate").val(list.RGS_DATE);
			$("#uUpdDate").val(list.UPD_DATE);

			// 이벤트항목정보 상세보기
			var list = jQuery("#grid").getRowData(rowid);
			fn_gridItem(list.CODE_ID);    // 이벤트세부항목
			fn_gridSub(list.CODE_ID);     // 이벤트 세부분류 

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
	});

	$.jqGrid('#grid_item_detail',
	{
		  datatype : "json"
		, postData : { 
			codeId : $.getCurrentRowValue("#grid", "CODE_ID")
		}
		, colNames :
		[
			  '번호'
			, '항목코드'
			, '항목명'
			, '필수여부'
			// hidden
			, '코드그룹'
			, 'CODE_ID'
			, '필수여부코드'
		]
		, colModel :
		[
			  { name : 'RK', width:50, align:'center'}
			, { name : 'EVT_ITEM_ID', width:165, align:'center' }
			, { name : 'EVT_ITEM_NM', width:165, align:'center' }
			, { name : 'EST_NM', width:80, align:'center' }
			// hidden
			, { name : 'CD_NM_KO', 'hidden':true}
			, { name : 'CODE_ID', 'hidden':true}
			, { name : 'EST_YN', 'hidden':true}
		]
		, pager : '#pager'
		, rowNum : 1000
		, sortname: 'EVT_ITEM_ID'
		, sortorder: 'ASC'
		, viewrecords:true
		, multiselect: false
		, loadonce:false
		, sortable: false
		, jsonReader: { }
		, onCellSelect : function(rowid, iCol, cellcontent, e){ }
		, beforeProcessing: function(data, status, xhr){ }
	});

	$.jqGrid('#grid_item_update',
	{
		  datatype : "json"
		, postData : { 
			codeId : $.getCurrentRowValue("#grid", "CODE_ID")
		}
		, colNames :
		[
			  '<input type="checkbox" name="hcheckbox" onchange="$.GridHeaderCheckBoxChange(\'#grid_item_update\', this, event);">'
			, '항목코드'
			, '항목명'
			, '필수여부'
			// hidden
			, '코드그룹'
			, 'CODE_ID'
		]
		, colModel :
		[
			  { name : 'CHECK', width:50, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, formatter: $.GridCheckBox}
			, { name : 'EVT_ITEM_ID', width:165, align:'center'}
			, { name : 'EVT_ITEM_NM', width:165, align:'center'}
			, { name : 'EST_YN', width:80, align:'center', editable: true, edittype:"select", editoptions:{value:""}, useroption: estYn, formatter: $.GridSelectBox}
			// hidden
			, { name : 'CD_NM_KO', 'hidden':true}
			, { name : 'CODE_ID', 'hidden':true}
		]
		, pager : '#pager'
		, rowNum : 1000
		, sortname: 'EVT_ITEM_ID'
		, sortorder: 'ASC'
		, viewrecords:true
		, multiselect: false
		, loadonce:false
		, sortable: false
		, jsonReader: { }
		, onCellSelect : function(rowid, iCol, cellcontent, e){ }
		, beforeProcessing: function(data, status, xhr){ }
		, loadComplete : function (data) {
			$('#grid_item_update SELECT').selectBox();
		}
	});
	
	//이벤트 항목(입력은 전체, 수정은 등록된 항목을 제외한 리스트)
	$.jqGrid('#grid_item_list_update',
	{
		  datatype : "json"
		, postData : {}
		, colNames :
		[
			  '<input type="checkbox" name="hcheckbox" onchange="$.GridHeaderCheckBoxChange(\'#grid_item_list_update\', this, event);">'
			, '번호'
			, '항목코드'
			, '항목명'
			, '코드그룹명'
			, '코드그룹'
		]
		, colModel :
		[
			  { name : 'CHECK', width:50, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, sortable: false, formatter: $.GridCheckBox}
			, { name : 'RK', width:50, align:'center', sortable: false}
			, { name : 'EVT_ITEM_ID', width:250, align:'center'}
			, { name : 'EVT_ITEM_NM', width:250, align:'center'}
			, { name : 'CD_GRP_NM', width:150, align:'center'}
			, { name : 'CD_GRP_ID', 'hidden':true}
		]
		, pager : '#pager'
		, rowNum : 1000
		, sortname: 'EVT_ITEM_ID'
		, sortorder: 'ASC'
		, viewrecords:true
		, multiselect: false
		, loadonce:false
		, jsonReader: { }
		, onCellSelect : function(rowid, iCol, cellcontent, e){ }
		, beforeProcessing: function(data, status, xhr){ }
	});

	//이벤트 항목 전체
	$.jqGrid('#grid_item_add',
	{
		  url : "/com/danusys/platform/work/event/evtItemList.do"
		, datatype : "json"
		, postData : {}
		, colNames :
		[
			  '<input type="checkbox" name="hcheckbox" onchange="$.GridHeaderCheckBoxChange(\'#grid_item_add\', this, event);">'
			, '번호'
			, '항목코드'
			, '항목명'
			, '코드그룹명'
			// hibben
			, '코드그룹'
		]
		, colModel :
		[
			  { name : 'CHECK', width:50, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, sortable: false, formatter: $.GridCheckBox}
			, { name : 'RK', width:50, align:'center', sortable: false}
			, { name : 'EVT_ITEM_ID', width:250, align:'center', sortable: false}
			, { name : 'EVT_ITEM_NM', width:250, align:'center', sortable: false}
			, { name : 'CD_GRP_NM',	width:150, align:'center', sortable: false}
			// hidden
			, { name : 'CD_GRP_ID', 'hidden':true}
		]
		, pager : '#pager'
		, rowNum : 1000
		, sortname: 'EVT_ITEM_ID'
		, sortorder: 'ASC'
		, viewrecords:true
		, multiselect: false
		, loadonce:false
		, jsonReader: { }
		, onCellSelect : function(rowid, iCol, cellcontent, e){ }
		, beforeProcessing: function(data, status, xhr){ }
	});
	// 이벤트세부분류 상세
	$.jqGrid('#grid_sub_detail',
	{
		  url : "/com/danusys/platform/work/event/evtSubList.do"
		, datatype : "json"
		, postData : { }
		, colNames :
		[
			  '세부분류코드'
			, '세부분류명'
			, '발생가중치'
			, '처리가중치'
			, '전파가중치'
		]
		, colModel :
		[
			  { name : 'EVT_ID_SUB_CD', width:90, align:'center'}
			, { name : 'EVT_ID_SUB_NM', width:90, align:'center'}
			, { name : 'WIT_1', width:90, align:'center'}
			, { name : 'WIT_2', width:90, align:'center'}
			, { name : 'WIT_3', width:90, align:'center'}
		]
		, sortable: false
		, shrinkToFit: false
		, viewrecords:true
		, loadonce:false
	});
	// 이벤트세부분류 수정
	$.jqGrid('#grid_sub_update',
	{
		  url : "/com/danusys/platform/work/event/evtSubList.do"
		, datatype : "json"
		, postData : { 
			codeId : $.getCurrentRowValue("#grid", "CODE_ID")
		}
		, colNames :
		[
			  '<input type="checkbox" name="hcheckbox" onchange="$.GridHeaderCheckBoxChange(\'#grid_sub_update\', this, event);">'
			, '세부분류명'
			, '발생가중치'
			, '처리가중치'
			, '전파가중치'
			// hidden
			, 'codeId'
			, '세부분류코드'
		]
		, colModel :
		[
			  { name : 'CHECK', width:50, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, formatter: $.GridCheckBox}
			, { name : 'EVT_ID_SUB_NM', width:120, align:'center'}
			, { name : 'WIT_1', width:90, align:'center', editable: true, edittype:"select", editoptions:{value:""}, useroption: witList, formatter: $.GridSelectBox}
			, { name : 'WIT_2', width:90, align:'center', editable: true, edittype:"select", editoptions:{value:""}, useroption: witList, formatter: $.GridSelectBox}
			, { name : 'WIT_3', width:90, align:'center', editable: true, edittype:"select", editoptions:{value:""}, useroption: witList, formatter: $.GridSelectBox}
			// hidden
			, { name : 'CODE_ID', hidden: true}
			, { name : 'EVT_ID_SUB_CD', hidden: true}
		]
		, viewrecords:true
		, multiselect: false
		, loadonce:false
		, sortable: false
		, jsonReader: { }
		, onCellSelect : function(rowid, iCol, cellcontent, e){ }
		, beforeProcessing: function(data, status, xhr){ }
		, loadComplete : function (data) {
			$('#grid_sub_update SELECT').selectBox();
		}
	});

	// 이벤트세부분류 수정
	$.jqGrid('#grid_sub_add',
	{
		  datatype : "json"
		, postData : { }
		, colNames :
		[
			  '<input type="checkbox" name="hcheckbox" onchange="$.GridHeaderCheckBoxChange(\'#grid_sub_add\', this, event);">'
			, '세부분류코드'
			, '세부분류명'
			, '발생가중치'
			, '처리가중치'
			, '전파가중치'
		]
		, colModel :
		[
			  { name : 'CHECK', width:50, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, formatter: $.GridCheckBox}
			, { name : 'EVT_ID_SUB_CD', width:150, align:'center'}
			, { name : 'EVT_ID_SUB_NM', width:150, align:'center'}
			, { name : 'WIT_1', width:80, align:'center', editable: true, edittype:"select", editoptions:{value:""}, useroption: witList, formatter: $.GridSelectBox}
			, { name : 'WIT_2', width:80, align:'center', editable: true, edittype:"select", editoptions:{value:""}, useroption: witList, formatter: $.GridSelectBox}
			, { name : 'WIT_3', width:80, align:'center', editable: true, edittype:"select", editoptions:{value:""}, useroption: witList, formatter: $.GridSelectBox}
		]
		, rowNum : 1000
		, sortname: 'EVT_ID_SUB_CD'
		, sortorder: 'ASC'
		, viewrecords:true
		, multiselect: false
		, loadonce:false
		, sortable: false
		, jsonReader: { }
		, onCellSelect : function(rowid, iCol, cellcontent, e){ }
		, beforeProcessing: function(data, status, xhr){ }
		, loadComplete : function (data) { }
	});
	// 검색
	$(".btnS").bind("click",function()
	{
		$("#grid").setGridParam({rowNum : $('#rowPerPageList').val()});
		var myPostData = $("#grid").jqGrid('getGridParam', 'postData');
		//검색할 조건의 값을 설정한다.
		myPostData.sysCd = $("#sSysCd").val();
		myPostData.usvcGrpCd = $("#sUsvcGrpCd").val();
		myPostData.useTyCd = $("#sUseTyCd").val();
		$("#grid").trigger("reloadGrid");
	});

	$("#sUsvcGrpCd").bind("change", function(){
		var url = "/com/danusys/platform/work/code/sysList.do";
		var params = "usvcGrpCd=" + $("#sUsvcGrpCd").val();
		$.ajax({
			type : "POST"
			, url : url
			, dataType : "json"
			, data: params
			, success:function(data)
			{
				//타켓 select, 전체여부(Y/N), code컬럼명, nm컬럼명, rows
				$.selectAdd("#sSysCd", 'Y', "SYS_CD", "SYS_NM", data.syscd);
			}
			, error:function(e){
				alert(e.responseText);
			}
		});
	});

	$("#iUsvcGrpCd").bind("change", function(){
		var url = "/com/danusys/platform/work/code/sysList.do";
		var params = "usvcGrpCd=" + $("#iUsvcGrpCd option:selected").val();

		$.ajax({
			type : "POST"
			, url : url
			, dataType : "json"
			, data: params
			, success:function(data)
			{
				//타켓 select, 전체여부(Y/N), code컬럼명, nm컬럼명, rows
				$.selectAdd("#iSysCd", 'N', "SYS_CD", "SYS_NM", data.syscd);
				$("#iSysCd").get(0).selectedIndex = 0;
			}
			, error:function(e){
				alert(e.responseText);
			}
		});
	});

	// 수정버튼
	$(".btnUp").bind("click",function(){
		var area = $(this).attr("area");
		var msg = "";
		var layer = "";
		var insertType = true;
		var inputType = true;
		if ( "add" == area) {
			msg = "추가";
			resetAction();
			layer = ".layerAdd";
		} else {
			msg = "수정";
			preModifyAction();
			layer = ".layerModify";
			$(".layerDetail").hide();    //상세보기 레이어 숨김추가(사이즈가 틀릴경우 보임 현상 발생)_141203_송준혁 
			insertType = false;
			inputType = false;
		}

		$("#modetitle").text(msg);
		$.changeInputMode(inputType);

		$(layer).show();
		var layerH = $(layer).height();
		$(layer).css({"margin-top": -(layerH/2)+"px"});

		$(".mask").remove();
		$("body").append("<div class='mask'></div>");
		try {
			$('.layer SELECT').selectBox("destroy");
			$('.layer SELECT').selectBox();
		} catch(e) {}
		
		insertFlag = insertType;
		return false;
	});

	
	// 이벤트세부항목 - 선택저장 : I, 삭제 : D, 팝업 : P
	$(".btnItem").bind("click",function()
	{
		var type = $(this).attr("area");
		var sGrid = "#grid_item_update";

		if ( "P" == type ) {
			fn_pop(".layerModifyItem");
		} else {

			var msg = "";
			var codeId = $("#hCodeId").val();
			if ( "U" == type ) {
				msg = "저장";
			} else if ( "D" == type ) {
				msg = "삭제";
			}
			var s = $.getSelRow(sGrid);
			var cnt =  s.length;
			if(0 == cnt)
			{
				alert(msg + "할 데이터를 선택하여 주십시오.");
				return false;
			}

			if (confirm("선택된 자료를 " + msg + " 하시겠습니까?") == false) { return false; }
			var params = "&dmlType=" + type;
			for(var i = 0; i<cnt; i++)
			{
				var list = jQuery(sGrid).getRowData(s[i]);
				params += "&codeId=" + codeId;
				params += "&evtItemId=" + list.EVT_ITEM_ID;
				params += "&estYn=" + $.getCustomObjectValue(sGrid, "select", "EST_YN", s[i]);
			}

			$.ajaxEx($(sGrid),
			{
				  url : "/com/danusys/platform/work/event/itemDml.do"
				, dataType : "json"
				, data: params
				, success:function(data)
				{
					$(sGrid).trigger("reloadGrid");
					alert(data.msg);
				}
				, error:function(e){
					alert(e.responseText);
				}
			});
		}
	});

	// 이벤트세부항목 - 선택저장 : I, 삭제 : D, 팝업 : P
	$(".btnSub").bind("click",function()
	{
		var type = $(this).attr("area");
		var sGrid = "#grid_sub_update";

		if ( "P" == type ) {
			fn_pop(".layerModifySub");
		} else {

			var msg = "";
			var codeId = $("#hCodeId").val();
			if ( "U" == type ) {
				msg = "저장";
			} else if ( "D" == type ) {
				msg = "삭제";
			}
			var s = $.getSelRow(sGrid);
			var cnt =  s.length;
			if(0 == cnt)
			{
				alert(msg + "할 데이터를 선택하여 주십시오.");
				return false;
			}

			if (confirm("선택된 자료를 " + msg + " 하시겠습니까?") == false) { return false; }
			var params = "&type=" + type;
			for(var i = 0; i<cnt; i++)
			{
				var list = jQuery(sGrid).getRowData(s[i]);
				params += "&codeId=" + encodeURIComponent(codeId);
				params += "&evtIdSubCd=" + encodeURIComponent(list.EVT_ID_SUB_CD);
				params += "&evtIdSubNm=" + encodeURIComponent(list.EVT_ID_SUB_NM);
				params += "&wit1=" + encodeURIComponent($.getCustomObjectValue(sGrid, "select", "WIT_1", s[i]));
				params += "&wit2=" + encodeURIComponent($.getCustomObjectValue(sGrid, "select", "WIT_2", s[i]));
				params += "&wit3=" + encodeURIComponent($.getCustomObjectValue(sGrid, "select", "WIT_3", s[i]));
			}

			$.ajaxEx($(sGrid),
			{
				  url : "/com/danusys/platform/work/event/eventSubDml.do"
				, dataType : "json"
				, data: params
				, success:function(data)
				{
					$(sGrid).trigger("reloadGrid");
					alert(data.msg);
				}
				, error:function(e){
					alert(e.responseText);
				}
			});
		}
	});

	//항목저장(팝업에서 추가)
	$(".btnSvItem").bind("click",function()
	{
		var params = "";
		var pGrid = "#grid_item_list_update";
		var codeId = $("#hCodeId").val();
		var s =  $.getSelRow(pGrid);
		if(s.length == 0) return false;
		if(confirm("선택된 자료를 추가하시겠습니까?") == false){ return false;}

		var paramsItem = "";
		for(var i = 0; i < s.length; i++)
		{
			var list = jQuery(pGrid).getRowData(s[i]);
			params += "&codeId=" + codeId;
			params += "&evtItemId=" + list.EVT_ITEM_ID;
		}

		$.ajaxEx($(pGrid),
		{
			  url : "/com/danusys/platform/work/event/insert_item.do"
			, dataType : "json"
			, data: params
			, success:function(data)
			{
				$("#grid_item_update").trigger("reloadGrid");
				$(pGrid).trigger("reloadGrid");
				alert(data.msg);
			}
			, error:function(e){
				alert(data.msg);
			}
		});
		$(".layerModify").show();
		$(".layerModifyItem").hide();
	});

	//항목저장(팝업에서 추가)
	$(".btnSvSub").bind("click",function()
	{
		var strCd = "#subCd";
		var strNm = "#subCdNm";
		var subCd = $(strCd).val();
		if ( null == subCd || '' == subCd ) {
			alert("분류코드를 등록하여야 합니다.");
			return;
		}

		// 분류명 분류코드 특수 문제 제거 
		//if (!fn_spWord(strCd)){return false;}
		//if (!fn_spWord(strNm)){return false;}
		if(confirm("저장 하시겠습니까?") == false){ return false;}

		var params = "";
		params += "&type=I";
		params += "&codeId=" + encodeURIComponent($("#hCodeId").val());
		params += "&evtIdSubCd=" + encodeURIComponent(subCd);
		params += "&evtIdSubNm=" + encodeURIComponent($(strNm).val());
		params += "&wit1=" + encodeURIComponent($("#subWit1 option:selected").val());
		params += "&wit2=" + encodeURIComponent($("#subWit2 option:selected").val());
		params += "&wit3=" + encodeURIComponent($("#subWit3 option:selected").val());
		params += "&useTyCd=" + encodeURIComponent($("#subUseTy option:selected").val());

		$.ajax({
			  type : "POST"
			, url : "/com/danusys/platform/work/event/eventSubDml.do"
			, dataType : "json"
			, data: params
			, success:function(data)
			{
				$("#grid_sub_update").trigger("reloadGrid");
				alert(data.msg);
			}
			, error:function(e){
				alert(e.responseText);
			}
		});

		$(".layerModify").show();
		$(".layerModifySub").hide();
	});

	//항목취소
	$(".btnCItem").bind("click",function()
	{
		var pDiv = ($(this).attr("area") == "item") ? ".layerModifyItem" : ".layerModifySub";
		$(".layerModify").show();
		$(pDiv).hide();
	});

	//file Element 핸들링
	$(".btnFileObject").bind("click",function(){
		var id = $(this).attr("user-ref-id");
		$("#" + id).click();
		return false;
	});

	$(".upload").bind("change", function(){
		$.checkChangeFileObject2(this);
		return false;
	});

});

function fn_pop(classId)
{
	if ( ".layerModifySub" == classId )
	{
		$("#subCd").val("");
		$("#subCdNm").val("");
		$.selectBarun("#subWit1", "0");
		$.selectBarun("#subWit2", "0");
		$.selectBarun("#subWit3", "0");
		$.selectBarun("#subUseTy", "Y");
	}
	$(".layerDetail").hide(); //상세보기 레이어 숨김추가(사이즈가 틀릴경우 보임 현상 발생)_141203_송준혁 
	$(".layerModify").hide();
	$(classId).show();
	$.center(classId);
}

function fn_gridItem(codeId)
{
	$("#grid_item_detail").jqGrid('setGridParam', {url: "/com/danusys/platform/work/event/evtItemInfoList.do"});
	var detail = $("#grid_item_detail").jqGrid('getGridParam', 'postData');
	detail.codeId = codeId;
	$("#grid_item_detail").trigger("reloadGrid");

	//등록된 이벤트항목
	$("#grid_item_update").jqGrid('setGridParam', {url: "/com/danusys/platform/work/event/evtItemInfoList.do"});
	var update = $("#grid_item_update").jqGrid('getGridParam', 'postData');
	update.codeId = codeId;
	$("#grid_item_update").trigger("reloadGrid");

	//등록된 이벤트를 제외한 항목
	$("#grid_item_list_update").jqGrid('setGridParam', {url: "/com/danusys/platform/work/event/evtItemList.do"});
	var listUpdate = $("#grid_item_list_update").jqGrid('getGridParam', 'postData');
	listUpdate.codeId = codeId;
	$("#grid_item_list_update").trigger("reloadGrid");
}

function fn_gridSub(codeId)
{
	// 이벤트 가중치 상세
	var sdGrid = $("#grid_sub_detail");
	sdGrid.jqGrid('getGridParam', 'postData').codeId = codeId;
	sdGrid.trigger("reloadGrid");
	// 등록된 이벤트 가중치
	var suGrid = $("#grid_sub_update");
	suGrid.jqGrid('getGridParam', 'postData').codeId = codeId;
	suGrid.trigger("reloadGrid");
}

function selectUsvcGrpCd(list)
{
	var url = "/com/danusys/platform/work/code/sysList.do";
	var params = "usvcGrpCd=" + encodeURIComponent(list.USVC_GRP_CD);

	$.ajax({
		  type : "POST"
		, url : url
		, dataType : "json"
		, data: params
		, success:function(data)
		{
			//타켓 select, 전체여부(Y/N), code컬럼명, nm컬럼명, rows
			$.selectAdd("#iSysCd", 'N', "SYS_CD", "SYS_NM", data.syscd);
			$.selectBarun("#iSysCd", list.SYS_CD);
		}
		, error:function(e){
			alert(e.responseText);
		}
	});
}

function resetAction()
{
	$("#iCodeId").attr("readonly", "readonly");
	$("#iCodeId").val("시스템코드(3)+서비스그룹(2)+이벤트 NO");

	$("#iEvtNm").val("");
	$("#iSysCd").get(0).selectedIndex = 0;
	$("#iUsvcGrpCd").get(0).selectedIndex = 0;
	//$("#iSrlNo").val("");
	//$("#iSortOrdr").val("");
	$("#iEvtDscrt").val("");
	//$("#iUrgdgGradCd").get(0).selectedIndex = 0;
	//$("#iEvtIconDspYn").get(0).selectedIndex = 0;
	//$("#iEvtLcMoveYn").get(0).selectedIndex = 0;
	//$("#iLightbarOperYn").get(0).selectedIndex = 0;
	//$("#iCmpndEvtYn").get(0).selectedIndex = 0;
	//$("#iEvtAutoTrmsStc").val("");
	$("#iUseTyCd").get(0).selectedIndex = 0;
	$("#iRgsUserId").val("");
	$("#iUpdUserId").val("");
	$("#iRgsDate").val("");
	$("#iUpdDate").val("");
	$("#iIconUrl00").val("");
	$("#iIconUrl01").val("");
	$("#iIconUrl00File").val("");
	$("#iIconUrl01File").val("");

	$("#iAutoEndTime").val("0");
	$("#iStdEvtYn").get(0).selectedIndex = 0;
	
	// 이벤트항목정보 추가
	var myPostData = $("#grid_item_list_update").jqGrid('getGridParam', 'postData');
	myPostData.codeId = "";
	$("#grid_item_list_update").trigger("reloadGrid"); 

	var myPostData = $("#grid_item_update").jqGrid('getGridParam', 'postData');
	myPostData.codeId = " ";
	$("#grid_item_update").trigger("reloadGrid"); 

	var myPostData = $("#grid_item_add").jqGrid('getGridParam', 'postData');
	myPostData.codeId = " ";
	$("#grid_item_add").trigger("reloadGrid"); 
}

function preModifyAction()
{
	$("#iCodeId").attr("readonly", "readonly");
	var url = "/com/danusys/platform/work/code/sysList.do";
	var params = "usvcGrpCd=" + encodeURIComponent($("#iUsvcGrpCd option:selected").val());

	$.ajax({
		  type : "POST"
		, url : url
		, dataType : "json"
		, data: params
		, success:function(data)
		{
			//타켓 select, 전체여부(Y/N), code컬럼명, nm컬럼명, rows
			$.selectAdd("#iSysCd", 'N', "SYS_CD", "SYS_NM", data.syscd);
			$("#iSysCd").get(0).selectedIndex = 0;
		}
		, error:function(e){
			alert(e.responseText);
		}
	});
}

function insertAction(obj)
{
	if($.validate(".layerAdd .tableType2") == false) { return false; }

	var usvcGrpCd = $("#iUsvcGrpCd option:selected").val();
	var sysCd = $("#iSysCd option:selected").val();
	var codeId = sysCd + usvcGrpCd;
	//var codeId = sysCd + usvcGrpCd + $("#iSrlNo").val();

	var params  = "&type=INSERT";
		params += "&codeId=" + codeId;
		params += "&codeNm=" + escape(encodeURIComponent($("#iCodeNm").val()));
		params += "&sysCd=" + sysCd;
		params += "&usvcGrpCd=" + usvcGrpCd;
		//params += "&srlNo=" + $("#iSrlNo").val();
		//params += "&sortOrdr=" + $("#iSortOrdr").val();
		params += "&cont=" + escape(encodeURIComponent($("#iCont").val()));
		//params += "&urgdgGradCd=" + $("#iUrgdgGradCd").val();
		//params += "&evtIconDspYn=" + $("#iEvtIconDspYn").val();
		//params += "&evtLcMoveYn=" + $("#iEvtLcMoveYn").val();
		//params += "&lightbarOperYn=" + $("#iLightbarOperYn").val();
		//params += "&cmpndEvtYn=" + $("#iCmpndEvtYn").val();
		//params += "&evtAutoTrmsStc=" + escape(encodeURIComponent($("#iEvtAutoTrmsStc").val()));
		params += "&useTyCd=" + $("#iUseTyCd").val();
		params += "&fileCnt=" + fn_fileCnt('i');
		params += "&iconUrl00=" + $("#iIconUrl00").val();
		params += "&iconUrl01=" + $("#iIconUrl01").val();
		//params += "&autoEndTime="+ $("#iAutoEndTime").val();
		params += "&stdEvtYn="+ $("#iStdEvtYn").val();

	var s =  $.getSelRow("#grid_item_add");
	if ( 0 == s.length ){
		if(confirm("세부항목 추가없이 진행하시겠습니까?") == false) return false;
	} else {
		if(confirm("선택된 자료를 추가하시겠습니까?") == false) return false;	
	}

	//var url = "/com/danusys/platform/work/event/insert.do";
	var url = "/com/danusys/platform/work/event/evtBaseDml.do";
	var paramsItem = "&evtItemId=null";
	for(var i = 0; i < s.length; i++)
	{
		var list = jQuery("#grid_item_add").getRowData(s[i]);
		paramsItem += "&evtItemId=" + list.EVT_ITEM_ID;
	}
	params += paramsItem;

	try {
		if($.multiFileUpload2(".layerAdd", url, params, function(){
				$("#grid").trigger("reloadGrid");
				$(".mask").remove();
				$(".layer").hide();
			}) == false) {
			return false;
		};
	}catch(e){}
	return true;
}

function updateAction(obj)
{
	if($.validate(".layerModify .tableType2") == false) { return false; }
	var autoEndTime = $("#uAutoEndTime").val();
	if(autoEndTime > 0 && autoEndTime < 300)
	{
		alert("자동종료시간의 입력값은 300보다 커야합니다.");
		return false;
	}

	var url = "/com/danusys/platform/work/event/evtBaseDml.do";
	var params  = "&type=UPDATE";
		params += "&codeId=" + $("#uCodeId").html();
		params += "&codeNm=" + escape(encodeURIComponent($("#uCodeNm").val()));
		params += "&sysCd=" + $("#uSysCd option:selected").val();
		params += "&usvcGrpCd=" + $("#uUsvcGrpCd option:selected").val();
		//params += "&srlNo=" + $("#uSrlNo").val();
		//params += "&sortOrdr=" + $("#uSortOrdr").val();
		params += "&cont=" + escape(encodeURIComponent($("#uCont").val()));
		//params += "&urgdgGradCd=" + $("#uUrgdgGradCd").val();
		//params += "&evtIconDspYn=" + $("#uEvtIconDspYn").val();
		//params += "&evtLcMoveYn=" + $("#uEvtLcMoveYn").val();
		//params += "&lightbarOperYn=" + $("#uLightbarOperYn").val();
		//params += "&cmpndEvtYn=" + $("#uCmpndEvtYn").val();
		//params += "&evtAutoTrmsStc=" + escape(encodeURIComponent($("#uEvtAutoTrmsStc").val()));
		params += "&useTyCd=" + $("#uUseTyCd").val();
		params += "&fileCnt=" + fn_fileCnt('u');
		params += "&iconUrl00=" + $("#uIconUrl00").val();
		params += "&iconUrl01=" + $("#uIconUrl01").val();
		//params += "&autoEndTime="+ autoEndTime;
		params += "&stdEvtYn="+ $("#uStdEvtYn").val();

	try {
		if ( $.multiFileUpload2(".layerModify", url, params, function(){
			$("#grid").setGridParam({page :$("#cur-page").val()});
			$("#grid").trigger("reloadGrid");
			$(".mask").remove();
			$(".layer").hide();
			}) == false) {
				return false;
			};
	} catch(e){}
	return true;
}

function deleteAction(obj)
{
	var url = "/com/danusys/platform/work/event/delete.do";
	var params = "&codeId=" + $("#dCodeId").html();

	$.ajaxEx($('#grid'),
	{
		  url : url
		, dataType : "json"
		, data: params
		, success:function(data)
		{
			$("#grid").setGridParam({page :$("#cur-page").val()});
			$("#grid").trigger("reloadGrid");
			alert(data.msg);
		}
		, error:function(e){
			alert(data.msg);
		}
	});
}

function fn_fileCnt(str)
{
	var icon00 = '#' + str + 'IconUrl00File';
	var icon01 = '#' + str + 'IconUrl01File';
	return $(icon00)[0].files.length + $(icon01)[0].files.length
}

function fn_spWord(str)
{
	var reVal = true;
	var obj = $(str);
	var reg = /[\[\]{}()<>?|`~!@#$&%^*_+=,.;:\"\\\'\\]/g;
	//특수문자 검증
	if ( reg.test(obj.val()) )
	{
		obj.val("");
		reVal = false;
	}
	return reVal;
}

</script>

</head>
<body user-context-root="/">
<div id="wrapper">
	<!-- topbar -->
	<jsp:include page="include/topMenu.jsp" >
	<jsp:param name="mc" value="6"/>
	</jsp:include>
	<!-- //topbar -->
	<!-- container -->
	<div class="container">
		<!-- leftMenu -->
		<div class="leftMenu">
			<ul>
        
			                <li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">상황속성</a>
			                    <ul>
	    
						<li class="user-select"><a href="/situationInfo.do">이벤트기본정보</a></li>
						
						<li class=""><a href="/work/event/item.do">이벤트세부항목</a></li>
						
						<!-- <li class=""><a href="#">전송경로정보</a></li>
						
						<li class=""><a href="#">이벤트처리단계별전송경로</a></li> -->
						
			                </ul>
			                <!-- <li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">상황전파그룹</a>
			                    <ul>
		
						<li class=""><a href="#">상황전파그룹관리</a></li>
						
	    		</ul> -->
	        </ul>
        <!--
		
			
			
			
			
			
	            <ul>
	                <li><a href="" id="" class="ic_code">코드관리</a>
	                    <ul>
	                        <li><a href="/com/danusys/platform/work/code.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=0">공통코드그룹</a></li>
	                        <li><a href="/wrks/sstm/code/dtcd.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=0">코드상세</a></li>
	                        <li><a href="/wrks/sstm/code/sycd.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=0">시스템코드</a></li>
	                        <li><a href="/wrks/sstm/code/sggcd.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=0">시군구코드</a></li>
	                        <li><a href="/wrks/sstm/code/dst.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=0">지구코드</a></li>
	                        <li><a href="/wrks/sstm/code/area.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=0">지역코드</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_user">사용자관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/usr/info.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=1">사용자관리</a></li>
	                        <li><a href="/wrks/sstm/usr/area.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=1">지역별사용자</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_group">그룹정보</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/grp/code.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=2">그룹관리</a></li>
	                        <li><a href="/wrks/sstm/grp/user_acc.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=2">그룹별이벤트(사용자권한)</a></li>
	                        <li><a href="/wrks/sstm/grp/user.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=2">그룹별사용자조회</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">모바일</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/mbl/grp.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=3">그룹관리</a></li>
	                        <li><a href="/wrks/sstm/mbl/info.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=3">계정정보</a></li>
	                        <li><a href="/wrks/sstm/mbl/version.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=3">버젼정보관리</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">이벤트관리</a>
	                    <ul>
	                        <li><a href="/com/danusys/platform/work/event.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=4">이벤트기본정보</a></li>
	                        <li><a href="/com/danusys/platform/work/event/item.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=4">이벤트세부항목</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">메뉴관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/menu/info.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=5">프로그램정보</a></li>
	                        <li><a href="/wrks/sstm/menu/menu.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=5">프로그램메뉴</a></li>
	                        <li><a href="/wrks/sstm/menu/grp.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=5">그룹별프로그램메뉴</a></li>
	                        <li><a href="/wrks/sstm/menu/user.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=5">사용자별프로그램메뉴</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">상황처리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/evtctl/info.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=7">상황관리</a></li>
	                        <li><a href="/wrks/sstm/evtctl/trans_recv.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=7">상황전달수신자관리</a></li>
	                        <li><a href="/wrks/sstm/evtctl/disp_mbl.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=7">표출단말관리</a></li>
	                        <li><a href="/wrks/sstm/evtprc/info.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=7">상황처리</a></li>
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
				



        
                <h2 class="tit">상황정보</h2> 
                <div class="location">
                    <span>Home</span>  &gt; <span>상황속성</span>  &gt; <span>이벤트기본정보</span>
                </div>
	    <!--
                <h2 class="tit">시스템</h2> 
                <div class="location">
                    <span>Home</span> &gt; <span>코드관리</span> &gt; <span>시스템코드</span>
                </div>
	    -->
			</div>
			<div class="content">
				<div class="titArea"><h3 class="tit">이벤트기본정보</h3></div>
				<div class="tableTypeFree seachT">
					<input type="hidden" id="hCodeId" />
					<table>
					<caption>이벤트기본정보</caption>
					<colgroup>
					<col style="width:90px;" />
					<col style="width:100px;" />
					<col style="width:80px;" />
					<col style="width:100px;" />
					<col style="width:80px;" />
					<col style="width:auto;" />
					</colgroup>
					<tbody>
					<tr>
						<th>서비스그룹</th>
						<td>
							<select name="sUsvcGrpCd" id="sUsvcGrpCd" class="selectType1">
								<option value="">전체</option>
								
								<option value="UC">U센터 </option>
								
								<!-- <option value="SH">공용 </option>
								
								<option value="TR">교통 </option>
								
								<option value="PS">대민서비스</option>
								
								<option value="UM">도시관리</option>
								
								<option value="CP">방범 </option>
								
								<option value="DP">방재 </option>
								
								<option value="HE">보건복지 </option>
								
								<option value="FT">시설물 </option>
								
								<option value="SF">안전 </option>
								
								<option value="VM">영상관리</option>
								
								<option value="IF">인프라 </option>
								
								<option value="AO">행정_기타 </option> -->
								
								<option value="EN">환경 </option>
								
							</select>
						</td>
						<th>시스템</th>
						<td>
							<select name="sSysCd" id="sSysCd" class="selectType1">
								<option value="">전체</option>
								
								<option value="EVENT_TYPE_1">안심귀가</option>
								
								<option value="EVENT_TYPE_2">사회적약자</option>
								
								<option value="EVENT_TYPE_3">112긴급지원</option>
								
								<option value="EVENT_TYPE_4">119긴급지원</option>
								
								<option value="EVENT_TYPE_5">비상벨</option>
								
								<option value="EVENT_TYPE_6">환경</option>
								
								<option value="EVENT_TYPE_7">재난</option>
								
								<!-- <option value="BIS">BIS</option>
								
								<option value="CTD">CCTV닥터</option>
								
								<option value="BNR">강도신고접수</option>
								
								<option value="RAF">강우량</option>
								
								<option value="PUG">경찰긴급출동</option>
								
								<option value="PPC">공원방범</option>
								
								<option value="FNM">광선로관리(FNMS)</option>
								
								<option value="TUA">교통돌발</option>
								
								<option value="TLK">교통돌발공사</option>
								
								<option value="TSC">교통신호제어</option>
								
								<option value="WES">기상</option>
								
								<option value="UVS">긴급영상공유</option>
								
								<option value="WLI">노약자위치정보관리</option>
								
								<option value="DNV">다누시스 VMS </option>
								
								<option value="APL">대기오염</option>
								
								<option value="RAW">도로공사</option>
								
								<option value="RPC">도로방범</option>
								
								<option value="UTI">도시교통정보</option>
								
								<option value="SLA">독거노인</option>
								
								<option value="CPA">반려동물</option>
								
								<option value="POC">방범</option>
								
								<option value="POD">방재</option>
								
								<option value="CPV">불법주정차단속</option>
								
								<option value="EBS">비상벨</option>
								
								<option value="FFS">산불감시</option>
								
								<option value="WSS">상수도감시</option>
								
								<option value="EMS">상황판</option>
								
								<option value="LPC">생활방범</option>
								
								<option value="FMS">센터시설물(FMS)</option>
								
								<option value="FHR">소방인명구조</option>
								
								<option value="FIF">소방화재</option>
								
								<option value="WLS">수위감시</option>
								
								<option value="WPC">수질관리</option>
								
								<option value="FCL">시설물</option>
								
								<option value="TSV">쓰레기투기단속</option>
								
								<option value="SKH">씽크홀</option>
								
								<option value="SEB">안전비상벨</option>
								
								<option value="CPZ">어린이보호구역</option>
								
								<option value="CRX">어린이안심</option>
								
								<option value="VSS">영상스트리밍</option>
								
								<option value="INV">이노뎁 VMS</option>
								
								<option value="DUC">재난정보긴급지원</option>
								
								<option value="IVA">주행차량자동인식</option>
								
								<option value="AVI">주행차량자동인식</option>
								
								<option value="WGS">침수감시</option>
								
								<option value="ILK">통합연계</option>
								
								<option value="UCP">통합플랫폼</option>
								
								<option value="SCS">학교안전</option>
								
								<option value="FIS">화재감시</option>
								
								<option value="ENV">환경</option> -->
								
							</select>
						</td>
						<th>사용유형</th>
						<td>
							<select name="" id="sUseTyCd" class="selectType1" maxlength="1">
								
								<option value="Y">사용</option>
								
								<option value="N">미사용</option>
								
								<option value="H">숨김</option>
								
								<option value="D">삭제</option>
								
							</select>
							<a href="javascript:;" class="btnRight btnS">검색</a>
						</td>
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
					<a href="#" class="btn btnDt btnUp" area="add" >추가</a>
					<a href="#" class="btn btnMultiDe">삭제</a>
				</div>
			</div>
			<!-- 이벤트 기본정보 추가 -->
			<div class="layer layerAdd" id="div_drag_2" >
				<div class="tit"><h4>이벤트세부항목 <span id="modetitle">추가</span></h4></div>
				<div class="layerCt">
					<div class="tableTypeFree tableType2">
						<table>
						<caption>이벤트기본정보 추가</caption>
						<tbody>
						<tr>
							<th>이벤트아이디</th>
							<td><input type="text" id="iCodeId" class="txtType" maxlength="40" /></td>
							<th>이벤트명</th>
							<td><input type="text" id="iCodeNm" class="txtType" maxlength="100" style="ime-mode:active"/></td>
						</tr>
						<tr>
							<th><star style="color: red">*</star> 서비스그룹</th>
							<td>
								<select name="" id="iUsvcGrpCd" class="selectType1" required="required" user-title="서비스그룹">
									
									<option value="UC">U센터 </option>
									
									<!-- <option value="SH">공용 </option>
									
									<option value="TR">교통 </option>
									
									<option value="PS">대민서비스</option>
									
									<option value="UM">도시관리</option>
									
									<option value="CP">방범 </option>
									
									<option value="DP">방재 </option>
									
									<option value="HE">보건복지 </option>
									
									<option value="FT">시설물 </option>
									
									<option value="SF">안전 </option>
									
									<option value="VM">영상관리</option>
									
									<option value="IF">인프라 </option>
									
									<option value="AO">행정_기타 </option> -->
									
									<option value="EN">환경 </option>
									
								</select>
							</td>
							<th><star style="color: red">*</star> 시스템</th>
							<td>
								<select name="" id="iSysCd" class="selectType1" required="required" user-title="시스템">
									
									<option value="REH">안심귀가</option>
								
									<option value="WPS">사회적약자</option>
								
									<option value="112">112긴급지원</option>
								
									<option value="119">119긴급지원</option>
								
									<option value="EBS">비상벨</option>
								
									<option value="ENV">환경</option>
								
									<option value="CAL">재난</option>
								
									<!-- <option value="BIS">BIS</option>
								
									<option value="CTD">CCTV닥터</option>
								
									<option value="BNR">강도신고접수</option>
								
									<option value="RAF">강우량</option>
								
									<option value="PUG">경찰긴급출동</option>
								
									<option value="PPC">공원방범</option>
								
									<option value="FNM">광선로관리(FNMS)</option>
								
									<option value="TUA">교통돌발</option>
								
									<option value="TLK">교통돌발공사</option>
								
									<option value="TSC">교통신호제어</option>
								
									<option value="WES">기상</option>
								
									<option value="UVS">긴급영상공유</option>
								
									<option value="WLI">노약자위치정보관리</option>
								
									<option value="DNV">다누시스 VMS </option>
								
									<option value="APL">대기오염</option>
								
									<option value="RAW">도로공사</option>
								
									<option value="RPC">도로방범</option>
								
									<option value="UTI">도시교통정보</option>
								
									<option value="SLA">독거노인</option>
								
									<option value="CPA">반려동물</option>
								
									<option value="POC">방범</option>
								
									<option value="POD">방재</option>
								
									<option value="CPV">불법주정차단속</option>
								
									<option value="EBS">비상벨</option>
								
									<option value="FFS">산불감시</option>
								
									<option value="WSS">상수도감시</option>
								
									<option value="EMS">상황판</option>
								
									<option value="LPC">생활방범</option>
								
									<option value="FMS">센터시설물(FMS)</option>
								
									<option value="FHR">소방인명구조</option>
								
									<option value="FIF">소방화재</option>
								
									<option value="WLS">수위감시</option>
								
									<option value="WPC">수질관리</option>
								
									<option value="FCL">시설물</option>
								
									<option value="TSV">쓰레기투기단속</option>
								
									<option value="SKH">씽크홀</option>
								
									<option value="SEB">안전비상벨</option>
								
									<option value="CPZ">어린이보호구역</option>
								
									<option value="CRX">어린이안심</option>
								
									<option value="VSS">영상스트리밍</option>
								
									<option value="INV">이노뎁 VMS</option>
								
									<option value="DUC">재난정보긴급지원</option>
								
									<option value="IVA">주행차량자동인식</option>
								
									<option value="AVI">주행차량자동인식</option>
								
									<option value="WGS">침수감시</option>
								
									<option value="ILK">통합연계</option>
								
									<option value="UCP">통합플랫폼</option>
								
									<option value="SCS">학교안전</option>
								
									<option value="FIS">화재감시</option>
									
									<option value="ENV">환경</option> -->
									
								</select>
							</td>
						</tr>
						<!-- <tr>
							<th><star style="color: red" user-required="insert">*</star>연번</th>
							<td><input type="text" id="iSrlNo" class="txtType" maxlength="3" required="required" user-title="연번" user-required="insert" user-data-type="number" user-key-len="3"/></td>
							<th>정렬순서</th>
							<td><input type="text" id="iSortOrdr" class="txtType" maxlength="10"/></td>
						</tr>
						<tr>
							<th>긴급도</th>
							<td>
								<select name="" id="iUrgdgGradCd" class="selectType1">
									
									<option value="10">최우선</option>
									
									<option value="20">우선</option>
									
									<option value="30">보통</option>
									
									<option value="40">주의관찰</option>
									
									<option value="50">탐지</option>
									
								</select>
							</td>
							<th>복합이벤트여부</th>
							<td>
								<select name="" id="iCmpndEvtYn" class="selectType1">
									<option value="Y">복합이벤트</option>
									<option value="N">단순이벤트</option>
								</select>
							</td>
						</tr> 
						<tr>
							<th>이벤트아이콘표출여부</th>
							<td>
								<select name="" id="iEvtIconDspYn" class="selectType1">
									<option value="Y">표출</option>
									<option value="N">표출안함</option>
								</select>
							</td>
							<th>경광등작동유형</th>
							<td colspan="3">
								<select name="" id="iLightbarOperYn" class="selectType1">
									<option value="0">작동안함</option>
									<option value="1">램프</option>
									<option value="2">램프+소리</option>
									<option value="3">램프</option>
								</select>
							</td>
						</tr> -->
						<tr>
							<th>사용유형</th>
							<td>
								<select name="" id="iUseTyCd" class="selectType1">
									
									<option value="Y">사용</option>
									
									<option value="N">미사용</option>
									
									<option value="H">숨김</option>
									
									<option value="D">삭제</option>
									
								</select>
							</td>
							<th>표준이벤트여부</th>
							<td>
								<select name="" id="iStdEvtYn" class="selectType1">
									<option value="Y">Y</option>
									<option value="N">N</option>
								</select>
							</td>
						</tr>
						<!-- <tr>
							<th>발생위치이동여부</th>
							<td>
								<select name="" id="iEvtLcMoveYn" class="selectType1">
									<option value="Y">이동</option>
									<option value="N">이동안함</option>
								</select>
							</td>
							<th>사용유형</th>
							<td>
								<select name="" id="iUseTyCd" class="selectType1">
									
									<option value="Y">사용</option>
									
									<option value="N">미사용</option>
									
									<option value="H">숨김</option>
									
									<option value="D">삭제</option>
									
								</select>
							</td>
						</tr> -->
						<tr>
							<th>발생 아이콘</th>
							<td>
								<input type="text" class="txtType70" id="iIconUrl00" readonly="readonly" style="width: 80px"/>
								<input type="file" id="iIconUrl00File" class="txtType carNum upload" style="display:none" user-ref-id="iIconUrl00" user-ext=".png" user-col-name="EVT_ICON_0" user-title="발생이미지"/>
								<a href="#" class="btn btnFileObject" user-ref-id="iIconUrl00File">찾기</a>
							</td>
							<th>인지 아이콘</th>
							<td>
								<input type="text" class="txtType70" id="iIconUrl01" readonly="readonly" style="width: 80px"/>
								<input type="file" id="iIconUrl01File" class="txtType carNum upload" style="display:none" user-ref-id="iIconUrl01" user-ext=".png" user-col-name="EVT_ICON_1" user-title="인지이미지"/>
								<a href="#" class="btn btnFileObject" user-ref-id="iIconUrl01File">찾기</a>
							</td>
						</tr>
						<!-- <tr>
							<th><star style="color: red">*</star>자동종료시간(초)</th>
							<td><input type="text" id="iAutoEndTime" class="txtType" maxlength="3" required="required" user-title="자동종료시간" user-required="insert" user-data-type="number" user-key-len="3"/></td>
							<th>표준이벤트여부</th>
							<td>
								<select name="" id="iStdEvtYn" class="selectType1">
									<option value="Y">Y</option>
									<option value="N">N</option>
								</select>
							</td>
						</tr> -->
						<tr>
							<th>설명</th>
							<td colspan="3"><input type="text" id="iCont" class="txtType txtType100" maxlength="1000" style="ime-mode:active"/></td>
						</tr>
						<!-- <tr>
							<th>이벤트자동전송문장</th>
							<td colspan="3"><input type="text" id="iEvtAutoTrmsStc" class="txtType txtType100" maxlength="255" style="ime-mode:active"/></td>
						</tr> -->
						</tbody>
						</table>
					</div>
					<br />
					<div class="tit"><h4><b>이벤트세부항목</b></h4></div>
					<!-- 	이벤트항목 리스트 -->
					<div>
						<div class="tableType1" style="width:100%; height:150px; overflow-y:scroll; overflow-x:hidden">
							<table id="grid_item_add" style="width:100%"></table>
						</div>
					</div>
					<div class="btnCtr">
						<a href="#" class="btn btnSv">저장</a>
						<a href="#" class="btn btnC">취소</a>
					</div>
				</div>
			</div>
			<!-- //이벤트 기본정보 추가 -->
			<!-- 이벤트기본정보 상세 레이어 -->
			<div class="layer layerDetail" id="div_drag_1" style="width:1000px">
				<div class="tit"><h4>이벤트기본정보 상세</h4></div>
				<div class="layerCt">
					<div class="tableTypeTris">
						<table>
						<caption>이벤트기본정보 상세</caption>
						<tbody>
						<tr>
							<th>이벤트아이디</th>
							<td id="dCodeId"></td>
							<th>이벤트명</th>
							<td id="dEvtNm"></td>
						</tr>
						<tr>
							<th>서비스그룹</th>
							<td id="dUsvcGrpNm"></td>
							<th>시스템</th>
							<td id="dSysNm"></td>
						</tr>
						<tr>
							<th>사용유형</th>
							<td id="dUseTyNm"></td>
							<th>표준이벤트여부</th>
							<td id="dStdEvtYn"></td>
						</tr>
						<!-- <tr>
							<th>시스템</th>
							<td id="dSysNm"></td>
							<th>연번</th>
							<td id="dSrlNo"></td>
							<th>정렬순서</th>
							<td id="dSortOrdr"></td>
						</tr>
						<tr>
							<th>긴급도</th>
							<td id="dUrgdgGradNm"></td>
							<th>복합이벤트여부</th>
							<td id="dCmpndEvtNm"></td>
							<th>이벤트아이콘표출여부</th>
							<td id="dEvtIconDspNm"></td>
						</tr>
						<tr>
							<th>경광등작동유형</th>
							<td id="dLightbarOperNm"></td>
							<th>발생위치이동여부</th>
							<td id="dEvtLcMoveNm"></td>
							<th>사용유형</th>
							<td id="dUseTyNm"></td>
						</tr> -->
						<tr>
							<th>발생아이콘</th>
							<td id="dIconUrl_0_0"></td>
							<th>인지아이콘</th>
							<td id="dIconUrl_0_1"></td>
						</tr>
						<!-- <tr>
							<th>자동종료시간(초)</th>
							<td colspan="5" id="dAutoEndTime"></td>
						</tr> -->
						</tbody>
						</table>
						<table>
						<tr>
							<th>설명</th>
							<td id="dEvtDscrt" colspan="5" ></td>
						</tr>
						<!-- <tr>
							<th>이벤트자동전송문장</th>
							<td id="dEvtAutoTrmsStc" colspan="5"></td>
						</tr> -->
						<tr>
							<th>등록자정보(아이디/날짜)</th>
							<td id="dRgsUserId"></td>
							<th>수정자정보(아이디/날짜)</th>
							<td id="dUpdUserId"></td>
						</tr>
						</table>
					</div>
					<br />
					<div class="boxWrap">
						<div class="tbLeft50" style="width:50%">
							<div class="tit"><h2><b>이벤트세부항목 그룹</b></h2></div>
							<!-- 등록된 사용자그룹 리스트 -->  
							<div class="tableType1 update" style="height:150px; overflow-y:scroll; overflow-x:hidden">
								<table id="grid_item_detail" style="width:100%"></table>
							</div>
						</div>
						<div class="tbLeft50" style="width:50%">
							<div class="tit"><h2><b>이벤트세부분류</b></h2></div>
							<!-- 이벤트세부분류   -->
							<div class="tableType1 update" style="height:150px; overflow-y:scroll; overflow-x:hidden">
								<table id="grid_sub_detail" style="width:100%"></table>
							</div>
						</div>
					</div>
					<div class="btnCtr">
						<a href="#" class="btn btnUp" area="update" >수정</a>
						<a href="#" class="btn btnDe">삭제</a>
						<a href="#" class="btn btnC">취소</a>
					</div>
				</div>
			</div>
			<!-- //이벤트기본정보 상세 레이어 -->
			<!-- 이벤트기본정보 수정 레이어 -->
			<div class="layer layerModify" id="div_drag_2" style="width:1000px">
				<div class="tit"><h4>이벤트세부항목 <span id="modetitle">추가</span></h4></div>
				<div class="layerCt">
					<div class="tableTypeFree tableType2">
						<table>
						<caption>이벤트기본정보 추가</caption>
						<tbody>
						<tr>
							<th>이벤트아이디</th>
							<td id="uCodeId"></td>
							<th>이벤트명</th>
							<td><input type="text" id="uCodeNm" class="txtType" maxlength="100" style="ime-mode:active"/></td>
						</tr>
						<tr>
							<th>서비스그룹</th>
							<td>
								<select name="" id="uUsvcGrpCd" class="uUsvcGrpCd" required="required" user-title="시스템">
									
									<option value="UC">U센터 </option>
									
									<!-- <option value="SH">공용 </option>
									
									<option value="TR">교통 </option>
									
									<option value="PS">대민서비스</option>
									
									<option value="UM">도시관리</option>
									
									<option value="CP">방범 </option>
									
									<option value="DP">방재 </option>
									
									<option value="HE">보건복지 </option>
									
									<option value="FT">시설물 </option>
									
									<option value="SF">안전 </option>
									
									<option value="VM">영상관리</option>
									
									<option value="IF">인프라 </option>
									
									<option value="AO">행정_기타 </option> -->
									
									<option value="EN">환경 </option>
									
								</select>
							</td>
							<th>시스템</th>
							<td>
								<select name="" id="uSysCd" class="uSysCd" required="required" user-title="시스템">
									
									<option value="REH">안심귀가</option>
								
									<option value="WPS">사회적약자</option>
								
									<option value="112">112긴급지원</option>
								
									<option value="119">119긴급지원</option>
								
									<option value="EBS">비상벨</option>
								
									<option value="ENV">환경</option>
								
									<option value="CAL">재난</option>
									
									<!-- <option value="112">112긴급지원</option>
									
									<option value="119">119긴급지원</option>
									
									<option value="BIS">BIS</option>
									
									<option value="CTD">CCTV닥터</option>
									
									<option value="BNR">강도신고접수</option>
									
									<option value="RAF">강우량</option>
									
									<option value="PUG">경찰긴급출동</option>
									
									<option value="PPC">공원방범</option>
									
									<option value="FNM">광선로관리(FNMS)</option>
									
									<option value="TUA">교통돌발</option>
									
									<option value="TLK">교통돌발공사</option>
									
									<option value="TSC">교통신호제어</option>
									
									<option value="WES">기상</option>
									
									<option value="UVS">긴급영상공유</option>
									
									<option value="WLI">노약자위치정보관리</option>
									
									<option value="DNV">다누시스 VMS </option>
									
									<option value="APL">대기오염</option>
									
									<option value="RAW">도로공사</option>
									
									<option value="RPC">도로방범</option>
									
									<option value="UTI">도시교통정보</option>
									
									<option value="SLA">독거노인</option>
									
									<option value="CPA">반려동물</option>
									
									<option value="POC">방범</option>
									
									<option value="POD">방재</option>
									
									<option value="CPV">불법주정차단속</option>
									
									<option value="EBS">비상벨</option>
									
									<option value="WPS">사회적약자</option>
									
									<option value="FFS">산불감시</option>
									
									<option value="WSS">상수도감시</option>
									
									<option value="EMS">상황판</option>
									
									<option value="LPC">생활방범</option>
									
									<option value="FMS">센터시설물(FMS)</option>
									
									<option value="FHR">소방인명구조</option>
									
									<option value="FIF">소방화재</option>
									
									<option value="WLS">수위감시</option>
									
									<option value="WPC">수질관리</option>
									
									<option value="FCL">시설물</option>
									
									<option value="TSV">쓰레기투기단속</option>
									
									<option value="SKH">씽크홀</option>
									
									<option value="SEB">안전비상벨</option>
									
									<option value="CPZ">어린이보호구역</option>
									
									<option value="CRX">어린이안심</option>
									
									<option value="VSS">영상스트리밍</option>
									
									<option value="INV">이노뎁 VMS</option>
									
									<option value="DUC">재난정보긴급지원</option>
									
									<option value="IVA">주행차량자동인식</option>
									
									<option value="AVI">주행차량자동인식</option>
									
									<option value="WGS">침수감시</option>
									
									<option value="ILK">통합연계</option>
									
									<option value="UCP">통합플랫폼</option>
									
									<option value="SCS">학교안전</option>
									
									<option value="FIS">화재감시</option>
									
									<option value="ENV">환경</option> -->
									
								</select>
							</td>
						</tr>
						<!-- <tr>
							<th>연번</th>
							<td><input type="text" id="uSrlNo" class="txtType" maxlength="10"/></td>
							<th>정렬순서</th>
							<td><input type="text" id="uSortOrdr" class="txtType" maxlength="10"/></td>
						</tr>
						<tr>
							<th>긴급도</th>
							<td>
								<select name="" id="uUrgdgGradCd" class="selectType1">
									
									<option value="10">최우선</option>
									
									<option value="20">우선</option>
									
									<option value="30">보통</option>
									
									<option value="40">주의관찰</option>
									
									<option value="50">탐지</option>
									
								</select>
							</td>
							<th>복합이벤트여부</th>
							<td>
								<select name="" id="uCmpndEvtYn" class="selectType1">
									<option value="Y">복합이벤트</option>
									<option value="N">단순이벤트</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>이벤트아이콘표출여부</th>
							<td>
								<select name="" id="uEvtIconDspYn" class="selectType1">
									<option value="Y">표출</option>
									<option value="N">표출안함</option>
								</select>
							</td>
							<th>경광등작동유형</th>
							<td colspan="3">
								<select name="" id="uLightbarOperYn" class="selectType1">
									<option value="0">작동안함</option>
									<option value="1">램프</option>
									<option value="2">램프+소리</option>
									<option value="3">램프</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>발생위치이동여부</th>
							<td>
								<select name="" id="uEvtLcMoveYn" class="selectType1">
									<option value="Y">이동</option>
									<option value="N">이동안함</option>
								</select>
							</td>
							<th>사용유형</th>
							<td>
								<select name="" id="uUseTyCd" class="selectType1">
									
									<option value="Y">사용</option>
									
									<option value="N">미사용</option>
									
									<option value="H">숨김</option>
									
									<option value="D">삭제</option>
									
								</select>
							</td>
						</tr> -->
						<tr>
							<th>사용유형</th>
							<td>
								<select name="" id="uUseTyCd" class="selectType1">
									
									<option value="Y">사용</option>
									
									<option value="N">미사용</option>
									
									<option value="H">숨김</option>
									
									<option value="D">삭제</option>
									
								</select>
							</td>
							<th>표준이벤트여부</th>
							<td>
								<select name="" id="uStdEvtYn" class="selectType1">
									<option value="Y">Y</option>
									<option value="N">N</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>발생 아이콘</th>
							<td>
								<input type="text" class="txtType70" id="uIconUrl00" readonly="readonly" style="width: 80px"/>
								<input type="file" id="uIconUrl00File" class="txtType carNum upload" style="display:none" user-ref-id="uIconUrl00" user-ext=".png" user-col-name="EVT_ICON_0" user-title="발생이미지"/>
								<a href="#" class="btn btnFileObject" user-ref-id="uIconUrl00File">찾기</a>
							</td>
							<th>인지 아이콘</th>
							<td>
								<input type="text" class="txtType70" id="uIconUrl01" readonly="readonly" style="width: 80px"/>
								<input type="file" id="uIconUrl01File" class="txtType carNum upload" style="display:none" user-ref-id="uIconUrl01" user-ext=".png" user-col-name="EVT_ICON_1" user-title="인지이미지"/>
								<a href="#" class="btn btnFileObject" user-ref-id="uIconUrl01File">찾기</a>
							</td>
						</tr>
						<!-- <tr>
							<th>자동종료시간(초)</th>
							<td><input type="text" id="uAutoEndTime" class="txtType" maxlength="10"/></td>
							<th>표준이벤트여부</th>
							<td>
								<select name="" id="uStdEvtYn" class="selectType1">
									<option value="Y">Y</option>
									<option value="N">N</option>
								</select>
							</td>
						</tr> -->
						<tr>
							<th>설명</th>
							<td colspan="3"><input type="text" id="uEvtDscrt" class="txtType txtType100" maxlength="1000" style="ime-mode:active"/></td>
						</tr>
						<!-- <tr>
							<th>이벤트자동전송문장</th>
							<td colspan="3"><input type="text" id="uEvtAutoTrmsStc" class="txtType txtType100" maxlength="255" style="ime-mode:active"/></td>
						</tr> -->
						</tbody>
						</table>
						<div class="btnCtr">
							<a href="#" class="btn btnSv">저장</a>
							<a href="#" class="btn btnC">취소</a>
						</div>
					</div>
					<br />
					<div class="boxWrap">
						<div class="tbLeft50" style="width:50%">
							<div class="tit"><h2><b>이벤트세부항목</b></h2></div>
							<div class="tableType1" style="width:100%; height:150px; overflow-y:scroll; overflow-x:hidden">
								<table id="grid_item_update" style="width:100%"></table>
							</div>
							<div class="btnCtr">
								<a href="#" class="btn btnItem" area="U">선택저장</a>
								<a href="#" class="btn btnItem" area="D">삭제</a>
								<a href="#" class="btn btnItem" area="P">추가</a>
							</div>
						</div>
						<div class="tbLeft50" style="width:50%">
							<div class="tit"><h2><b>이벤트세부분류</b></h2></div>
							<div class="tableType1" style="width:100%; height:150px; overflow-y:scroll; overflow-x:hidden">
								<table id="grid_sub_update" style="width:100%"></table>
							</div>
							<div class="btnCtr">
								<a href="#" class="btn btnSub" area="U">선택저장</a>
								<a href="#" class="btn btnSub" area="D">삭제</a>
								<a href="#" class="btn btnSub" area="P">추가</a>
							</div>
						</div>
					</div> <!-- //그리드 수정 및 등록 -->
					
				</div>
			</div>
			<!-- //이벤트기본정보 수정 레이어 -->
			<!-- 레이어팝업 항목추가 -->
			<div class="layer layerModifyItem" id="div_drag_3">
				<div class="tit"><h4>이벤트세부항목 추가</h4></div>
				<div class="layerCt">
					<div class="tableType1" style="height:450px; overflow-y:scroll; overflow-x:hidden">
						<table id="grid_item_list_update" style="width:100%"></table>
					</div>
					<div class="btnCtr update">
						<a href="#" class="btn btnSvItem">저장</a>
						<a href="#" class="btn btnCItem" area="item">취소</a>
					</div>
				</div>
			</div>
			<!-- //레이어팝업 항목추가 -->
			<!-- 가중치 항목추가 -->
			<div class="layer layerModifySub" id="div_drag_3">
				<div class="tit"><h4>이벤트세부분류 추가</h4></div>
				<div class="layerCt">
					<table class="tableType2">
					<tr>
						<th>분류코드</th>
						<td><input type="text" name="subCd" id="subCd" class="txtType txtType100" style="ime-mode:active"></td>
					</tr>
					<tr>
						<th>분류코드명</th>
						<td><input type="text" name="subCdNm" id="subCdNm" class="txtType txtType100" style="ime-mode:active"></td>
					</tr>
					<tr>
						<th>발생가중치</th>
						<td>
							<select id="subWit1" class="selectType80">
								
									<option value="0">0</option>
								
									<option value="0.1">0.1</option>
								
									<option value="0.2">0.2</option>
								
									<option value="0.3">0.3</option>
								
									<option value="0.5">0.5</option>
								
									<option value="1">1</option>
								
									<option value="3">3</option>
								
							</select>
						</td>
					</tr>
					<tr>
						<th>처리가중치</th>
						<td>
							<select id="subWit2" class="selectType80">
								
									<option value="0">0</option>
								
									<option value="0.1">0.1</option>
								
									<option value="0.2">0.2</option>
								
									<option value="0.3">0.3</option>
								
									<option value="0.5">0.5</option>
								
									<option value="1">1</option>
								
									<option value="3">3</option>
								
							</select>
						</td>
					</tr>
					<tr>
						<th>전파가중치</th>
						<td>
							<select id="subWit3" class="selectType80">
								
									<option value="0">0</option>
								
									<option value="0.1">0.1</option>
								
									<option value="0.2">0.2</option>
								
									<option value="0.3">0.3</option>
								
									<option value="0.5">0.5</option>
								
									<option value="1">1</option>
								
									<option value="3">3</option>
								
							</select>
						</td>
					</tr>
					<tr>
						<th>사용유형</th>
						<td>
							<select id="subUseTy" class="selectType80">
								<option value="Y">Y</option>
								<option value="N">N</option>
							</select>
						</td>
					</tr>
					</table>
					<div class="btnCtr update">
						<a href="#" class="btn btnSvSub">저장</a>
						<a href="#" class="btn btnCItem" area="sub">취소</a>
					</div>
				</div>
				<!-- //가중치 항목추가 -->
			</div>    <!-- //레이어팝업 항목추가 -->
		</div>        <!-- //content -->
	</div>            <!-- //container -->
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



<!-- <script>

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



</script> --></div>
</div>
<!-- //footer -->
</body>
</html>