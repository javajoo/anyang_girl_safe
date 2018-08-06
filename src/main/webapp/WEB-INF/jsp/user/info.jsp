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
	$.manuHandler('44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2', '848e773f-8686-4515-8f17-4d5650e36936');

    $.jqGrid($('#grid'), {
        url : '/wrks/sstm/usr/info/list.do?', //'/wrks/sstm/usr/info/list.json',
        datatype : "json",
        postData : { 
        	userId : $("#userId").val(),
        	userNmKo : $("#userNmKo").val(),
        	useTyCd : $("#useTyCd").val()
        },
        colNames : [
                    	'<input type="checkbox" name="hcheckbox" onchange="$.GridHeaderCheckBoxChange(\'#grid\', this, event);">',
                        '아이디',
                        '비밀번호',
                        '이름',
                        '영문이름',
                        '사용유형코드',
                        '사용유형',
                        '핸드폰번호',
                        '이메일',
                        '사무실전화번호',
                        '기관명',
                        '부서명',
                        '직급명',
                        'IP주소',
                        '담당업무',
                        '비고',
                        'IP_TY_CD',
                        'IP_CD'
                   ],
        colModel : [
                  { name : 'CHECK', width:60, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, sortable: false, formatter: $.GridCheckBox},
                  { name : 'USER_ID', width:250, align:'center'},
                  { name : 'PASSWORD', width:100, align:'center', hidden:true},
		          { name : 'USER_NM_KO', width:250, align:'center'},
		          { name : 'USER_NM_EN', width:300, align:'center', hidden:true},
		          { name : 'USE_TY_CD', width:180, align:'center', hidden:true},
		          { name : 'USE_NM', width:170, align:'center'},
		          { name : 'MOBL_NO', width:200, align:'center', hidden:true},
		          { name : 'EMAIL', width:200, align:'center', hidden:true},
		          { name : 'OFFC_TEL_NO', width:200, align:'center', hidden:true},
		          { name : 'INSTT_NM', width:200, align:'center', hidden:true},
		          { name : 'DEPT_NM', width:200, align:'center', hidden:true},
		          { name : 'RANK_NM', width:200, align:'center', hidden:true},
		          { name : 'IP_ADRES', width:200, align:'center', hidden:true},
		          { name : 'RPSB_WORK', width:250, align:'center'},
		          { name : 'REMARK', width:200, align:'center', hidden:true},
		          { name : 'IP_TY_CD', width:200, align:'center', hidden:true},
		          { name : 'IP_CD', width:200, align:'center', hidden:true}
          ],
        //pager : '#pager',
        rowNum : $('#rowPerPageList').val(),
        sortname: 'USER_ID',
        sortorder: 'ASC',
        viewrecords: true,
        multiselect: false,
        loadonce:false,
        jsonReader: {
        	id: "USER_ID",
        	root: function(obj) { return obj.rows; },
        	page: function(obj) { return 1; },
        	total: function(obj) {
        		if(obj.rows.length > 0) {
        			var page  = obj.rows[0].ROWCNT / rowNum;
        			if( (obj.rows[0].ROWCNT % rowNum) > 0)
        				page++;
        			return page;
        		}
        		else
        			return 1; 
        	},
        	records: function(obj) { return $.showCount(obj); }
        },
        onCellSelect : function(rowid, iCol, cellcontent, e){
			if(iCol == 0) return false;

			var list = jQuery("#grid").getRowData(rowid);
        	
        	/* 핸드폰번호 */
        	var mo = list.MOBL_NO;
        	var moblNo = mo.split("-");
			
        	/* 이메일 */
        	var em = list.EMAIL;
        	var email = em.split("@");
        	
        	/* 사무실번호 */
        	var op = list.OFFC_TEL_NO;
        	var offcTelNo = op.split("-");
        	
        	$("#dUserId").html(list.USER_ID);
			//$("#dPassword").html(list.PASSWORD);
			$("#dUserNmKo").html(list.USER_NM_KO);
			$("#dUserNmEn").html(list.USER_NM_EN);
			$("#dMoblNo").html(list.MOBL_NO);
			$("#dEmail").html(list.EMAIL);
			$("#dOffcTelNo").html(list.OFFC_TEL_NO);
			$("#dUseTyCd").html(list.USE_NM);
			$("#dInsttNm").html(list.INSTT_NM);
			$("#dDeptNm").html(list.DEPT_NM);
			$("#dRankNm").html(list.RANK_NM);
			$("#dRpsbWork").html(list.RPSB_WORK);
			$("#dIpAdres").html(list.IP_ADRES);
			$("#dRemark").html(list.REMARK);
			$("#dIpTyCd").html(list.IP_TY_CD);
			$("#dIpCd").html(list.IP_CD);
			
			$("#iUserId").val(list.USER_ID);
			//$("#iPassword").val(list.PASSWORD);
			$("#iUserNmKo").val(list.USER_NM_KO);
			$("#iUserNmEn").val(list.USER_NM_EN);
			$.selectBarun("#iMoblNo1", moblNo[0]);	
			$("#iMoblNo2").val(moblNo[1]);
			$("#iMoblNo3").val(moblNo[2]);
			$("#iEmail1").val(email[0]);
			$("#iEmail2").val(email[1]);
			$.selectBarun("#iOffcTelNo1", offcTelNo[0]);
			$("#iOffcTelNo2").val(offcTelNo[1]);
			$("#iOffcTelNo3").val(offcTelNo[2]);
			$.selectBarun("#iUseTyCd", list.USE_TY_CD);
			$("#iInsttNm").val(list.INSTT_NM);
			$("#iDeptNm").val(list.DEPT_NM);
			$("#iRankNm").val(list.RANK_NM);
			$("#iRpsbWork").val(list.RPSB_WORK);
			$("#iIpAdres").val(list.IP_ADRES);
			$("#iRemark").val(list.REMARK);
			//$("#iIpTyCd").val(list.IP_TY_CD);
			//$("#iIpCd").val(list.IP_CD);
			$.selectBarun("#iIpTyCd", list.IP_TY_CD);
			$.selectBarun("#iIpCd", list.IP_CD);
			
			ipTyCdList(list.IP_CD);
			
			/* 사용자그룹 상세보기*/
  			var list = jQuery("#grid").getRowData(rowid);
			$("#grid_user_grp_detail").jqGrid('setGridParam', {url: "/wrks/sstm/usr/info/list_user_grp.do"}); ///wrks/sstm/usr/info/list_user_grp.json
	    	var myPostData = $("#grid_user_grp_detail").jqGrid('getGridParam', 'postData');
	    	myPostData.userId = list.USER_ID;
	    	$("#grid_user_grp_detail").trigger("reloadGrid");  	
	    	
			/* 사용자그룹 수정*/
  			//등록된 사용자그룹
			//var list = jQuery("#grid").getRowData(rowid);
			$("#grid_user_grp_update").jqGrid('setGridParam', {url: "/wrks/sstm/usr/info/list_user_grp.do"}); ///wrks/sstm/usr/info/list_user_grp.json
	    	myPostData = $("#grid_user_grp_update").jqGrid('getGridParam', 'postData');
	    	myPostData.userId = list.USER_ID;
	    	$("#grid_user_grp_update").trigger("reloadGrid");	

	    	//등록된 항목을 제외한 사용자그룹 항목
	    	$("#grid_user_grp_list_update").jqGrid('setGridParam', {url: "/wrks/sstm/usr/info/list_grp.do"}); ///wrks/sstm/usr/info/list_grp.json
	      	myPostData = $("#grid_user_grp_list_update").jqGrid('getGridParam', 'postData');
	      	myPostData.userId = list.USER_ID;
	    	$("#grid_user_grp_list_update").trigger("reloadGrid");  			
			

			/* 사용자지역 상세보기*/
 			//var list = jQuery("#grid").getRowData(rowid);
			$("#grid_user_area_detail").jqGrid('setGridParam', {url: "<c:url value='/'/>wrks/sstm/usr/info/list_user_area.do"}); ///wrks/sstm/usr/info/list_user_area.json
	    	myPostData = $("#grid_user_area_detail").jqGrid('getGridParam', 'postData');
	    	myPostData.userId = list.USER_ID;
	    	$("#grid_user_area_detail").trigger("reloadGrid"); 	
	    	
			/* 사용자지역 수정*/
 			//등록된 사용자지역
 			//var list = jQuery("#grid").getRowData(rowid);
			$("#grid_user_area_update").jqGrid('setGridParam', {url: "<c:url value='/'/>wrks/sstm/usr/info/list_user_area.do"}); ///wrks/sstm/usr/info/list_user_area.json
	    	myPostData = $("#grid_user_area_update").jqGrid('getGridParam', 'postData');
	    	myPostData.userId = list.USER_ID;
	    	$("#grid_user_area_update").trigger("reloadGrid");	

	    	//등록된 항목을 제외한 사용자지역 항목
	    	$("#grid_user_area_list_update").jqGrid('setGridParam', {url: "/json/user/list_area.json"}); ///wrks/sstm/usr/info/list_area.json
	      	myPostData = $("#grid_user_area_list_update").jqGrid('getGridParam', 'postData');
	      	myPostData.userId = list.USER_ID;
	    	$("#grid_user_area_list_update").trigger("reloadGrid");  			
	    	
			
			$.showDetail();
        },
        beforeRequest: function() {
        	$.loading(true);
        	rowNum = $('#rowPerPageList').val();
        },
        beforeProcessing: function(data, status, xhr){
        	$.loading(false);
        	if(typeof data.rows != "undefine" || data.row != null) {
        		$.makePager("#grid", data, $("#grid").getGridParam('page'), $('#rowPerPageList').val());
        	}
        }        
  	});

    /* 사용자그룹 */
	//등록된 사용자 그룹(상세)
    $.jqGrid('#grid_user_grp_detail', {
        //url : '/wrks/sstm/usr/info/list_user_grp.json',
        datatype : "json",
        postData : { 
        	userId : $.getCurrentRowValue("#grid", "USER_ID")
        },
        colNames : [
                   	 	//'<input type="checkbox" name="hcheckbox" onchange="$.GridHeaderCheckBoxChange(\'#grid_user_grp_detail\', this, event);">',
                   	 	'번호',
                   	 	'그룹아이디',
                        '그룹명',
                        '권한레벨',
                        '지구코드',
                        '지구명',
                        '사용유형'
                   ],
        colModel : [
                    //{ name : 'CHECK', width:50, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, sortable: false, formatter: $.GridCheckBox},
                    { name : 'RK', width:50, align:'center', sortable: false},                    
                    { name : 'GRP_ID', width:100, align:'center'},
                    { name : 'GRP_NM_KO', width:100, align:'center'},
                    { name : 'AUTH_LVL_NM', width:120, align:'center'},
                  	{ name : 'DSTRT_CD', width:80, align:'center', hidden:true},
                  	{ name : 'DSTRT_NM', width:80, align:'center'},
                  	{ name : 'USE_TY_NM', width:90, align:'center'}
                  	
          			],
        pager : '#pager',
        rowNum : 1000,
        sortname: 'GRP_ID',
        sortorder: 'ASC',
        viewrecords:true,
		multiselect: false,
		loadonce:false,
        jsonReader: {
        },
        onCellSelect : function(rowid, iCol, cellcontent, e){
        },
        beforeProcessing: function(data, status, xhr){
        }        
  	});	
	
  //등록된 사용자 그룹(수정)
    $.jqGrid('#grid_user_grp_update', {
        //url : '/wrks/sstm/usr/info/list_user_grp.json',
        datatype : "json",
        postData : {
        	userId : $.getCurrentRowValue("#grid", "USER_ID")
        },
        colNames : [
                   	 	'<input type="checkbox" name="hcheckbox" onchange="$.GridHeaderCheckBoxChange(\'#grid_user_grp_update\', this, event);">',
                   	 	'번호',
                   	 	'그룹아이디',
                        '그룹명',
                        '권한레벨',
                        '지구코드',
                        '지구명',
                        '사용유형',
                        'USER_ID'
                   ],
        colModel : [
                    { name : 'CHECK', width:20, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, sortable: false, formatter: $.GridCheckBox},
                    { name : 'RK', width:30,  align:'center', sortable: false},                    
                    { name : 'GRP_ID', width:100, align:'center'},
                    { name : 'GRP_NM_KO', width:100, align:'center'},
                    { name : 'AUTH_LVL_SELECT', width:120, align:'center', editable: true, edittype:"select", editoptions:{value:""}, formatter: $.GridSelectBox2},
                  	{ name : 'DSTRT_CD', width:65, align:'center', hidden:true},
                  	{ name : 'DSTRT_NM', width:80, align:'center'},
                  	{ name : 'USE_TY_NM', width:90, align:'center'},
                  	{ name : 'USER_ID', width:100, align:'center', hidden:true}
           	
                  	
          			],
        pager : '#pager',
        rowNum : 1000,
        sortname: 'GRP_ID',
        sortorder: 'ASC',
        viewrecords:true,
		multiselect: false,
		loadonce:false,
        jsonReader: {
        },
        onCellSelect : function(rowid, iCol, cellcontent, e){
        },
        beforeProcessing: function(data, status, xhr){
        },
        loadComplete : function (data) {
			$('#grid_user_grp_update SELECT').selectBox("destroy");
    		$('#grid_user_grp_update SELECT').selectBox();
        }
  	});
	
	//그룹(수정_등록된 항목을 제외한 리스트)
    $.jqGrid('#grid_user_grp_list_update', {
        //url : '/wrks/sstm/usr/info/list_grp.json',
        datatype : "json",
        postData : { 
        	userId : ""
        },
        colNames : [
                   	 	'<input type="checkbox" name="hcheckbox" onchange="$.GridHeaderCheckBoxChange(\'#grid_user_grp_list_update\', this, event);">',
                   	 	'번호',
                   	 	'그룹아이디',
                        '그룹명',
                        '지구명',
                        '사용유형',                        
                        '권한레벨',                        
                   ],
        colModel : [
                    /* 
                    { name : 'CHECK', width:50, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, sortable: false, formatter: $.GridCheckBox},
                    { name : 'RK', width:50,  align:'center', sortable: false},                    
                    { name : 'GRP_ID', width:100, align:'center'},
                    { name : 'GRP_NM_KO', width:150, align:'center'},
                  	{ name : 'DSTRT_NM', width:150, align:'center'},
                  	{ name : 'USE_TY_NM', width:100, align:'center'},         
                  	{ name : 'AUTH_LVL_SELECT', width:100, align:'center', editable: true, edittype:"select", editoptions:{value:""}, formatter: $.GridSelectBox2}         
                  	 */

                    { name : 'CHECK', width:100, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, sortable: false, formatter: $.GridCheckBox},
                    { name : 'RK', width:100,  align:'center', sortable: false},                    
                    { name : 'GRP_ID', width:100, align:'center'},
                    { name : 'GRP_NM_KO', width:170, align:'center'},
                  	{ name : 'DSTRT_NM', width:200, align:'center'},
                  	{ name : 'USE_TY_NM', width:100, align:'center'},         
                  	{ name : 'AUTH_LVL_SELECT', width:150, align:'center', editable: true, edittype:"select", editoptions:{value:""}, formatter: $.GridSelectBox2}         
                  	                  	 
          			],
        pager : '#pager',
        rowNum : 1000,
        sortname: 'GRP_ID',
        sortorder: 'ASC',
        viewrecords:true,
		multiselect: false,
		loadonce:false,		 
        jsonReader: {
        },
        onCellSelect : function(rowid, iCol, cellcontent, e){
        },
        beforeProcessing: function(data, status, xhr){
        },
        loadComplete : function (data) {
			$('#grid_user_grp_list_update SELECT').selectBox("destroy");
    		$('#grid_user_grp_list_update SELECT').selectBox();
        }
  	});	

	//그룹 전체(입력)
    $.jqGrid('#grid_user_grp_list_insert', {
        url : '/wrks/sstm/usr/info/list_grp.do', //'/wrks/sstm/usr/info/list_grp.json',
        datatype : "json",
        postData : { 
        	userId : ""
        },
        colNames : [
                   	 	'<input type="checkbox" name="hcheckbox" onchange="$.GridHeaderCheckBoxChange(\'#grid_user_grp_list_insert\', this, event);">',
                   	 	'번호',
                   	 	'그룹아이디',
                        '그룹명',
                        '권한레벨',
                        '지구코드',
                        '지구명',
                        '사용유형'

                   ],
        colModel : [
                    { name : 'CHECK', width:20, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, sortable: false, formatter: $.GridCheckBox},
                    { name : 'RK',	width:30,  align:'center', sortable: false},                    
                    { name : 'GRP_ID', width:100, align:'center'},
                    { name : 'GRP_NM_KO', width:100, align:'center'},
                    { name : 'AUTH_LVL_SELECT', width:120, align:'center', editable: true, edittype:"select", editoptions:{value:""}, formatter: $.GridSelectBox2},
                  	{ name : 'DSTRT_CD', width:65, align:'center', hidden:true},
                  	{ name : 'DSTRT_NM', width:80, align:'center'},
                  	{ name : 'USE_TY_NM', width:90, align:'center'}
                  	
                  	
          			],
        pager : '#pager',
        rowNum : 1000,
        sortname: 'GRP_ID',
        sortorder: 'ASC',
        viewrecords:true,
		multiselect: false,
		loadonce:false,		 
        jsonReader: {
        },
        onCellSelect : function(rowid, iCol, cellcontent, e){
        },
        beforeProcessing: function(data, status, xhr){
        }        
  	});	
	
    /* 사용자지역 */
	//등록된 사용자 지역(상세보기)
    $.jqGrid('#grid_user_area_detail', {
        //url : '/wrks/sstm/usr/info/list_user_area.json',
        datatype : "json",
        postData : { 
        	userId : $.getCurrentRowValue("#grid", "USER_ID")
        },
        colNames : [
                   	 	//'<input type="checkbox" name="hcheckbox" onchange="$.GridHeaderCheckBoxChange(\'#grid_user_area_detail\', this, event);">',
                   	 	'번호',
                   	 	'지역코드',
                        '지역명',
                        '사용유형'
                   ],
        colModel : [
                    //{ name : 'CHECK', width:50, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, sortable: false, formatter: $.GridCheckBox},
                    { name : 'RK', width:50, align:'center', sortable: false},                    
                    { name : 'AREA_CD', width:100, align:'center'},
                    { name : 'AREA_NM', width:120, align:'center'},
                    { name : 'USE_TY_NM', width:100, align:'center'}
                    
                    
          			],
        pager : '#pager',
        rowNum : 1000,
        sortname: 'AREA_CD',
        sortorder: 'ASC',
        viewrecords:true,
		multiselect: false,
		loadonce:false,		 
        jsonReader: {
        },
        onCellSelect : function(rowid, iCol, cellcontent, e){
        },
        beforeProcessing: function(data, status, xhr){
        }        
  	});	
	
	//등록된 사용자 지역(수정)
    $.jqGrid('#grid_user_area_update', {
        //url : '/wrks/sstm/usr/info/list_user_area.json',
        datatype : "json",
        postData : { 
        	userId : $.getCurrentRowValue("#grid", "USER_ID")
        },
        colNames : [
                   	 	'<input type="checkbox" name="hcheckbox" onchange="$.GridHeaderCheckBoxChange(\'#grid_user_area_update\', this, event);">',
                   	 	'번호',
                   	 	'지역코드',
                        '지역명',
                        '사용유형',
                        'USER_ID'
                   ],
        colModel : [
                    { name : 'CHECK', width:20, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, sortable: false, formatter: $.GridCheckBox},
                    { name : 'RK', width:30, align:'center', sortable: false},                    
                    { name : 'AREA_CD', width:100, align:'center'},
                    { name : 'AREA_NM', width:120, align:'center'},
                    { name : 'USE_TY_NM', width:100, align:'center'},
                    { name : 'USER_ID', width:100, align:'center', hidden:true}
                    
          			],
        pager : '#pager',
        rowNum : 1000,
        sortname: 'AREA_CD',
        sortorder: 'ASC',
        viewrecords:true,
		multiselect: false,
		loadonce:false,		 
        jsonReader: {
        },
        onCellSelect : function(rowid, iCol, cellcontent, e){
        },
        beforeProcessing: function(data, status, xhr){
        }        
  	});	
	
	//지역(수정_등록된 항목을 제외한 리스트)
    $.jqGrid('#grid_user_area_list_update', {
        //url : '/wrks/sstm/usr/info/list_area.json',
        datatype : "json",
        postData : { 
        	userId : ""
        },
        colNames : [
                   	 	'<input type="checkbox" name="hcheckbox" onchange="$.GridHeaderCheckBoxChange(\'#grid_user_area_list_update\', this, event);">',
                   	 	'번호',
                   	 	'지역코드',
                        '지역명',
                        '사용유형'
                   ],
        colModel : [
                    /* 
                    { name : 'CHECK', width:50, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, sortable: false, formatter: $.GridCheckBox},
                    { name : 'RK', width:50, align:'center', sortable: false},                    
                    { name : 'AREA_CD', width:200, align:'center'},
                    { name : 'AREA_NM', width:200, align:'center'},
                    { name : 'USE_TY_NM', width:100, align:'center'}
                     */
                    
                     { name : 'CHECK', width:100, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, sortable: false, formatter: $.GridCheckBox},
                     { name : 'RK', width:100, align:'center', sortable: false},                    
                     { name : 'AREA_CD', width:300, align:'center'},
                     { name : 'AREA_NM', width:280, align:'center'},
                     { name : 'USE_TY_NM', width:150, align:'center'}                     
                    
          			],
        pager : '#pager',
        rowNum : 1000,
        sortname: 'AREA_CD',
        sortorder: 'ASC',
        viewrecords:true,
		multiselect: false,
		loadonce:false,		 
        jsonReader: {
        },
        onCellSelect : function(rowid, iCol, cellcontent, e){
        },
        beforeProcessing: function(data, status, xhr){
        }        
  	});	

	//지역 전체(입력)
    $.jqGrid('#grid_user_area_list_insert', {
        url : '/json/user/list_area.json', //'/wrks/sstm/usr/info/list_area.json',
        datatype : "json",
        postData : { 
        	userId : ""
        },
        colNames : [
                   	 	'<input type="checkbox" name="hcheckbox" onchange="$.GridHeaderCheckBoxChange(\'#grid_user_area_list_insert\', this, event);">',
                   	 	'번호',
                   	 	'지역코드',
                        '지역명',
                        '사용유형'
                   ],
        colModel : [
                    { name : 'CHECK', width:20, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, sortable: false, formatter: $.GridCheckBox},
                    { name : 'RK', width:30, align:'center', sortable: false},                    
                    { name : 'AREA_CD', width:100, align:'center'},
                    { name : 'AREA_NM', width:120, align:'center'},
                    { name : 'USE_TY_NM', width:100, align:'center'}

                    
                    
          			],
        pager : '#pager',
        rowNum : 1000,
        sortname: 'AREA_CD',
        sortorder: 'ASC',
        viewrecords:true,
		multiselect: false,
		loadonce:false,		 
        jsonReader: {
        },
        onCellSelect : function(rowid, iCol, cellcontent, e){
        },
        beforeProcessing: function(data, status, xhr){
        }        
  	});	
	    
    // 검색
    $(".btnS").bind("click",function(){
    	$("#grid").setGridParam({rowNum : $('#rowPerPageList').val()});
    	var myPostData = $("#grid").jqGrid('getGridParam', 'postData');
    	myPostData.userId = $("#userId").val();
    	myPostData.userNmKo = $("#userNmKo").val();
    	myPostData.useTyCd = $("#useTyCd").val();
    	$("#grid").trigger("reloadGrid");
    });

    $("#iIpTyCd").bind("change", function(){
    	var url = '/json/user/selectIpTyCd.json'; //"/wrks/sstm/usr/info/selectIpTyCd.json"; 
        var params = "ipTyCd=" + $("#iIpTyCd").val();
       	
        $.ajax({
        	type : "POST",
    	    url : url,
    	    dataType : "json",
    	    data: params,
            success:function(data){
            	//타켓 select, 전체여부(Y/N), code컬럼명, nm컬럼명, rows
				$.selectAdd("#iIpCd", 'N', "CD_ID", "CD_NM_KO", data.rows);
		    	$.changeElementAttr("#iIpCd");
            },   
            error:function(e){  
                alert(e.responseText);  
            }  
        });
    });
    $("#iIpCd").bind("change", function(){
    	$.changeElementAttr("#iIpCd");
    });

    $.changeElementAttr("#iIpCd");
    
    
   
    
    
    
	/* 사용자그룹 버튼 이벤트 */
	//그룹추가
    $(".btnAg").bind("click",function(){
 		//$(".layerDetail").hide(); 
        //$(".layerModify").hide();
        $(".layerModifyGrp").show();

        var layerH = $(".layerModifyGrp").height();
        //$(".layerModify").css({"top": (layerH/2)+"px"});
	    $(".layerModifyGrp").css({'margin-top':''});
        $(".layerModifyGrp").css({"top": (($(document).height() - layerH)/2)+"px"});
        
        
        $("#maskPrgm").remove();
        $("body").append("<div class='maskPop' id='maskPrgm'></div>");

        $('.layerModifyGrp SELECT').selectBox("destroy");
		$('.layerModifyGrp SELECT').selectBox();
    });    

	//그룹삭제
    $(".btnDg").bind("click",function(){
    	deleteMultiActionUserGrp();
    });    
	//그룹저장
    $(".btnSvGrp").bind("click",function(){

    	var params = "";
		params += "&userId=" + encodeURIComponent($("#iUserId").val());
		
	    var s =  $.getSelRow("#grid_user_grp_list_update");
	    
		if(s.length == 0){
			alert("선택된 그룹이 없습니다.");
			return false;
		}
		
		if(confirm("선택된 그룹을 추가하시겠습니까?") == false) return false;	
	
		var url = "/wrks/sstm/usr/info/insert_grp.json";  
	
		var paramsItem = ""; //""&grpId=null";    
	
	    for(var i = 0; i < s.length; i++) {
			var list = jQuery("#grid_user_grp_list_update").getRowData(s[i]);
			paramsItem += "&grpId=" + encodeURIComponent(list.GRP_ID);
			paramsItem += "&dstrtCd=" + encodeURIComponent(list.DSTRT_CD);
			paramsItem += "&authLvl=" + encodeURIComponent($.getCustomObjectValue("#grid_user_grp_list_update", "select", "AUTH_LVL_SELECT", i + 1));
	    }
	    //alert(paramsItem)
	    params += paramsItem;
	    
	    $.ajaxEx($('#grid_user_grp_update'), {
		    url : url,
		    dataType : "json",
		    data: params,
	        success:function(data){
	
	        	$("#grid_user_grp_update").trigger("reloadGrid");
	        	$("#grid_user_grp_list_update").trigger("reloadGrid");
	        	alert(data.msg);
	        },   
	        error:function(e){  
	            alert(data.msg);
	            
	        }  
	    });
	    
        $(".layerModify").show();
        $(".layerModifyGrp").hide();
        $("#maskPrgm").remove();
    	
    });    

	//그룹취소
    $(".btnCGrp").bind("click",function(){
        $(".layerModify").show();
        $(".layerModifyGrp").hide();
        $("#maskPrgm").remove();
    }); 	    

	/* 사용자 지역 버튼 이벤트 */
	//지역추가
    $(".btnAa").bind("click",function(){
 		//$(".layerDetail").hide(); //상세보기 레이어 숨김추가(사이즈가 틀릴경우 보임 현상 발생)_141203_송준혁 
        //$(".layerModify").hide();
        $(".layerModifyArea").show();

        var layerH = $(".layerModifyArea").height();
        //$(".layerModify").css({"top": (layerH/2)+"px"});
	    $(".layerModifyArea").css({'margin-top':''});
        $(".layerModifyArea").css({"top": (($(document).height() - layerH)/2)+"px"});

        $("#maskPrgm").remove();
        $("body").append("<div class='maskPop' id='maskPrgm'></div>");
    });

	//지역삭제
    $(".btnDa").bind("click",function(){
    	deleteMultiActionUserArea();
    });
	
	//지역저장
    $(".btnSvArea").bind("click",function(){

    	var params = "";
		params += "&userId=" + encodeURIComponent($("#iUserId").val());
		
	    var s =  $.getSelRow("#grid_user_area_list_update");
	    
		if(s.length == 0){
			alert("선택된 지역이 없습니다.");
			return false;
		}
		
		
		if(confirm("선택된 지역을 추가하시겠습니까?") == false) return false;
	
		var url = "/wrks/sstm/usr/info/insert_area.json";
	
		var paramsItem = "&areaCd=null";
	
	    for(var i = 0; i < s.length; i++) {
			var list = jQuery("#grid_user_area_list_update").getRowData(s[i]);
			paramsItem += "&areaCd=" + encodeURIComponent(list.AREA_CD);
	    }
	    
	    params += paramsItem;
	    
	    $.ajaxEx($('#grid_user_area_update'), {
		    url : url,
		    dataType : "json",
		    data: params,
	        success:function(data){
	
	        	$("#grid_user_area_update").trigger("reloadGrid");
	        	$("#grid_user_area_list_update").trigger("reloadGrid");
	        	alert(data.msg);
	        },   
	        error:function(e){  
	            alert(data.msg);
	            
	        }  
	    });
	    
        $(".layerModify").show();
        $(".layerModifyArea").hide();
        $("#maskPrgm").remove();    	
    });    

	//지역취소
    $(".btnCArea").bind("click",function(){
        $(".layerModify").show();
        $(".layerModifyArea").hide();
        $("#maskPrgm").remove();
    }); 	    
    
	
    /* 비밀번호 확인 */
	$("#iPasswordCk").change(function(){
		if($("#iPassword").val() != $("#iPasswordCk").val()){
			$("#ckPs").show();
		}else{
			$("#ckPs").hide();
		}
	});

});

