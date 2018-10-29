<!-- 시설물현황조회 -->
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
					<select id="search_type_box" class="easyui-combobox" style="width: 90px; height: 27px;">
					</select>
				</div>
				<div id="approval_box_wrap" class="list_cont" style="display: inline;">
					<em>승인여부 : </em>
					<select id="approval_box" style="width: 80px; height: 27px; display: none;">
					</select>
				</div>
				<div class="list_cont2">
					<input type="text" id="search_eventR_tot" class="easyui-textbox" style="width:200px;"/>
					<a href="#" id="search_eventR" class="eventR_button_list" onclick="reload()">조회</a>
				</div>
			</li>
		</ul>
		<ul class="list_ty_full" style="width:100%;height:200px;">
			<li class="table_title">
				<em>가입자 승인 리스트</em>
			</li>
			<li>
				<table id="userApprovalList_table" title="" style="width:100%;height:calc(100%-129px);">
				</table>
			</li>
			<li class="btn_list">
				<a href="#" id="approval_button" class="eventR_button_list" onclick="onAddUserPopup()">추가</a>
			</li>
		</ul>
	</div>
</div>
<script>

var selectedData;

$(document).ready(function(){
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
	    	label: '전체',
	    	value: ''
	    },
	    {
	    	label: '이름',
	    	value: 'name'
	    },
	    {
	    	label: '생년월일',
	    	value: 'birth'
	    },
	    {
	    	label: '주소',
	    	value: 'address'
	    },
	    {
	    	label: '번호',
	    	value: 'phon'
	    },
	    {
	    	label: '단말기번호',
	    	value: 'sensor'
	    }]
	});
	
	/* $("#approval_box").combobox({
		valueField:'value',
	    textField:'label',
	    data: [{
	    	label: '전체',
	    	value: ''
	    },
	    {
	    	label: '승인',
	    	value: 'Y'
	    },
	    {
	    	label: '미승인',
	    	value: 'N'
	    }]
	}); */
	
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
        width: 400,
        height: 340,
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
    jsonObj.phoneNumber = row.phoneNumber;

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
                width: 400,
                height: 340,
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

function reload(){
	const jsonObj = {};
	jsonObj.eventDeS = $("#search_eventR_timeS").datebox('getValue').replace(/\//g, '');
	jsonObj.eventDeE = $("#search_eventR_timeE").datebox('getValue').replace(/\//g, '');
	jsonObj.totSearch = $("#search_eventR_tot").val();
	jsonObj.searchType = $("#search_type_box").combobox('getValue');
	// jsonObj.approval = $("#approval_box").combobox('getValue');
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
			{field:'birth',title:'생년월일',width:'5%',align:'center'},
			{field:'phoneNumber',width:'15%',title:'번호',align:'center'},
			{field:'address',title:'주소',width:'20%',align:'center'},
			{field:'sensorId',title:'센서번호',width:'15%',align:'center'},
			{field:'smartId',title:'스테이션번호',width:'15%',align:'center'},
			{field:'approval',title:'승인여부',width:'15%',align:'center'}
	    ]],
	    onDblClickRow:function(index, row) {
	    	onUserDetailPopup(row);
	    },
	    onLoadSuccess:function(data){
	    	var rows = $('#userApprovalList_table').datagrid('getRows');
			if($('#userApprovalList_table').datagrid('getData').rows=='sessionOut'){
				sCnt++;
				if(sCnt == 1){
					alert('세션아웃 됐습니다.');
					//location.href="/";
					closeWindow();
				}
			} else {
				setStationId(rows);
			}
		}
	});
}
</script>

