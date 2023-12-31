<!-- 가입자 관리 -->
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
				<div id="search_type_box_wrap" class="list_cont">
					<em>검색 조건 : </em>
					<select id="search_type_box" class="easyui-combobox" style="width: 110px; height: 27px;"></select>
					<input type="text" id="search_eventR_tot" class="easyui-textbox" style="width:200px;" onkeypress="if(event.keyCode==13){reload();}"/>
					<a href="#" id="search_eventR" class="eventR_button_list" onclick="reload()">조회</a>
					<a href="#" class="eventR_button_list" onclick="searchInit()">초기화</a>
				</div>
			</li>
		</ul>
		<ul class="list_ty_full" style="width:100%;height:200px;">
			<li class="table_title">
				<em>가입자 리스트</em>
			</li>
			<li>
				<table id="userApprovalList_table" title="" style="width:100%;height:calc(100%-129px);">
				</table>
			</li>
			<li class="btn_list">
				<a href="#" id="delete_button" class="delete_button" onclick="deleteUser()">삭제</a>
				<a href="#" id="excel_download_btn" class="eventR_button_list">엑셀 다운로드</a>
				<a href="#" id="approval_button" class="eventR_button_list" onclick="onAddUserPopup()">추가</a>
			</li>
		</ul>
	</div>
</div>
<script>

var selectedData;

function searchInit() {
	$('#search_eventR_timeS').datebox({
		requeired:true
	});
	$('#search_eventR_timeE').datebox({
		requeired:true
	});
	
	$('#search_type_box').combobox({
	    valueField:'value',
	    textField:'label',
	    data: [{
	    	label: '이름',
	    	value: 'name',
	    	"selected":true
	    },
	    {
	    	label: '나이',
	    	value: 'age'
	    },
	    {
	    	label: '지번주소',
	    	value: 'jibunAddress'
	    },
	    {
	    	label: '도로명주소',
	    	value: 'roadAddress'
	    },
	    {
	    	label: '연락처',
	    	value: 'phon'
	    },
	    {
	    	label: '센서번호',
	    	value: 'sensor'
	    },
	    {
	    	label: '스테이션번호',
	    	value: 'smart'
	    }]
	});
	
	$('#search_eventR_tot').val('');
}

