<!-- 이벤트 모니터링 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="cont_area">
	<div id="eventM_management" title="" style="height:100%;">
		<ul class="list_condi">
			<li class="list">
				<!-- <input type="checkbox" id="search_eventM_chk" name="search_eventM_chk" value="1" checked="checked"/>
				<label for="search_eventM_chk" style="margin-right: 199px;">시설물고장제외</label> -->
				<c:choose>
	        	<c:when test="${admin.authority=='P'}">
	        		<select class="easyui-combobox" id="search_eventM_gbn"
					data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_3',method:'get'
					,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_3');}" panelHeight="auto" style="width:150px"></select>
	        	</c:when>
	        	<c:when test="${admin.authority=='F'}">
	        		<select class="easyui-combobox" id="search_eventM_gbn"
					data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_4',method:'get'
					,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_4');}" panelHeight="auto" style="width:150px"></select>
	        	</c:when>
	        	<c:when test="${admin.authority=='W'}">
	        		<select class="easyui-combobox" id="search_eventM_gbn"
					data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_2',method:'get'
					,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_2');}" panelHeight="auto" style="width:150px"></select>
	        	</c:when>
	        	<c:when test="${admin.authority=='S'}">
	        		<select class="easyui-combobox" id="search_eventM_gbn"
					data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_1',method:'get'
					,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_1');}" panelHeight="auto" style="width:150px"></select>
	        	</c:when>
	        	<c:when test="${admin.authority=='D'}">
	        		<select class="easyui-combobox" id="search_eventM_gbn"
					data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&codeCd=EVENT_TYPE_7',method:'get'
					,valueField:'codeCd',textField:'codeNm',onLoadSuccess:function(){$(this).combobox('setValue','EVENT_TYPE_7');
					$('#refresh_es_btn').show();}" panelHeight="auto" style="width:150px"></select>
	        	</c:when>
	        	<c:otherwise>
					<select class="easyui-combobox" id="search_eventM_gbn"
					data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&all=Y',method:'get'
					,valueField:'codeCd',textField:'codeNm',onChange:search_eventM" panelHeight="auto" style="width:150px"></select>
	        	</c:otherwise>
	        	</c:choose>
	        	<a href="#" id="refresh_es_btn" onclick="refresh_es_event()" 
	        		style="background: url(../images/icons/refresh_btn_sel.png) no-repeat center center; width: 35px;
    				height: 35px; top: 2px; position: absolute; display: none;"></a>
	        	<a href="#" id="search_eventM_handle" class="eventM_button_list" onclick="search_eventM_handle()"></a>
			</li>
			<!-- <li class="list">
				<a href="#" id="search_eventM_handle" class="eventM_button_list" onclick="search_eventM_handle()"></a>
			</li> -->
		</ul>
		
		<ul class="list_ty" style="height:calc(100% - 87px);">
			<div class="table_title">
				<em>조회결과</em>
				<!-- <span class="list_tot" id="search_eventM_tot" name="search_eventM_tot">0</span><label for="search_eventM_tot">건</label> -->
			</div>
			<table id="eventM_table" class="easyui-datagrid" title="" style="width:100%;height:95%;"
				data-options="pagination:true,pageSize:18,onClickRow:selectEeventMGIS,onDblClickRow:selectEeventMRow">
			   	<thead>
			       	<tr>
						<th data-options="field:'eventType',width:100,align:'center'">유형</th>
						<th data-options="field:'eventDe',width:160,align:'center'">발생일자</th>
						<th data-options="field:'stateNm',width:100,align:'center'">진행상태</th>
						<th data-options="field:'castNet',width:80,align:'center'">상황처리</th>
						<th data-options="field:'id',width:70,align:'center',hidden:true">아이디</th>
						<th data-options="field:'latitude',hidden:true">위도</th>
						<th data-options="field:'longitude',hidden:true">경도</th>
						<th data-options="field:'eventNo',hidden:true">신고/접수번호</th>
						<th data-options="field:'iconName',hidden:true">이벤트아이콘명</th>
					</tr>
				</thead>
			</table>
		</ul>
	</div>
</div>
