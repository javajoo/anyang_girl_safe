<!-- 이벤트내역 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="eventR_management" title="" style="height:100%;">
		<ul class="list_condi">
			<li class="list">
				<input type="text" id="search_eventR_tot" class="easyui-textbox" style="width:200px;"/>
				<a href="#" id="search_eventR" class="eventR_button_list" onclick="search_eventR()"></a>
			</li>
			<li class="list">
				<input id="search_eventR_timeS" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser,prompt:'시작일 입력'" style="width:175px;">
				&nbsp;~ 
				<input id="search_eventR_timeE" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser,prompt:'종료일 입력'" style="width:175px;">
			</li>
		</ul>
		
		<ul class="list_ty" style="height:calc(100% - 129px);">
			<div class="table_title">
				<em>조회결과</em>
				<!-- <span class="list_tot" id="search_eventR_tot" name="search_eventR_tot">0</span><label for="search_eventR_tot">건</label> -->
			</div>
			<table id="eventR_table" class="easyui-datagrid" title="" style="width:100%;height:95%"
			data-options="pagination:true,pageSize:15,onClickRow:selectEeventMGIS">
			   	<thead>
			       	<tr>
						<th data-options="field:'eventType',width:70,align:'center'">유형</th>
						<th data-options="field:'acceptCont',width:150,align:'center'">이벤트내역</th>
						<th data-options="field:'eventDe',width:85,align:'center'">발생일자</th>
						<th data-options="field:'stateNm',width:60,align:'center'">상태</th>
						<th data-options="field:'facilityId',width:70,align:'center'">시설물</th>
						<th data-options="field:'id',width:70,align:'center',hidden:true">아이디</th>
						<th data-options="field:'longitude',width:70,align:'left',hidden:true"></th>
						<th data-options="field:'latitude',width:70,align:'left',hidden:true"></th>
					</tr>
				</thead>
			</table>
		</ul>
	</div>
</div>