function ipTyCdList(ipCd){
	
	var url = '/json/user/selectIpTyCd.json'; //"/wrks/sstm/usr/info/selectIpTyCd.json"; 
    var params = "ipTyCd=" + $("#iIpTyCd").val();
   	
    $.ajax({
    	type : "POST",
	    url : url,
	    dataType : "json",
	    data: params,
        success:function(data){
        	//타켓 select, 전체여부(Y/N), code컬럼명, nm컬럼명, rows
			$.selectAdd("#iIpCd", 'N', "CD_ID", "CD_NM_KO", data.rows);
			$.selectBarun("#iIpCd", ipCd);
        	$.changeElementAttr("#iIpCd");
	    	
        },   
        error:function(e){  
            alert(e.responseText);  
        }  
    });
}
function resetAction() {
	$("#iUserId").removeAttr("readonly");
	$("#ckPs").hide();
	$.resetInputObject(".layerModify .tableTypeFree");

	/* 사용자그룹 등록*/
  	var myPostData = $("#grid_user_grp_list_update").jqGrid('getGridParam', 'postData');
	myPostData.userId = "";
	$("#grid_user_grp_list_update").trigger("reloadGrid"); 

  	var myPostData = $("#grid_user_grp_update").jqGrid('getGridParam', 'postData');
	myPostData.userId = "";
	$("#grid_user_grp_update").trigger("reloadGrid"); 
	
	
	ipTyCdList();
	
	// 추가
	$("#iPassword").attr("required", "required");
	$("#iPasswordCk").attr("required", "required");
	
	$("dStar").remove();
	$(".star").before("<dStar style='color: red'>*</dStar>");
	
	$(".layerModify .tableType1.insert").show();
	$(".layerModify .tableType1.update").hide();
	$(".btn.btnAg").hide();
	$(".btn.btnDg").hide();
	$(".btn.btnAa").hide();
	$(".btn.btnDa").hide();
}

