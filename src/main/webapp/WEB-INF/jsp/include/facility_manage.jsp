<!-- 시설물관리 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="facilityM_management" title="" style="height:100%;">
		<ul class="list_condi">
			<li class="list">
				<select class="easyui-combobox" id="search_facilityM_gbn1" panelHeight="auto" style="width:130px; margin-right: 2px;">
					<option value="" selected>시설물 종류(전체)</option>
					<option value="CCTV">카메라</option>
					<option value="SENSOR">환경센서</option>
					<option value="CENTER">센터</option>
				</select>
				<select class="easyui-combobox" id="search_facilityM_gbn2" panelHeight="auto" style="width:130px; margin-right: 2px;">
					<option value="0" selected>시설물 용도(전체)</option>
				</select>
				<select class="easyui-combobox" id="search_facilityM_gbn3" panelHeight="auto" style="width:130px;">
					<option value="0" selected>시설물 상태(전체)</option>
				</select>
				<!-- <select class="easyui-combobox" id="search_facilityM_gbn" panelHeight="auto" style="width:100px;">
					<option value="" selected>전체</option>
					<option value="CCTV">카메라</option>
					<option value="SENSOR">환경센서</option>
					<option value="CENTER">센터</option>
				</select> -->
			</li>
			<li class="list">
				<select class="easyui-combobox" id="search_facilityM_gbn4" panelHeight="auto" style="width:130px;">
					<option value="0" selected>경찰 지구대(전체)</option>
				</select>
				<input type="checkbox" id="search_facilityM_chk1" name="search_facilityM_chk1" style="margin: 1px 2px 3px 5px;"/>
				<label for="search_facilityM_chk1">관할지구누락포함</label>
				<input type="checkbox" id="search_facilityM_chk2" name="search_facilityM_chk2" style="margin: 1px 2px 3px 5px;"/>
				<label for="search_facilityM_chk2">차량번호인식CCTV만표출</label>
			</li>
			<li class="list">
				<input type="checkbox" id="search_facilityM_chk3" name="search_facilityM_chk3" style="margin: 1px 2px 3px 5px;"/>
				<label for="search_facilityM_chk3">결과 지도에 반영</label>
				<input type="text" id="search_castingN_tot" style="width:230px;" placeholder="시설물명|주소|관리번호를 입력하세요."/>
				
				<a href="#" id="search_facilityM" class="facilityM_button_list" onclick="search_facilityM()"></a>
			</li>
		</ul>
		
		<ul class="list_ty" style="height:calc(100% - 230px);">
			<div class="table_title">
				<em>조회결과</em>
			</div>
			<table id="facilityM_table" class="easyui-datagrid" title="" style="width:100%;height:95%"
			data-options="pagination:true,pageSize:15,onClickRow:selectEeventMGIS,onDblClickRow:selectFacilityMRow">
			   	<thead>
			       	<tr>
						<th data-options="field:'cctvNm',width:150,align:'center'">시설물명</th>
						<th data-options="field:'facilityType',width:80,align:'center'">종류</th>
						<th data-options="field:'purposeNm',width:80,align:'center'">용도</th>
						<th data-options="field:'state',width:80,align:'center'">상태</th>
						<th data-options="field:'seqNo',hidden:true">시설물ID</th>
						<th data-options="field:'purpose',hidden:true">용도코드</th>
						<th data-options="field:'nodeId',hidden:true">노드아이디</th>
						<th data-options="field:'longitude',hidden:true">경도</th>
						<th data-options="field:'latitude',hidden:true">위도</th>
						<th data-options="field:'nodeIp',hidden:true">IP</th>
						<th data-options="field:'nodePort',hidden:true">PORT</th>
						<th data-options="field:'mngCd',hidden:true">관리번호</th>
						<th data-options="field:'facilityCenterGbn',hidden:true">센터_구분</th>
						<th data-options="field:'facilityCenterPlace',hidden:true">센터_장소</th>
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
	
	<div id="facilityM_dtl_management" title="" style="height:100%;">
		<ul class="list_condi2">
			<li class="list">
				<a href="#" id="inst_facility" class="setting_button_inst" onclick="inst_facility()"></a>
				<a href="#" id="modify_facility" class="setting_button_modify" onclick="modify_facility()"></a>
				<a href="#" id="del_facility" class="setting_button_del2" onclick="del_facility()"></a>
				<a href="#" id="back_facility" class="setting_button_back" onclick="back_facility()"></a>
			</li>
		</ul>
		
		<ul class="list_ty" style="height:calc(100% - 90px);overflow: auto;overflow-x: hidden;">
			<table id="facilityM_dtl_table_1" class="facility_dtl">
		        <tr>
					<td class="pop_body_title_text">*시설물ID</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_id' disabled>
					</td>
					
					<td class="pop_body_title_text">센터코드</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_center_cd' value='강서구센터'>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">*시설물명</td>
					<td class="pop_body_title_value" colspan="5">
						<input type='text' style="width:350px;" id='facility_nm'>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">*종류</td>
					<td class="pop_body_title_value">
						<select class="easyui-combobox" id="facility_type" panelHeight="auto" style="width:80px;"
								data-options="onSelect: select_facility_type">
							<option value="CCTV" selected>CCTV</option>
							<option value="SENSOR">SENSOR</option>
							<option value="CENTER">CENTER</option>
						</select>
					</td>
					
					<td class="pop_body_title_text facility_hidden">*용도</td>
					<td class="pop_body_title_value facility_hidden">
						<select class="easyui-combobox" id="facility_propos"
						data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=CCTV',method:'get'
						,valueField:'codeCd',textField:'codeNm'" panelHeight="auto" style="width:100px"></select>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">*관리번호</td>
					<td class="pop_body_title_value" colspan="5">
						<input type='text' style="width:350px;" id='facility_mng_cd'>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">서비스명</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_service_nm'>
					</td>
					<td class="pop_body_title_text">지구</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_zone' value='강서구'>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">시군구</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_si' value='부산시'>
					</td>
					<td class="pop_body_title_text">경찰지구대</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_police_zone'>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">설치장소</td>
					<td class="pop_body_title_value" colspan="5">
						<input type='text' style="width:350px;" id='facility_addres'>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">*좌표X</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_lon' value='0'>
					</td>
					<td class="pop_body_title_text">*좌표Y</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_lat' value='0'>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">*카메라정보</td>
					<td class="pop_body_title_value" colspan="5">
						<table>
							<tr>
								<td class="pop_body_title_text" style="font-size: 11px;">노드ID</td>
								<td class="pop_body_title_value">
									<input type='text' size='8' id='facility_node_id'>
								</td>
								<td class="pop_body_title_text" style="font-size: 11px;">노드IP</td>
								<td class="pop_body_title_value">
									<input type='text' size='8' id='facility_node_ip'>
								</td>
								<td class="pop_body_title_text" style="font-size: 11px; width: 175px;">노드port</td>
								<td class="pop_body_title_value">
									<input type='text' size='6' id='facility_node_port'>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">완제품구분</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_compl' value='완제품'>
					</td>
					<td class="pop_body_title_text">고유식별번호</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_identi'>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">사용유형</td>
					<td class="pop_body_title_value">
						<select class="easyui-combobox" id="facility_use" panelHeight="auto" style="width:80px;">
							<option value="1" selected>사용</option>
							<option value="2">미사용</option>
						</select>
					</td>
					<td class="pop_body_title_text">기능별유형</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_func_type' value='회전형'>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">대표상태</td>
					<td class="pop_body_title_value">
						<select class="easyui-combobox" id="facility_pre_state" panelHeight="auto" style="width:80px;">
							<option value="1" selected>정상</option>
							<option value="2">비정상</option>
						</select>
					</td>
					<td class="pop_body_title_text">고유식별번호</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_pre_id'>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">센터번호</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_center_tel'>
					</td>
					<td class="pop_body_title_text">비상벨번호</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_bell_nm'>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">물품구분</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_goods_gbn' value='주차시설물'>
					</td>
					<td class="pop_body_title_text">관리자연락처</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_mng_tel'>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">*접속IP</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_acpt_ip'>
					</td>
					<td class="pop_body_title_text">*접속포트</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_acpt_port'>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">*접속ID</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_acpt_id'>
					</td>
					<td class="pop_body_title_text">*접속비밀번호</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_acpt_pw'>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">*카메라 URL</td>
					<td class="pop_body_title_value" colspan="5">
						<input type='text' style="width: 350px;" id='facility_rtsp_url'>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">시설물MAC주소</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_mac'>
					</td>
					<td class="pop_body_title_text">G/W</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_gw'>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">SUBNET</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_subnet'>
					</td>
					<td class="pop_body_title_text">설치일</td>
					<td class="pop_body_title_value">
						<input class="easyui-datebox" style="width:105px;" id='facility_inst_de' data-options="formatter:myformatter_time,parser:myparser_time,prompt:'입력일자'">
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">서버IP</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_server_ip'>
					</td>
					<td class="pop_body_title_text">서버포트</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_server_port'>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">서버접속ID</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_server_id'>
					</td>
					<td class="pop_body_title_text">서버접속비밀번호</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_server_pw'>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">장치확인IP</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_device_ip'>
					</td>
					<td class="pop_body_title_text">장치확인포트</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_device_port'>
					</td>
				</tr>
				<tr>
					<td class="pop_body_title_text">장치확인ID</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_device_id'>
					</td>
					<td class="pop_body_title_text">장치확인비밀번호</td>
					<td class="pop_body_title_value">
						<input type='text' style="width:105px;" id='facility_device_pw'>
					</td>
				</tr>
				<!-- <tr>
					<td class="pop_body_title_text">입력일자</td>
					<td class="pop_body_title_value" colspan="3">
						<input class="easyui-datebox" style="width:243px;" id='facility_inst_de' data-options="formatter:myformatter_time,parser:myparser_time,prompt:'입력일자'" disabled>
					</td>
				</tr>
				
				<tr>
					<td class="pop_body_title_text">수정일자</td>
					<td class="pop_body_title_value" colspan="3">
						<input class="easyui-datebox" style="width:243px;" id='facility_upd_de' data-options="formatter:myformatter_time,parser:myparser_time,prompt:'수정일자'" disabled>
					</td>
				</tr> -->
				
		    </table>
		</ul>
		
	    
	    <!-- <table id="facilityM_dtl_table_2" class="facility_dtl">
	        <tr>
				<td class="pop_body_title_text">시설물ID</td>
				<td class="pop_body_title_value">
					<input type='text' style="width:100px;" id='facility_center_id' disabled>
				</td>
				
				<td class="pop_body_title_text">종류</td>
				<td class="pop_body_title_value">
					<select class="easyui-combobox" id="facility_center_type" panelHeight="auto" style="width:100px;"
							data-options="onSelect: select_facility_type">
						<option value="CCTV" selected>CCTV</option>
						<option value="SENSOR">SENSOR</option>
						<option value="CENTER">CENTER</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="pop_body_title_text">구분</td>
				<td class="pop_body_title_value">
					<select class="easyui-combobox" id="facility_center_gbn"
					data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=CENTER_GBN',method:'get'
					,valueField:'codeCd',textField:'codeNm'
					,onSelect: select_facility_center_gbn"
					panelHeight="auto" style="width:100px"></select>
				</td>
				
				<td class="pop_body_title_text">용도</td>
				<td class="pop_body_title_value">
					<select class="easyui-combobox" id="facility_center_propos"
					data-options="valueField:'codeCd',textField:'codeNm'" panelHeight="auto" style="width:100px"></select>
				</td>
			</tr>
			<tr>
				<td class="pop_body_title_text">시설물명</td>
				<td class="pop_body_title_value" colspan="5">
					<input type='text' style="width:401px;" id='facility_center_nm'>
				</td>
			</tr>
			
			<tr>
				<td class="pop_body_title_text">장소</td>
				<td class="pop_body_title_value" colspan="5">
					<input type='text' style="width:401px;" id='facility_center_place'>
				</td>
			</tr>
			<tr>
				<td class="pop_body_title_text">입력일자</td>
				<td class="pop_body_title_value" colspan="3">
					<input class="easyui-datebox" style="width:243px;" id='facility_inst_de' data-options="formatter:myformatter_time,parser:myparser_time,prompt:'입력일자'" disabled>
				</td>
			</tr>
			
			<tr>
				<td class="pop_body_title_text">수정일자</td>
				<td class="pop_body_title_value" colspan="3">
					<input class="easyui-datebox" style="width:243px;" id='facility_upd_de' data-options="formatter:myformatter_time,parser:myparser_time,prompt:'수정일자'" disabled>
				</td>
			</tr>
			
	    </table> -->
	</div>
</div>

