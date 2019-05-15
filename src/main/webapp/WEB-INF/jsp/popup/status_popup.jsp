<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="status_popup">
	<span class="popup_title">여성 거주지 안심 서비스</span>
	
	<table class="status_table">
		<tr>
			<th class="status_title" style="width: 100px;">서비스명</th>
			<th class="status_title" style="width: 60px;">총 가입자</th>
			<th class="status_title" style="width: 60px;">정상</th>
			<th class="status_title" colspan="5">비정상</th>
		</tr>
		<tr>
			<th class="status_title" rowspan="2">여성 거주지<br>안심 서비스</th>
			<td id="user_num" rowspan="2"></td>
			<td id="normal_num" rowspan="2"></td>
			<th class="status_title" style="width: 70px;">총계</th>
			<th class="status_title" style="width: 72px;">센서상태</th>
			<th class="status_title" style="width: 72px;">배터리</th>
			<!-- 2019.05.13 KMH 여성안심서비스 미비사항 수정 (스테이션/센서 연결을 미연결로 변경, 크기조정) -->
			<th class="status_title extra_title" style="width: 100px;">스테이션미연결</th>
			<th class="status_title extra_title" style="width: 70px;">센서미연결</th>
			<!-- <th class="status_title extra_title" style="width: 72px;">스테이션연결</th>
			<th class="status_title extra_title" style="width: 70px;">센서연결</th> -->
		</tr>
		<tr>
			<td id="error_num"></td>
			<td id="girl_sensor_status_off"></td>
			<td id="girl_bat_off"></td>
			<td id="girl_smart_off" class="extra_title"></td>
			<td id="girl_sensor_off" class="extra_title"></td>
		</tr>
	</table>
</div>

<script>
$(document).ready(function(){
	const jsonObj = {};
	
	//여성거주지
	var url = "/select/girlSafe.getStatus/action.do";
	$.ajax({
		type : "POST"
		, url : url
		, async : false
		, dataType : "json"
		, data : {"param" : JSON.stringify(jsonObj)}
		, success:function(data) {
			var total = Number(data[0].total);
			var normal = Number(data[0].normal);
			
			$('#user_num').text(Number(data[0].userNum));
			/* 2019.05.13 KMH 여성안심서비스 미비사항 수정 (총계 수치와 정상 수치를 변경)*/
			$('#error_num').text(Number(data[0].normal));
			/* $('#normal_num').text(Number(data[0].normal)); */
			$('#girl_sensor_status_off').text(Number(data[0].sensorStatusOff));
			$('#girl_bat_off').text(Number(data[0].batOff));
			$('#girl_smart_off').text(Number(data[0].smartOff));
			$('#girl_sensor_off').text(Number(data[0].sensorOff));
			var error = Number(data[0].sensorStatusOff)+Number(data[0].batOff);
			/* 2019.05.13 KMH 여성안심서비스 미비사항 수정(총계 수치와 정상 수치를 변경) */
			$('#normal_num').text(error);
			/* $('#error_num').text(error); */
			
			$('.stat_area .status_total span').text(total);
			$('.stat_area .status_1 span').text(total-normal);
			$('.stat_area .status_2 span').text(normal);
		}
		, error:function(e) {
			alert(e.responseText);
		}
	});
});
</script>