<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="event_list" class="cont_inner" title="" style="height:99%; width: 97%;">
		<ul class="list_condi_full">
			<li class="list">
				<em>가입일 : </em>
				<input id="search_eventR_timeS" data-options="formatter:myformatter,parser:myparser,prompt:'시작일 입력'">
				&nbsp;~ 
				<input id="search_eventR_timeE" data-options="formatter:myformatter,parser:myparser,prompt:'종료일 입력'">
			</li>
			<li class="list">
				<div class="list_cont2">
					<a href="#" id="search_eventR" class="eventR_button_list" onclick="reload()">조회</a>
				</div>
			</li>
		</ul>
		<ul class="list_ty_full" style="width:100%;height:200px;">
			<li class="table_title">
				<em>계정 리스트</em>
			</li>
			<li>
				<table id="userApprovalList_table" title="" style="width:100%;height:calc(100%-129px);">
				</table>
			</li>
			<li class="btn_list">
				<a href="#" id="excel_download_btn" class="eventR_button_list">엑셀 다운로드</a> 
				<a href="#" id="passFail_button" class="eventR_button_list" onclick="passFail()">비밀번호 횟수 초기화</a>
				<a href="#" id="approval_button" class="eventR_button_list" onclick="onAddAdminPopup()">추가</a>
			</li>
		</ul>
	</div>
</div>
<script>

var selectedRow;
var selectedData;

$(document).ready(function(){
	$('#excel_download_btn').click(function() {
		var url = "/excelDownload/girlSafe.getAdminList/action.do";
		var fileName = "girlSafeAdminUser";
		var data ={
				userTimeS : $("#search_eventR_timeS").datebox('getValue').replace(/\//g, ''),
				userTimeE : $("#search_eventR_timeE").datebox('getValue').replace(/\//g, '')	
		};
		excelDownLoad($('#userApprovalList_table'), url, fileName, data);
	});
	$('#search_eventR_timeS').datebox({
		requeired:true
	});
	$('#search_eventR_timeE').datebox({
		requeired:true
	});
	
	$('.datebox-black .combo-arrow').removeClass("combo-arrow").addClass("combo-arrow_sel");
	$('.datebox').removeClass("datebox").addClass("datebox-black");
	$('.datebox-calendar-inner').parent().addClass("datebox-calendar-div");
	$('.datebox-calendar-inner').parent().parent().addClass("datebox-calendar-panel");
	
	reload();
});

function clearPopup() {
	$('#user_sensor_box').val('');
	$('#user_smart_box').val('');
	$('#user_name_box').val('');
	$('#user_age_box').val('');
	$('#user_address_box').val('');
	$('#user_phone_box').val('');
	$('#user_update_btn').css('display', 'inline-block');
	$('#user_save_btn').css('display', 'none');
}

function onAddAdminPopup() {
	var page = '/popup/admin_popup'; 
    $("#popup_area").html("");
    $("#popup_area").load("/action/page.do", { path : page }, function() {
    	
    });
    
    $('#popup_area').dialog({
        title: '계정 신규 등록',
        width: 400,
        height: 450,
        closed: false,
        cache: false,
        modal: true,
		onClose: function() {
			selectedRow = '';
			selectedData = '';
			clearPopup();
		}
    });
    $('#popup_area').dialog('open');
}

function passFail(){
	var row = $('#userApprovalList_table').datagrid('getSelected');
	if (row){
		const jsonObj = {};

        jsonObj.id = row.id;

        $.ajax(
            {
                type       : "POST",
                url        : "${pageContext.request.contextPath}/ajax/update/girlSafe.updatePassFail/action.do",
                dataType   : "json",
                data       : {
                    "param" : JSON.stringify(jsonObj)
                },
                async      : false,
                beforeSend : function(xhr) {
                    // 전송 전 Code
                }
            }).done(function (result) {
            if (result == "SUCCESS")
            {
                alert("초기화 완료");
                $('#userApprovalList_table').datagrid('reload');
            }
            else
            {
                alert("초기화 실패");
            }
        }).fail(function (xhr) {
            alert("초기화 실패");
        }).always(function() {

        });
	}
}

function onAdminDetailPopup(row, data) {
	var page = '/popup/admin_popup'; 
    $("#popup_area").html("");
    $("#popup_area").load("/action/page.do", { path : page }, function() {
    	
    });
    selectedRow = row;
    selectedData = data;
    
    const jsonObj = {};
    jsonObj.id = data.id;

    $.ajax(
        {
            type       : "POST",
            url        : "/select/girlSafe.getAdmin/action.do",
            dataType   : "json",
            data       : {
                "param" : JSON.stringify(jsonObj)
            },
            async      : false,
            beforeSend : function(xhr) {
                // 전송 전 Code
            }
        }).done(function (row) {
            $('#popup_area').dialog({
                title: '계정 상세 정보',
                width: 400,
                height: 450,
                closed: false,
                cache: false,
                modal: true,
        		onClose: function() {
        			selectedRow = '';
        			selectedData = '';
        			clearPopup();
        		}
            });
            $('#popup_area').dialog('open');
    }).fail(function (xhr) {
        alert("수정 실패");
    }).always(function() {

    });
}

function reload(){
	const jsonObj = {};
	jsonObj.userTimeS = $("#search_eventR_timeS").datebox('getValue').replace(/\//g, '');
	jsonObj.userTimeE = $("#search_eventR_timeE").datebox('getValue').replace(/\//g, '');
	
	$('#userApprovalList_table').datagrid({
	    url:'/selectList/girlSafe.getAdminList/action.do',
	    pagination:true,
	    pageSize:12,
	    scrollOnSelect:false,
	    queryParams : {
	    	pageSize:12,
			param : JSON.stringify(jsonObj),
			state: '0',
	    },
	    columns:[[
	        {field:'num',title:'No',width:'5%',align:'center'},
	        {field:'id',title:'아이디',width:'15%',align:'center'},
			{field:'name',title:'이름',width:'10%',align:'center'},
			{field:'birthday',title:'생년월일',width:'10%',align:'center'},
			{field:'phoneNumber',title:'번호',width:'15%',align:'center'},
			{field:'email',title:'이메일',width:'15%',align:'center'},
			{field:'address',title:'소속',width:'20%',align:'center'},
			{field:'rank',title:'등급',width:'5%',align:'center'}
	    ]],
	    onDblClickRow:function(row, data) {
	    	onAdminDetailPopup(row, data);
	    },
	    onLoadSuccess:function(data){
			if(data.rows=='sessionOut'){
				sCnt++;
				if(sCnt == 1){
					alert('세션아웃 됐습니다.');
					closeWindow();
				}
			}
		}
	});
}
</script>

