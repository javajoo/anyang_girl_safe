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
	$.manuHandler('e1cdc03a-f6ea-43d2-9e6b-b71f59534e78', '2692c263-c575-4c9c-948c-7dd26074210d');
    
	$.jqGrid('#grid_group', {
        url : '/wrks/sstm/grp/user/list_group.do',
        datatype : "json",
        postData : { 
        	dstrtCd : $("#sDstrtCd").val(),
        	grpNm : $("#sGrpNm").val()
        },
        colNames : [
                        '코드',
                        '그룹명', 
                        '지구명',
                        '지구코드',
                   ],
        colModel : [
                  	{ name : 'GRP_ID', width:140, align:'center'},
                  	{ name : 'GRP_NM_KO', width:170, align:'center'},
                  	{ name : 'DSTRT_NM', width:170, align:'center'},
                  	{ name : 'DSTRT_CD', width:160, align:'center', hidden:true}
          ],
          
          
        pager : '#pager',
        rowNum : 1000,
        sortname: 'GRP_NM_KO',
        sortorder: 'ASC',
        viewrecords:true,
		multiselect: false,
		shrinkToFit: true,
        scrollOffset: 0,
        autowidth: true,
		loadonce:false,		 
        jsonReader: {
        },
        
        onCellSelect : function(rowid, iCol, cellcontent, e){
        	$("#sUserNmKo").val("");
        	//console.log($("#grid_group input[type=radio]").get(rowid));
			var list = jQuery("#grid_group").getRowData(rowid);
			
			$("#grid_user").jqGrid('setGridParam', {url: "/wrks/sstm/grp/user/list_user.do"});
	    	var myPostData = $("#grid_user").jqGrid('getGridParam', 'postData');
	    	myPostData.grpId = list.GRP_ID;
	    	myPostData.userNmKo = "";
	    	//console.log(list.GRP_ID);
	    	$("#grid_user").trigger("reloadGrid");
			
        },
        beforeProcessing: function(data, status, xhr){
        	$("#sUserNmKo").val("");
            $("#grid_user").clearGridData();
        }
  	});

    $.jqGrid('#grid_user', {
        //url : '/wrks/sstm/grp/user/list_user.do',
        datatype : "json",
        postData : { 
        	grpId : $.getCurrentRowValue("#grid_group", "GRP_ID"),
        },
        colNames : [
                        '아이디',
                        '사용자명',
                        '연락처',
                        '권한레벨',
                        '권한레벨명',
                        '사용유형',
                        'GRP_ID',
                        '비밀번호',
                        '영문이름',
                        '이메일',
                        '사무실전화번호',
                        '기관명',
                        '부서명',
                        '직급명',
                        'IP주소',
                        '담당업무',
                        '비고'
                        
                   ],
        colModel : [
                  	{ name : 'USER_ID', width:135, align:'center'},
                  	{ name : 'USER_NM_KO', width:150, align:'center'},
                  	{ name : 'MOBL_NO', width:140, align:'center', hidden:true},
                  	{ name : 'AUTH_LVL', width:110, align:'center', hidden:true},
                  	{ name : 'AUTH_LVL_NM', width:120, align:'center'},
  		          	{ name : 'USE_NM', width:90, align:'center'},
                  	{ name : 'GRP_ID', width:100, align:'center', hidden:true},
	                
                    { name : 'PASSWORD', width:100, align:'center', hidden:true},
		            { name : 'USER_NM_EN', width:300, align:'center', hidden:true},
		            { name : 'EMAIL', width:200, align:'center', hidden:true},
		            { name : 'OFFC_TEL_NO', width:200, align:'center', hidden:true},
		            { name : 'INSTT_NM', width:200, align:'center', hidden:true},
		            { name : 'DEPT_NM', width:200, align:'center', hidden:true},
		            { name : 'RANK_NM', width:200, align:'center', hidden:true},
		            { name : 'IP_ADRES', width:200, align:'center', hidden:true},
		            { name : 'RPSB_WORK', width:250, align:'center', hidden:true},
		            { name : 'REMARK', width:200, align:'center', hidden:true}
  		          	
          			],
        pager : '#pager',
        rowNum : 1000,
        sortname: 'USER_ID',
        sortorder: 'ASC',
        viewrecords:true,
		multiselect: false,
		shrinkToFit: true,
        scrollOffset: 0,
        autowidth: true,
		loadonce:false,		 
        jsonReader: {
        	
        },
        
        onCellSelect : function(rowid, iCol, cellcontent, e){

			var list = jQuery("#grid_user").getRowData(rowid);
        	
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
			
			$("#iUserId").val(list.USER_ID);
			$("#iPassword").val(list.PASSWORD);
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
			
			$.showDetail();
        }
        
        
        
  	});

    $(".btnS").bind("click",function(){
    	var myPostData = $("#grid_group").jqGrid('getGridParam', 'postData');
    	myPostData.dstrtCd = $("#sDstrtCd").val();
    	myPostData.grpNm = $("#sGrpNm").val();
    	$("#grid_group").trigger("reloadGrid");
	});
    
    $(".btnS2").bind("click",function(){
    	var myPostData = $("#grid_user").jqGrid('getGridParam', 'postData');
    	myPostData.userNmKo = $("#sUserNmKo").val();
    	$("#grid_user").trigger("reloadGrid");
	});      
    
    
});
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
        
			                <li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">코드관리</a>
			                    <ul>
	    
						<li class=""><a href="/wrks/sstm/code/cmcd.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=ab3b1372-27ec-445a-9587-ad727030044a&sys=wrks1">공통코드그룹</a></li>
						
						<li class=""><a href="/wrks/sstm/code/dtcd.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=7f97775c-2af9-4cbe-b4a5-025e650c4c53&sys=wrks1">코드상세</a></li>
						
						<li class=""><a href="/wrks/sstm/code/sycd.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=2d342805-eb8f-4ca4-89c2-47bfd45535fd&sys=wrks1">시스템코드</a></li>
						
						<li class=""><a href="/wrks/sstm/code/sggcd.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=5d1c81be-e721-4863-bb39-029c3acc5055&sys=wrks1">시군구코드</a></li>
						
						<li class=""><a href="/wrks/sstm/code/dst.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=613458d8-c3dd-429d-a40e-e7234ad685fb&sys=wrks1">지구코드</a></li>
						
						<li class=""><a href="/wrks/sstm/code/area.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=dd4c613c-05ba-4afe-a2e1-46121eb22cb6&sys=wrks1">지역코드</a></li>
						
						<li class=""><a href="/wrks/sstm/code/fcltcd.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=8ad302af-f274-48d7-85f7-edc20fdbec5f&sys=wrks1">시설물용도별유형코드</a></li>
						
			                </ul>
			                <li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">사용자관리</a>
			                    <ul>
		
						<li class=""><a href="/wrks/sstm/usr/info.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=62e4b61c-2ddf-4ba4-88b5-2dad0d7a40d7&sys=wrks1">사용자관리</a></li>
						
						<li class=""><a href="/wrks/sstm/usr/area.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=8d1133eb-3126-464a-997a-d294289c224d&sys=wrks1">지역별사용자</a></li>
						
			                </ul>
			                <li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">그룹관리</a>
			                    <ul>
		
						<li class=""><a href="/wrks/sstm/grp/code.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=413e7d5e-dad4-4c90-821c-70ee1c14f814&sys=wrks1">그룹관리</a></li>
						
						<!-- <li class=""><a href="/wrks/sstm/grp/user_acc.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=494b3ae3-1518-42bf-8456-0759c3bfd566&sys=wrks1">그룹별이벤트(사용자권한)</a></li> -->
						
						<li class="user-select"><a href="/wrks/sstm/grp/user.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=2692c263-c575-4c9c-948c-7dd26074210d&sys=wrks1">그룹별사용자조회</a></li>
						
						<!-- <li class=""><a href="/wrks/sstm/grp/auth.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=199c6208-a977-4977-a096-07aea050b3ed&sys=wrks1">그룹별권한레벨관리</a></li>
						
						<li class=""><a href="/wrks/sstm/grp/role.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=18ceb0d3-31af-46ee-92bd-53afca873a90&sys=wrks1">롤관리</a></li>
						
						<li class=""><a href="/wrks/sstm/grp/auth_role.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=8b879ee6-9945-4dbe-bc57-6a0d095b0595&sys=wrks1">그룹권한레벨별롤</a></li> -->
						
			                </ul>
			            <!--     <li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">모바일</a>
			                    <ul>
		
						<li class=""><a href="/wrks/sstm/mbl/info.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=b65b5877-ead6-4e56-97af-98588768ecc7&sys=wrks1">기기정보</a></li>
						
						<li class=""><a href="/wrks/sstm/mbl/version.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=483e5f6d-5787-4251-b7aa-7e7f6f290607&sys=wrks1">앱버전정보</a></li>
						
			                </ul>
			                <li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">메뉴관리</a>
			                    <ul>
		
						<li class=""><a href="/wrks/sstm/menu/info.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=d72785f9-b239-49d5-abfd-a92d53da8681&sys=wrks1">프로그램정보</a></li>
						
						<li class=""><a href="/wrks/sstm/menu/menu.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=c9988482-5afb-4162-af19-bca7500a7f4e&sys=wrks1">메뉴프로그램</a></li>
						
						<li class=""><a href="/wrks/sstm/menu/grpauth.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=9b732ace-2221-4c90-ac0f-d51af54dcf70&sys=wrks1">그룹권한별메뉴</a></li>
						
						<li class=""><a href="/wrks/sstm/menu/user.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=020cf8af-8c82-4d98-a53b-2b6553a54fe2&sys=wrks1">사용자별메뉴</a></li>
						
						<li class=""><a href="/wrks/sstm/menu/icon.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=7f0bce74-2343-4166-93b0-eb638fd82f0e&sys=wrks1">아이콘관리</a></li>
						
			                </ul>
			                <li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">게시판관리</a>
			                    <ul>
		
						<li class=""><a href="/wrks/cop/com/selectTemplateInfs.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=8d176642-3b1d-4a86-86c6-a1ef57798e77&sys=wrks1">게시판템플릿</a></li>
						
						<li class=""><a href="/wrks/cop/bbs/SelectBBSMasterInfs.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=6d55a460-47b1-421c-85fc-4edd85cfd13d&sys=wrks1">게시판생성관리</a></li>
						
			                </ul>
			                <li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">RSS정보</a>
			                    <ul>
		
						<li class=""><a href="/wrks/wrkmng/msgmng/rss.do?top=e1cdc03a-f6ea-43d2-9e6b-b71f59534e78&left=e0d9c0e6-7f12-4bfc-808f-4e99c6c4622e&sys=wrks1">RSS 정보관리</a></li> -->
						
	    		</ul>
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
                    <span>Home</span>  &gt; <span>그룹정보</span>  &gt; <span>그룹별사용자조회</span>
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
                    <h3 class="tit">그룹별 사용자조회</h3>
                </div>
                <div class="boxWrap">
	                <div class="tbLeft50">
		                <div class="tableTypeFree seachT">
		                    <table>
		                        <caption>사용자 추가</caption>
		                        <tbody>
		                        <tr>
			                        <th>지구</th>
			                        <td>
										<select name="" id="sDstrtCd" class="selectType1">
											<option value="">전체</option>
										     
										        <option value="467">부산 강서구</option>   
										                         
										</select>
			                        </td>
	                            	<th>그룹명</th>
		                            <td>
		                            	<input type="text" name="" id="sGrpNm" class="txtType grpNm searchEvt" style="ime-mode:active">
										<a href="javascript:;" class="btnRight btnS searchBtn">검색</a>
			                        </td>
		                        </tr>
		                        </tbody>
		                    </table>
		                </div><br/>
		                <div class="tableType1">
		    				<table id="grid_group" style="width:100%">
		    				</table>
		                </div>
	                </div>
	                <div class=tbRight50>
		                <div class="tableTypeFree seachT">
		                    <table>
		                        <caption>사용자 추가</caption>
		                        <tbody>
		                        <tr>
			                        <th>사용자명</th>
			                        <td><input type="text" name="" id="sUserNmKo" class="txtType grpNm searchEvt2" style="ime-mode:active">
										<a href="javascript:;" class="btnRight btnS2 searchBtn2">검색</a>
			                        </td>
		                        </tr>
		                        </tbody>
		                    </table>
		                </div><br/>
		                <div class="tableType1">
		    				<table id="grid_user" style="width:100%">
		    				</table>
		                </div>
	                </div>
                </div>
            </div>
			
			 <!-- 레이어팝업 상세 -->
            <div class="layer layerDetail" id="div_drag_1">
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
