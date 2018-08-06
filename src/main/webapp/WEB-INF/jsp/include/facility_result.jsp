<!-- 시설물현황조회 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="faciliyR_management" title="" style="height:99%; width: 97%;">
		<ul class="list_ty" style="">
			<div class="table_title" style="margin-left: 30px;">
				<em>전체</em>
			</div>
			<table id="faciliyR_tot_table" class="easyui-datagrid" title="" style="width:100%;height:100px">
			   	<thead>
			       	<tr>
			       		<th data-options="field:'facilityGbn',width:80,align:'center'">구분</th>
						<th data-options="field:'totCnt',width:100,align:'center'">수량합계</th>
						<th data-options="field:'normalCnt',width:100,align:'center'">정상건수</th>
						<th data-options="field:'errorCnt',width:100,align:'center'">고장건수</th>
						<th data-options="field:'unCnt',width:100,align:'center'">미측정건수</th>
					</tr>
				</thead>
			</table>
		</ul>
		
		<ul class="list_ty" style="width:100%;margin-top: 10px;">
			<div class="table_title" style="margin-left: 30px;">
				<em>종류별</em>
			</div>
			<table id="faciliyR_type_table" class="easyui-datagrid" title="" style="width:100%;height:200px">
			   	<thead>
			       	<tr>
			       		<th data-options="field:'facilityGbn',width:80,align:'center'">구분</th>
						<th data-options="field:'totCnt',width:150,align:'center'">수량합계</th>
						<th data-options="field:'normalCnt',width:150,align:'center'">정상건수</th>
						<th data-options="field:'errorCnt',width:150,align:'center'">고장건수</th>
						<th data-options="field:'unCnt',width:150,align:'center'">미측정건수</th>
					</tr>
				</thead>
			</table>
		</ul>
	</div>
</div>

