<!-- 투망감시 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="castingN_management" title="" style="height:100%;">
		<ul class="list_condi">
			<li class="list">
				<input type="text" id="search_castingN_tot" class="easyui-textbox" style="width:200px;"/>
				<a href="#" id="search_castingN" class="castingN_button_list" onclick="search_castingN()"></a>
				<input type="checkbox" id="search_castingN_chk" name="search_castingN_chk" style="margin: 1px 2px 3px 65px;"/>
				<label for="search_castingN_chk">주소검색</label>
			</li>
		</ul>
		
		<ul class="list_ty" style="height:calc(100% - 87px);">
			<div class="table_title">
				<em>조회결과</em>
				<!-- <span class="list_tot" id="search_castingN_tot" name="search_castingN_tot">0</span><label for="search_castingN_tot">건</label> -->
			</div>
			<table id="castingN_table" class="easyui-datagrid" title="" style="width:100%;height:95%" pageList="[15,20,30]"
			data-options="pagination:true,pageSize:18,onClickRow:selectEeventMGIS,onDblClickRow:selectCastingNRow"><!--url:'/com/danusys/platform/selectFacilityList.do',method:'get',  -->
			   	<thead>
			       	<tr>
						<th data-options="field:'mngCd',width:150,align:'center'">관리번호</th>
						<th data-options="field:'purpose',width:80,align:'center'">용도</th>
						<th data-options="field:'cctvNm',width:250,align:'center'">시설물명</th>
						<th data-options="field:'nodeId',hidden:true">노드아이디</th>
						<th data-options="field:'longitude',hidden:true">경도</th>
						<th data-options="field:'latitude',hidden:true">위도</th>
						<th data-options="field:'nodeIp',hidden:true">IP</th>
						<th data-options="field:'nodePort',hidden:true">PORT</th>
					</tr>
				</thead>
			</table>
		</ul>
	</div>
</div>