$(document).ready(function(){
	$('#excel_download_btn').click(function() {
		var url = "/excelDownload/girlSafe.getUserList/action.do";
		var fileName = "girlSafeUser";
		var data ={
				userTimeS : $("#search_eventR_timeS").datebox('getValue').replace(/\//g, ''),
				userTimeE : $("#search_eventR_timeE").datebox('getValue').replace(/\//g, ''),
				searchType : $("#search_type_box").combobox('getValue'),
				totSearch : $("#search_eventR_tot").val()
		};
		excelDownLoad($('#userApprovalList_table'), url, fileName, data);
	});
	
	searchInit();
	
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
	$('#user_birth_box').val('');
	$('#user_address_box').val('');
	$('#user_phone_box').val('');
	$('#user_update_btn').css('display', 'inline-block');
	$('#user_save_btn').css('display', 'none');
}

function onAddUserPopup() {
	var page = '/popup/user_popup'; 
    $("#popup_area").html("");
    $("#popup_area").load("/action/page.do", { path : page }, function() {
    	
    });
    
    $('#popup_area').dialog({
        title: '사용자 신규 등록',
        width: 410,
        height: 420,
        closed: false,
        cache: false,
        modal: true,
		onClose: function() {
			selectedData = '';
			clearPopup();
		}
    });
    $('#popup_area').dialog('open');
}

function approval(){
	var row = $('#userApprovalList_table').datagrid('getSelected');
	if (row){
		const jsonObj = {};

        jsonObj.phoneNumber = row.phoneNumber;

        $.ajax(
            {
                type       : "POST",
                url        : "${pageContext.request.contextPath}/ajax/update/girlSafe.updateApproval/action.do",
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
                alert("승인 완료");
                $('#userApprovalList_table').datagrid('reload');
            }
            else
            {
                alert("수정 실패");
            }
        }).fail(function (xhr) {
            alert("수정 실패");
        }).always(function() {

        });
	}
}

function onUserDetailPopup(row) {
	var page = '/popup/user_popup'; 
    $("#popup_area").html("");
    $("#popup_area").load("/action/page.do", { path : page }, function() {
    	
    });

	const jsonObj = {};
    jsonObj.phoneNumber = (row.phoneNumber).replace(/-/g,"");

    $.ajax(
        {
            type       : "POST",
            url        : "/select/girlSafe.getUser/action.do",
            dataType   : "json",
            data       : {
                "param" : JSON.stringify(jsonObj)
            },
            async      : false,
            beforeSend : function(xhr) {
                // 전송 전 Code
            }
        }).done(function (data) {
        	selectedData = data;
            $('#popup_area').dialog({
                title: '사용자 상세 정보',
                width: 410,
                height: 420,
                closed: false,
                cache: false,
                modal: true,
        		onClose: function() {
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

function setStationId(rows) {
	var length = rows.length;
	var maxLength = 4;
	
	for (var i = 0; i < length; i++) {
		var smartId = rows[i].smartId;
		var idLength = maxLength - smartId.length;
		for (var j = 0; j < idLength; j++) {
			smartId = '0' + smartId;
		}
		rows[i].smartId = 'SA-S' + smartId;
		$('#userApprovalList_table').datagrid('refreshRow', i);
	}
}

function deleteUser() {
	var row = $('#userApprovalList_table').datagrid('getSelected');
	
	const jsonArray1 = [];
	const jsonArray2 = [];
	const jsonArray3 = [];
	const jsonArray4 = [];
	
	const jsonObj = {};
    jsonObj.rowStatus = "D";
    jsonObj.phoneNumber = row.phoneNumber.replace(/-/g,'');
    
    
  //insert into user_action_log 하기 위해 필요한 파라미터들
	jsonObj.logPath = "가입자 관리";
    jsonObj.adminId = "${admin.id}";
	jsonObj.adminName = "${admin.name}";
	jsonObj.userKey = row.phoneNumber.replace(/-/g, "");;
	jsonObj.userName = row.name;
	jsonObj.saveLog = "Y";
    
    
    
    jsonArray1[0] = jsonObj;
    jsonArray2[0] = jsonObj;
    jsonArray3[0] = jsonObj;
    jsonArray4[0] = jsonObj;

    $.ajax({
            type       : "POST",
            url        : "/multiTransaction/girlSafe.insertWithdraw/girlSafe.deleteUser/girlSafe.deleteHw/girlSafe.deleteUserSub/action.do",
            dataType   : "json",
            data       : {
            	"param1" : JSON.stringify(jsonArray1),
                "param2" : JSON.stringify(jsonArray2),
                "param3" : JSON.stringify(jsonArray3),
                "param4" : JSON.stringify(jsonArray4)
            },
            async      : false,
            beforeSend : function(xhr) {
                // 전송 전 Code
            }
        }).done(function (result) {
        if (result == "SUCCESS") {
            $('#userApprovalList_table').datagrid('reload');
            alert("삭제 완료");
        }
        else {
            alert("삭제 실패");
        }
    }).fail(function (xhr) {
        alert("삭제 실패");
    }).always(function() {

    });
}

function reload(){
	const jsonObj = {};
	jsonObj.userTimeS = $("#search_eventR_timeS").datebox('getValue').replace(/\//g, '');
	jsonObj.userTimeE = $("#search_eventR_timeE").datebox('getValue').replace(/\//g, '');
	jsonObj.searchType = $("#search_type_box").combobox('getValue');
	jsonObj.totSearch = $("#search_eventR_tot").val();
	$('#userApprovalList_table').datagrid({
	    url:'/selectList/girlSafe.getUserList/action.do',
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
			{field:'name',title:'이름',width:'10%',align:'center'},
			{field:'birthAge',title:'생년월일(나이)',width:'10%',align:'center'},
			{field:'phoneNumber',width:'15%',title:'연락처',align:'center'},
			{field:'address',title:'주소',width:'20%',align:'center'},
			{field:'sensorId',title:'센서번호',width:'15%',align:'center'},
			{field:'smartId',title:'스테이션번호',width:'10%',align:'center'},
			{field:'insertDate',title:'가입일',width:'15%',align:'center'}
	    ]],
	    onSelect:function(index, row) {
			$('#delete_button').css('display', 'inline-block');
	    },
	    onUnselect:function(index, row) {
			$('#delete_button').css('display', 'none');
	    },
	    onDblClickRow:function(index, row) {
	    	onUserDetailPopup(row);
	    },
	    onLoadSuccess:function(data){
	    	$('#delete_button').css('display', 'none');
	    	
	    	var rows = $('#userApprovalList_table').datagrid('getRows');
			if(data.rows=='sessionOut'){
				alert('세션아웃 됐습니다.');
				closeWindow();
			} else {
				setStationId(rows);
			}
		}
	});
}
</script>

