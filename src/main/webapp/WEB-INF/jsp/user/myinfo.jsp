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
<title>${admin.USER_NM_KO} 사용자 정보</title>

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
//var lst = JSON.parse('[{"USER_NM_KO":"경찰","USE_TY_CD":"Y","ROWCNT":1,"USER_ID":"user112","RPSB_WORK":"개발","OFFC_TEL_NO":"--","DEPT_NM":"전략기획","IP_CD":"AL","MOBL_NO":"010-1234-5678","RK":1,"USE_NM":"사용","EMAIL":"test@test.com","PASSWORD":"9Gxtjs1KkNek4KVEPIrGhWoz09droGTWdbEjjr8d3XA\u003d","IP_TY_CD":"IPv4","USER_NM_EN":"user112"}]');

$(document).ready(function(){

	$.manuHandler('', '');
	
	
    /* 사용자그룹 */
	//등록된 사용자 그룹(상세)
    $.jqGrid('#grid_user_grp_detail', {
        url : '<c:url value='/'/>wrks/sstm/usr/info/list_user_grp.do',
        datatype : "json",
        postData : { 
        	userId :  $('#bUserId').val()
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
                    { name : 'RK', width:50, align:'center', sortable: false, hidden:true},                    
                    { name : 'GRP_ID', width:100, align:'center'},
                    { name : 'GRP_NM_KO', width:100, align:'center'},
                    { name : 'AUTH_LVL_NM', width:100, align:'center'},
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
    
    /* 사용자지역 */
	//등록된 사용자 지역(상세보기)
    $.jqGrid('#grid_user_area_detail', {
        url : '<c:url value='/'/>wrks/sstm/usr/info/list_user_area.do',
        datatype : "json",
        postData : { 
        	userId : $('#bUserId').val()
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
                    { name : 'RK', width:50, align:'center', sortable: false, hidden:true},                    
                    { name : 'AREA_CD', width:80, align:'center'},
                    { name : 'AREA_NM', width:80, align:'center'},
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
	
    $(".btnOk").bind("click",function(){

    	window.close();
    	
    });
 
    
    
});
</script>
</head>
<body>
<div id="wrapperPop">
    <!-- topbar -->
    <!-- //topbar -->
    <!-- container -->
    <div class="container">
        
        <!-- content -->
            <div class="topArea">
                
            </div>
            <div class="content">
                <div class="titArea">
                    <h3 class="tit">사용자 정보</h3>
                </div>
	                <div class="layerCt">
	                    <div class="tableTypeWide">
	                    	<input type="hidden" id="bUserId" value="${myinfoList[0].USER_ID}"/>
	                        <table>
	                            <caption>사용자 상세</caption>
	                            <tbody>
		                            <tr>
		                                <th>아이디</th>
		                                <td id="dUserId">${myinfoList[0].USER_ID}</td>
		                                <!-- <th>비밀번호</th>
		                                <td id="dPassword"></td> -->
		                                <th>한글이름</th>
		                                <td id="dUserNmKo" colspan="3">${myinfoList[0].USER_NM_KO}</td>
		                            </tr>
		                            <tr>
		                                <th>영문이름</th>
		                                <td id="dUserNmEn">${myinfoList[0].USER_NM_EN}</td>
			                            <th>핸드폰번호</th>
		                                <td id="dMoblNo" colspan="3">${myinfoList[0].MOBL_NO}</td>
		                            </tr>
		                            <tr>
		                            	<th>사용유형</th>
		                            	<td id="dUseTyCd">${myinfoList[0].USE_NM}</td>
		                            	<th>이메일</th>
		                            	<td id="dEmail" colspan="3">${myinfoList[0].EMAIL}</td>
		                            </tr>
		                            <tr>
		                            	<th>기관명</th>
		                            	<td id="dInsttNm">${myinfoList[0].INSTT_NM}</td>
		                            	<th>사무실전화번호</th>
		                            	<td id="dOffcTelNo" colspan="3">${myinfoList[0].OFFC_TEL_NO}</td>
		                            </tr>
		                            <tr>
		                            	<th>부서명</th>
		                            	<td id="dDeptNm">${myinfoList[0].DEPT_NM}</td>
		                            	<th>직급명</th>
		                            	<td id="dRankNm">${myinfoList[0].RANK_NM}</td>
		                            	<th>담당업무</th>
		                            	<td id="dRpsbWork">${myinfoList[0].RPSB_WORK}</td>
		                            </tr>
		                            <tr>
		                            	<th>IP주소체계구분</th>
		                            	<td id="dIpTyCd">${myinfoList[0].IP_TY_CD}</td>
		                            	<th>IP주소입력구분</th>
		                            	<td id="dIpCd">${myinfoList[0].IP_CD}</td>
		                            	<th>IP주소</th>
		                            	<td id="dIpAdres">${myinfoList[0].IP_ADRES}</td>
		                            </tr>
		                            <tr>
		                            	<th>비고</th>
		                            	<td id="dRemark" colspan="5">${myinfoList[0].REMARK}</td>
		                            </tr>
	                            </tbody>
	                        </table>
	                    </div>
	                    
	                    <!--등록된 사용자그룹/사용자지역 리스트  -->
		                <div class="boxWrap">
		                	<br>
		                	<div class="tbLeft50"  style="width:65%">
		                		<div class="tit"><b>사용자 그룹</b></div>
					            <!-- 등록된 사용자그룹 리스트 -->  
			                    <div class="tableType1 update" style="height:250px; overflow-y:scroll; overflow-x:hidden">
					    			<table id="grid_user_grp_detail" style="width:100%">
					    			</table>
					            </div>
					        </div>
					        <div class="tbLeft50"  style="width:35%">
					            <!-- 등록된 사용자지역 리스트   -->
					            <div class="tit"><b>사용자 지역</b></div>
			                    <div class="tableType1 update" style="height:250px; overflow-y:scroll; overflow-x:hidden">
					    			<table id="grid_user_area_detail" style="width:100%">
					    			</table>
					            </div>
		                	</div>
		                	
		                </div>
	                </div>
					<br>
            	<div class="btnWrap btnR">
            	
                    <a href="javascript:;" class="btn btnDt btnOk">확인</a>
               </div>               
            </div>
        <!-- //content -->
    </div>
    <!-- //container -->
</div>
</body>
</html> 

