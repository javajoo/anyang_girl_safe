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
	$.manuHandler('44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2', '6b9398b2-0047-41bf-9d5b-8af7650d515e');
    
	 $(".tableType1 areaUser2").hide();
	
	$.jqGrid('#grid_area', {
        url : '/json/user/area_list.json',  //'/wrks/sstm/usr/area/area_list.json',
        datatype : "json",
        postData : {},
        colNames : [
                    	'',
                        '코드',
                        '지역명', 
                        '사용유무'
        ],
        colModel : [
                    { name : 'CHECK', width:50, align:'center', editable:true, edittype:'radio', editoptions: { value:"True:False" }, sortable: false
                    	, formatter: function (cellValue, option) {
            				return '<input type="radio" name="radio" value="' + option.rowId + '"/>';
        				}
                    },
                  	{ name : 'AREA_CD', width:120, align:'center'},
                  	{ name : 'AREA_NM', width:125, align:'center'},
                  	{ name : 'USE_TY_NM', width:160, align:'center'}
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
        onSelectRow : function(rowid, status, e){
        	$.resetInputObject(".tbRight50 .tableTypeFree.seachT");
        	$("#grid_area input[type=radio]").get(rowid - 1).checked = true;
        	
			var list = jQuery("#grid_area").getRowData(rowid);
	    	
			
			$("#pAreaCd").val(list.AREA_CD);
			
			$("#grid_area_user").jqGrid('setGridParam', {url: "/json/user/user_list.json"}); ///wrks/sstm/usr/area/user_list.json
			var myPostData = $("#grid_area_user").jqGrid('getGridParam', 'postData');
	    	
			myPostData.areaCd = list.AREA_CD;
			myPostData.areaNm = list.AREA_NM;
			
			myPostData.useTyCd = "";
			myPostData.userNm = "";
			myPostData.userId = "";
			myPostData.moblNo = "";
			
	    	$("#grid_area_user").trigger("reloadGrid");
	    	$("#preSelectRowId").val(rowid);
        },
        beforeProcessing: function(data, status, xhr){
        	$.resetInputObject(".tbRight50 .tableTypeFree.seachT");
            $("#grid_area_user").clearGridData();
        },
        loadComplete: function(){
        	$("#grid_area input[type=radio]").change(function(){
        		$("#grid_area").jqGrid('setSelection',$(this).val(),true);
        	});
        }
  	});

    $.jqGrid('#grid_area_user', {
        //url : '/wrks/sstm/usr/area/user_list.json',
        datatype : "json",
        postData : {
        	areaCd : "",
        	areaNm : "",
        	
        	useTyCd : "",
        	userNm : "",
        	userId : "",
        	moblNo : ""
        },
        colNames : [
                   	 	'<input type="checkbox" name="hcheckbox" onchange="$.GridHeaderCheckBoxChange(\'#grid_area_user\', this, event);">'
                        , '아이디'
                        , '성명'
                        , '연락처'
                        , '사용여부'
                        
                        , '비밀번호'
                        , '영문이름'
                        , '이메일'
                        , '사무실 전화번호'
                        , '사용유형코드'
                        , '직급명'
                        , '부서명'
                        , '기관명'
                        , '담당업무'
                        , 'IP주소'
                        , '비고'
        ],
        colModel : [
                    { name : 'CHECK', width:50, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, sortable: false, formatter: $.GridCheckBox}
                  	, { name : 'USER_ID', width:100, align:'center'}
                  	, { name : 'USER_NM_KO', width:125, align:'center'}
                  	, { name : 'MOBL_NO', width:120, align:'center'}
                  	, { name : 'USE_TY_NM', width:90, align:'center'}
                  	
                  	, { name : 'PASSWORD', width: 5, align: 'center', hidden: true}
                  	, { name : 'USER_NM_EN', width: 5, align: 'center', hidden: true}
                  	, { name : 'EMAIL', width: 5, align: 'center', hidden: true}
                  	, { name : 'OFFC_TEL_NO', width: 5, align: 'center', hidden: true}
                  	, { name : 'USE_TY_CD', width: 5, align: 'center', hidden: true}
                  	, { name : 'RANK_NM', width: 5, align: 'center', hidden: true}
                  	, { name : 'DEPT_NM', width: 5, align: 'center', hidden: true}
                  	, { name : 'INSTT_NM', width: 5, align: 'center', hidden: true}
                  	, { name : 'RPSB_WORK', width: 5, align: 'center', hidden: true}
                  	, { name : 'IP_ADRES', width: 5, align: 'center', hidden: true}
                  	, { name : 'REMARK', width: 5, align: 'center', hidden: true}
        ],
        pager : '#pager',
        rowNum : 1000,
        sortname: 'USER_ID',
        sortorder: 'ASC',
        viewrecords:true,
		multiselect: false,
		loadonce:false,		 
        jsonReader: {
        },
        onCellSelect : function(rowid, iCol, cellcontent, e){
			var list = jQuery("#grid_area_user").getRowData(rowid);
        	
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
			$("#dPassword").html(list.PASSWORD);
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
			
			$.showDetail();
        }
  	});

   $.jqGrid('#grid_areaUser_popup', {
        //url : '/wrks/sstm/usr/info/list.json',
        datatype : "json",
        postData : {
        	useTyCd : "Y",
        	userId : "",
	    	userNmKo : "",
	    	moblNo : "",
	    	areaCd : ""
        },
        colNames : [
                   	 	'<input type="checkbox" name="hcheckbox" onchange="$.GridHeaderCheckBoxChange(\'#grid_areaUser_popup\', this, event);">',
                        '아이디',
                        '사용자명',
                        '전화번호',
                        '사용유형'
                   ],
        colModel : [
                    { name : 'CHECK', width:50, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, sortable: false, formatter: $.GridCheckBox},
                  	{ name : 'USER_ID', width:180, align:'center'},
                  	{ name : 'USER_NM_KO', width:180, align:'center'},
                  	{ name : 'MOBL_NO', width:220, align:'center'},
                  	{ name : 'USE_NM', width:100, align:'center'}
          			],
        pager : '#pager',
        rowNum : 1000,
        sortname: 'USER_ID',
        sortorder: 'ASC',
        viewrecords:true,
		multiselect: false,
		loadonce:false,		 
        jsonReader: {
        },
        onCellSelect : function(rowid, iCol, cellcontent, e){
			if(iCol == 0) return false;
        }
         
  	});

    $(".btnS").bind("click",function(){
    	var myPostData = $("#grid_area").jqGrid('getGridParam', 'postData');
    	
    	myPostData.areaCd = $("#sAreaCd").val();
    	myPostData.areaNm = $("#sAreaNm").val();
    	
    	$("#grid_area").trigger("reloadGrid");
	});

    $(".btnS2").bind("click",function(){
    	var myPostData = $("#grid_area_user").jqGrid('getGridParam', 'postData');
    	
    	myPostData.userNm = $("#sUserNm").val();
    	myPostData.userId = $("#sUserId").val();
    	myPostData.moblNo = $("#sMoblNo").val();
    	myPostData.useTyCd = $("#useTyCd").val();
    	
    	$("#grid_area_user").trigger("reloadGrid");
	});
    
    $(".btnS3").bind("click",function(){
    	var myPostData = $("#grid_areaUser_popup").jqGrid('getGridParam', 'postData');
    	
    	myPostData.userId = $("#pUserId").val();
    	myPostData.userNmKo = $("#pUserNmKo").val();
    	myPostData.moblNo = $("#pMoblNo").val();
    	myPostData.areaCd = $("#pAreaCd").val();

    	$("#grid_areaUser_popup").trigger("reloadGrid");
	});
    
    $(".btnRgt1").click(function(){
    	var s = $.getSelRowRadio("#grid_area");
    	if(s.length == 0) {
    		alert("지역을 선택하세요.");
    		return false;
    	}else {
    		var area = $(this).attr("area");
    		$("#modetitle").text("추가");
    		$.changeInputMode(true);
    		try{
	    		if(resetAction(area, function() {
	    		    $(".layerModify").show();
	    		    
	    		    $(".layerModify .tableType1").hide();
	    	        var title = $(".layerModify .tableType1." + area).attr("user-title");
	    	        $(".layerModify .tit>h4").html(title);
	    	        $(".layerModify .tableType1." + area).show();
	    	        $(".layerModify .btnCtr>a").attr("area", area);

	    	        var layerH = $(".layerModify").height();
	    	        $(".layerModify").css({"margin-top": -(layerH/2)+"px"});
	    		    
	    		}) == false)
	    			return false;
	    	}catch(e) {}
    		$(".layerModify").show();
    		
    		var layerH = $(".layerModify").height();
	        $(".layerModify").css({"margin-top": -(layerH/2)+"px"});
    		
            $(".mask").remove();
            $("body").append("<div class='mask'></div>");

            try{
        		$('.layer SELECT').selectBox("destroy");
        		$('.layer SELECT').selectBox();
        	} catch(e) {}
        	insertFlag = true;
        	return false;
    	}
    });
});

