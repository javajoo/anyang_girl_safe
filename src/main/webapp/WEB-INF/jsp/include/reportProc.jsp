<!-- 112이벤트 모니터링 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="cont_area">
	<div id="event112M_management" title="" style="height:100%;">
		<ul class="list_condi">
			<li class="list">
			    <em>기간</em>
				<input id="search_event112M_timeS" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser,prompt:'시작일 입력'" style="width:175px;">
				&nbsp;~ 
				<input id="search_event112M_timeE" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser,prompt:'종료일 입력'" style="width:175px;">
			</li>
			<!-- <li class="list">
				<a href="#" id="search_eventM_handle" class="eventM_button_list" onclick="search_eventM_handle()"></a>
			</li> -->
			<li class="list">
			    <select class="easyui-combobox" id="search_event112M_gbn" panelHeight="auto" style="width:80px;">
					<option value="0" selected>전체</option>
					<option value="1">발생</option>
					<option value="1">처리중</option>
					<option value="1">취소</option>
				</select>
			</li>
		</ul>
		
		<ul class="list_ty" style="height:calc(100% - 130px);">
			<div class="table_title">
				<em>조회결과</em>
				<!-- <span class="list_tot" id="search_eventM_tot" name="search_eventM_tot">0</span><label for="search_eventM_tot">건</label> -->
			</div>
			<table id="112eventM_table" class="easyui-datagrid" title="" style="width:100%;height:95%;"
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