function preModifyAction() {
	$("#iUserId").attr("readonly", "readonly");
	$("#iPassword").val("");
	$("#iPasswordCk").val("");
	$("#adminPw").val("")
	
	$("#ckPs").hide();
	
	$("dStar").remove();
	$("#iPassword").removeAttr("required");
	$("#iPasswordCk").removeAttr("required");
	
	$(".layerModify .tableType1.insert").hide();
	$(".layerModify .tableType1.update").show();
	$(".btn.btnAg").show();
	$(".btn.btnDg").show();
	$(".btn.btnAa").show();
	$(".btn.btnDa").show();
}

function updateAction(obj) {
	
	var moblNo = $("#iMoblNo1").val() +"-"+ $("#iMoblNo2").val() +"-"+ $("#iMoblNo3").val();
	var email = $("#iEmail1").val() +"@"+ $("#iEmail2").val();
	var offcTelNo = $("#iOffcTelNo1").val() +"-"+ $("#iOffcTelNo2").val() +"-"+ $("#iOffcTelNo3").val();
	
    var url = "/wrks/sstm/usr/info/update.do";  
    var params = "userId=" + encodeURIComponent($("#iUserId").val());
	    params += "&password=" + encodeURIComponent($("#iPassword").val());
	    params += "&userNmKo=" + encodeURIComponent($("#iUserNmKo").val());
	    params += "&userNmEn=" + encodeURIComponent($("#iUserNmEn").val());
	    params += "&moblNo=" + encodeURIComponent(moblNo);
	    params += "&email=" + encodeURIComponent(email);
	    params += "&offcTelNo=" + encodeURIComponent(offcTelNo);
	    params += "&useTyCd=" + encodeURIComponent($("#iUseTyCd").val());
	    params += "&insttNm=" + encodeURIComponent($("#iInsttNm").val());
	    params += "&deptNm=" + encodeURIComponent($("#iDeptNm").val());
	    params += "&rankNm=" + encodeURIComponent($("#iRankNm").val());
	    params += "&rpsbWork=" + encodeURIComponent($("#iRpsbWork").val());
	    params += "&ipAdres=" + encodeURIComponent($("#iIpAdres").val());
	    params += "&remark=" + encodeURIComponent($("#iRemark").val());  
	    params += "&ipTyCd=" + encodeURIComponent($("#iIpTyCd").val());  
	    params += "&ipCd=" + encodeURIComponent($("#iIpCd").val());
	    params += "&adminPw="+ encodeURIComponent($("#adminPw").val());
	    
    /* 비밀번호 확인 */
	if($("#iPassword").val() != $("#iPasswordCk").val()){
		alert("비밀번호가 일치하지않습니다.");
		$("#ckPs").show();
		return false;
	}else{
		$("#ckPs").hide();
	}

	/* 그룹 */
 	var paramsItem = ""; // "&grpId=null";  
 	var rows = $("#grid_user_grp_update").jqGrid('getGridParam', 'records');

    for(var i=0; i<rows; i++){
      	var list = jQuery("#grid_user_grp_update").getRowData(i + 1);
		
		paramsItem += "&grpId=" + encodeURIComponent(list.GRP_ID);
		paramsItem += "&dstrtCd=" + encodeURIComponent(list.DSTRT_CD);
		//paramsItem += "&authLvl=" + $.getCustomObjectValue("#grid_user_grp_update", "select", "AUTH_LVL_SELECT", i + 1);
		paramsItem += "&authLvl=" + encodeURIComponent($.getCustomObjectValue("#grid_user_grp_update", "select", "AUTH_LVL_SELECT", i + 1));
		 
    }
    params += paramsItem;
    
    $.ajaxEx($('#grid'), {
	    url : url,
	    dataType : "json",
	    data: params,
        success:function(data){

        	$("#grid").setGridParam({page :$("#cur-page").val()});
        	$("#grid").trigger("reloadGrid");
        	//alert("저장하였습니다.");
        	alert(data.msg);
        },   
        error:function(e){  
            //alert(e.responseText);
            alert(data.msg);
        }  
    });
}