function resetAction(area, callBack) {
	$.resetInputObject(".layerModify .tableTypeFree.seachT");

	
	//$("#grid_" + area + "_popup").jqGrid('setGridParam', {url: "/wrks/sstm/usr/info/list.json"});
	$("#grid_" + area + "_popup").jqGrid('setGridParam', {url: "/wrks/sstm/usr/area/user_list_popup.json"});
	//console.log($("#grid_" + area + "_popup").jqGrid('getGridParam', 'url'));
	$("#grid_" + area + "_popup").jqGrid('setGridParam', {
		beforeProcessing: callBack
	});

	var myPostData = $("#grid_areaUser_popup").jqGrid('getGridParam', 'postData');
	
	myPostData.userId = $("#pUserId").val();
	myPostData.userNmKo = $("#pUserNmKo").val();
	myPostData.moblNo = $("#pMoblNo").val();
	myPostData.areaCd = $("#pAreaCd").val();
	
	$("#grid_" + area + "_popup").trigger("reloadGrid");
}

function validate(area) {
	return $.validate(".layerModify .tableType1." + area);
}

function insertAction(area, src) {
	var s =  $.getSelRow("#grid_" + area + "_popup");

	if(s.length == 0){
		alert("사용자를 선택하여 주십시오");
		return false;
	}
	
    var url = "/wrks/sstm/usr/area/insert_" + area + ".json";  
    var params = "";
    
    params += "&areaCd=" + encodeURIComponent($.getCurrentRowValue("#grid_area", "AREA_CD"));
	
    for(var i = 0; i < s.length; i++) {
		var list = jQuery("#grid_" + area + "_popup").getRowData(s[i]);
		params += "&userId=" + encodeURIComponent(list.USER_ID);
    }

    $.ajaxEx($("#grid_area_user"), {
	    url : url,
	    dataType : "json",
	    data: params,
        success:function(data){
        	
        	$("#grid_area_user").trigger("reloadGrid");
        	//alert("삭제하였습니다.");
        	alert(data.msg);
        },   
        error:function(e){  
            //alert(e.responseText);
        	alert(data.msg);
        }  
    });    	
}

