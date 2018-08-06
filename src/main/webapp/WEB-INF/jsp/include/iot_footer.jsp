<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/js/weather.js"></script>

<script type="text/javascript">
	function settingOpen(){
		$('#settingdlg').parent().children().first().addClass("tabs_title");
		
   		var data = new Object();
   		$.ajax({
   			method : 'GET',
   			data : data,
   			url : 'danu/com/platform/adminList.do',
   			dataType : 'json',
   			contentType: "application/json; charset=utf-8",
   		}).done(function(resposeJson) {
   			$('#account-result').datagrid('loadData', resposeJson);
   		});
		
		$('#settingdlg').dialog('open');
	}
	
	$(document).ready(function() {
		
		$('#event_dlg').parent().addClass('event_dlg_win');
		$('#event_dlg').dialog('close');
		$("#renewal_dlg").dialog('close');
		getWeather();
		
		search_event_confm();
	});
	
	function search_event_confm(){
		$('#event_dlg .panel').empty();
		$.ajax({
			url: "com/danusys/platform/selectEventFlagConfm.do",
			type: "get",
			async: false,
			cache: false,
			data: authflag,
			success: function(datas, textStatus, jQxhr){
				var o = Object();
				
				var dataSize = datas.rows.length;
				if(dataSize > 0){
					$('#event_message').removeClass('event_message_x');
					$('#event_message').addClass('event_message_o');
					$('#event_message > p').text(dataSize);
				}
				else {
					$('#event_message').removeClass('event_message_o');
					$('#event_message').addClass('event_message_x');
				}
				for(var i=0; i<dataSize; i++){
					var data = datas.rows[i];
					
					var accdBody;
					if(i==0) accdBody = "<div title='' class='panel-body accordion-body' onClick='javascript:selectEventConfm(\""+data.eventNo+"\")'>";
					else accdBody = "<div title='' class='panel-body accordion-body accordion-body-non' onClick='javascript:selectEventConfm(\""+data.eventNo+"\")'>";
					
					$('#event_pop').append("<div class='panel' style='width: 226px;'>"
					+"<div class='panel-header accordion-header' style='height:28px; width:208px;'>"
					+"<div class='panel-title'>"+data.eventTitle+"</div>"
					+"<div class='panel-tool'>"
					+"<a href='javascript:void(0)' class='event_extend'></a>"
					+"<a href='javascript:tot_chk("+data.seqNo+")' class='event_chk'></a>"
					+"</div>"
					+"</div>"
					+ accdBody
					+"<p>"+data.eventTitle+"<br>"+data.eventDe+"<br><br>"+data.acceptId+"<br>"+data.eventPlace+"</p>"
					+"</div>"
					+"</div>");
				}
				$('#event_pop .panel').click(function(event){
					$("#event_pop .accordion-body").addClass("accordion-body-non");
					$(event.currentTarget.lastChild).removeClass("accordion-body-non");
				});
				$('#event_pop .panel .accordion-body').click(function(event){
					//이벤트 팝업 클릭 시 영상 표출
				});
				console.log('이벤트 확인창 로딩 완료');
			},
			error: function(jqXhr, textStatus, errorThrown){
				alert("데이터를 불러오는데 실패했습니다.");
			}
		});
	}
	
	function tot_chk(seqNo){
		var msg = '일괄 확인 처리 하시겠습니까?';
		if(seqNo != null) msg = '확인 처리 하시겠습니까?';
		
		$.messager.confirm('확인', msg, function(r){
			if (r){
				var data = new Object();
				data.seqNo = seqNo;
				data.instId = '${admin.id}';
				
				$.get( "/com/danusys/platform/insertEventFlagConfm.do", data)
				.done(function(json) {
					if(json.stat == "sucess"){
						search_event_confm();
						$('#event_dlg').dialog('close');
						$.messager.alert("정보", "확인 처리되었습니다.",'info');
					}else{
						$.messager.alert("에러", json.stat,'error');
					}
			 	});
			}
		});
	}
	
	function selectEventConfm(eventNo){
		menuDisplay('menu_eventM');
		var data = $('#eventM_table').datagrid('getData').rows;
		for(i=0; i<data.length; i++){
			if(data[i].eventNo == eventNo){
				$('#eventM_table').datagrid('selectRow',i)
				return;
			}
		}
	}
	</script>

<div id="event_dlg" class="easyui-dialog" title=" "
 style="top:calc(100% - 385px);left:60px;width:235px;height:350px;">
	<!-- <input type="checkbox" id="tot_chk" name="tot_chk" value="1" onClick="tot_chk()"/>
	<label for="tot_chk" style="font-family: 'nanum-barun-gothic-regular';">일괄읽음표시</label> -->
	<div id="event_pop"></div>
</div>

<div id="event_message" class="event_message_x" class="easyui-linkbutton" onclick="$('#event_dlg').dialog('open')">
	<p>1</p>
</div>
<div id="weather_icon" class="weather_icon"></div>
<div id="weather" class="weather">맑거나 흐리거나 비오거나 눈옴</div>