function validate() {
	return $.validate(".layerModify .tableTypeFree");
}

function insertAction(obj) {
	var moblNo = $("#iMoblNo1").val() +"-"+ $("#iMoblNo2").val() +"-"+ $("#iMoblNo3").val();
	var email = $("#iEmail1").val() +"@"+ $("#iEmail2").val();
	var offcTelNo = $("#iOffcTelNo1").val() +"-"+ $("#iOffcTelNo2").val() +"-"+ $("#iOffcTelNo3").val();
	
	var url = "/wrks/sstm/usr/info/insert.do";  
	var params = "userId=" + encodeURIComponent($("#iUserId").val());
	    params += "&password=" + encodeURIComponent($("#iPassword").val());
	    params += "&userNmKo=" + encodeURIComponent($("#iUserNmKo").val());
	    params += "&userNmEn=" + encodeURIComponent($("#iUserNmEn").val());
	    params += "&moblNo=" + encodeURIComponent(moblNo);
	    params += "&email=" + encodeURIComponent(email);
	    params += "&offcTelNo=" + encodeURIComponent(offcTelNo);
	    params += "&useTyCd=" + encodeURIComponent($("#iUseTyCd").val());
	    params += "&insttNm=" + encodeURIComponent($("#iInsttNm").val());
	    params += "&deptNm=" + encodeURIComponent($("#iDeptNm").val());
	    params += "&rankNm=" + encodeURIComponent($("#iRankNm").val());
	    params += "&rpsbWork=" + encodeURIComponent($("#iRpsbWork").val());
	    params += "&ipAdres=" + encodeURIComponent($("#iIpAdres").val());
	    params += "&remark=" + encodeURIComponent($("#iRemark").val());
	    params += "&ipTyCd=" + encodeURIComponent($("#iIpTyCd").val());
	    params += "&ipCd=" + encodeURIComponent($("#iIpCd").val());
	    params += "&adminPw="+ encodeURIComponent($("#adminPw").val());
	    
	    
		/* 비밀번호 확인 */
		if($("#iPassword").val() != $("#iPasswordCk").val()){
			alert("비밀번호가 일치하지않습니다.");
			$("#ckPs").show();
			return false;
		}else{
			$("#ckPs").hide();
		}
		
		/* 그룹 */
	    var s =  $.getSelRow("#grid_user_grp_list_insert");
		if(s.length == 0){
			alert("하나 이상의 그룹은 반드시 선택하여야 합니다.");
			return false;			
			//if(confirm("그룹 추가없이 진행하시겠습니까?") == false) return false;
		}else if(s.length > 1){
			alert("하나의 그룹만 선택하여야 합니다.");
			return false;
		}
/* 		else{
			if(confirm("선택된 자료를 추가하시겠습니까?") == false) return false;	
		} */ 
		var paramsItem = ""; // "&grpId=null";  
	    for(var i = 0; i < s.length; i++) {
			var list = jQuery("#grid_user_grp_list_insert").getRowData(s[i]);
			
			paramsItem += "&grpId=" + encodeURIComponent(list.GRP_ID);
			paramsItem += "&dstrtCd=" + encodeURIComponent(list.DSTRT_CD);
			//paramsItem += "&authLvl=" + $.getCustomObjectValue("#grid_user_grp_list_insert", "select", "AUTH_LVL_SELECT", i + 1);
			paramsItem += "&authLvl=" + encodeURIComponent($.getCustomObjectValue("#grid_user_grp_list_insert", "select", "AUTH_LVL_SELECT", i + 1));
	    }
	    params += paramsItem;

	    /* 지역 */
	    s =  $.getSelRow("#grid_user_area_list_insert");
		if(s.length == 0){
			alert("하나 이상의 지역은 반드시 추가하여야 합니다.");
			return false;				
			//if(confirm("지역 추가없이 진행하시겠습니까?") == false) return false;
		}
/* 		else{
			if(confirm("선택된 자료를 추가하시겠습니까?") == false) return false;	
		} */ 
		paramsItem = "&areaCd=null";
	    for(var i = 0; i < s.length; i++) {
			var list = jQuery("#grid_user_area_list_insert").getRowData(s[i]);
			
			paramsItem += "&areaCd=" + encodeURIComponent(list.AREA_CD);
	    }
	    params += paramsItem;
		

    $.ajaxEx($('#grid'), {
	    url : url,
	    dataType : "json",
	    data: params,
        success:function(data){
        	
        	if(data.session == 1){
	        	$("#grid").trigger("reloadGrid");
            	alert(data.msg);
            	
                $.hideInsertForm();
                
        	}else{
        		alert(data.msg);
        	} 
        	
        	
        },   
        error:function(e){  
            //alert(e.responseText);
        	alert(data.msg);
        }  
    });
}

