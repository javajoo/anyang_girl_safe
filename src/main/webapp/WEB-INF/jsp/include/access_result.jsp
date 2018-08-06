<!-- 접속이력조회 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="accessR_management" title="" style="height:99%; width: 50%;border: 1px solid #e0e0e0;margin: 2px;float: left;">
		<ul class="list_condi2">
			<li class="list">
				<input type="text" id="search_accessR_tot" class="easyui-textbox" style="width:142px;"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input id="search_accessR_timeS" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser,prompt:'시작일 입력'" style="width:175px;">
				&nbsp;~ 
				<input id="search_accessR_timeE" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser,prompt:'종료일 입력'" style="width:175px;">
				
				<a href="#" id="search_accessR" class="accessR_button_list" onclick="search_accessR()"></a>
			</li>
		</ul>
		
		<ul class="list_ty" style="height:calc(100% - 85px);">
			<div class="table_title">
				<em>조회결과</em>
				<!-- <span class="list_tot" id="search_accessR_tot" name="search_accessR_tot">0</span><label for="search_accessR_tot" style="">건</label> -->
			</div>
			<table id="accessR_table" class="easyui-datagrid" title="" style="width: 100%;height:95%"
			data-options="pagination:true,pageSize:15,onClickRow:selectAccessR">
			   	<thead>
			       	<tr>
						<th data-options="field:'adminNm',width:130,align:'center'">이름</th>
						<th data-options="field:'adminId',width:140,align:'center'">아이디</th>
						<th data-options="field:'login',width:140,align:'center'">로그인</th>
						<th data-options="field:'logout',width:140,align:'center'">로그아웃</th>
						<th data-options="field:'dtlCnt',width:70,align:'center'">이력내역수</th>
						<th data-options="field:'sessionId',hidden:true"></th>
					</tr>
				</thead>
			</table>
			<a href="#" id="accessR_excel" class="accessR_button_excel" onclick="accessR_excel()"></a>
		</ul>
	</div>
	<div id="accessR_management2" title="접속이력 상세내역" style="height:99%; width: 48%;border: 1px solid #e0e0e0;margin: 2px 10px;float: left;">
		<div class="dtl_title2"><em>상세내역</em></div>
		<table id="" class="accessR_table_dtl">
			<tr>
				<td class="body_title_text">이름</td>
				<td class="body_title_value">
					<input type='text' style="width:223px;padding-left:20px;" id='dtl_nm' disabled>
				</td>
				<td class="body_title_text">권한등급</td>
				<td class="body_title_value">
					<input type='text' style="width:223px;padding-left:20px;" id='dtl_role' disabled>
				</td>
			</tr>
			<tr>
				<td class="body_title_text">로그인</td>
				<td class="body_title_value">
					<input type='text' style="width:223px;padding-left:20px;" id='dtl_login' disabled>
				</td>
				<td class="body_title_text">로그아웃</td>
				<td class="body_title_value">
					<input type='text' style="width:223px;padding-left:20px;" id='dtl_logout' disabled>
				</td>
			</tr>
		</table>
		<ul class="list_ty" style="height:calc(100% - 145px);">
			<table id="accessR_dtl_table" class="easyui-datagrid" title="" style="width: 100%;height:98%;"
			data-options="pagination:true,pageSize:5">
			   	<thead>
			       	<tr>
			       		<th data-options="field:'typeNm',width:150,align:'center'">유형</th>
						<th data-options="field:'time1',width:200,align:'center'">시간1</th>
						<th data-options="field:'time2',width:200,align:'center'">시간2</th>
						<th data-options="field:'cctvNm',width:280,align:'center'">카메라명</th>
						<th data-options="field:'sessionId',hidden:true"></th>
					</tr>
				</thead>
			</table>
			<a href="#" id="accessR_dtl_excel" class="accessR_dtl_button_excel" onclick="accessR_dtl_excel()"></a>
		</ul>
	</div>
</div>
