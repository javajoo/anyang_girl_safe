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
<title>상황통계</title>



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


</head>
<body>
<div id="wrapper">
	<!-- topbar -->
	<jsp:include page="include/topMenu.jsp" >
	<jsp:param name="mc" value="3"/>
	</jsp:include>
	<!-- //topbar -->
	<!-- container -->
	<div class="container">
		<!-- leftMenu -->
		




        <div class="leftMenu">
			<ul>
        
			                <li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_on.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">통계</a>
			                    <ul>
		
						<li class=""><a href="/situationStats.do">이벤트발생 통계</a></li>
						
						<!-- <li class=""><a href="#">사용자접속 통계</a></li> -->
						
			                </ul>
			                <!-- <li><a href="" id="" class="" style="background: url(/images/menu/menu_icon_off.png) no-repeat left top;" on-image="/images/menu/menu_icon_on.png" off-image="/images/menu/menu_icon_off.png">긴급영상제공통계</a>
			                    <ul>
		
						<li class=""><a href="/wrks/evtctl/stats/cctvMonType.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=25db05f6-b562-41df-b04c-62373912e60f">CCTV접속현황(월/유형)</a></li>
						
						<li class=""><a href="/wrks/evtctl/stats/cctvMonUsers.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=0a1692ec-a544-4544-a863-427f14c86b96">CCTV접속현황(월/사용자)</a></li>
						
						<li class=""><a href="/wrks/evtctl/stats/cctvTermType.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=bf078dc5-6083-4edc-86f9-eeb62a04df30">CCTV접속현황(기간/유형)</a></li>
						
						<li class=""><a href="/wrks/evtctl/stats/cctvTermUser.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=d7a16435-421c-49a2-90f4-56833829b7ef">CCTV접속현황(기간/사용자)</a></li>
						
						<li class=""><a href="/wrks/evtctl/stats/cctvDetail.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=b14e2035-e054-41cb-9011-454540369457">CCTV접속상세이력</a></li>
						    
	    		</ul>
	    		</li> -->
	        </ul>
        <!--
		
			
			
			
			
			
	            <ul>
	                <li><a href="" id="" class="ic_code">코드관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/code/cmcd.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=0">공통코드그룹</a></li>
	                        <li><a href="/wrks/sstm/code/dtcd.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=0">코드상세</a></li>
	                        <li><a href="/wrks/sstm/code/sycd.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=0">시스템코드</a></li>
	                        <li><a href="/wrks/sstm/code/sggcd.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=0">시군구코드</a></li>
	                        <li><a href="/wrks/sstm/code/dst.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=0">지구코드</a></li>
	                        <li><a href="/wrks/sstm/code/area.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=0">지역코드</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_user">사용자관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/usr/info.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=1">사용자관리</a></li>
	                        <li><a href="/wrks/sstm/usr/area.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=1">지역별사용자</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_group">그룹정보</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/grp/code.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=2">그룹관리</a></li>
	                        <li><a href="/wrks/sstm/grp/user_acc.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=2">그룹별이벤트(사용자권한)</a></li>
	                        <li><a href="/wrks/sstm/grp/user.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=2">그룹별사용자조회</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">모바일</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/mbl/grp.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=3">그룹관리</a></li>
	                        <li><a href="/wrks/sstm/mbl/info.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=3">계정정보</a></li>
	                        <li><a href="/wrks/sstm/mbl/version.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=3">버젼정보관리</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">이벤트관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/evnt/base.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=4">이벤트기본정보</a></li>
	                        <li><a href="/wrks/sstm/evnt/item.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=4">이벤트세부항목</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">메뉴관리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/menu/info.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=5">프로그램정보</a></li>
	                        <li><a href="/wrks/sstm/menu/menu.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=5">프로그램메뉴</a></li>
	                        <li><a href="/wrks/sstm/menu/grp.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=5">그룹별프로그램메뉴</a></li>
	                        <li><a href="/wrks/sstm/menu/user.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=5">사용자별프로그램메뉴</a></li>
	                    </ul>
	                </li>
	                <li><a href="" id="" class="ic_area">상황처리</a>
	                    <ul>
	                        <li><a href="/wrks/sstm/evtctl/info.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=7">상황관리</a></li>
	                        <li><a href="/wrks/sstm/evtctl/trans_recv.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=7">상황전달수신자관리</a></li>
	                        <li><a href="/wrks/sstm/evtctl/disp_mbl.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=7">표출단말관리</a></li>
	                        <li><a href="/wrks/sstm/evtprc/info.do?top=e75cf498-e141-4113-9bc4-0f405ea62c32&left=7">상황처리</a></li>
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
                <h2 class="tit">상황통계</h2> 
                <div class="location">
                    <span>Home</span>  &gt; <span>통계</span>
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
					<h3 class="tit">이벤트발생 통계</h3>
				</div>
				<form id="listForm" name="listForm" method="post">
				<div class="tableTypeHalf seachT">
					<table>
					<caption>이벤트발생 통계</caption>
					<colgroup>
						<col style="width: 150px;" />
						<col style="width: *" />
						<col style="width: 150px;" />
						<col style="width: 150px" />
						<col style="width: 150px" />
						<col style="width: 100px" />
					</colgroup>
					<tbody>
					<tr>
						<th>이벤트구분</th>
						<td>
							<select name="searchEventType" id="searchEventType" class="selectType1" onchange="javascript:search();" >
							<option value="" > ::: 전체 :::</option>
							
								<option value="112UC001" >112센터긴급영상지원</option>
							
								<option value="112UC120" >112긴급출동지원</option>
							
								<option value="112UC110" >112차량위치</option>
							
							</select>
						</td>
						<th>기간</th>
						<td>
							<select name="searchYear" id="searchYear" class="selectType1" onchange="search()" >
							
								<option value="2018" >2018</option>
							
							</select>
							년
						</td>
						<td>
							<select name="searchMonth" id="searchMonth" class="selectType1" onchange="search()" >
							<option value="" > ::: 전체 :::</option>
							
								<option value="1" >1</option>
							
								<option value="2" >2</option>
							
								<option value="3" >3</option>
							
								<option value="4" >4</option>
							
								<option value="5" >5</option>
							
								<option value="6" >6</option>
							
								<option value="7" >7</option>
							
								<option value="8" >8</option>
							
								<option value="9" >9</option>
							
								<option value="10" >10</option>
							
								<option value="11" >11</option>
							
								<option value="12" >12</option>
							
							</select>
							월
						</td>
						<td>
							<a href="javascript:search();" class="btnRight btnS searchBtn">검색</a>
						</td>
					</tr>
					</tbody>
					</table>
				</div>
				</form>
				</br>
				<div class="tableType1" style="overflow-y:hidden; overflow-x:hidden">
					<table id="grid" style="width:100%"></table>
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