function deleteAction(obj) {
	var url = "/wrks/sstm/usr/info/delete.do";  
    var params = "userId=" + encodeURIComponent($("#dUserId").text());  

    $.ajaxEx($('#grid'), {
	    url : url,
	    dataType : "json",
	    data: params,
        success:function(data){

        	$("#grid").setGridParam({page :$("#cur-page").val()});
        	$("#grid").trigger("reloadGrid");
        	alert("삭제하였습니다.");
        },   
        error:function(e){  
            //alert(e.responseText);
            alert(data.msg);
        }  
    });
}

function deleteMultiAction(obj) {
	//var s =  $("#grid").jqGrid('getGridParam', 'selarrrow');
	var s =  $.getSelRow("#grid");
	if(s.length == 0){
		alert("삭제할 데이터를 선택하여 주십시오.");
		return false;
	}

	if(confirm("선택된 자료를 삭제하시겠습니까?") == false) return false;
    var url = "/wrks/sstm/usr/info/deleteMulti.json";  
    var params = "";  
	
    for(var i = 0; i < s.length; i++) {
		var list = jQuery("#grid").getRowData(s[i]);
	    params += "&userId=" + encodeURIComponent(list.USER_ID);
    }

    $.ajaxEx($('#grid'), {
	    url : url,
	    dataType : "json",
	    data: params,
        success:function(data){

        	$("#grid").setGridParam({page :$("#cur-page").val()});
        	$("#grid").trigger("reloadGrid");
        	//alert("삭제하였습니다.");
        	alert(data.msg);
        },   
        error:function(e){  
            //alert(e.responseText);
        	alert(data.msg);
        }  
    });
    
    return true;
}


