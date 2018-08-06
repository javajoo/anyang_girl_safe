<!-- 이벤트히스토리 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="iotH_management" title="" style="height:100%;">
		<ul class="list_condi">
			<li class="list">
				<input id="search_iotH_timeS" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser,prompt:'시작일 입력'" style="width:175px;">
				&nbsp;~ 
				<input id="search_iotH_timeE" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser,prompt:'종료일 입력'" style="width:175px;">
			</li>
			<li class="list">
				<em class="list_em">유형</em>
				<select id="search_iotH_gbn" class="easyui-combobox" style="width:100px;">
					<option value="0">전체</option>
					<option value="1">악취농도</option>
					<option value="2">온도</option>
					<option value="3">습도</option>
					<option value="4">풍속</option>
				</select>
				<em class="list_em">시설물명</em>
				<input type="text" id="search_iotH_nm" class="easyui-textbox" style="width:200px;"/>
				
				<a href="#" id="search_iotH" class="iotH_button_list" onclick="search_iotH()"></a>
			</li>
		</ul>
		
		<ul class="list_ty" style="height:calc(100% - 129px);">
			<div class="table_title">
				<em>조회결과</em>
			</div>
			<table id="iotH_table" class="easyui-datagrid" title="" style="width:100%;height:96%"
			data-options="pagination:true,pageSize:13,rownumbers:true,sortable:true,remoteSort:false
			,onClickRow:selectIoTH">
			   	<thead>
			       	<tr>
						<th data-options="field:'date',width:120,align:'center',sortable:true">날짜/시간</th>
						<th data-options="field:'name',width:100,align:'center'">시설물명</th>
						<th data-options="field:'typeNm',width:70,align:'center'">유형</th>
						<th data-options="field:'value',width:100,align:'center'">수치</th>
						<th data-options="field:'longitude',hidden:true">경도</th>
						<th data-options="field:'latitude',hidden:true">위도</th>
						<th data-options="field:'thresholdLo',hidden:true">상한임계치</th>
						<th data-options="field:'thresholdHi',hidden:true">상한임계치</th>
						<th data-options="field:'unit',hidden:true">단위</th>
					</tr>
				</thead>
			</table>
		</ul>
	</div>
</div>

