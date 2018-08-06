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
<title>여성 안심서비스</title>

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
	$.manuHandler('6dbf7152-c02a-4a53-84ec-3431adf5dde8', 'd747dcc0-db2f-4172-b47d-80f59ac562cc');

	$.jqGrid($('#grid'), {
        url : '/com/danusys/platform/work/event/item/list.do',
        datatype : "json",
        postData : { 
        	evtItemId : $("#evtItemId").val(),
        	evtItemNm : $("#evtItemNm").val()
        },
        colNames : [
                        '<input type="checkbox" name="hcheckbox" onchange="$.GridHeaderCheckBoxChange(\'#grid\', this, event);">',
                        '정렬순서',
                        '이벤트항목아이디',
                        '항목명',
                        '코드그룹아이디',
                        '항목그룹',
                        '등록자',
                        '등록일',
                        '수정자',
                        '수정일'
                   ],
        colModel : [
                  { name : 'CHECK', width:50, align:'center', editable:true, edittype:'checkbox', editoptions: { value:"True:False" }, sortable: false, formatter: $.GridCheckBox},
                  { name : 'SORT_ORDR', width:100, align:'center'},
                  { name : 'EVT_ITEM_ID', width:250, align:'center'},
                  { name : 'EVT_ITEM_NM', width:250, align:'center'},
                  { name : 'CD_GRP_ID', width:170, align:'center'},
                  { name : 'ITEM_GRP', width:150, align:'center'},
                  { name : 'RGS_USER_ID', width:300, align:'center', hidden:true},
                  { name : 'RGS_DATE', width:300, align:'center', hidden:true},
                  { name : 'UPD_USER_ID', width:100, align:'center', hidden:true},
                  { name : 'UPD_DATE', width:125, align:'center', hidden:true}
          ],
        pager : '#pager',
        rowNum : $('#rowPerPageList').val(),
        sortname: 'SORT_ORDR',
        sortorder: 'ASC',
        viewrecords:true,
        multiselect: false,
        shrinkToFit: true,
        scrollOffset: 0,
        autowidth: true,
        loadonce:false,
        jsonReader: {
        	id: "EVT_ITEM_ID",
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
			
			$("#dEvtItemId").html(list.EVT_ITEM_ID);
			$("#dEvtItemNm").html(list.EVT_ITEM_NM);
			$("#dCdGrpId").html(list.CD_GRP_ID);
			$("#dItemGrp").html(list.ITEM_GRP);
			$("#dSortOrdr").html(list.SORT_ORDR);
			$("#dRgsUserId").html(list.RGS_USER_ID);
			$("#dRgsDate").html(list.RGS_DATE);			
			$("#dUpdUserId").html(list.UPD_USER_ID);
			$("#dUpdDate").html(list.UPD_DATE);
			
			$("#iEvtItemId").val(list.EVT_ITEM_ID);
			$("#iEvtItemNm").val(list.EVT_ITEM_NM);
			$("#iCdGrpId").val(list.CD_GRP_ID);
			$("#iItemGrp").val(list.ITEM_GRP);
			$("#iSortOrdr").val(list.SORT_ORDR);
			$("#evtItemIdBk").val(list.EVT_ITEM_ID);
			
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
    	
    	//검색할 조건의 값을 설정한다.
    	myPostData.evtItemId = $("#evtItemId").val();
    	myPostData.evtItemNm = $("#evtItemNm").val();

    	$("#grid").trigger("reloadGrid");
    });
});

function resetAction() {
	//alert("resetAction");

	$("#iEvtItemId").val("");
	$("#iEvtItemNm").val("");
	$("#iCdGrpId").val("");
	$("#iItemGrp").val("");
	$("#iSortOrdr").val("");
	$("#evtItemIdBk").val("");
}

function updateAction(obj) {
	//alert('updateAction');
	
    var url = "/com/danusys/platform/work/event/item/update.do";  
    var params = "evtItemId=" + encodeURIComponent($("#iEvtItemId").val());
        params += "&evtItemNm=" + encodeURIComponent($("#iEvtItemNm").val());  
        params += "&cdGrpId=" + encodeURIComponent($("#iCdGrpId").val());  
        params += "&sortOrdr=" + encodeURIComponent($("#iSortOrdr").val());  
        params += "&itemGrp=" + encodeURIComponent($("#iItemGrp").val());  
        params += "&updUserId=" + encodeURIComponent($("#iUpdUserId").val());  
        params += "&evtItemIdBk=" + encodeURIComponent($("#evtItemIdBk").val());

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
            alert(e.responseText);  
        }  
    });
}