function deleteMultiActionUserGrp(obj) {
	
	var s =  $.getSelRow("#grid_user_grp_update");
	if(s.length == 0){
		alert("선택된 그룹이 없습니다.");
		return false;
	}
	
	if(confirm("선택된 자료를 삭제하시겠습니까?") == false) return false;
    
	var url = "/wrks/sstm/usr/info/deleteMulti_user_grp.json";
    var params = "";

    for(var i = 0; i < s.length; i++) {
		var list = jQuery("#grid_user_grp_update").getRowData(s[i]);
		
	    params += "&userId="+ encodeURIComponent(list.USER_ID);
	    params += "&grpId="+ encodeURIComponent(list.GRP_ID);
	    params += "&dstrtCd="+ encodeURIComponent(list.DSTRT_CD);
    }

    $.ajaxEx($('#grid_user_grp_update'), {
	    url : url,
	    dataType : "json",
	    data: params,
        success:function(data){
        	$("#grid_user_grp_update").trigger("reloadGrid");
        	$("#grid_user_grp_list_update").trigger("reloadGrid");
        	alert(data.msg);
        },
        error:function(e){
            alert(data.msg);            
        }
    });

    return true;
}

function deleteMultiActionUserArea(obj) {

	var s =  $.getSelRow("#grid_user_area_update");
	if(s.length == 0){
		alert("선택된 지역이 없습니다.");
		return false;	
	}
	
	if(confirm("선택된 자료를 삭제하시겠습니까?") == false) return false;
    var url = "/wrks/sstm/usr/info/deleteMulti_user_area.json";  
    var params = "";  

    for(var i = 0; i < s.length; i++) {
		var list = jQuery("#grid_user_area_update").getRowData(s[i]);
		
	    params += "&areaCd=" + encodeURIComponent(list.AREA_CD);
	    params += "&userId=" + encodeURIComponent(list.USER_ID);
	    
	    
    }

    $.ajaxEx($('#grid_user_area_update'), {
	    url : url,
	    dataType : "json",
	    data: params,
        success:function(data){

        	$("#grid_user_area_update").trigger("reloadGrid");
        	$("#grid_user_area_list_update").trigger("reloadGrid");
        	alert(data.msg);
        },   
        error:function(e){  
            alert(data.msg);
            
        }  
    });

    return true;
}

</script>

</head>
<body>
<div id="wrapper">
    <!-- topbar -->
	<%-- <jsp:include page="/WEB-INF/jsp/include/topMenu.jsp" >
	<jsp:param name="mc" value="5"/>
	</jsp:include> --%>
	<!-- //topbar -->
    <!-- container -->
    <div class="container">
        <!-- leftMenu -->
		




        <div class="leftMenu">
