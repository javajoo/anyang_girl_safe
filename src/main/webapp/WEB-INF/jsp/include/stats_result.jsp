<!-- 통계 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="statsR_management" title="">
		<ul class="list_condi2">
			<li class="list">
				<select class="easyui-combobox" id="search_statsR_gbn"
					data-options="url: 'com/danusys/platform/selectCode.do?codeGroup=EVENT_TYPE&all=Y',method:'get'
					,valueField:'codeCd',textField:'codeNm',onChange:search_statsR" panelHeight="auto" style="width:150px">
				</select>
				<input id="search_statsR_year" class="easyui-datetimespinner" data-options="formatter:myformatter2,parser:myparser2,selections:[[0,4]],prompt:'년도 입력',onChange:search_statsR" style="width:175px;">
				
				<a href="#" id="search_statsR" class="statsR_button_list" onclick="search_statsR()"></a>
			</li>
		</ul>
		
		<ul class="list_ty" style="width:100%">
			<div class="table_title">
				<em>이벤트발생현황</em>
			</div>
			<table id="statsR_table" class="easyui-datagrid" title="" style="width:100%;height:95%" data-options="">
			   	<thead>
			       	<tr>
			       		<th data-options="field:'eventTitle',width:100,align:'center'">구분</th>
			       		<th data-options="field:'year',width:50,align:'center'">년도</th>
						<th data-options="field:'m1',width:50,align:'center'">1월</th>
						<th data-options="field:'m2',width:50,align:'center'">2월</th>
						<th data-options="field:'m3',width:50,align:'center'">3월</th>
						<th data-options="field:'m4',width:50,align:'center'">4월</th>
						<th data-options="field:'m5',width:50,align:'center'">5월</th>
						<th data-options="field:'m6',width:50,align:'center'">6월</th>
						<th data-options="field:'m7',width:50,align:'center'">7월</th>
						<th data-options="field:'m8',width:50,align:'center'">8월</th>
						<th data-options="field:'m9',width:50,align:'center'">9월</th>
						<th data-options="field:'m10',width:50,align:'center'">10월</th>
						<th data-options="field:'m11',width:50,align:'center'">11월</th>
						<th data-options="field:'m12',width:50,align:'center'">12월</th>
					</tr>
				</thead>
			</table>
		</ul>
	</div>
</div>

