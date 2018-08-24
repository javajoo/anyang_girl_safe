<!-- 시설물현황조회 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<div class="cont_area">
	<div id="stats_list" class="cont_inner" title="" style="height:99%; width: 97%;">
		<ul class="list_condi_full">
			<li class="list">
				<div class="list_cont">
					<em>종류 : </em>
					<select id="search_type_box" class="easyui-combobox" style="width: 80px; height: 27px;">
					</select>
				</div>
				<div id="end_yn_box_wrap" class="list_cont">
					<em>범위 : </em>
					<select id="search_range_box" style="width: 90px; height: 27px; display: none;">
					</select>
				</div>
				<div class="list_cont2">
					<a href="#" id="search_eventR" class="eventR_button_list" onclick="reload()">조회</a>
				</div>
			</li>
		</ul>
		<ul class="list_ty_full" style="width:100%;">
			<li style="padding: 0 15%; text-aligh: center;">
				<div class="chartwrap" style="width:100%;  height:500px;">
					<h1 style="width: 100%;">월별 차트</h1>
					<canvas id="lineChart"></canvas>
				</div>
			</li>
			<li class="table_title">
				<em></em>
			</li>
			<li>
				<table id="statsList_table" title="" style="width:100%;height:calc(100%-129px);">
				</table>
			</li>
		</ul>
	</div>
</div>

<script>

var lineChart;
var colorSet = [
		{
			line: '#555E7B',
			point: '#704054'
		},
		{
			line: '#B7D968',
			point: '#CECD47'
		},
		{
			line: '#B576AD',
			point: '#CD5093'
		},
		{
			line: '#E04644',
			point: '#EA302E'
		},
		{
			line: '#FDE47F',
			point: '#FEDB56'
		},
		{
			line: '#7CCCE5',
			point: '#A4BCDD'
		},
		{
			line: '#C2CDF9',
			point: '#D6BDF7'
		},
		{
			line: '#B7E5F7',
			point: '#CEDDF4'
		},
		{
			line: '#CEE840',
			point: '#DEE12C'
		},
		{
			line: '#F7568C',
			point: '#FA3A67'
		},
		{
			line: '#88DD73',
			point: '#AED24E'
		},
		{
			line: '#E54EAD',
			point: '#ED3593'
		},
		{
			line: '#DB2388',
			point: '#E71862'
		},
		{
			line: '#BBF4F9',
			point: '#D1F0F7'
		},
		{
			line: '#F7BBBC',
			point: '#FAA5A7'
		},
		{
			line: '#F94D72',
			point: '#FB344E'
		},
		{
			line: '#9286F9',
			point: '#B55FF7'
		},
		{
			line: '#7D83ED',
			point: '#A55BE7'
		},
		{
			line: '#ABFCCB',
			point: '#C6FBBA'
		},
		{
			line: '#C775E5',
			point: '#D950DD'
		},
		{
			line: '#89F4A2',
			point: '#AFF084'
		},
		{
			line: '#1F469B',
			point: '#29307B'
		},
		{
			line: '#73ED68',
			point: '#98E747'
		},
		{
			line: '#9EF7AB',
			point: '#BDF490'
		},
		{
			line: '#EA1CD9',
			point: '#F113CD'
		},
		{
			line: '#71F282',
			point: '#95EE5A'
		},
		{
			line: '#78DB6F',
			point: '#9ECF4B'
		},
		{
			line: '#B1DDED',
			point: '#CAD2E7'
		},
		{
			line: '#E3BDFC',
			point: '#ECA8FB'
		},
		{
			line: '#EEF42C',
			point: '#F3F01E'
		},
		{
			line: '#F23AD9',
			point: '#F627CD'
		}
	];

var config = {
		type: 'line',
		data: {
			labels: [
				'1월', 
				'2월', 
				'3월', 
				'4월', 
				'5월', 
				'6월', 
				'7월', 
				'8월', 
				'9월', 
				'10월', 
				'11월', 
				'12월'
			]
		},
		options: {
			responsive: true,
			title: {
				display: true,
				text: '월별 차트'
			},
			tooltips: {
				position: 'nearest',
				mode: 'nearest',
				intersect: true,
			},
			hover: {
				mode: 'nearest',
				intersect: true
			},
			scales: {
				xAxes: [{
					display: true,
					scaleLabel: {
						display: true,
						labelString: '월'
					}
				}],
				yAxes: [{
					display: true,
					scaleLabel: {
						display: true,
						labelString: '횟수'
					},
					ticks: {
						min: 0
					}
				}]
			}
		}
	};