<ul>
	<li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">환경설정</a>
	<ul>
		<li class=""><a href="/system.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=45b5a59f-e94b-4d2e-aa92-ba1760c595b3">관제화면옵션설정</a></li>
		<li class=""><a href="/wrks/sstm/rdus/dis_evt.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=2e1e01e9-9fcc-4e32-8e40-2e699fab182f">재난 세부분류별 표출이벤트</a></li>
		<li class=""><a href="/wrks/sstm/rdus/auto_dis.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=35626504-8693-49cb-b194-50eff61ff4db">자동표출이벤트항목관리</a></li>
	</ul>
	</li>
	<li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">사용자정보</a>
	<ul>
		<li class="user-select"><a href="/wrks/sstm/usr/info.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=848e773f-8686-4515-8f17-4d5650e36936">사용자관리</a></li>
		<!-- <li class=""><a href="/wrks/sstm/usr/area.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=6b9398b2-0047-41bf-9d5b-8af7650d515e">지역별사용자</a></li> -->
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
                    <span>Home</span>  &gt; <span>사용자정보</span>  &gt; <span>사용자관리</span>
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
                    <h3 class="tit">사용자관리</h3>
                </div>
                <div class="tableTypeHalf seachT">
                    <table>
                        <caption>사용자 추가</caption>
                        <tbody>
                        <tr>
	                        <th>아이디</th>
	                        <td><input type="text" name="" id="userId" class="txtType carNum searchEvt" style="ime-mode:inactive"></td>
	                        <th>이름</th>
	                        <td><input type="text" name="" id="userNmKo" class="txtType carNum searchEvt" style="ime-mode:active"></td>
                            <th>사용유형</th>
                            <td>
                            	<select name="" id="useTyCd" class="selectType1" maxlength="1">
						    		 
						        		<option value="Y">사용</option>   
						    		 
						        		<option value="N">미사용</option>   
						    		 
						        		<option value="H">숨김</option>   
						    		 
						        		<option value="D">삭제</option>   
						    		                     
								</select>
								<a href="javascript:;" class="btnRight btnS searchBtn">검색</a>
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
    				<table id="grid" style="width:100%">
    				</table>
                </div>
                <div class="paginate">
                </div>
                <div class="btnWrap btnR">
                    <a href="#" class="btn btnDt btnRgt">추가</a>
                    <!-- <a href="#" class="btn btnMultiDe">삭제</a> -->
                </div>
            </div>
            
            <!-- 레이어팝업 상세 -->
            <div class="layer layerDetail" id="div_drag_1" style="width:1000px">
                <div class="tit"><h4>사용자 상세</h4></div>
                <div class="layerCt">
                    <div class="tableTypeWide">
                        <table>
                            <caption>사용자 상세</caption>
                            <tbody>
	                            <tr>
	                                <th>아이디</th>
	                                <td id="dUserId"></td>
	                                <th>비밀번호</th>
	                                <td id="dPassword"></td>
	                                <th>한글이름</th>
	                                <td id="dUserNmKo"></td>
	                            </tr>
	                            <tr>
	                                <th>영문이름</th>
	                                <td id="dUserNmEn"></td>
		                            <th>핸드폰번호</th>
	                                <td id="dMoblNo" colspan="3"></td>
	                            </tr>
	                            <tr>
	                            	<th>사용유형</th>
	                            	<td id="dUseTyCd"></td>
	                            	<th>이메일</th>
	                            	<td id="dEmail" colspan="3"></td>
	                            </tr>
	                            <tr>
	                            	<th>기관명</th>
	                            	<td id="dInsttNm"></td>
	                            	<th>사무실전화번호</th>
	                            	<td id="dOffcTelNo" colspan="3"></td>
	                            </tr>
	                            <tr>
	                            	<th>부서명</th>
	                            	<td id="dDeptNm"></td>
	                            	<th>직급명</th>
	                            	<td id="dRankNm"></td>
	                            	<th>담당업무</th>
	                            	<td id="dRpsbWork"></td>
	                            </tr>
	                            <tr>
	                            	<th>IP주소체계구분</th>
	                            	<td id="dIpTyCd"></td>
	                            	<th>IP주소입력구분</th>
	                            	<td id="dIpCd"></td>
	                            	<th>IP주소</th>
	                            	<td id="dIpAdres"></td>
	                            </tr>
	                            <tr>
	                            	<th>비고</th>
	                            	<td id="dRemark" colspan="5"></td>
	                            </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <!--등록된 사용자그룹/사용자지역 리스트  -->
	                <div class="boxWrap">
	                	<br>
	                	<div class="tbLeft50"  style="width:60%">
	                		<div class="tit"><h2><b>사용자 그룹</b></h2></div>
				            <!-- 등록된 사용자그룹 리스트 -->  
		                    <div class="tableType1 update" style="height:250px; overflow-y:scroll; overflow-x:hidden">
				    			<table id="grid_user_grp_detail" style="width:100%">
				    			</table>
				            </div>
				        </div>
				        <div class="tbLeft50"  style="width:40%">
				            <!-- 등록된 사용자지역 리스트   -->
				            <div class="tit"><h2><b>사용자 지역</b></h2></div>
		                    <div class="tableType1 update" style="height:250px; overflow-y:scroll; overflow-x:hidden">
				    			<table id="grid_user_area_detail" style="width:100%">
				    			</table>
				            </div>
	                	</div>
	                </div>
                    
                    <div class="btnCtr">
                        <a href="#" class="btn btnMd">수정</a>
                        <a href="#" class="btn btnDe">삭제</a>
                        <a href="#" class="btn btnC">취소</a>
                    </div>
                </div>
            </div>
            <!-- //레이어팝업 상세 -->
            
            <!-- //레이어팝업 등록 -->
            <div class="layer layerModify" id="div_drag_2" style="width:1000px">
                <div class="tit"><h4>사용자 <span id="modetitle">추가</span></h4></div>
                <div class="layerCt">
                    <div class="tableTypeFree">
                        <table>
                            <caption>사용자 추가</caption>
                            <tbody id="ind">
	                            <tr>
	                                <th><star style="color: red; ime-mode:inactive" user-required="insert">*</star> 아이디</th>
	                                <td><input type="text" name="" id="iUserId" class="txtType" maxlength="40" required="required" user-title="아이디"/></td>
	                                <th><tx class="star">비밀번호</tx></th>
	                                <td><input type="password" name="" id="iPassword" class="txtType" maxlength="64" required="" user-title="비밀번호" user-data-type="password" user-data-min="8" user-data-max="20"/></td>
	                                <th><tx class="star">비밀번호 확인</tx></th>
	                                <td><input type="password" name="" id="iPasswordCk" class="txtType" maxlength="64" required="" user-title="비밀번호 확인"  user-data-type="password"/></td>	
	                            </tr>
	                            <tr id="ckPs" style='display:none; color:red'><td></td><td colspan='3'><b>* 비밀번호가 일치하지 않습니다. 다시 확인해 주세요</b></td></tr>
	                            <tr>
	                                <th><star style="color: red">*</star>한글이름</th>
	                                <td><input type="text" name="" id="iUserNmKo" class="txtType" maxlength="100" required="required" user-title="한글이름" style="ime-mode:active"/></td>
	                                <th>영문이름</th>
	                                <td colspan="3"><input type="text" name="" id="iUserNmEn" class="txtType" maxlength="100" style="ime-mode:inactive"/></td>
	                            </tr>
	                            <tr>
	                            	<th>사용유형</th>
	                            	<td>
	                            		<select name="" id="iUseTyCd" class="selectType1" maxlength="1">
										     
										        <option value="Y">사용</option>   
										     
										        <option value="N">미사용</option>   
										     
										        <option value="H">숨김</option>   
										     
										        <option value="D">삭제</option>   
										                         
										</select>
	                            	</td>
		                            <th><star style="color: red">*</star>핸드폰번호</th>
	                                <td colspan="3">
	                                	<select name="" id="iMoblNo1" class="selectType1">
											<option value="">== 선택 ==</option>
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="017">017</option>
										</select>
										&nbsp;&nbsp; - &nbsp;&nbsp;
	                                	<input type="text" name="" id="iMoblNo2" class="date8Type" maxlength="4"/>
	                                	&nbsp;&nbsp; - &nbsp;&nbsp;
	                                	<input type="text" name="" id="iMoblNo3" class="date8Type" maxlength="4"/>
	                                </td>
	                            </tr>
	                            <tr>
	                            	<th>부서명</th>
	                            	<td><input type="text" name="" id="iDeptNm" class="txtType" maxlength="100" style="ime-mode:active"/></td>
	                            	<th>이메일</th>
	                            	<td colspan="3">
	                            		<input type="text" name="" id="iEmail1" class="txtType" maxlength="50"/>
	                            		&nbsp;&nbsp; @ &nbsp;&nbsp;
	                            		<input type="text" name="" id="iEmail2" class="txtType" maxlength="40"/>
