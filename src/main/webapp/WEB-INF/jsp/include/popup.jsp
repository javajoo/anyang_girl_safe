<!-- 팝업 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="./js/popup.js"></script>
<div id="event_monitoring_handle" class="easyui-dialog" title="상황관리" data-options="resizable:false,modal:false,closed:true" style="top:75px;">
	<div id="pop_tabs" class="easyui-tabs" style="width:782px;height:108px" data-options="tabPosition:''">
		<div title="전체">
			<ul class="pop_list_condi">
				<li class="list">
					<em class="b_tit2">상황유형</em>
					<c:choose>
		        	<c:when test="${admin.authority=='P'}">
		        		<select class="easyui-combobox" id="pop_search_type_0"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_3',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_3');search_eventM();}" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:when test="${admin.authority=='F'}">
		        		<select class="easyui-combobox" id="pop_search_type_0"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_4',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_4');search_eventM();}" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:when test="${admin.authority=='W'}">
		        		<select class="easyui-combobox" id="pop_search_type_0"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_2',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_2');search_eventM();}" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:when test="${admin.authority=='S'}">
		        		<select class="easyui-combobox" id="pop_search_type_0"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_1',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_1');search_eventM();}" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:when test="${admin.authority=='D'}">
		        		<select class="easyui-combobox" id="pop_search_type_0"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_7',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_7');search_eventM();}" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:otherwise>
						<select class="easyui-combobox" id="pop_search_type_0"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&all=Y',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){search_eventM();}, onChange:function(){change_type();}" panelHeight="auto" style="width:150px"></select>
		        	</c:otherwise>
		        	</c:choose>
					
					<c:choose>
		        	<c:when test="${admin.authority=='P'}">
		        		<em class="b_tit2">처리상태</em>
						<select class="easyui-combobox" id="pop_search_state"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_STATE&sysCd=Y&codeCd=EVENT_TYPE_3',method:'get'
						,valueField:'codeCd',textField:'codeNm'" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:when test="${admin.authority=='F'}">
		        		<em class="b_tit2">처리상태</em>
						<select class="easyui-combobox" id="pop_search_state"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_STATE&sysCd=Y&codeCd=EVENT_TYPE_4',method:'get'
						,valueField:'codeCd',textField:'codeNm'" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:when test="${admin.authority=='W'}">
		        		<em class="b_tit2">처리상태</em>
						<select class="easyui-combobox" id="pop_search_state"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_STATE&sysCd=Y&codeCd=EVENT_TYPE_2',method:'get'
						,valueField:'codeCd',textField:'codeNm'" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:when test="${admin.authority=='S'}">
		        		<em class="b_tit2">처리상태</em>
						<select class="easyui-combobox" id="pop_search_state"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_STATE&sysCd=Y&codeCd=EVENT_TYPE_1',method:'get'
						,valueField:'codeCd',textField:'codeNm'" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:when test="${admin.authority=='D'}">
		        		<em class="b_tit2">처리상태</em>
						<select class="easyui-combobox" id="pop_search_state"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_STATE&sysCd=Y&codeCd=EVENT_TYPE_7',method:'get'
						,valueField:'codeCd',textField:'codeNm'" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:otherwise>
						<em class="b_tit2">처리상태</em>
						<select class="easyui-combobox" id="pop_search_state"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_STATE&all=Y',method:'get'
						,valueField:'codeCd',textField:'codeNm'" panelHeight="auto" style="width:150px"></select>
		        	</c:otherwise>
		        	</c:choose>
					
				</li>
				<li class="pop_list_condi">
					<em class="b_tit2">발생일자</em>
					<input id="pop_search_timeS_0" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser,prompt:'시작일 입력'" style="width:175px;">
					&nbsp;~ 
					<input id="pop_search_timeE_0" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser,prompt:'종료일 입력'" style="width:175px;">
					
					<a href="#" class="pop_button_list" onclick="search_pop(0)"></a>
				</li>
			</ul>
			
		</div>
		<div title="발생">
			<ul class="pop_list_condi">
				<li class="list">
					<em class="b_tit2">상황유형</em>
					<c:choose>
		        	<c:when test="${admin.authority=='P'}">
		        		<select class="easyui-combobox" id="pop_search_type_1"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_3',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_3');}" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:when test="${admin.authority=='F'}">
		        		<select class="easyui-combobox" id="pop_search_type_1"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_4',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_4');}" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:when test="${admin.authority=='W'}">
		        		<select class="easyui-combobox" id="pop_search_type_1"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_2',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_2');}" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:when test="${admin.authority=='S'}">
		        		<select class="easyui-combobox" id="pop_search_type_1"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_1',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_1');}" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:when test="${admin.authority=='D'}">
		        		<select class="easyui-combobox" id="pop_search_type_1"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_7',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_7');}" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:otherwise>
						<select class="easyui-combobox" id="pop_search_type_1"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&all=Y',method:'get'
						,valueField:'codeCd',textField:'codeNm'" panelHeight="auto" style="width:150px"></select>
		        	</c:otherwise>
		        	</c:choose>
				</li>
				<li class="pop_list_condi">
					<em class="b_tit2">발생일자</em>
					<input id="pop_search_timeS_1" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser,prompt:'시작일 입력'" style="width:175px;">
					&nbsp;~ 
					<input id="pop_search_timeE_1" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser,prompt:'종료일 입력'" style="width:175px;">
					
					<a href="#" class="pop_button_list2" onclick="search_pop('EVENT_STATE_1')"></a>
					<a href="#" id="search_pop_new" class="pop_button_list_new" onclick="search_pop_new()"></a>
				</li>
			</ul>
		</div>
		<div title="처리중">
			<ul class="pop_list_condi">
				<li class="list">
					<em class="b_tit2">상황유형</em>
					<c:choose>
		        	<c:when test="${admin.authority=='P'}">
		        		<select class="easyui-combobox" id="pop_search_type_2"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_3',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_3');}" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:when test="${admin.authority=='F'}">
		        		<select class="easyui-combobox" id="pop_search_type_2"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_4',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_4');}" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:when test="${admin.authority=='W'}">
		        		<select class="easyui-combobox" id="pop_search_type_2"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_2',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_2');}" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:when test="${admin.authority=='S'}">
		        		<select class="easyui-combobox" id="pop_search_type_2"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_1',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_1');}" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:when test="${admin.authority=='D'}">
		        		<select class="easyui-combobox" id="pop_search_type_2"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_7',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_7');}" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:otherwise>
						<select class="easyui-combobox" id="pop_search_type_2"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&all=Y',method:'get'
						,valueField:'codeCd',textField:'codeNm'" panelHeight="auto" style="width:150px"></select>
		        	</c:otherwise>
		        	</c:choose>
				</li>
				<li class="pop_list_condi">
					<em class="b_tit2">발생일자</em>
					<input id="pop_search_timeS_2" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser,prompt:'시작일 입력'" style="width:175px;">
					&nbsp;~ 
					<input id="pop_search_timeE_2" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser,prompt:'종료일 입력'" style="width:175px;">
					
					<a href="#" class="pop_button_list" onclick="search_pop('EVENT_STATE_2')"></a>
				</li>
			</ul>
		</div>
		<div title="종료">
			<ul class="pop_list_condi">
				<li class="list">
					<em class="b_tit2">상황유형</em>
					<c:choose>
		        	<c:when test="${admin.authority=='P'}">
		        		<select class="easyui-combobox" id="pop_search_type_3"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_3',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_3');}" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:when test="${admin.authority=='F'}">
		        		<select class="easyui-combobox" id="pop_search_type_3"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_4',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_4');}" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:when test="${admin.authority=='W'}">
		        		<select class="easyui-combobox" id="pop_search_type_3"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_2',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_2');}" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:when test="${admin.authority=='S'}">
		        		<select class="easyui-combobox" id="pop_search_type_3"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_1',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_1');}" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:when test="${admin.authority=='D'}">
		        		<select class="easyui-combobox" id="pop_search_type_3"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_7',method:'get'
						,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_7');}" panelHeight="auto" style="width:150px"></select>
		        	</c:when>
		        	<c:otherwise>
						<select class="easyui-combobox" id="pop_search_type_3"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&all=Y',method:'get'
						,valueField:'codeCd',textField:'codeNm'" panelHeight="auto" style="width:150px"></select>
		        	</c:otherwise>
		        	</c:choose>
				</li>
				<li class="pop_list_condi">
					<em class="b_tit2">발생일자</em>
					<input id="pop_search_timeS_3" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser,prompt:'시작일 입력'" style="width:175px;">
					&nbsp;~ 
					<input id="pop_search_timeE_3" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser,prompt:'종료일 입력'" style="width:175px;">
					
					<a href="#" class="pop_button_list" onclick="search_pop('EVENT_STATE_4')"></a>
				</li>
			</ul>
		</div>
	</div>
	<div class="tabs_pop_top">
		<table id="total_result" class="easyui-datagrid" title="" style="width:780px;height:280px;"
		data-options="pagination:true,onClickRow:selectPopRow,pageSize:7,onLoadSuccess:function(row,data){if(row.total>'0'){selectPopRow(0,row.rows[0]);$(this).datagrid('selectRow',0);}}">
			<thead>
				<tr>
					<th data-options="field:'seqNo',hidden:true">관리번호</th>
					<th data-options="field:'eventNo',width:100,align:'center'">사건/접수번호</th>
					<th data-options="field:'eventType',width:70,align:'center'">이벤트명</th>
					<th data-options="field:'eventCont',width:120,align:'center'">내용</th>
					<th data-options="field:'eventDe',width:130,align:'center'">발생일시</th>
					<th data-options="field:'stateNm',width:100,align:'center'">상태</th>
		            <th data-options="field:'acceptId',width:80,align:'center'">접수자</th>
		            <th data-options="field:'acceptCont',width:100,align:'center'">발생내용</th>
		            
		            <th data-options="field:'state',hidden:true">상태코드</th>
		            <th data-options="field:'eventRating',hidden:true">등급</th>
		            <th data-options="field:'eventPlace',hidden:true">발생장소</th>
		            <th data-options="field:'acceptType',hidden:true">접수유형</th>
		            <th data-options="field:'infoNm',hidden:true">신고자</th>
		            <th data-options="field:'zone',hidden:true">지구명</th>
		            <th data-options="field:'facilityId',hidden:true">상황발생시설물ID</th>
		            <th data-options="field:'endDe',hidden:true">종료일시</th>
		            <th data-options="field:'latitude',hidden:true">위도</th>
		            <th data-options="field:'longitude',hidden:true">경도</th>
	            </tr>
	        </thead>
	    </table>
	</div>
	
	
	<div class="pop_body_bottom">
		<div class="dtl_title"><em>처리내역</em></div>
		<table id="total_result_state" class="easyui-datagrid" title="" style="width:780px;height:150px;'"
		data-options="rownumbers:true">
			<thead>
				<tr>
					<th data-options="field:'seqNo',hidden:true">관리번호</th>
					<th data-options="field:'stateNm',width:80,align:'center'">진행상태</th>
					<th data-options="field:'eventCont',width:200,align:'center'">내용</th>
					<th data-options="field:'eventDe',width:130,align:'center'">일시</th>
		            <th data-options="field:'dispId',width:80,align:'center'">처리자</th>
	            </tr>
	        </thead>
	    </table>
	    
	    <div class="dtl_title"><em>기본정보</em></div>
	    <table id="total_result_dtl_1" class="pop_dtl">
	        <tr>
				<td class="pop_body_title_text">이벤트유형</td>
				<td class="pop_body_title_value">
					<c:choose>
			        	<c:when test="${admin.authority=='P'}">
			        	<select class="easyui-combobox" id="pop_type"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_3',method:'get'
						,valueField:'codeCd',textField:'codeNm'" panelHeight="auto" style="width:243px"></select>
			        	</c:when>
			        	<c:when test="${admin.authority=='F'}">
			        	<select class="easyui-combobox" id="pop_type"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_4',method:'get'
						,valueField:'codeCd',textField:'codeNm'" panelHeight="auto" style="width:243px"></select>
			        	</c:when>
			        	<c:when test="${admin.authority=='W'}">
			        	<select class="easyui-combobox" id="pop_type"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_2',method:'get'
						,valueField:'codeCd',textField:'codeNm'" panelHeight="auto" style="width:243px"></select>
			        	</c:when>
			        	<c:when test="${admin.authority=='S'}">
			        	<select class="easyui-combobox" id="pop_type"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_1',method:'get'
						,valueField:'codeCd',textField:'codeNm'" panelHeight="auto" style="width:243px"></select>
			        	</c:when>
			        	<c:when test="${admin.authority=='D'}">
			        	<select class="easyui-combobox" id="pop_type"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_7',method:'get'
						,valueField:'codeCd',textField:'codeNm'" panelHeight="auto" style="width:243px"></select>
			        	</c:when>
			        	<c:otherwise>
			        	<select class="easyui-combobox" id="pop_type"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&all=N',method:'get'
						,valueField:'codeCd',textField:'codeNm'" panelHeight="auto" style="width:243px"></select>
			        	</c:otherwise>
		        	</c:choose>
				</td>
				
				<td class="pop_body_title_text">이벤트등급</td>
				<td class="pop_body_title_value">
					<select class="easyui-combobox" id="pop_rating" panelHeight="auto" style="width:243px;">
						<option value="1" selected>긴급</option>
						<option value="2">일반</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="pop_body_title_text">발생일시</td>
				<td class="pop_body_title_value">
					<input class="easyui-datebox" style="width:243px;" id='pop_dateS' data-options="formatter:myformatter_time,parser:myparser_time,prompt:'발생일시'">
				</td>
				<td class="pop_body_title_text">종료일시</td>
				<td class="pop_body_title_value">
					<input class="easyui-datebox" style="width:243px;" id='pop_dateE' data-options="formatter:myformatter_time,parser:myparser_time,prompt:'종료일시'">
				</td>
			</tr>
			<tr>
				<td class="pop_body_title_text">발생장소</td>
				<td class="pop_body_title_value" colspan="3">
					<!-- <p style="font-size: 12px;float: left;margin-right: 2px;">부산시 강서구 </p><input type='text' style="width:561px;" id='pop_place' placeholder='주소 직접입력'> -->
					 <p style="font-size: 12px;float: left;margin-right: 2px;"></p><input type='text' style="width:561px;" id='pop_place' placeholder='주소 직접입력'>
				</td>
			</tr>
			<tr>
				<td class="pop_body_title_text">발생내용</td>
				<td class="pop_body_title_value" colspan="3">
					<input type='text' style="width:630px;" id='pop_accept_cont'>
				</td>
			</tr>
			<tr>
				<td class="pop_body_title_text">발생위치</td>
				<td class="pop_body_title_value" colspan="3">
					<table>
						<tr>
							<td class="pop_body_title_text">경도</td>
							<td class="pop_body_title_value">
								<input type='text' size='20' id='pop_lon'>
							</td>
							<td class="pop_body_title_text">위도</td>
							<td class="pop_body_title_value">
								<input type='text' size='20' id='pop_lat'>
							</td>
							<td class="pop_body_title_text">고도</td>
							<td class="pop_body_title_value">
								<input type='text' size='20' id='pop_alt'>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="pop_body_title_text">접수유형</td>
				<td class="pop_body_title_value">
					<select class="easyui-combobox" id="pop_accept_type"
					data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=ACCEPT_TYPE',method:'get'
					,valueField:'codeCd',textField:'codeNm'" panelHeight="auto" style="width:243px"></select>
				</td>
				<td class="pop_body_title_text">신고자</td>
				<td class="pop_body_title_value">
					<input type='text' style="width:239px;" id='pop_info_nm'>
				</td>
			</tr>
			<tr>
				<td class="pop_body_title_text">신고/접수번호</td>
				<td class="pop_body_title_value">
					<input type='text' style="width: 241px;-webkit-logical-width: 239px;" id='pop_event_no'>
				</td>
				<td class="pop_body_title_text">지구명</td>
				<td class="pop_body_title_value">
					<input type='text' style="width:239px;" id='pop_zone'>
				</td>
			</tr>
	    </table>
	    
	    <div class="dtl_title"><em>세부항목</em></div>
	    <table id="total_result_dtl_2" class="pop_dtl">
			<tr>
				<td class="pop_body_title_text">상황발생시설물ID</td>
				<td class="pop_body_title_value" >
					<input type='text' style="width:630px;" id='pop_facility'>
				</td>
			</tr>
	    </table>
	    
	    <!-- <div class="dtl_title"><em>지역</em></div>
	    <table id="total_result_dtl_3" class="pop_dtl">
			<tr>
				<td class="pop_body_title_text">항목1</td>
				<td class="pop_body_title_value" >
					<input type='text' size='80' id='pop_si'>
				</td>
			</tr>
	    </table> -->
	    
	    <div id="memo">
		    <div class="dtl_title"><em>내용</em></div>
		    <!-- <input type='textarea' size='80' id='pop_memo'> -->
		    <textarea id='pop_memo' class='text_area'></textarea><!-- class='datagrid-editable-input' -->
	    </div>
	    
	    <div class="pop_button_area">
			<a href="#" id="search_pop_upd" class="pop_button_list_upd " onclick="search_pop_upd('upd')"></a>
			<a href="#" id="search_pop_end" class="pop_button_list_end " onclick="search_pop_upd('end')"></a>
			<a href="#" id="search_pop_save" class="pop_button_list_save " onclick="search_pop_save()"></a>
		</div>
		
		<input id="authority" type="hidden" value="${admin.authority}"/>
	</div>
	
</div>
