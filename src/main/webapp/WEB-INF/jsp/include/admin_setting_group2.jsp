<!-- 그룹별 이벤트(사용자권한) -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="cont_area">
	<div id="group2_management" title="" style="height:100%;">
		<h5>그룹관리</h5>
		<ul class="list_condi4">
			<li class="list">
				<p>그룹별 이벤트</p>
			</li>
			<li class="list">
				<span>지구</span>
				<select class="easyui-combobox" id="search_group2_gbn" panelHeight="auto" style="width:243px;">
					<option value="" selected>전체</option>
					<option value="0">대전도안</option>
				</select>
				<span>그룹명</span>
				<input type="text" id="search_group2_name" class="easyui-textbox" style="width:200px;"/>
				<a href="#" id="search_group2" class="setting_button_list" onclick="search_group2()"></a>
			</li>
			
			<li class="list">
				<span>이벤트</span>
			</li>
		</ul>
		
		<ul class="list_ty" style="height:30%;margin-top: 90px;">
			<table id="group2_table_grp" class="easyui-datagrid" title="" style="width:50%;height:95%;"
				data-options="rownumbers:true">
			   	<thead>
			       	<tr>
			       		 <th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'group2_code',width:100,align:'center'">코드</th>
						<th data-options="field:'group2_nm',width:100,align:'center'">그룹명</th>
						<th data-options="field:'group2_zone',width:100,align:'center'">지구명</th>
						<th data-options="field:'seqNo',hidden:true">관리번호</th>
					</tr>
				</thead>
			</table>
			
			<table id="group2_table_evnt" class="easyui-datagrid" title="" style="width:50%;height:95%;"
				data-options="rownumbers:true">
			   	<thead>
			       	<tr>
			       		 <th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'group2_evnt_id',width:100,align:'center'">아이디</th>
						<th data-options="field:'group2_evnt_nm',width:100,align:'center'">이벤트</th>
						<th data-options="field:'group2_evnt_sys',width:100,align:'center'">시스템</th>
						<th data-options="field:'group2_evnt_grp',width:100,align:'center'">서비스그룹</th>
						<th data-options="field:'seqNo',hidden:true">관리번호</th>
					</tr>
				</thead>
			</table>
		</ul>
		<ul class="list_condi3">
			<li class="list">
				<a href="#" id="del_evnt_group2" class="setting_button_del" onclick="del_evnt_group2()"></a>
				<a href="#" id="add_evnt_group2" class="setting_button_add" onclick="add_evnt_group2()"></a>
			</li>
		</ul>
		
		<ul class="list_condi5">
			<li class="list">
				<span>사용자권한레벨[시스템>연기발생(영상분석)]</span>
			</li>
			<li class="list">
				<span>모바일기기권한레벨[시스템>연기발생(영상분석)]</span>
			</li>
		</ul>
		<ul class="list_ty" style="height:29%;margin-top: 90px;">
			<table id="group2_table_lev1" class="easyui-datagrid" title="" style="width:50%;height:95%;"
				data-options="rownumbers:true">
			   	<thead>
			       	<tr>
			       		 <th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'group2_lev1_id',width:100,align:'center'">아이디</th>
						<th data-options="field:'group2_lev1_user',width:100,align:'center'">사용자</th>
						<th data-options="field:'group2_lev1_auth_lev',width:100,align:'center'">권한레벨</th>
						<th data-options="field:'group1_lev1_use_lev',width:100,align:'center'">사용레벨</th>
						<th data-options="field:'seqNo',hidden:true">관리번호</th>
					</tr>
				</thead>
			</table>
			
			<table id="group2_table_lev2" class="easyui-datagrid" title="" style="width:50%;height:95%;"
				data-options="rownumbers:true">
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
		<ul class="list_condi3_half">
			<li class="list">
				<a href="#" id="del_lev1_group2" class="setting_button_del" onclick="del_lev1_group2()"></a>
				<a href="#" id="save_lev1_group2" class="setting_button_save" onclick="save_lev1_group2()"></a>
				<a href="#" id="add_lev1_group2" class="setting_button_add" onclick="add_lev1_group2()"></a>
			</li>
		</ul>
		<ul class="list_condi3_half">
			<li class="list">
				<a href="#" id="del_lev2_group2" class="setting_button_del" onclick="del_lev2_group2()"></a>
				<a href="#" id="save_lev2_group2" class="setting_button_save" onclick="save_lev2_group2()"></a>
				<a href="#" id="add_lev2_group2" class="setting_button_add" onclick="add_lev2_group2()"></a>
			</li>
		</ul>
		
	</div>
</div>