$(document).ready(function(){
	$('#search_type_box').combobox({
	    valueField:'value',
	    textField:'label',
	    data: [
	    {
	    	label: '거주지(구)',
	    	value: 'gu'
	    },
	    {
	    	label: '거주지(동)',
	    	value: 'dong'
	    }]
	});
	
	$('#search_range_box').combobox({
	    valueField:'value',
	    textField:'label',
	    data: [
	    {
	    	label: '거주지(구)',
	    	value: 'gu'
	    },
	    {
	    	label: '거주지(동)',
	    	value: 'dong'
	    }]
	});
	
	Chart.defaults.global.legend.display = false;
	Chart.defaults.global.tooltips.enabled = true;
	Chart.defaults.global.tooltips.titleFontSize = 15;
	Chart.defaults.global.maintainAspectRatio = false,

	pieChartElement = document.getElementById("pieChart");
	lineChartElement = document.getElementById("lineChart");

	lineChart = new Chart(lineChartElement, config);
	
	reload();
});

function addDataSet(data, index) {
	var dataSet = {
		label: data.label,
		backgroundColor: colorSet[index].line,
		borderColor: colorSet[index].point,
		data: [
			parseInt(data.m1),
			parseInt(data.m2),
			parseInt(data.m3),
			parseInt(data.m4),
			parseInt(data.m5),
			parseInt(data.m6),
			parseInt(data.m7),
			parseInt(data.m8),
			parseInt(data.m9),
			parseInt(data.m10),
			parseInt(data.m11),
			parseInt(data.m12)
		],
		fill: false,
	};
	
	config.data.datasets.push(dataSet);
	lineChart.update();
}

function addData(label, type) {
	var data = {
		label: label,
		type: type
	};
	
	datas.push(data);
}

function getEventDongStatsList() {
	var url = "/select/girlSafe.getEventDongStatsList/action.do";
	const jsonObj = {};
	$.ajax({
		type : "POST"
		, url : url
		, dataType : "json"
		, data : {"param" : JSON.stringify(jsonObj)}
		, success: function(data)
		{
			var length = data.length;
			for (var i = 0; i < length; i++) {
				addDataSet(data[i], i);
			}
		}
		, error:function(e){
			alert(e.responseText);
		}
	});
}

function getEventGuStatsList() {
	var url = "/select/girlSafe.getEventGuStatsList/action.do";
	const jsonObj = {};
	$.ajax({
		type : "POST"
		, url : url
		, dataType : "json"
		, data : {"param" : JSON.stringify(jsonObj)}
		, success: function(data)
		{
			var length = data.length;
			for (var i = 0; i < length; i++) {
				addDataSet(data[i], i);
			}
		}
		, error:function(e){
			alert(e.responseText);
		}
	});
}

function getUserDongStatsList() {
	var url = "/select/girlSafe.getUserDongStatsList/action.do";
	const jsonObj = {};
	$.ajax({
		type : "POST"
		, url : url
		, dataType : "json"
		, data : {"param" : JSON.stringify(jsonObj)}
		, success: function(data)
		{
			var length = data.length;
			for (var i = 0; i < length; i++) {
				addDataSet(data[i], i);
			}
		}
		, error:function(e){
			alert(e.responseText);
		}
	});
}

function getUserGuStatsList() {
	var url = "/select/girlSafe.getUserGuStatsList/action.do";
	const jsonObj = {};
	$.ajax({
		type : "POST"
		, url : url
		, dataType : "json"
		, data : {"param" : JSON.stringify(jsonObj)}
		, success: function(data)
		{
			var length = data.length;
			for (var i = 0; i < length; i++) {
				addDataSet(data[i], i);
			}
		}
		, error:function(e){
			alert(e.responseText);
		}
	});
}

function reload(){
	config.data.datasets = [];
	getEventDongStatsList();
	/* $('#eventList_table').datagrid({
	    url:'/selectList/girlSafe.getEventGuStatsList/action.do',
	    pagination:true,
	    pageNumber:1,
	    fitColumns:true,
	    queryParams : {
	    	param : JSON.stringify(jsonObj),
			state: '0',
	    },
	    columns:[[
	        {field:'label',title:'거주지',width:50,align:'center'},
			{field:'total',title:'총계',width:70,align:'center'}
	    ]],
	    onLoadSuccess:function(data){
	    	console.log(data);
			if($('#eventList_table').datagrid('getData').rows=='sessionOut'){
				sCnt++;
				if(sCnt == 1){
					alert('세션아웃 됐습니다.');
					//location.href="/";
					closeWindow();
				}
			}			
			var length = data.length;
			for (var i = 0; i < length; i++) {
				addDataSet(data[i]);
			}
		}
	});	 */
}
</script>



