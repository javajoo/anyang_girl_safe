<!-- 시설물현황조회 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<div class="cont_area">

		<div class="chartwrap" style="position:absolute; width:500px;  height:500px;">
		<h1>LINE 차트</h1>
			<canvas id="lineChart" style="height:500px;"></canvas>
		</div>
	
</div>

<script>



$(document).ready(function(){
	Chart.defaults.global.legend.display = false;
	Chart.defaults.global.tooltips.enabled = true;
	Chart.defaults.global.tooltips.titleFontSize = 15;
	Chart.defaults.global.maintainAspectRatio = false,

	pieChartElement = document.getElementById("pieChart");
	lineChartElement = document.getElementById("lineChart");

	new Chart(lineChartElement, {
	    type: 'line',
	    tooltipFillColor: "rgba(51, 51, 51, 0.55)",
	    data: {
	        labels: [
	            "총근로 근무율",
	            "잔여근로",
	        ],
	        datasets: [
	            {
				backgroundColor: "#ff00ff",
				borderColor: "#ff00ff",
	            data: [
					100,
					50,
					70,
					20,
					10
				],
				fill: false,
			}, {
				fill: false,
				backgroundColor: "#ffff00",
				borderColor: "#ffff00",
				data: [
					10,
					20,
					100
				]
	        }]
	    },
	    options: { 
	        responsive: true,
	        segmentShowStroke : false,	        
	        showTooltips : false,
	        tooltips: 
	        {
	            custom: function(tooltip)
	            {
	                if (!tooltip) 
	                    return;
	                    tooltip.displayColors = false;
	            },
	            callbacks:
	            {
	                label: function(tooltipItem, data)
	                {
	                    var i = tooltipItem.index;                 
	                    return  data.datasets[0].data[i] + "%";
	                },
	                title: function(tooltipItem, data)
	                {
	                    return;
	                }
	            }
	        }
	    }
	});	
	
	/* $('#search_eventR_timeS').datebox({
		requeired:true
	});
	$('#search_eventR_timeE').datebox({
		requeired:true
	});
		 */
});

function reload(){
	const jsonObj = {};
	$('#eventList_table').datagrid({
	    url:'/selectList/girlSafe.getEventList/action.do',
	    pagination:true,
	    pageSize:10,
	    pageNumber:1,
	    fitColumns:true,
	    queryParams : {
	    	param : JSON.stringify(jsonObj),
			pageSize : 10,
			state: '0',
	    },
	    columns:[[
	        {field:'num',title:'No',width:50,align:'center'},
			{field:'name',title:'이름',width:80,align:'center'},
			{field:'age',title:'나이',width:70,align:'center'},
			{field:'phoneNumber',title:'번호',width:100,align:'center'},
			{field:'address',title:'주소',width:100,align:'center'},
			{field:'startTime',title:'발생일',width:100,align:'center'},
			{field:'endTime',title:'종료일',width:100,align:'center'},
			{field:'endYN',title:'종료여부',width:100,align:'center'},
			{field:'sensorId',title:'단말기번호',width:70,align:'center'}
	    ]],
	    onLoadSuccess:function(data){
			if($('#eventList_table').datagrid('getData').rows=='sessionOut'){
				sCnt++;
				if(sCnt == 1){
					alert('세션아웃 됐습니다.');
					//location.href="/";
					closeWindow();
				}
			}
			if(data && data.total > 0) {				
				selectEeventMGIS(0, data.rows[0]);	// 발생된 이벤트 선택 및 지도 표출.
				$(this).datagrid('selectRow',0);
			}
		}
	});	
}
</script>



