var insertFlag = false;
var checkedObject = new Object();
var gridPopHeight = 600;

	

/* 환경설정 좌측 서브메뉴 클릭 이벤트 */
function changeSubmenu(flag){
	$('.center_cont').hide();		//기존 import jsp hide
	$('.half_cont').hide();		//기존 import jsp hide
	$('#'+flag+"_cont").show();		//선택 import jsp show
}

function search_user1(){
	$('#user1_table').datagrid('loadData', {"total":0,"rows":[]});
	$('#user1_table').datagrid('options').url = "com/danusys/platform/selectAdminSettingUserList.do";
	$('#user1_table').datagrid('options').pageNumber = 1;
	$('#user1_table').datagrid('load', {
		pageSize: 11,
		id: $("#search_user1_id").val(),
		name: $("#search_user1_name").val(),
		userFlag: $("#search_user1_gbn").combobox('getValue')
    });
}
function selectUserDetail(row, data){
	$('#user_detail_view').show();
	$('#user_detail_view').dialog('open');
	
	console.log(data);
	$('#user_row').val(row);//순번
	
	$('#user_authority').val(data.authority);//담당업무
	$('#user_birthday').val(data.birthday);//생년월일
	$('#user_email').val(data.email);//이메일
	$('#user_id').val(data.id);//아이디
	$('#user_joindate').val(data.joinDate);//가입일
	$('#user_name').val(data.name);//이름(한글)
	$('#user_nm_en').val(data.userNmEn);//이름(영문)
	$('#user_phoneno').val(data.phoneNo);//전화번호
	$('#user_pwd').val(data.pwd);//패스워드
	$('#user_seqno').val(data.seqNo);//관리번호
	$('#user_userflag').val(data.userFlag);//사용유형
	
	$('#user_ip_adres').val(data.ipAdres);//ip주소
	$('#user_ip_ty_cd').val(data.ipTyCd);//ip체계구분
	$('#user_ip_cd').val(data.ipCd);//ip입력구분
	$('#user_offc_tel_no').val(data.offcTelNo);//사무실전화
	$('#user_rank_nm').val(data.rankNm);//직급명
	$('#user_dept_nm').val(data.deptNm);//부서명
	$('#user_instt_nm').val(data.insttNm);//기관명
	$('#user_rpsb_work').val(data.rpsbWork);//담당업무
	$('#user_remark').val(data.remark);//비고
	
	$('#user_detail_group_table').datagrid('loadData', {"total":0,"rows":[]});
	$('#user_detail_group_table').datagrid('options').url = "/com/danusys/platform/user/AdminGroupUserList.do";
	$('#user_detail_group_table').datagrid('options').pageNumber = 1;
	$('#user_detail_group_table').datagrid('load', {
		pageSize: 4,
		searchCondition: 1,
		searchKeyword: data.id
    });
	$('#user_detail_dstrt_table').datagrid('loadData', {"total":0,"rows":[]});
	$('#user_detail_dstrt_table').datagrid('options').url = "/com/danusys/platform/user/CmUserAreaList.do";
	$('#user_detail_dstrt_table').datagrid('options').pageNumber = 1;
	$('#user_detail_dstrt_table').datagrid('load', {
		rownumbers: true,
		pageSize: 4,
		searchCondition: 1,
		searchKeyword: data.id
    });	
	
	$('#user_modify_row').val(row);//순번
	
	$('#user_modify_authority').val(data.authority);//담당업무
	$('#user_modify_birthday').val(data.birthday);//생년월일
	$('#user_modify_email').val(data.email);//이메일
	$('#user_modify_id').val(data.id);//아이디
	$('#user_modify_joindate').val(data.joinDate);//가입일
	$('#user_modify_name').val(data.name);//이름(한글)
	$('#user_modify_nm_en').val(data.userNmEn);//이름(영문)
	$('#user_modify_phoneno').val(data.phoneNo);//전화번호
	$('#user_modify_pwd').val(data.pwd);//패스워드
	$('#user_modify_seqno').val(data.seqNo);//관리번호
	$('#user_modify_userflag').combobox('setValue',data.userFlag);//사용유형
	
	$('#user_modify_ip_adres').val(data.ipAdres);//ip주소
	$('#user_modify_ip_ty_cd').combobox('setValue',data.ipTyCd);//ip체계구분
	$('#user_modify_ip_cd').combobox('setValue',data.ipCd);//ip입력구분
	$('#user_modify_offc_tel_no').val(data.offcTelNo);//사무실전화
	$('#user_modify_rank_nm').val(data.rankNm);//직급명
	$('#user_modify_dept_nm').val(data.deptNm);//부서명
	$('#user_modify_instt_nm').val(data.insttNm);//기관명
	$('#user_modify_rpsb_work').val(data.rpsbWork);//담당업무
	$('#user_modify_remark').val(data.remark);//비고
	var data3 = {};
	data3 =[
				{"productid":"FI-SW-01","productname":"Koi"},
				{"productid":"K9-DL-01","productname":"Dalmation"},
				{"productid":"RP-SN-01","productname":"Rattlesnake"},
				{"productid":"RP-LI-02","productname":"Iguana"},
				{"productid":"FL-DSH-01","productname":"Manx"},
				{"productid":"총괄","productname":"Persian"},
				{"productid":"","productname":"Amazon Parrot"}
			]
	//console.log(data3);
/*$('#user_modify_group_table').datagrid({
		url: "/com/danusys/platform/user/AdminGroupUserList.do",*/
/*		columns:[[
			{field:'ck',checkbox:true},     
			{field:'seqNo',title:'관리번호',width:70,sortable:false,align:'center',type:'validatebox'},
			{field:'grpId',title:'그룹아이디',width:90,sortable:false,align:'center',type:'validatebox'},
			{field:'grpNm',title:'그룹명',width:120,sortable:false,align:'center',type:'validatebox'},
			{field:'productid',title:'권한레벨',width:90,sortable:false,align:'center',
				
				formatter:function(value,row){
					console.log(row);
					console.log('========='+row.productname);
					return data3.productname;
				},
				editor:{
					
					type:'combobox',
				    options:{
				    	url:'/easyui/demo/datagrid/products.json',
					    valueField:'productid',
				        textField:'productname',
				        required:true,
				        //panelHeight:'auto',
					    //editable:true,
					  
				   }   
				},
				
			},
			{field:'dstrtCd',title:'지구코드',width:90,sortable:false,align:'center',editor:'validatebox'},
			{field:'useTyCd',title:'사용유형',sortable:false,align:'center',editor:'validatebox'},
			
		]]*/
		
	
/*		columns:[[
				{field:'authLvlNm',title:'authLvlNm', width:80, editor:{
				    type:'combobox',
				    options:{
				        valueField:'productid',
				        textField:'name',
				        data:[
				            {productid: 1, name: "satu"},
				            {productid: 2, name: "dua"},
				            {productid: 3, name: "tiga"},
				        ],
				        required:true
				    }
				}
				}
		          
		          ]]*/
	/*});*/
	$('#user_modify_group_table').datagrid('loadData', {"total":0,"rows":[]});
	$('#user_modify_group_table').datagrid('options').url = "/com/danusys/platform/user/AdminGroupUserList.do";
	$('#user_modify_group_table').datagrid('options').pageNumber = 1;
	$('#user_modify_group_table').datagrid('load', {
		pageSize: 4,
		searchCondition: 1,
		searchKeyword: data.id
    });
	$('#user_modify_dstrt_table').datagrid('loadData', {"total":0,"rows":[]});
	$('#user_modify_dstrt_table').datagrid('options').url = "/com/danusys/platform/user/CmUserAreaList.do";
	$('#user_modify_dstrt_table').datagrid('options').pageNumber = 1;
	$('#user_modify_dstrt_table').datagrid('load', {
		rownumbers: true,
		pageSize: 4,
		searchCondition: 1,
		searchKeyword: data.id
    });		
	
}
function close_btn() {
	$('#user_detail_view').dialog('close');
}
$(document).ready(function(){
	$(".btnC").bind("click",function(){
		$('#user_detail_view').dialog('close');
	});
	$(".btnMd").bind("click",function(row, data){
		close_btn();
		
		$('#user_modify_view').show();
		$('#user_modify_view').dialog('open');
		
		console.log(data);

		
	});

});
var editIndex = undefined;
function endEditing(){
	if (editIndex == undefined){return true}
	if ($('#user_modify_group_table').datagrid('validateRow', editIndex)){
		$('#user_modify_group_table').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickCell(index, field){
	if (editIndex != index){
		if (endEditing()){
			$('#user_modify_group_table').datagrid('selectRow', index)
					.datagrid('beginEdit', index);
			var ed = $('#user_modify_group_table').datagrid('getEditor', {index:index,field:field});
			if (ed){
				($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
			}
			editIndex = index;
		} else {
			setTimeout(function(){
				$('#user_modify_group_table').datagrid('selectRow', editIndex);
			},0);
		}
	}
}
function onEndEdit(index, row){
	var ed = $(this).datagrid('getEditor', {
		index: index,
		field: 'authLvl'
	});
	row.authLvlNm = $(ed.target).combobox('getText');
}