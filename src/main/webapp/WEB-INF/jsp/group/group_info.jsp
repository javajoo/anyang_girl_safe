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
	$.manuHandler('e1cdc03a-f6ea-43d2-9e6b-b71f59534e78', '413e7d5e-dad4-4c90-821c-70ee1c14f814');

    $.jqGrid($('#grid'), {
        url : '/wrks/sstm/grp/code/list.do', //'/json/group/list.json',
        datatype : "json",
        postData : { 
        	grpId : $("#sGrpId").val(),
        	grpNmKo : $("#sGrpNm").val(),
        	useTyCd : $("#sUseTyCd").val()
        },
        colNames : [
                   	 	'<input type="checkbox" name="hcheckbox" onchange="$.GridHeaderCheckBoxChange(\'#grid\', this, event);">',
                        '번호',
                        '그룹아이디',
                        '지구코드',
                        '그룹이름',
                        '그룹이름영문',
                        '그룹설명',
                        '소속지구명',                        
                        '사용유형',
                        '사용유형코드',
                        '시작프로그램메뉴'
                   ],
        colModel : [
                    { name : 'CHECK', width:70, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, sortable: false, formatter: $.GridCheckBox},
					{ name : 'RK', width:50, align:'center', sortable: false},
                  	{ name : 'GRP_ID', width:120, align:'center'},
                  	{ name : 'DSTRT_CD', width:100, align:'center', 'hidden':true},
                  	{ name : 'GRP_NM_KO', width:200, align:'center'},
                  	{ name : 'GRP_NM_EN', width:200, align:'center', 'hidden':true},
                  	{ name : 'GRP_DSCRT', width:290, align:'center'},
                  	{ name : 'DSTRT_NM', width:160, align:'center'},                  	
                  	{ name : 'USE_TY_NM', width:80, align:'center'},
                  	{ name : 'USE_TY_CD', width:60, align:'center', 'hidden':true},
                  	{ name : 'START_PGM_MENU_ID', width:60, align:'center', 'hidden':true}
          ],
          
          
        pager : '#pager',
        rowNum : $('#rowPerPageList').val(),
        sortname: 'GRP_NM_KO',
        sortorder: 'ASC',
        viewrecords:true,
		multiselect: false,
		shrinkToFit: true,
        scrollOffset: 0,
        autowidth: true,
		loadonce:false,		 
        jsonReader: {
        	//id: "GRP_ID",
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

			$("#dGrpId").html(list.GRP_ID);
			$("#dDstrtNm").html(list.DSTRT_NM);
			$("#dGrpNmKo").html(list.GRP_NM_KO);
			$("#dGrpNmEn").html(list.GRP_NM_EN);
			$("#dGrpDscrt").html(list.GRP_DSCRT);
			$("#dUseTyNm").html(list.USE_TY_NM);
			$("#dStartPgmMenuId").html(list.START_PGM_MENU_ID);
			
			//$.selectBarun("#iMoblId", list.MOBL_ID);
			$("#iGrpId").val(list.GRP_ID);
			$.selectBarun("#iDstrtCd", list.DSTRT_CD);
			$("#iGrpNmKo").val(list.GRP_NM_KO);
			$("#iGrpNmEn").val(list.GRP_NM_EN);
			$("#iGrpDscrt").val(list.GRP_DSCRT);
			$.selectBarun("#iUseTyCd", list.USE_TY_CD);
			$("#grpIdBak").val(list.GRP_ID);
			$("#iStartPgmMenuId").val(list.START_PGM_MENU_ID);
			
			
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

    $(".btnS").bind("click",function(){
    	$("#grid").setGridParam({rowNum : $('#rowPerPageList').val()});
    	var myPostData = $("#grid").jqGrid('getGridParam', 'postData');
    	myPostData.grpId = $("#sGrpId").val();
    	myPostData.grpNmKo = $("#sGrpNm").val();
    	myPostData.useTyCd = $("#sUseTyCd").val();
    	
    	$("#grid").trigger("reloadGrid");
    });      
    
    
});

function resetAction() {
	$("#iGrpId").removeAttr("readonly");
	$("#iGrpId").val("");
	$.selectBarun("#iDstrtCd", "");
	$("#iGrpNmKo").val("");
	$("#iGrpNmEn").val("");
	$("#iGrpDscrt").val("");
	$.selectBarun("#iUseTyCd", "");
	$("#iStartPgmMenuId").val("");
}

function preModifyAction() {
	$("#iGrpId").attr("readonly", "readonly");
}

function updateAction(obj) {
    var url = "/wrks/sstm/grp/code/update.do";  
    var params = "";
    params += "&grpId=" + encodeURIComponent($("#iGrpId").val());
   	params += "&dstrtCd=" + encodeURIComponent($("#iDstrtCd").val());
   	params += "&grpNmKo=" + encodeURIComponent($("#iGrpNmKo").val());
   	params += "&grpNmEn=" + encodeURIComponent($("#iGrpNmEn").val());
   	params += "&grpDscrt=" + encodeURIComponent($("#iGrpDscrt").val());
   	params += "&useTyCd=" + encodeURIComponent($("#iUseTyCd").val());        
   	params += "&grpIdBak=" + encodeURIComponent($("#grpIdBak").val());
   	params += "&startPgmMenuId=" + encodeURIComponent($("#iStartPgmMenuId").val());   	
        
    $.ajaxEx($('#grid'), {
	    url : url,
	    dataType : "json",
	    data: params,
        success:function(data){

        	$("#grid").setGridParam({page :$("#cur-page").val()});
        	$("#grid").trigger("reloadGrid");
        	//alert("업데이트하였습니다.");
        	alert(data.msg);
        },   
        error:function(e){  
            //alert(e.responseText);
        	alert(data.msg);
        }  
    });
}

function validate() {
	return $.validate(".layerModify .tableType2");
}

function insertAction(obj) {
    var url = "/wrks/sstm/grp/code/insert.do";  
    var params = "";
    params += "&grpId=" + encodeURIComponent($("#iGrpId").val());
   	params += "&dstrtCd=" + encodeURIComponent($("#iDstrtCd").val());
   	params += "&grpNmKo=" + encodeURIComponent($("#iGrpNmKo").val());
   	params += "&grpNmEn=" + encodeURIComponent($("#iGrpNmEn").val());
   	params += "&grpDscrt=" + encodeURIComponent($("#iGrpDscrt").val());
   	params += "&useTyCd=" + encodeURIComponent($("#iUseTyCd").val());    
   	params += "&startPgmMenuId=" + encodeURIComponent($("#iStartPgmMenuId").val());   	   	
        
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
    var url = "/wrks/sstm/grp/code/delete.do";  
    
    var params = "";
    params += "&grpIdBak=" + $("#grpIdBak").val();
    
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
}

function deleteMultiAction() {
	//var s =  $("#grid").jqGrid('getGridParam', 'selarrrow');
	var s =  $.getSelRow("#grid");
	if(s.length == 0){
		alert("삭제할 데이터를 선택하여 주십시오.");
		return false;
	}

	if(confirm("선택된 자료를 삭제하시겠습니까?") == false) return false;
    var url = "/wrks/sstm/grp/code/deleteMulti.do";  
    var params = "";

    for(var i = 0; i < s.length; i++) {
		var list = jQuery("#grid").getRowData(s[i]);
	    params += "&grpId=" + list.GRP_ID;
    }
    //alert(params); return;

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


</script>

</head>
<body>
<div id="wrapper">
    <!-- topbar -->
	<jsp:include page="/WEB-INF/jsp/include/topMenu.jsp" >
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
		<li class=""><a href="/system.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=45b5a59f-e94b-4d2e-aa92-ba1760c595b3">관제화면옵션설정</a></li>
		<li class=""><a href="/wrks/sstm/rdus/dis_evt.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=2e1e01e9-9fcc-4e32-8e40-2e699fab182f">재난 세부분류별 표출이벤트</a></li>
		<li class=""><a href="/wrks/sstm/rdus/auto_dis.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=35626504-8693-49cb-b194-50eff61ff4db">자동표출이벤트항목관리</a></li>
	</ul>
	</li>
	<li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">사용자정보</a>
	<ul>
		<li class=""><a href="/wrks/sstm/usr/info.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=848e773f-8686-4515-8f17-4d5650e36936">사용자관리</a></li>
		<li class=""><a href="/wrks/sstm/usr/area.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=6b9398b2-0047-41bf-9d5b-8af7650d515e">지역별사용자</a></li>
	</ul>
	</li>
	<li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_on.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">그룹정보</a>
	<ul>
		<li class="user-select"><a href="/wrks/sstm/grp/code.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=413e7d5e-dad4-4c90-821c-70ee1c14f814">그룹관리</a></li>
		<!-- <li class=""><a href="/wrks/sstm/grp/user_acc.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=494b3ae3-1518-42bf-8456-0759c3bfd566">그룹별이벤트(사용자권한)</a></li> -->
		<li class=""><a href="/wrks/sstm/grp/user.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=2692c263-c575-4c9c-948c-7dd26074210d">그룹별사용자조회</a></li>
		<!-- <li class=""><a href="/wrks/sstm/grp/auth.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=199c6208-a977-4977-a096-07aea050b3ed">그룹별권한레벨관리</a></li>
		<li class=""><a href="/wrks/sstm/grp/role.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=18ceb0d3-31af-46ee-92bd-53afca873a90">롤관리</a></li>
		<li class=""><a href="/wrks/sstm/grp/auth_role.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=8b879ee6-9945-4dbe-bc57-6a0d095b0595">그룹권한레벨별롤</a></li> -->
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
	                        <li><a href="/wrks/sstm/code/cmcd.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=0">공통코드그룹</a></li>
	                        <li><a href="/wrks/sstm/code/dtcd.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=0">코드상세</a></li>
	                        <li><a href="/wrks/sstm/code/sycd.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=0">시스템코드</a></li>
	                        <li><a href="/wrks/sstm/code/sggcd.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=0">시군구코드</a></li>
	                        <li><a href="/wrks/sstm/code/dst.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=0">지구코드</a></li>
	                        <li><a href="/wrks/sstm/code/area.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=0">지역코드</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_user">사용자관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/usr/info.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=1">사용자관리</a></li>
	                        <li><a href="/wrks/sstm/usr/area.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=1">지역별사용자</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_group">그룹정보</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/grp/code.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=2">그룹관리</a></li>
	                        <li><a href="/wrks/sstm/grp/user_acc.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=2">그룹별이벤트(사용자권한)</a></li>
	                        <li><a href="/wrks/sstm/grp/user.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=2">그룹별사용자조회</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">모바일</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/mbl/grp.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=3">그룹관리</a></li>
	                        <li><a href="/wrks/sstm/mbl/info.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=3">계정정보</a></li>
	                        <li><a href="/wrks/sstm/mbl/version.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=3">버젼정보관리</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">이벤트관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/evnt/base.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=4">이벤트기본정보</a></li>
	                        <li><a href="/wrks/sstm/evnt/item.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=4">이벤트세부항목</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">메뉴관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/menu/info.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=5">프로그램정보</a></li>
	                        <li><a href="/wrks/sstm/menu/menu.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=5">프로그램메뉴</a></li>
	                        <li><a href="/wrks/sstm/menu/grp.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=5">그룹별프로그램메뉴</a></li>
	                        <li><a href="/wrks/sstm/menu/user.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=5">사용자별프로그램메뉴</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">상황처리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/evtctl/info.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=7">상황관리</a></li>
	                        <li><a href="/wrks/sstm/evtctl/trans_recv.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=7">상황전달수신자관리</a></li>
	                        <li><a href="/wrks/sstm/evtctl/disp_mbl.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=7">표출단말관리</a></li>
	                        <li><a href="/wrks/sstm/evtprc/info.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=7">상황처리</a></li>
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
                    <span>Home</span>  &gt; <span>그룹정보</span>  &gt; <span>그룹관리</span>
                </div>
            </div>
            <div class="content">
                <div class="titArea">
                    <h3 class="tit">그룹관리</h3>
                </div>
                <div class="tableTypeHalf seachT">
                    <table>
                        <caption>사용자 추가</caption>
                        <tbody>
                        <tr>
	                        <th>그룹아이디</th>
	                        <td><input type="text" name="" id="sGrpId" class="txtType carNum searchEvt" style="ime-mode:inactive"></td>
	                        <th>그룹명</th>
	                        <td><input type="text" name="" id="sGrpNm" class="txtType carNum searchEvt" style="ime-mode:active"></td>
                            <th>사용유형</th>
                            <td>
                            	<select name="" id="sUseTyCd" class="selectType1" maxlength="1">
						    		 
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
                    <a href="#" class="btn btnMultiDe">삭제</a>
                </div>                
            </div>


	        <!-- 레이어팝업 등록 -->
 	        
            <div class="layer layerDetail" id="div_drag_1">
                <div class="tit"><h4>그룹정보 상세</h4></div>
                <div class="layerCt">
                    <div class="tableType2">
                    	<input type="hidden" id="grpIdBak" />
                        <table>
                            <caption>그룹정보 상세</caption>
                            <tbody>
                            <tr>
                                <th>그룹아이디</th>
                                <td id="dGrpId"></td>
                                <th>지구명</th>
                                <td id="dDstrtNm"></td>
                            </tr>                            
                            <tr>
                                <th>그룹이름(한글)</th>
                                <td id="dGrpNmKo"></td>
                                <th>그룹이름(영문)</th>
                                <td id="dGrpNmEn"></td>
                            </tr>
                            <tr>
                                <th>그룹설명</th>
                                <td id="dGrpDscrt"></td>
                                <th>사용유형</th>
                                <td id="dUseTyNm"></td>
                            </tr>
                             <!-- <tr>
                                <th>시작프로그램메뉴</th>
                                <td id="dStartPgmMenuId" colspan="3"></td>
                             </tr> -->
                            </tbody>
                        </table>
                    </div>
                    <div class="btnCtr">
                        <a href="#" class="btn btnMd">수정</a>
                        <a href="#" class="btn btnDe">삭제</a>
                        <a href="#" class="btn btnC">취소</a>
                    </div>
                </div>
            </div>
             
            <!-- //레이어팝업 등록 -->
            <!-- //레이어팝업 등록 -->
             
            <div class="layer layerModify" id="div_drag_2">
                <div class="tit"><h4>그룹정보 <span id="modetitle">추가</span></h4></div>
                <div class="layerCt">
                    <div class="tableType2">
                        <table>
                            <caption>그룹정보 추가</caption>
                            
                            <tbody>
                            <tr>
                                <th><star style="color: red" user-required="insert">*</star> 그룹아이디</th>
                                <td><input type="text" name="" id="iGrpId" class="txtType carNum" maxlength="40"  required="required" user-title="그룹아이디" user-required="insert" style="ime-mode:inactive"></td>
                                <th><star style="color: red">*</star> 소속지구명</th>
                                <td>
									<select name="" id="iDstrtCd" class="selectType1">
									     
									        <option value="467">부산 강서구</option>   
									                         
									</select>	
                                </td>
                            </tr>                            
                            <tr>
                                <th><star style="color: red">*</star> 그룹이름(한글)</th>
                                <td><input type="text" name="" id="iGrpNmKo" class="txtType carNum" maxlength="100" required="required" user-title="그룹이름(한글)" style="ime-mode:active"></td>
                                <th>그룹이름(영문)</th>
                                <td><input type="text" name="" id="iGrpNmEn" class="txtType carNum" maxlength="100" style="ime-mode:inactive"></td>
                            </tr>
                            <tr>
                                <th>그룹설명</th>
                                <td><input type="text" name="" id="iGrpDscrt" class="txtType carNum" maxlength="1000" style="ime-mode:active"></td>
                                <th><star style="color: red">*</star> 사용유형</th>
                                <td>
									<select name="" id="iUseTyCd" class="selectType1">
									     
									        <option value="Y">사용</option>   
									     
									        <option value="N">미사용</option>   
									     
									        <option value="H">숨김</option>   
									     
									        <option value="D">삭제</option>   
									                         
									</select>	
                                </td>
                            </tr>
                            
                             <!-- <tr>
                                <th>시작프로그램메뉴</th>
                                <td colspan="3"><input type="text" id="iStartPgmMenuId" class=txtType70 maxlength="40" style="ime-mode:active"/></td> 
                             </tr> -->
                            
                            
                            
                            
                            </tbody>
                        </table>
                    </div>
                    <div class="btnCtr">
                        <a href="#" class="btn btnSvEc">저장</a>
                        <a href="#" class="btn btnC">취소</a>
                    </div>
                </div>
            </div>
             
            <!-- //레이어팝업 등록 -->

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


	/* 소켓연결  */
	//var url = $("#msgServerIp").val() + ":" + $("#msgServerPort").val();
	var url = '70.13.50.15';
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



</script>
    </div>
 </div>
<!-- //footer -->   
</body>
</html>
