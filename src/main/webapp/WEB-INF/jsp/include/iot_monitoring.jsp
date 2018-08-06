<!-- 모니터링 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="iotM_management" title="" style="height:100%;">
		<ul class="list_condi">
			<li class="list">
				<em class="list_em">시설물명</em>
				<input type="text" id="search_iotM_nm" class="easyui-textbox" style="width:250px;"/>
				
	        	<a href="#" id="search_iotM" class="iotM_button_list" onclick="search_iotM()"></a>
			</li>
		</ul>
		
		<ul class="list_ty" style="height:calc(100% - 48px);">
			<table id="iotM_table" class="easyui-datagrid" style="width:100%;height:100%;"
				data-options="rownumbers:true,sortable:true,remoteSort:false,pagination:false
				,onClickRow:selectIoTM,onDblClickRow:selectIotMRow">
			   	<thead>
			       	<tr>
						<th data-options="field:'name',width:100,align:'center'">시설물명</th>
						<th data-options="field:'ou',width:120,align:'center',sortable:true">악취농도(OU/㎥)</th>
						<th data-options="field:'temperature',width:70,align:'center',sortable:true">온도(ºC)</th>
						<th data-options="field:'humidity',width:100,align:'center',sortable:true">습도(%)</th>
						<th data-options="field:'windspeed',width:80,align:'center',sortable:true">풍속(m/s)</th>
						<th data-options="field:'latitude',hidden:true">위도</th>
						<th data-options="field:'longitude',hidden:true">경도</th>
						<th data-options="field:'siteno',hidden:true">센서id</th>
						<th data-options="field:'ouLo',hidden:true">악취_하한</th>
						<th data-options="field:'ouHi',hidden:true">악취_상한</th>
						<th data-options="field:'temperatureLo',hidden:true">온도_하한</th>
						<th data-options="field:'temperatureHi',hidden:true">온도_상한</th>
						<th data-options="field:'humidityLo',hidden:true">습도_하한</th>
						<th data-options="field:'humidityHi',hidden:true">습도_상한</th>
						<th data-options="field:'windspeedLo',hidden:true">풍속_하한</th>
						<th data-options="field:'windspeedHi',hidden:true">풍속_상한</th>
						<th data-options="field:'nodeId',hidden:true">노드아이디</th>
						<th data-options="field:'nodeIp',hidden:true">IP</th>
						<th data-options="field:'nodePort',hidden:true">PORT</th>
					</tr>
				</thead>
			</table>
		</ul>
	</div>
</div>
