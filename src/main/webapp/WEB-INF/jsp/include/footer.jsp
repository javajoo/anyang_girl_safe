<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
/* 
.weather_icon img{
	float: left; 
}
.weather{
	vertical-align: middle;
	margin: 0 auto;
	line-height: 50px; 
} */
</style>
<script type="text/javascript" src="/js/weather.js"></script>
<script type="text/javascript" src="/js/flipclock.js"></script>
<link rel="stylesheet" type="text/css" href="/css/flipclock.css" />

<script type="text/javascript">
	var dataSize = 0;
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
	jQuery(function(e){
		//$('#timebar').flipcountdown({size:"sm",speedFlip:50});
		/* console.log(event);
		if(authflag.substring(5, 6)=='A'){ // check if param A: all, P: 112, F: 119
			
			var intSec=1;intMin=0;
			$('#timebar').flipcountdown({speedFlip:60,size:'sm',tick:function(e){
			 	//console.log(Math.floor(tt / 60));
			 	intSec++;
			 	if(Math.floor(intSec/10)!=0){intMin++;intSec=0;}
			 	timebar=((intMin<10)?"0":"")+String(intMin)+":"+((intSec<10)?"0":"")+String(intSec);
			 	
			 	//if(intMin>=1){alert('리로드하세요')}
			 	console.log(e);
			 	return ( intMin>=1 ) ? false : timebar;
			 }
			});//autoUpdate	:false,
		} */
	})
	var clock;
	$(document).ready(function() {
		
		$('#event_dlg').parent().addClass('event_dlg_win');
		$('#event_dlg').dialog('close');
		$("#renewal_dlg").dialog('close');
		getWeather();
		// get flipcountdown small timebar
		if(authflag.substring(5, 6)=='A'){ // check if param A: all, P: 112, F: 119
			search_event_confm();
			$("#timerenewal").css("display","none");
			
		/* $('#timebar').flipcountdown({size:"sm",speedFlip:50});*/
			/* var intSec=1;intMin=0;
			$('#timebar').flipcountdown({speedFlip:60,size:'sm',tick:function(){
			 	//console.log(Math.floor(tt / 60));
			 	intSec++;
			 	if(Math.floor(intSec/10)!=0){intMin++;intSec=0;}
			 	timebar=((intMin<10)?"0":"")+String(intMin)+":"+((intSec<10)?"0":"")+String(intSec);
			 	
			 	//if(intMin>=1){alert('갱신하세요')}
			 	return ( intMin>=1 ) ? false : timebar;
			 }
			}); */
				 
		}else{
			clock = $('#timebar2').FlipClock(1200,{clockFace: 'MinuteCounter',countdown: true,
		        callbacks: {stop: function() {
		        		console.log('timebar end');
		        		$("#renewal_dlg").dialog({modal: true});
		        		var lastSec = 60;
		        		var secVar = setInterval(function(){document.getElementById("minitime").innerHTML = lastSec--; 
		        			if(lastSec==0){clearInterval(secVar);location.href='/danu/com/platform/logout.do';}
		        		}, 1000);
		        	}
		        }
		    });
		}
		// get location button functionality
		//$("#get-weather-btn").click(function(event){
			//event.preventDefault();
			//$("#location-lat-long").val("Finding location. Please wait...");
			// check if browser supports the geolocation api
			//if(navigator.geolocation) {
				//navigator.geolocation.getCurrentPosition(success);			// if geolocation supported, call function
			//} else {
				//$("#location-lat-long").val('Your browser doesn\'t support the geolocation api.');
			//}
		
		//});
		
		// function to get lat/long and plot on a google map
		function success(position) {
			var latitude		= position.coords.latitude;							// set latitude variable
			var longitude		= position.coords.longitude;						// set longitude variable
			
			var latLongResponse	= 'Latitude: ' + latitude + ' / Longitude: ' + longitude;	// build string containing lat/long
			$("#location-lat-long").val(latLongResponse);							// write lat/long string to input field
			
			getWeather(latitude,longitude);											// get weather for the lat/long
		}
		
				

		// function to speak a response
		function speakText(response) {
			
			// setup synthesis
			var msg = new SpeechSynthesisUtterance();
			var voices = window.speechSynthesis.getVoices();
			msg.voice = voices[2];					// Note: some voices don't support altering params
			msg.voiceURI = 'native';
			msg.volume = 1;							// 0 to 1
			msg.rate = 1;							// 0.1 to 10
			msg.pitch = 2;							// 0 to 2
			msg.text = response;
			msg.lang = 'ko-KR';
			//msg.lang = 'en-US';
			
			speechSynthesis.speak(msg);
		}
		
		//var secVarHot = setInterval(function(){hotEvent(dataSize);}, 1*20*1000);
	});
	
	function search_event_confm(){
		$('#event_dlg .panel').empty();

 
		$.ajax({
			url: "com/danusys/platform/selectEventConfm.do",
			type: "get",
			async: false,
			cache: false,
			data: authflag,
			success: function(datas, textStatus, jQxhr){
				var o = Object();
				
				dataSize = datas.rows.length;
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
		//var secVarHot = setInterval(function(){hotEvent(dataSize);}, 4000);
		hotEvent(dataSize);
	}
	
	function tot_chk(seqNo){
		var msg = '일괄 확인 처리 하시겠습니까?';
		if(seqNo != null) msg = '확인 처리 하시겠습니까?';
		
		$.messager.confirm('확인', msg, function(r){
			if (r){
				var data = new Object();
				data.seqNo = seqNo;
				
				$.post( "com/danusys/platform/updateEventConfm.do", data)
				.done(function(json) {
					if(json.stat == "sucess"){
						search_event_confm();
						$('#event_dlg').dialog('close');
						$.messager.alert("정보", "저장되었습니다.",'info');
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
	
	function time_renewal(){
        location.reload();
    }
	
	function hotEvent(dataSize){
		$.ajax({
			url: "com/danusys/platform/selectEventConfm.do",
			type: "get",
			async: false,
			data: authflag,
			success: function(datas, textStatus, jQxhr){
				dataSizeHot = datas.rows.length;
				//console.log('old:'+dataSize+', new:'+dataSizeHot);
				if(Number(dataSize) < Number(dataSizeHot)){
					$('#event_message').removeClass('event_message_x');
					$('#event_message').addClass('event_message_o');
					$('#event_message > p').text(dataSizeHot);
					//alert(dataSizeHot);
					slide_msg_box(1);
				}
			}
		});
	}
	function slide_msg_box(i){
	 var calDiv = jQuery(".slide_msg_box");
	 if(i==1){
	    calDiv.show().animate({opacity:100,top:3,left:20},800)
	 }else{
	  calDiv.animate({left:-400},1000,function(){
	   calDiv.hide();
	   dataSize = dataSizeHot;
	   
	  })
	 }
	}
	</script>
<div id="event_dlg" class="easyui-dialog" title=" "
 style="top:calc(100% - 385px);left:60px;width:235px;height:350px;">
	<input type="checkbox" id="tot_chk" name="tot_chk" value="1" onClick="tot_chk()"/>
	<label for="tot_chk" style="font-family: 'nanum-barun-gothic-regular';">일괄읽음표시</label>
	<div id="event_pop"></div>
</div>

<div id="renewal_dlg" class="easyui-dialog" title=" 긴급영상지원 로그아웃 " style="width:400px;height:300px;padding:26px">
	<div class="panel" style="display: block;">
	
    <!-- <div class="panel-header" style="width: 388px;">
        <div class="panel-title">112긴급영상지원<img src="/images/renewal/popup_close.png" align="right"></div>
        <div class="panel-tool">
        	<a class="panel-tool-close" href="javascript:void(0)"></a>
        </div>
    </div> -->
    <div id="renewal_pop" class="panel-body accordion-body">
    	<div id="renewal_pop_message1">
			<div>"긴급영상지원 자동 로그아웃 예정입니다."</div>
			<div class="_font_bold _margin_top10">남은 시간은 <span id="minitime">60</span>초입니다.</div>
		</div>
		<div id="renewal_pop_message2">
			<div><span>●</span> 개인의 정보조회, 정보보호등의 이유로 20분동안의 시간적 제한이 있습니다.</div>
			<div class="_margin_top10"><span>●</span> 로그인 시간을 연장하시려면 "로그인 연장하기" 버튼 또는 오른쪽 하단의 <img src="/images/renewal/renewal_btn.png" style="width:17px;"/> 갱신 버튼을 클릭하세요.</div>
		</div>
		<div class="renewal_pop_line"></div>
		<div id="pop_renewal_btn" class="pop_renewal_btn" onclick="time_renewal()"></div>
			
    </div>

</div>
	
	
</div>
<div class="slide_msg_bg"></div>
<div class="slide_msg_box">
	<div class="slide_msg_cont">
		<p class="btn_layer_close"><img src="/images/icons/notice_msg_box.png"/></p>
	</div>
</div>
<!-- <div id="event_message11" class="event_message" class="easyui-linkbutton" onclick="$('#event_dlg').dialog('close')" style="margin-left:100px;"></div> -->
<div id="event_message" class="event_message_x" class="easyui-linkbutton" onclick="$('#event_dlg').dialog('open');slide_msg_box();">
	<p>1</p>
</div>
<div id="weather_icon" class="weather_icon"></div>
<div id="weather" class="weather">맑거나 흐리거나 비오거나 눈옴</div>
<div id="timerenewal" class="timerenewal" onclick="time_renewal()"></div>
<div id="timebar2" class="timebar2"></div>
<!-- <div id="bottom">
	<span class="title_version_image"></span>
	<span id="title_version" class="title_version">Android: 0.0.0    iOS: 0.0.0</span>
</div> -->