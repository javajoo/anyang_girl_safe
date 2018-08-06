<!-- 선택감시 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="selectM_management" title="" style="height:100%;">
		<ul class="list_condi">
			<li class="list">
				<select class="easyui-combobox" id="search_selectM_gbn2" panelHeight="auto" style="width:130px; margin-right: 2px;">
					<option value="0" selected>시설물 용도(전체)</option>
				</select>
				<select class="easyui-combobox" id="search_selectM_gbn3" panelHeight="auto" style="width:130px;">
					<option value="0" selected>시설물 상태(전체)</option>
				</select>
				<select class="easyui-combobox" id="search_selectM_gbn4" panelHeight="auto" style="width:130px;">
					<option value="0" selected>경찰 지구대(전체)</option>
				</select>
				<!-- <select class="easyui-combobox" id="search_facilityM_gbn" panelHeight="auto" style="width:100px;">
					<option value="" selected>전체</option>
					<option value="CCTV">카메라</option>
					<option value="SENSOR">환경센서</option>
					<option value="CENTER">센터</option>
				</select> -->
			</li>
			<li class="list">
				<input type="checkbox" id="search_selectM_chk1" name="search_selectM_chk1" style="margin: 1px 2px 3px 5px;"/>
				<label for="search_selectM_chk1">관할지구누락포함</label>
				<input type="checkbox" id="search_selectM_chk2" name="search_selectM_chk2" style="margin: 1px 2px 3px 5px;"/>
				<label for="search_selectM_chk2">차량번호인식CCTV만표출</label>
			</li>
			<li class="list">
				<input type="checkbox" id="search_selectM_chk3" name="search_selectM_chk3" style="margin: 1px 2px 3px 5px;"/>
				<label for="search_selectM_chk3">결과 지도에 반영</label>
				<input type="text" id="search_castingN_tot" style="width:230px;" placeholder="시설물명|주소|관리번호를 입력하세요."/>
				
				<a href="#" id="search_selectM" class="selectM_button_list" onclick="fcltUsedTyList()"></a>
			</li>
		</ul>
		
		<ul class="list_ty" style="height:calc(100% - 230px);">
			<div class="table_title">
				<em>조회결과</em>
			</div>
			<table id="selectM_table" class="easyui-datagrid" title="" style="width:100%;height:95%"
			data-options="pagination:true,pageSize:15,onClickRow:selectEeventMGIS,onDblClickRow:selectMRow">
			   	<thead>
			       	<tr>
						<th data-options="field:'cctvNm',width:150,align:'center'">시설물명</th>
						<th data-options="field:'facilityGbn',width:80,align:'center'">종류</th>
						<th data-options="field:'purpose',width:80,align:'center'">용도</th>
						<th data-options="field:'state',width:80,align:'center'">상태</th>
						<th data-options="field:'seqNo',hidden:true">관리번호</th>
						<th data-options="field:'nodeId',hidden:true">노드아이디</th>
						<th data-options="field:'longitude',hidden:true">경도</th>
						<th data-options="field:'latitude',hidden:true">위도</th>
						<th data-options="field:'nodeIp',hidden:true">IP</th>
						<th data-options="field:'nodePort',hidden:true">PORT</th>
					</tr>
				</thead>
			</table>
		</ul>
		
		<ul class="list_condi2">
			<li class="list">
				<a href="#" id="add_facility" class="setting_button_add2" onclick="add_facility()"></a>
				<a href="#" id="excel_upd_facility" class="setting_button_excel_upd" onclick="excel_upd_facility()"></a>
				<a href="#" id="excel_down_facility" class="setting_button_excel_down" onclick="excel_down_facility()"></a>
				<a href="#" id="dtl_facility" class="setting_button_dtl" onclick="dtl_facility()"></a>
			</li>
		</ul>
	</div>
	
	<!-- <div id="facilityM_dtl_management" title="" style="height:100%;">
		<ul class="list_condi2">
			<li class="list">
				<a href="#" id="modify_facility" class="setting_button_modify" onclick="modify_facility()"></a>
				<a href="#" id="del_facility" class="setting_button_del2" onclick="del_facility()"></a>
				<a href="#" id="back_facility" class="setting_button_back" onclick="back_facility()"></a>
			</li>
		</ul>
		
		<table id="facilityM_dtl_table" class="facility_dtl">
	        <tr>
				<td class="pop_body_title_text">시설물ID</td>
				<td class="pop_body_title_value">
					<input type='text' style="width:130px;" id='facility_id'>
				</td>
				
				<td class="pop_body_title_text">용도</td>
				<td class="pop_body_title_value">
					<select class="easyui-combobox" id="facility_propos"
					data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=CCTV',method:'get'
					,valueField:'codeCd',textField:'codeNm'" panelHeight="auto" style="width:130px"></select>
					<select class="easyui-combobox" id="pop_rating" panelHeight="auto" style="width:243px;">
						<option value="1" selected>긴급</option>
						<option value="2">일반</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="pop_body_title_text">발생일시</td>
				<td class="pop_body_title_value">
					<input class="easyui-datebox" style="width:243px;" id='pop_dateS' data-options="formatter:myformatter_time,parser:myparser_time,prompt:'발생일시'">
				</td>
				<td class="pop_body_title_text">종료일시</td>
				<td class="pop_body_title_value">
					<input class="easyui-datebox" style="width:243px;" id='pop_dateE' data-options="formatter:myformatter_time,parser:myparser_time,prompt:'종료일시'">
				</td>
			</tr>
			<tr>
				<td class="pop_body_title_text">발생장소</td>
				<td class="pop_body_title_value" colspan="3">
					<p style="font-size: 12px;float: left;margin-right: 2px;">부산시 강서구 </p><input type='text' style="width:561px;" id='pop_place' placeholder='주소 직접입력'>
				</td>
			</tr>
			<tr>
				<td class="pop_body_title_text">시설물명</td>
				<td class="pop_body_title_value" colspan="3">
					<input type='text' style="width:130px;" id='facility_nm'>
				</td>
			</tr>
			<tr>
				<td class="pop_body_title_text">발생위치</td>
				<td class="pop_body_title_value" colspan="3">
					<table>
						<tr>
							<td class="pop_body_title_text">경도</td>
							<td class="pop_body_title_value">
								<input type='text' size='10' id='facility_lon'>
							</td>
							<td class="pop_body_title_text">위도</td>
							<td class="pop_body_title_value">
								<input type='text' size='10' id='facility_lat'>
							</td>
							<td class="pop_body_title_text">고도</td>
							<td class="pop_body_title_value">
								<input type='text' size='10' id='facility_alt'>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="pop_body_title_text">접수유형</td>
				<td class="pop_body_title_value">
					<select class="easyui-combobox" id="pop_accept_type"
					data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=ACCEPT_TYPE',method:'get'
					,valueField:'codeCd',textField:'codeNm'" panelHeight="auto" style="width:243px"></select>
				</td>
				<td class="pop_body_title_text">신고자</td>
				<td class="pop_body_title_value">
					<input type='text' style="width:239px;" id='pop_info_nm'>
				</td>
			</tr>
			<tr>
				<td class="pop_body_title_text">신고/접수번호</td>
				<td class="pop_body_title_value">
					<input type='text' style="width: 241px;-webkit-logical-width: 239px;" id='pop_event_no'>
				</td>
				<td class="pop_body_title_text">지구명</td>
				<td class="pop_body_title_value">
					<input type='text' style="width:239px;" id='pop_zone'>
				</td>
			</tr>
	    </table>
		
	</div> -->
</div>