<!-- 	                            		
	                            		<select name="" id="iEmail3" class="selectType1">
											<option value="">== 선택 ==</option>
											<option value="hanmail.net">hanmail.net</option>
											<option value="naver.com">naver.com</option>
											<option value="gmail.com">gmail.com</option>
										</select>
 -->
	                            	</td>
	                            </tr>
	                            <tr>
	                            	<th>기관명</th>
	                            	<td><input type="text" name="" id="iInsttNm" class="txtType" maxlength="100" style="ime-mode:active"/></td>
	                            	<th>사무실전화번호</th>
	                            	<td id="iOffcTelNo" colspan="3">

	                                	<select name="" id="iOffcTelNo1" class="selectType1">
											<option value="">== 선택 ==</option>
											<option value="02">02</option>
											<option value="031">031</option>
											<option value="032">032</option>
											<option value="033">033</option>
											<option value="041">041</option>
											<option value="042">042</option>
											<option value="043">043</option>
											<option value="049">049</option>
											<option value="051">051</option>
											<option value="052">052</option>
											<option value="053">053</option>
											<option value="054">054</option>
											<option value="055">055</option>
											<option value="061">061</option>
											<option value="062">062</option>
											<option value="063">063</option>
											<option value="064">064</option>
										</select>										
										
										&nbsp;&nbsp; - &nbsp;&nbsp;
	                                	<input type="text" name="" id="iOffcTelNo2" class="date8Type" maxlength="4"/>
	                                	&nbsp;&nbsp; - &nbsp;&nbsp;
	                                	<input type="text" name="" id="iOffcTelNo3" class="date8Type" maxlength="4"/>
	                            	</td>
	                            </tr>
	                            <tr>
	                            </tr>
	                            <tr>
	                            	<th>직급명</th>
	                            	<td><input type="text" name="" id="iRankNm" class="txtType" maxlength="100" style="ime-mode:active"/></td>
	                            	<th>담당업무</th>
	                            	<td><input type="text" name="" id="iRpsbWork" class="txtType" maxlength="100" style="ime-mode:active"/></td>
	                            	<th><star style="color: red">*</star>IP주소체계구분</th>
	                            	<td>
	                            		<select name="" id="iIpTyCd" class="selectType1" required="required" user-title="IP주소체계구분">
										     
										        <option value="IPv4">IPv4</option>
										     
										        <option value="IPv6">IPv6</option>
										    
										</select>
									</td>
	                            </tr>
	                            <tr>
	                            	<th><star style="color: red">*</star>IP주소입력구분</th>
	                            	<td>
	                            		<select name="" id="iIpCd" class="selectType1" required="required" user-title="IP주소입력구분" user-trigger-id="iIpAdres" user-trigger-req-ex="AL">
										     
										        <option value="AC">AC</option>   
										     
										        <option value="AL">AL</option>   
										     
										        <option value="BB">BB</option>   
										     
										        <option value="BC">BC</option>   
										     
										        <option value="DC">DC</option>   
										                         
										</select>
	                            	</td>
	                            	<th><star style="color: red" user-trigger-req-ex="AL">*</star>IP주소</th>
	                            	<td colspan="3"><input type="text" name="" id="iIpAdres" class="txtType" maxlength="255" required="required" user-title="IP주소" user-data-type="ip" user-ref-ids="iIpTyCd, iIpCd"/></td>
	                            </tr>
	                            <tr>
	                            	<th>비고</th>
	                            	<td colspan="3"><textarea class="textArea" id="iRemark" maxlength="255" style="ime-mode:active"></textarea></td>
	                            	<th><star style="color: red">*</star>관리자 비밀번호</th>
	                            	<td><input type="password" class="txtType" id="adminPw" maxlength="64" required="required" user-title="관리자 비밀번호"/></td>
	                            </tr>
                            </tbody>
                        </table>
                    </div>
                    </br>
                    <!--사용자그룹/사용자지역 추가 입력모드  -->
	                <div class="boxWrap">
	                	<div class="tbLeft50"  style="width:60%">
		                 	<!-- 	사용자그룹 리스트 -->
		                    <div class="tableType1 insert" style="height:250px; overflow-y:scroll; overflow-x:hidden">
				    			<table id="grid_user_grp_list_insert" style="width:100%">
				    			</table>
				            </div>
				        </div>
				        <div class="tbLeft50" style="width:40%">		
		                 	<!-- 	사용자지역 리스트 -->
		                    <div class="tableType1 insert" style="height:250px; overflow-y:scroll; overflow-x:hidden">
				    			<table id="grid_user_area_list_insert" style="width:100%">
				    			</table>
				            </div>
	                	</div>
	                </div>
 	                <!--사용자그룹/사용자지역 추가 수정모드  -->
	                <div class="boxWrap">
	                	<div class="tbLeft50" style="width:60%">
				            <!-- 등록된 사용자그룹 리스트 -->  
		                    <div class="tableType1 update" style="height:250px; overflow-y:scroll; overflow-x:hidden">
				    			<table id="grid_user_grp_update" style="width:100%">
				    			</table>
				            </div>
				        </div>
				        <div class="tbLeft50" style="width:40%">			                  
				            <!-- 등록된 사용자지역 리스트   -->
		                    <div class="tableType1 update" style="height:250px; overflow-y:scroll; overflow-x:hidden">
				    			<table id="grid_user_area_update" style="width:100%">
				    			</table>
				            </div>
	                	</div>
	                </div>
	                
                    <div class="btnCtr">
                        <!-- <a href="#" class="btn btnAg">그룹추가</a>
                        <a href="#" class="btn btnDg">그룹삭제</a>                    
                        <a href="#" class="btn btnAa">지역추가</a>
                        <a href="#" class="btn btnDa">지역삭제</a> -->                        
                        <a href="#" class="btn btnSvEc">저장</a>
                        <a href="#" class="btn btnC">취소</a>
                    </div>
                </div>
            </div>
            <!-- //레이어팝업 등록 -->
            <!-- 레이어팝업 사용자그룹추가 -->
            <div class="layer layerModifyGrp" id="div_drag_3" style="z-index:100; width:1000px">
                <div class="tit"><h4>사용자그룹 추가</h4></div>
                <div class="layerCt">
                 	<!-- 그룹 리스트 -->
                    <div class="tableType1" style="height:600px; overflow-y:scroll; overflow-x:hidden">
		    			<table id="grid_user_grp_list_update" style="width:100%">
		    			</table>
		            </div>
	                <div class="btnCtr update">
                        <a href="#" class="btn btnSvGrp">저장</a>
                        <a href="#" class="btn btnCGrp">취소</a>
                    </div>
                </div>
            </div>
            <!-- //레이어팝업 사용자그룹추가 -->            
            <!-- 레이어팝업 사용자지역추가 -->
            <div class="layer layerModifyArea" id="div_drag_4" style="z-index:100; width:1000px">
                <div class="tit"><h4>사용자지역 추가</h4></div>
                <div class="layerCt">
                 	<!-- 지역 리스트 -->
                    <div class="tableType1" style="height:600px; overflow-y:scroll; overflow-x:hidden">
		    			<table id="grid_user_area_list_update" style="width:100%">
		    			</table>
		            </div>
	                <div class="btnCtr update">
                        <a href="#" class="btn btnSvArea">저장</a>
                        <a href="#" class="btn btnCArea">취소</a>
                    </div>
                </div>
            </div>
            <!-- //레이어팝업 사용자지역추가 -->            

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