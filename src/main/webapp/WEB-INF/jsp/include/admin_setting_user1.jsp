<!-- 사용자관리 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.subnsub_title {
    padding: 15px 0 0 15px;
    background: url(/images/icons/subdivide.png) no-repeat left content-box;
    width: 200px;
    font-family: 'nanum-barun-gothic-regular';
 }
.subnsub_title em {
	padding-left: 20px;
}
a.btn {
	font-family: 'notokr-medium';
    display: inline-block;
    height: 32px;
    padding: 7px 20px 0;
    box-sizing: border-box;
    background-color: #2076a7;
    color: #ffffff;
    border-radius: 2px;
}
.boxtable { width: 100%; position: relative;z-index: 1;background: #eee; border-collapse: collapse; }
.boxtable td { border: 1px solid #e1e1e1;height: 25px; }
.width200 { width: 200px; }
.body_title_modify { background: #fff; }

#user_modify_view .boxtable input { height: 25px; }
</style>
<div class="cont_area">
	<div id="user1_management" title="" style="height:100%;">
		<h5>사용자관리</h5>
		<ul class="list_condi2">
			<li class="list">
				<p>사용자관리</p>
			</li>
			<li class="list">
				<span>아이디</span>
				<input type="text" id="search_user1_id" class="easyui-textbox" style="width:200px;"/>
				<span>이름</span>
				<input type="text" id="search_user1_name" class="easyui-textbox" style="width:200px;"/>
				<span>사용유형</span>
				<select class="easyui-combobox" id="search_user1_gbn" panelHeight="auto" style="width:243px;">
					<option value="1" selected>사용</option>
					<option value="0">미사용</option>
				</select>
				<a href="#" id="search_user1" class="setting_button_list" onclick="search_user1()"></a>
			</li>
		</ul>
		
		<ul class="list_ty" style="height:calc(100% - 250px);margin-top: 90px;">
			<div class="table_title">
				<em>조회결과</em>
			</div>
			<table id="user1_table" class="easyui-datagrid" title="" style="width:100%;height:95%;"
				data-options="pagination:true,pageSize:11,onClickRow:selectUserDetail">
			   	<thead>
			       	<tr>
			       		<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'id',width:250,align:'center'">아이디</th>
						<th data-options="field:'name',width:250,align:'center'">이름</th>
						<th data-options="field:'userFlag',width:150,align:'center'">사용유형1</th>
						<th data-options="field:'authority',width:200,align:'center'">담당업무1</th>
						<th data-options="field:'seqNo',hidden:true">관리번호</th>
						<th data-options="field:'userNameEn',hidden:true">영문이름</th>
						<th data-options="field:'ipAdres',hidden:true">ip주소</th>
						<th data-options="field:'ipTyCd',hidden:true">ip체계구분</th>
						<th data-options="field:'ipCd',hidden:true">ip입력구분</th>
						<th data-options="field:'offcTelNo',hidden:true">사무실전화</th>
						<th data-options="field:'rankNm',hidden:true">직급명</th>
						<th data-options="field:'deptNm',hidden:true">부서명</th>
						<th data-options="field:'insttNm',hidden:true">기관명</th>
						<th data-options="field:'rpsbWork',hidden:true">담당업무</th>
						<th data-options="field:'remark',hidden:true">비고</th>
						<th data-options="field:'sessionId',hidden:true"></th>
					</tr>
				</thead>
			</table>
		</ul>
		
		<ul class="list_condi3">
			<li class="list">
				<a href="#" id="add_user1" class="setting_button_add" onclick="add_user1()"></a>
				<a href="#" id="del_user1" class="setting_button_del" onclick="del_user1()"></a>
			</li>
		</ul>
	</div>

	<div id="user_detail_view" class="easyui-dialog" title="사용자정보 상세" data-options="resizable:false,modal:true,closed:true" style="width:930px;height:760px;">
		<div class="subnsub_title"><em>사용자 상세</em></div>
		<ul style="padding: 10px;">
		<table class="boxtable">
			<tr>
				<td class="body_title_text">아이디</td>
				<td class="body_title_value">
					<input type='text' style="width:133px;padding-left:20px;" id='user_id' disabled>
				</td>
				<td class="body_title_text">비밀번호</td>
				<td class="body_title_value">
					<input type='password' style="width:133px;padding-left:20px;" id='user_pwd' disabled>
				</td>
				<td class="body_title_text">한글이름</td>
				<td class="body_title_value">
					<input type='text' style="width:133px;padding-left:20px;" id='user_name' disabled>
				</td>
			</tr>
			<tr>
				<td class="body_title_text">영문이름</td>
				<td class="body_title_value">
					<input type='text' style="width:133px;padding-left:20px;" id='user_nm_en' disabled>
				</td>
				<td class="body_title_text">핸드폰번호</td>
				<td class="body_title_value" colspan="3">
					<input type='text' style="width:300px;padding-left:20px;" id='user_phoneno' disabled>
				</td>
			</tr>
			<tr>
				<td class="body_title_text">사용유형</td>
				<td class="body_title_value">
					<input type='text' style="width:133px;padding-left:20px;" id='user_userflag' disabled>
				</td>
				<td class="body_title_text">이메일</td>
				<td class="body_title_value" colspan="3">
					<input type='text' style="width:300px;padding-left:20px;" id='user_email' disabled>
				</td>
			</tr>
			<tr>
				<td class="body_title_text">기관명</td>
				<td class="body_title_value">
					<input type='text' style="width:133px;padding-left:20px;" id='user_instt_nm' disabled>
				</td>
				<td class="body_title_text">사무실전화번호</td>
				<td class="body_title_value" colspan="3">
					<input type='text' style="width:300px;padding-left:20px;" id='user_offc_tel_no' disabled>
				</td>
			</tr>
			<tr>
				<td class="body_title_text">부서명</td>
				<td class="body_title_value">
					<input type='text' style="width:133px;padding-left:20px;" id='user_dept_nm' disabled>
				</td>
				<td class="body_title_text">직급명</td>
				<td class="body_title_value">
					<input type='text' style="width:133px;padding-left:20px;" id='user_rank_nm' disabled>
				</td>
				<td class="body_title_text">담당업무</td>
				<td class="body_title_value">
					<input type='text' style="width:133px;padding-left:20px;" id='user_rpsb_work' disabled>
				</td>
			</tr>
			<tr>
				<td class="body_title_text">IP체계구분</td>
				<td class="body_title_value">
					<input type='text' style="width:133px;padding-left:20px;" id='user_ip_ty_cd' disabled>
				</td>
				<td class="body_title_text">IP입력구분</td>
				<td class="body_title_value">
					<input type='text' style="width:133px;padding-left:20px;" id='user_ip_cd' disabled>
				</td>
				<td class="body_title_text">IP주소</td>
				<td class="body_title_value">
					<input type='text' style="width:133px;padding-left:20px;" id='user_ip_adres' disabled>
				</td>
			</tr>

			<tr>
				<td class="body_title_text">비고</td>
				<td class="body_title_value" colspan="5">
					<input type='text' style="width:600px;padding-left:20px;" id='user_remark' disabled>
				</td>
			</tr>
		</table>
		</ul>
		
		<ul class="list_ty" style="height:calc(100% - 450px);padding: 10px;float: left; width: 560px;">
		<div class="subnsub_title"><em>사용자 지역</em></div>
			<table id="user_detail_group_table" class="easyui-datagrid" title="" style="width: 100%;height:98%" 
			data-options="pagination:true,pageSize:4">
			   	<thead>
			       	<tr>
			       		<th data-options="field:'seqNo',width:70,align:'center'">관리번호</th>
						<th data-options="field:'grpId',width:100,align:'center'">그룹아이디</th>
						<th data-options="field:'grpNm',width:130,align:'center'">그룹명</th>
						<th data-options="field:'authLvlNm',width:90,align:'center'">권한레벨</th>
						<th data-options="field:'dstrtCd',width:90,align:'center'">지구코드</th>
						<th data-options="field:'useTyCd',align:'center'">사용유형</th>
					</tr>
				</thead>
			</table>
		</ul>
		<ul class="list_ty" style="height:calc(100% - 450px);padding: 10px;float: right; width: 320px;">
		<div class="subnsub_title"><em>사용자 그룹</em></div>
			<table id="user_detail_dstrt_table" class="easyui-datagrid" title="" style="width: 100%;height:98%;" 
			data-options="pagination:true,pageSize:4">
			   	<thead>
			       	<tr>
			       		<th data-options="field:'seqNo',width:50,align:'center'">번호</th>
						<th data-options="field:'areaCd',width:100,align:'center'">지역코드</th>
						<th data-options="field:'areaNm',width:100,align:'center'">지역명</th>
						<th data-options="field:'useTyCd',align:'center'">사용유형</th>
						
					</tr>
				</thead>
			</table>
		</ul>
		<div style="position: absolute;width: 930px; height: 34px;bottom: 30px; text-align: center;padding: 10px;">
			<a href="#" id="btnMd" class="btn btnMd" >수정</a>
			<a href="#" id="btnDe" class="btn btnDe" >삭제</a>
			<a href="#" id="btnC" class="btn btnC" >취소</a>
		</div>	
	</div>
	
	
	<div id="user_modify_view" class="easyui-dialog" title="사용자정보 수정" data-options="resizable:false,modal:true,closed:true" style="width:930px;height:760px;">
		<div class="subnsub_title"><em>사용자 상세</em></div>
		<ul style="padding: 10px;">
		<table class="boxtable">
			<tr>
				<td class="body_title_text">아이디</td>
				<td class="body_title_modify">
					<input type='text' style="width:135px;padding-left:20px;" id='user_modify_id'/>
				</td>
				<td class="body_title_text">비밀번호</td>
				<td class="body_title_modify">
					<input type='text' style="width:135px;padding-left:20px;" id='user_modify_pwd' />
				</td>
				<td class="body_title_text">한글이름</td>
				<td class="body_title_modify">
					<input type='text' style="width:135px;padding-left:20px;" id='user_modify_name' />
				</td>
			</tr>
			<tr>
				<td class="body_title_text">영문이름</td>
				<td class="body_title_modify">
					<input type='text' style="width:135px;padding-left:20px;" id='user_modify_nm_en' />
				</td>
				<td class="body_title_text">핸드폰번호</td>
				<td class="body_title_modify" colspan="3">
					<input type='text' style="width:350px;padding-left:20px;" id='user_modify_phoneno' />
				</td>
			</tr>
			<tr>
				<td class="body_title_text">사용유형</td>
				<td class="body_title_modify">
					<select class="selectType1 selectBox easyui-combobox" id="user_modify_userflag" maxlength="1" style="width:100px;padding-left:20px;" >
					        <option value="Y">사용</option>   
					        <option value="N">미사용</option>   
					        <option value="H">숨김</option>   
					        <option value="D">삭제</option>   
					</select>
				</td>
				<td class="body_title_text">이메일</td>
				<td class="body_title_modify" colspan="3">
					<input type='text' style="width:350px;padding-left:20px;" id='user_modify_email' />
				</td>
			</tr>
			<tr>
				<td class="body_title_text">기관명</td>
				<td class="body_title_modify">
					<input type='text' style="width:135px;padding-left:20px;" id='user_modify_instt_nm' />
				</td>
				<td class="body_title_text">사무실전화번호</td>
				<td class="body_title_modify" colspan="3">
					<input type='text' style="width:350px;padding-left:20px;" id='user_modify_offc_tel_no' />
				</td>
			</tr>
			<tr>
				<td class="body_title_text">부서명</td>
				<td class="body_title_modify">
					<input type='text' style="width:135px;padding-left:20px;" id='user_modify_dept_nm' />
				</td>
				<td class="body_title_text">직급명</td>
				<td class="body_title_modify">
					<input type='text' style="width:135px;padding-left:20px;" id='user_modify_rank_nm' />
				</td>
				<td class="body_title_text">담당업무</td>
				<td class="body_title_modify">
					<input type='text' style="width:135px;padding-left:20px;" id='user_modify_rpsb_work' />
				</td>
			</tr>
			<tr>
				<td class="body_title_text">IP체계구분</td>
				<td class="body_title_modify">
					<select class="selectType1 selectBox easyui-combobox" id="user_modify_ip_ty_cd" required="required" user-title="IP주소체계구분" style="width:100px;padding-left:20px;">
						<option value="IPv4">IPv4</option>
						<option value="IPv6">IPv6</option>
					</select>
				</td>
				<td class="body_title_text">IP입력구분</td>
				<td class="body_title_modify">
					<select class="selectType1 selectBox easyui-combobox" id="user_modify_ip_cd" required="required" user-title="IP주소입력구분" user-trigger-req-ex="AL" user-trigger-id="iIpAdres" style="width:100px;padding-left:20px;">
					<option value="AC">AC</option><option value="AL">AL</option><option value="BB">BB</option><option value="BC">BC</option><option value="DC">DC</option>
					</select>
				</td>
				<td class="body_title_text">IP주소</td>
				<td class="body_title_modify">
					<input type='text' style="width:135px;padding-left:20px;" id='user_modify_ip_adres' />
				</td>
			</tr>

			<tr>
				<td class="body_title_text">비고</td>
				<td class="body_title_modify" colspan="5">
					<input type='text' style="width:650px;padding-left:20px;" id='user_modify_remark' />
				</td>
			</tr>
		</table>
		</ul>
		
		<ul class="list_ty" style="height:calc(100% - 450px);padding: 10px;float: left; width: 560px;">
		<div class="subnsub_title"><em>사용자 지역</em></div>
			<table id="user_modify_group_table" class="easyui-datagrid" title="" style="width: 100%;height:98%" 
			data-options="pagination:true,pageSize:4,singleSelect: true,onClickCell: onClickCell,onEndEdit: onEndEdit">
			   	<thead>
			       	<tr>
			       		<th data-options="field:'seqNo',width:70,align:'center'">관리번호</th>
						<th data-options="field:'grpId',width:100,align:'center'">그룹아이디</th>
						<th data-options="field:'grpNm',width:130,align:'center'">그룹명</th>
						<th data-options="field:'authLvl',width:90,align:'center',
						formatter:function(value,row){
							return row.authLvlNm;
						},
						editor:{
							type:'combobox',
							options:{
								valueField:'authLvl',
								textField:'authLvlNm',
								data:[{authLvl:0,authLvlNm:'총괄'},{authLvl:1,authLvlNm:'관리'}],
								required:true
							},
							
						}">권한레벨</th>
						<th data-options="field:'dstrtCd',width:90,align:'center'">지구코드</th>
						<th data-options="field:'useTyCd',align:'center'">사용유형</th>
						
					</tr>
				</thead>
			</table>
		</ul>
		<ul class="list_ty" style="height:calc(100% - 450px);padding: 10px;float: right; width: 320px;">
		<div class="subnsub_title"><em>사용자 그룹</em></div>
			<table id="user_modify_dstrt_table" class="easyui-datagrid" title="" style="width: 100%;height:98%;" 
			data-options="pagination:true,pageSize:4">
			   	<thead>
			       	<tr>
			       		<th data-options="field:'seqNo',width:50,align:'center'">번호</th>
						<th data-options="field:'areaCd',width:100,align:'center'">지역코드</th>
						<th data-options="field:'areaNm',width:100,align:'center'">지역명</th>
						<th data-options="field:'useTyCd',align:'center'">사용유형</th>
						
					</tr>
				</thead>
			</table>
		</ul>
		<div style="position: absolute;width: 930px; height: 34px;bottom: 30px; text-align: center;padding: 10px;">
			<a href="#" id="btnMd" class="btn btnMd" >그룹추가</a>
			<a href="#" id="btnMd" class="btn btnMd" >그룹삭제</a>
			<a href="#" id="btnMd" class="btn btnMd" >지역추가</a>
			<a href="#" id="btnMd" class="btn btnMd" >지역삭제</a>
			<a href="#" id="btnMd" class="btn btnMd" >저장</a>
			<a href="#" id="btnC" class="btn btnC" >취소</a>
		</div>	
	</div>

</div>
