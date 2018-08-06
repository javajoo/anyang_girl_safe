<!-- 순환감시 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="cycleM_management" title="" style="height:100%;">
		<ul class="list_condi">
			<li class="list">
			    <input type="checkbox" id="cycle_M_chk1" name="cycle_M_chk1" />
				<em>순환여부/순환시간</em>
				
				<select class="easyui-combobox" id="cycle_M_gbn1" panelHeight="auto" style="width:60px; margin-right: 2px;">
					<option value="0" selected>15초</option>
					<option value="1">30초</option>
					<option value="2">45초</option>
					<option value="2">60초</option>
				</select>
			
				<select class="easyui-combobox" id="cycle_M_gbn_gbn2" panelHeight="auto" style="width:80px;">
					<option value="0" selected>감시지역</option>
					<option value="1">담당자</option>
				</select>
				<input type="text" id="search_castingN_tot" style="width:130px;" > <!-- placeholder="시설물명|주소|관리번호를 입력하세요."/> -->
				<a href="#" id="search_cycleN" class="cycleN_button_list" ></a>
			</li>
		</ul>
		
		<ul class="list_ty" style="height:calc(100% - 100px);">
			<div class="table_title">
				<em>조회결과</em>
			</div>
			<table id="cycleM_table" class="easyui-datagrid" title="" style="width:100%;height:95%"
			data-options="pagination:true,pageSize:0,onClickRow:selectEeventMGIS,onDblClickRow:selectFacilityMRow">
			   	<thead>
			       	<tr>
						<th data-options="field:'cycleNm',width:70,align:'center'">번호</th>
						<th data-options="field:'cycleGbn',width:80,align:'center'">감시지역</th>
						<th data-options="field:'cycleUser',width:80,align:'center'">담당자</th>
						<th data-options="field:'cycleExp',width:80,align:'center'">설명</th>
						<th data-options="field:'cycleGIS',width:70,align:'center'">지도</th>
					</tr>
				</thead>
			</table>
		</ul>
	</div>
	
</div>

