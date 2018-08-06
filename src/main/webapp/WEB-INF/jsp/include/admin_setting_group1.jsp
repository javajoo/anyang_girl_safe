<!-- 그룹관리 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="cont_area">
	<div id="group1_management" title="" style="height:100%;">
		<h5>그룹관리</h5>
		<ul class="list_condi2">
			<li class="list">
				<p>그룹관리</p>
			</li>
			<li class="list">
				<span>그룹아이디</span>
				<input type="text" id="search_group1_id" class="easyui-textbox" style="width:200px;"/>
				<span>그룹명</span>
				<input type="text" id="search_group1_name" class="easyui-textbox" style="width:200px;"/>
				<span>사용유형</span>
				<select class="easyui-combobox" id="search_group1_gbn" panelHeight="auto" style="width:243px;">
					<option value="1" selected>사용</option>
					<option value="0">미사용</option>
				</select>
				<a href="#" id="search_group1" class="setting_button_list" onclick="search_group1()"></a>
			</li>
		</ul>
		
		<ul class="list_ty" style="height:calc(100% - 250px);margin-top: 90px;">
			<div class="table_title">
				<em>조회결과</em>
			</div>
			<table id="group1_table" class="easyui-datagrid" title="" style="width:100%;height:95%;"
				data-options="rownumbers:true,pagination:true,pageSize:15">
			   	<thead>
			       	<tr>
			       		 <th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'group1_id',width:100,align:'center'">그룹아이디</th>
						<th data-options="field:'group1_nm',width:100,align:'center'">그룹이름</th>
						<th data-options="field:'group1_expl',width:150,align:'center'">그룹설명</th>
						<th data-options="field:'group1_zone',width:100,align:'center'">소속지구명</th>
						<th data-options="field:'group1_gbn',width:80,align:'center'">사용유형</th>
						<th data-options="field:'seqNo',hidden:true">관리번호</th>
					</tr>
				</thead>
			</table>
		</ul>
		
		<ul class="list_condi3">
			<li class="list">
				<a href="#" id="add_group1" class="setting_button_add" onclick="add_group1()"></a>
				<a href="#" id="del_group1" class="setting_button_del" onclick="del_group1()"></a>
			</li>
		</ul>
	</div>
</div>