</script></div>
</div>
<!-- //footer -->
<script type="text/javascript">
$(document).ready(function(){
	$.manuHandler('e75cf498-e141-4113-9bc4-0f405ea62c32', '');
});

function getGridSize(param)
{
	var size = 12;
	if(param == 2) {
		size = 28;
	} else if (param == 1 || param == 3 || param == 5 || param == 7 || param == 8 || param == 10 || param == 12) {
		size = 31;
	} else if (param == 4 || param == 6 || param == 9 || param == 11) {
		size = 30;
	}
	return size;
}

function getColNames(gubun, param)
{
	var unit = (param == '') ? "월" : "일";
	var size = getGridSize(param);
	
	var names = new Array();
	if(gubun != '') names.push(gubun);
	for(var i=1; i<=size ; i++) {
		names.push(i+unit);
	}
	return names;
}

function getColModel(param)
{
	var size = getGridSize(param);
	
	var models = new Array();
	var wid = "'white-space: normal;width=80px;'";
	var firstModel = '({name:"GUBUN", align:"center", cellattr: function(){ return "style=' + wid + '" }})';
	
	models.push(eval(firstModel));
	
	for(var i=1; i<=size ; i++) {
		var string = "{name:'TERM" + i +"', align:'center', formatter:'currency',formatoptions: {thousandsSeparator: ',', decimalPlaces:0}}";
		var obj = eval('(' + string + ')');
		models.push(obj);
	}
	return models;
}

	/** 그리드설정 */
	$('#grid').jqGrid(
	{
			  url : '/wrks/info/sts/eventStsList/eventStatsData.json'
			, datatype : "json"
			, postData :
			{ 
				  searchEventType:$("#searchEventType option:selected").val()
				, searchYear:$("#searchYear option:selected").val()
				, searchMonth:$("#searchMonth option:selected").val()
			}
			, colNames : getColNames("구분", $("#searchMonth option:selected").val())
			, colModel : getColModel($("#searchMonth option:selected").val())
			, rowNum : 15
			, viewrecords:true
			, multiselect: false
			, loadonce:false
			, height : 'auto'
			, autowidth : true
			, jsonReader: {repeatitems: false, id: "ref"}
			, sortable: false
	});

	$(".btnS").bind("click",function()
	{
		if ($.validate(".tableTypeHalf.seachT") == false) {
			return;
		}
		$("#grid").setGridParam({rowNum : $('#rowPerPageList').val()});
		var myPostData = $("#grid").jqGrid('getGridParam', 'postData');
		//검색할 조건의 값을 설정한다.
		myPostData.searchEventType = $("#searchEventType option:selected").val();
		myPostData.searchYear = $("#searchYear option:selected").val();
		myPostData.searchMonth = $("#searchMonth option:selected").val();

		$("#grid").trigger("reloadGrid");
	});

	function search()
	{
		document.listForm.action = "/wrks/info/sts/eventStsList.do";
		document.listForm.submit();
	}
</script>

</body>
</html> 