function validate() {
	if($("#iEvtItemId").val().trim() == "") {
		alert("이벤트항목아이디를 입력하세요.");
		return false;
	}
	return true;
}

function insertAction(obj) {
	//alert('insertAction');
	var url = "/com/danusys/platform/work/event/item/insert.do";  
	
	var iEvtItemIdLength = $("#iEvtItemId").val().length;
	if (iEvtItemIdLength > 40) {
		alert("항목아이디는 40자리 이하로 입력하여야 합니다.");
		return false;
	}	
	
	var params = "evtItemId=" + encodeURIComponent($("#iEvtItemId").val());
	    params += "&evtItemNm=" + encodeURIComponent($("#iEvtItemNm").val());
	    params += "&cdGrpId=" + encodeURIComponent($("#iCdGrpId").val());
	    params += "&sortOrdr=" + encodeURIComponent($("#iSortOrdr").val());
	    params += "&itemGrp=" + encodeURIComponent($("#iItemGrp").val());
	    params += "&rgsUserId=" + encodeURIComponent($("#iRgsUserId").val());

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
            alert(e.responseText);  
        }  
    });
}

function deleteAction(obj) {
	//alert('deleteAction');

	var url = "/com/danusys/platform/work/event/item/delete.do";  
    //var params = "cdGrpId=" + $("#dCdGrpId").text();  
    var params = "evtItemIdBk=" + $("#evtItemIdBk").val();

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

function deleteMultiAction(obj) {
	//alert('deleteMultiAction');
	
	//var s =  $("#grid").jqGrid('getGridParam', 'selarrrow');
	//s = $("grid").getGridParam('selarrrow');
	var s =  $.getSelRow("#grid");
	if(s.length == 0){
		alert("삭제할 데이터를 선택하여 주십시오.");
		return false;
	}

	if(confirm("선택된 자료를 삭제하시겠습니까?") == false) return false;
    var url = "/com/danusys/platform/work/event/item/deleteMulti.do";  
    var params = "";  
	//alert(s.length);
    for(var i = 0; i < s.length; i++) {
		var list = jQuery("#grid").getRowData(s[i]);
		
	    params += "&evtItemId=" + list.EVT_ITEM_ID;   
    }
    //alert(params);

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

/* 한글입력 방지 */
function fn_press_han(obj)
{
    //좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
    if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 46 ) return;
    //obj.value = obj.value.replace(/[\a-zㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
    obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
}

function onlyNumber(event){
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		return;
	else
		return false;
}

function removeChar(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		return;
	else
		event.target.value = event.target.value.replace(/[^0-9]/g, "");
}
</script>

</head>
<body>
<div id="wrapper">
    <!-- topbar -->
	<jsp:include page="../include/topMenu.jsp" >
	<jsp:param name="mc" value="6"/>
	</jsp:include>
	<!-- //topbar -->
	<!-- container -->
	<div class="container">
		<!-- leftMenu -->
        <div class="leftMenu">
			<ul>
        		<li><a href="" id="" class="" style="background: url(/images/menu/21d32a3c-631c-4c14-8fef-9c4c4cb73b7a_off.png) no-repeat left top;" on-image="/images/menu/21d32a3c-631c-4c14-8fef-9c4c4cb73b7a_on.png" off-image="/images/menu/21d32a3c-631c-4c14-8fef-9c4c4cb73b7a_off.png">상황속성</a>
			    	<ul>
	    				<li class=""><a href="/mainWork.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=f024c2a1-d80a-4a85-b794-5f6a8d437720&sys=wrks1">이벤트기본정보</a></li>
						<li class="user-select"><a href="/work/event/item.do?top=6dbf7152-c02a-4a53-84ec-3431adf5dde8&left=d747dcc0-db2f-4172-b47d-80f59ac562cc&sys=wrks1">이벤트세부항목</a></li>
						<!-- <li class=""><a href="#">전송경로정보</a></li>
						<li class=""><a href="#">이벤트처리단계별전송경로</a></li> -->
					</ul>
			    <!-- <li><a href="" id="" class="" style="background: url(/images/menu/90b300b1-4249-4c0a-8947-4be22301c84b_off.png) no-repeat left top;" on-image="/images/menu/90b300b1-4249-4c0a-8947-4be22301c84b_on.png" off-image="/images/menu/90b300b1-4249-4c0a-8947-4be22301c84b_off.png">상황전파그룹</a>
			    	<ul>
						<li class=""><a href="#">상황전파그룹관리</a></li>
					</ul>
				</li> -->
	        </ul>
	    </div>
        
        <!-- content -->
        <div class="contentWrap">
            <div class="topArea">
				<a href="#"><div class="btnOpen"></div></a>
                <h2 class="tit">상황정보</h2> 
                <div class="location">
                    <span>Home</span>  &gt; <span>상황속성</span>  &gt; <span>이벤트기본정보</span>
                </div>
			</div>
            <div class="content">
                <div class="titArea">
                    <h3 class="tit">이벤트세부항목</h3>
                </div>
                <div class="tableType2 seachT">
                    <table>
                        <caption>이벤트세부항목</caption>
						<colgroup>
                        	<col style="width:90px;">
                        	<col style="width:100px;">
                        	<col style="width:80px;">
                        	<col style="width:auto;">
                        </colgroup>
                        <tbody>
                        <tr>
	                        <th>항목아이디</th>
	                        <td><input type="text" name="" id="evtItemId" class="txtType carNum searchEvt" style="ime-mode:inactive"></td>
	                        <th>항목명</th>
	                        <td><input type="text" name="" id="evtItemNm" class="txtType carNum searchEvt" style="ime-mode:active">
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
            
            <!-- 레이어팝업 상세 -->
            <div class="layer layerDetail" id="div_drag_1">
                <div class="tit"><h4>이벤트세부항목 상세</h4></div>
                <div class="layerCt">
                    <div class="tableType2">
                        <table>
                            <caption>이벤트세부항목 상세</caption>
                            <tbody>
                            <tr>
                                <th>항목아이디</th>
                                <td id="dEvtItemId"></td>
                                <th>항목명</th>
                                <td id="dEvtItemNm"></td>
                            </tr>
                            <tr>
                                <th>코드그룹아이디</th>
                                <td id="dCdGrpId" colspan="3"></td>
                            </tr>
                            <tr>
                                <th>항목그룹</th>
                                <td id="dItemGrp"></td>
                                <th>정렬순서</th>
                                <td id="dSortOrdr"></td>
                            </tr>
                            <tr>
                                <th>수정자</th>
                                <td id="dUpdUserId"></td>
                                <th>수정일</th>
                                <td id="dUpdDate"></td>
                            </tr>
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
            <!-- //레이어팝업 상세 -->
            
            <!-- 레이어팝업 등록 -->
            <div class="layer layerModify" id="div_drag_2">
                <div class="tit"><h4>이벤트세부항목 <span id="modetitle">추가</span></h4></div>
                <div class="layerCt">
                    <div class="tableType2">
                    	<input type="hidden" id="evtItemIdBk" />
                        <table>
                            <caption>이벤트세부항목 추가</caption>
                            <tbody>
                            <tr>
                                <th><star style="color: red" user-required="insert">*</star> 항목아이디</th>
                                <td><input type="text" id="iEvtItemId" class="txtType" maxlength="40"   required="required" user-required="insert" style="ime-mode:inactive" onkeydown="fn_press_han(this);" style="ime-mode:disabled;"/></td>
                                <th>항목명</th>
                                <td><input type="text" id="iEvtItemNm" class="txtType" maxlength="100" style="ime-mode:active"/></td>
                            </tr>
                            <tr>
                                <th>코드그룹아이디</th>
                                <td colspan="3"><input type="text" id="iCdGrpId" class="txtType" maxlength="40" style="ime-mode:inactive" onkeydown="fn_press_han(this);" style="ime-mode:disabled;"/></td>
                            </tr>
                            <tr>
                                <th>항목그룹</th>
                                <td><input type="text" id="iItemGrp" class="txtType" maxlength="2" style="ime-mode:inactive"/></td>
                                <th>정렬순서</th>
                                <td><input type="text" id="iSortOrdr" class="txtType" maxlength="10"  onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;'/></td>
                            </tr>
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



	</script>
	</div>
</div>
<!-- //footer -->
</body>
</html> 