function deleteMultiAction(area) {
	var s =  $.getSelRow("#grid_area_user");

	if(s.length == 0){
		alert("사용자를 선택하여 주십시오");
		return false;
	}

	if(confirm("선택된 자료를 삭제하시겠습니까?") == false) return false;
	var url = "/wrks/sstm/usr/area/delete_" + area + ".json";  
    var params = "";

    for(var i = 0; i < s.length; i++) {
		var list = jQuery("#grid_area_user").getRowData(s[i]);
		params += "&userId=" + encodeURIComponent(list.USER_ID);
    }
    params += "&areaCd="+ encodeURIComponent($.getCurrentRowValue("#grid_area", "AREA_CD"));

    $.ajaxEx($("#grid_area_user"), {
	    url : url,
	    dataType : "json",
	    data: params,
        success:function(data){

        	$("#grid_area_user").trigger("reloadGrid");
        	alert("자료를 삭제하였습니다.");
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
	    
						<li class=""><a href="/wrks/sstm/rdus/cctvRadiusSet.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=45b5a59f-e94b-4d2e-aa92-ba1760c595b3">관제화면옵션설정</a></li>
						
						<li class=""><a href="/wrks/sstm/rdus/dis_evt.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=2e1e01e9-9fcc-4e32-8e40-2e699fab182f">재난 세부분류별 표출이벤트</a></li>
						
						<li class=""><a href="/wrks/sstm/rdus/auto_dis.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=35626504-8693-49cb-b194-50eff61ff4db">자동표출이벤트항목관리</a></li>
						
			                </ul>
			                <li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">사용자정보</a>
			                    <ul>
		
						<li class=""><a href="/wrks/sstm/usr/info.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=848e773f-8686-4515-8f17-4d5650e36936">사용자관리</a></li>
						
						<li class="user-select"><a href="/wrks/sstm/usr/area.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=6b9398b2-0047-41bf-9d5b-8af7650d515e">지역별사용자</a></li>
						
			                </ul>
			                <li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">모바일</a>
			                    <ul>
		
						<li class=""><a href="/wrks/sstm/mbl/version.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=d438ed42-227a-4e94-9712-e2b163d488a0">모바일앱버젼정보관리</a></li>
						
						<li class=""><a href="/wrks/sstm/mbl/info.do?top=44d3b2b6-f4d7-4684-ab7a-dfbb0ea0cdd2&left=e6154242-e44c-422f-8e51-b137dc21a5ac">모바일기기정보</a></li>
						    
	    		</ul>
	    		</li>
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
                    <span>Home</span>  &gt; <span>사용자정보</span>  &gt; <span>지역별사용자</span>
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
                    <h3 class="tit">지역별사용자</h3>
                </div>
                <div class="boxWrap">
	                <div class="tbLeft50">
		                <div class="tableTypeFree seachT">
		                    <table>
		                        <caption>지역리스트</caption>
		                        <tbody>
		                        <tr>
			                        <th>코드</th>
			                        <td><input type="text" name="" id="sAreaCd" class="txtType txtType100px grpNm searchEvt"></td>
			                        <th>지역명</th>
			                        <td>
			                        	<input type="text" name="" id="sAreaNm" class="txtType txtType100px grpNm searchEvt" style="ime-mode:active">
			                        </td>
			                        <td>
										<a href="javascript:;" class="btn btnS searchBtn">검색</a>
									</td>
		                        </tr>
		                        </tbody>
		                    </table>
		                </div><br/>
		                <div class="tableType1" style="height:650px; overflow-y:scroll; overflow-x:hidden">
		    				<table id="grid_area" style="width:100%">
		    				</table>
		                </div>
	                </div>
	                <div class="tbRight50">
		                <div class="tableTypeFree seachT">
		                    <table>
		                        <caption>사용자 리스트</caption>
		                        <tbody>
			                        <tr>
				                        <th>성명</th>
				                        <td><input type="text" name="" id="sUserNm" class="txtType txtType100px grpNm searchEvt2" style="ime-mode:active"></td>
				                        <th>아이디</th>
				                        <td><input type="text" name="" id="sUserId" class="txtType txtType100px grpNm searchEvt2" style="ime-mode:inactive">
				                        </td>
			                        </tr>
			                        <tr>
				                        <!-- <th>그룹</th>
				                        <td><input type="text" name="" id="sGrpId" class="txtType txtType100px grpNm"></td> -->
				                        <th>휴대폰</th>
				                        <td>
				                        	<input type="text" name="" id="sMoblNo" class="txtType txtType100px grpNm searchEvt2">
				                        </td>
										<th>사용유형</th>
			                            <td>
			                            	<select name="" id="useTyCd" class="selectType1" maxlength="1">
									    		 
									        		<option value="Y">사용</option>   
									    		 
									        		<option value="N">미사용</option>   
									    		 
									        		<option value="H">숨김</option>   
									    		 
									        		<option value="D">삭제</option>   
									    		
											</select>
			                            </td>                
			                        </tr>
			                        <tr>                        	
			                            <td colspan=4>
											<a href="javascript:;" class="btnRight btnS2 searchBtn2">검색</a>
			                            </td>
			                        </tr>
		                        </tbody>
		                    </table>
		                </div><br/>
		                <div class="tableType1">
		    				<table id="grid_area_user" style="width:100%">
		    				</table>
		                </div>
		                <div class="btnWrap btnR">
		                    <a href="#" class="btn btnDt btnRgt1" area="areaUser">추가</a>
		                    <a href="#" class="btn btnMultiDe" area="areaUser">삭제</a>
		                </div>                
	                </div>
                </div>
            </div>

            <!-- //레이어팝업 등록 -->
            <div class="layer layerModify" id="div_drag_1">
                <div class="tit"><h4>사용자<span id="modetitle">등록</span></h4></div>
                <div class="tableTypeFree seachT">
                    <table>
                        <caption>사용자 등록</caption>
                        <colgroup>
                            <col style="width: 70px;" />
                            <col style="width: *" />
                            <col style="width: 50px;" />
                            <col style="width: 30px" />
                            <col style="width: 90px;" />
                            <col style="width: *" />
                            <col style="width: 50px" />
                        </colgroup>
                        <tbody>
	                        <tr>
	                        	<input  type="hidden" name="" id="pAreaCd" />
		                        <th>아이디</th>
		                        <td><input type="text" name="" id="pUserId" class="txtType searchEvt3" style="ime-mode:inactive"></td>
		                        <th>이름</th>
		                        <td><input type="text" name="" id="pUserNmKo" class="txtType searchEvt3" style="width: 100px; ime-mode:active"></td>
		                        <th>전화번호</th>
		                        <td><input type="text" name="" id="pMoblNo" class="txtType searchEvt3"></td>
		                        <td style="text-align: right;"><a href="javascript:;" class="btnRight btnS3 searchBtn3" style="width: 70px; text-align: center;">검색</a></td>
	                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="layerCt">
	                <div class="tableType1 areaUser" area="1" user-title="사용자 추가" style="height:150px; overflow-y:scroll; overflow-x:hidden">
	    				<table id="grid_areaUser_popup" style="width:100%">
	    				</table>
	                </div>
                    <div class="btnCtr">
                        <a href="#" class="btn btnSv">추가</a>
                        <a href="#" class="btn btnC">취소</a>
                    </div>
                </div>
            </div>
            <!-- //레이어팝업 등록 -->
            
            <!-- 레이어팝업 상세 -->
            <div class="layer layerDetail" id="div_drag_2">
                <div class="tit"><h4>사용자 상세</h4></div>
                <div class="layerCt">
                    <div class="tableType2">
                        <table>
                            <caption>사용자 상세</caption>
                            <tbody>
	                            <tr>
	                                <th>아이디</th>
	                                <td id="dUserId" colspan="3"></td>
	                                <!-- <th>비밀번호</th>
	                                <td id="dPassword"></td> -->
	                            </tr>
	                            <tr>
	                                <th>한글이름</th>
	                                <td id="dUserNmKo"></td>
	                                <th>영문이름</th>
	                                <td id="dUserNmEn"></td>
	                            </tr>
	                            <tr>
		                            <th>핸드폰번호</th>
	                                <td id="dMoblNo" colspan="3"></td>
	                            </tr>
	                            <tr>
	                            	<th>이메일</th>
	                            	<td id="dEmail" colspan="3"></td>
	                            </tr>
	                            <tr>
	                            	<th>사무실전화번호</th>
	                            	<td id="dOffcTelNo" colspan="3"></td>
	                            </tr>
	                            <tr>
	                            	<th>사용유형</th>
	                            	<td id="dUseTyCd"></td>
	                            	<th>기관명</th>
	                            	<td id="dInsttNm"></td>
	                            </tr>
	                            <tr>
	                            	<th>부서명</th>
	                            	<td id="dDeptNm"></td>
	                            	<th>직급명</th>
	                            	<td id="dRankNm"></td>
	                            </tr>
	                            <tr>
	                            	<th>담당업무</th>
	                            	<td id="dRpsbWork"></td>
	                            	<th>IP주소</th>
	                            	<td id="dIpAdres"></td>
	                            </tr>
	                            <tr>
	                            	<th>비고</th>
	                            	<td id="dRemark" colspan="3"></td>
	                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="btnCtr">
                        <a href="#" class="btn btnC">닫기</a>
                    </div>
                </div>
            </div>
            <!-- //레이어팝업 상세 -->
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
