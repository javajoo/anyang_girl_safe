<!-- 그룹별 권한레벨관리 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="cont_area">
	<div id="group4_management" title="" style="height:100%;">
		<h5>그룹관리</h5>
		<ul class="list_condi4">
			<li class="list">
				<p>그룹별 권한레벨관리</p>
			</li>
			<li class="list">
				<span>지구</span>
				<select class="easyui-combobox" id="search_group4_gbn" panelHeight="auto" style="width:243px;">
					<option value="" selected>전체</option>
					<option value="0">대전도안</option>
				</select>
				<span>그룹명</span>
				<input type="text" id="search_group4_name" class="easyui-textbox" style="width:200px;"/>
				<a href="#" id="search_group4" class="setting_button_list" onclick="search_group4()"></a>
			</li>
			
			<li class="list">
				<span>이벤트</span>
			</li>
		</ul>
		
		<ul class="list_ty" style="height:30%;margin-top: 90px;">
			<table id="group4_table_grp" class="easyui-datagrid" title="" style="width:50%;height:95%;"
				data-options="rownumbers:true">
			   	<thead>
			       	<tr>
			       		 <th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'group4_nm',width:100,align:'center'">그룹명</th>
						<th data-options="field:'group4_zone',width:100,align:'center'">지구명</th>
						<th data-options="field:'seqNo',hidden:true">관리번호</th>
					</tr>
				</thead>
			</table>
			
			<table id="group4_table_evnt" class="easyui-datagrid" title="" style="width:50%;height:95%;"
				data-options="rownumbers:true">
			   	<thead>
			       	<tr>
			       		 <th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'group4_lev',width:100,align:'center'">권한레벨</th>
						<th data-options="field:'group4_lev_nm',width:100,align:'center'">권한레벨명</th>
						<th data-options="field:'group4_up_lev',width:100,align:'center'">상위권한레벨</th>
						<th data-options="field:'seqNo',hidden:true">관리번호</th>
					</tr>
				</thead>
			</table>
		</ul>
		<ul class="list_condi3">
			<li class="list">
				<a href="#" id="del_evnt_group4" class="setting_button_del" onclick="del_evnt_group4()"></a>
				<a href="#" id="add_evnt_group4" class="setting_button_add" onclick="add_evnt_group4()"></a>
			</li>
		</ul>
		
	</div>
</div>
