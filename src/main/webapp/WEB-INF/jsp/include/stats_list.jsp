<!-- 시설물현황조회 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="stats_list" class="cont_inner" title="" style="height:99%; width: 97%;">
		<ul class="list_condi_full">
			<li class="list">
				<div class="list_cont">
					<em>종류 : </em>
					<select id="search_type_box" class="easyui-combobox" style="width: 110px; height: 27px;">
					</select>
				</div>
				<div class="list_cont">
					<em>범위 : </em>
					<select id="search_range_box" style="width: 90px; height: 27px; display: none;">
					</select>
				</div>
				<div class="list_cont">
					<em>연도 : </em>
					<select id="search_year_box" style="width: 90px; height: 27px; display: none;">
					</select>
				</div>
				<div class="list_cont2">
					<a href="#" id="search_eventR" class="eventR_button_list" onclick="reload()">조회</a>
				</div>
			</li>
		</ul>
		<ul class="list_ty_full" style="width:100%;">
			<li style="padding: 0 15%; text-aligh: center; height: 500px;">
				<div class="chartwrap" style="width:100%; height:500px;">
					<canvas id="lineChart" style="width:100%; height:500px;"></canvas>
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
var currentData;
var lineChart;
var userRangeData = [
    {
		label: '거주지(구)',
		value: 'gu',
		selected: true
	},
   	{
   		label: '거주지(동)',
   		value: 'dong'
   	}];
var eventRangeData = [
	{
		label: '거주지(구)',
		value: 'gu',
		selected: true
	},
	{
		label: '거주지(동)',
		value: 'dong'
	},
	{
		label: '기기별',
		value: 'hw'
	}];
var logRangeData = [
	{
		label: 'WEB ID별',
		value: 'id',
		selected: true
	}];
var colorSet = [
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
		maintainAspectRatio: true,
		title: {
			display: true,
			text: '월별 차트',
			fontSize: 25,
			fontFamily: 'nanum-barun-gothic-regular'
		},
		tooltips: {
			position: 'average',
			mode: 'index',
			intersect: false,
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
					labelString: '월',
					fontFamily: 'nanum-barun-gothic-regular'
				}
			}],
			yAxes: [{
				display: true,
				scaleLabel: {
					display: true,
					labelString: '횟수',
					fontFamily: 'nanum-barun-gothic-regular'
				},
				ticks: {
					min: 0
				}
			}]
		}
	}
};

$(document).ready(function(){
	checkBrower();
	
	$('#search_range_box').combobox({
	    valueField:'value',
	    textField:'label',
	    data: [
	    {
	    	label: '거주지(구)',
	    	value: 'gu',
	    	selected: true
	    },
	    {
	    	label: '거주지(동)',
	    	value: 'dong'
	    },
	    {
	    	label: '기기별',
	    	value: 'hw'
	    }]
	});
	
	$('#search_type_box').combobox({
	    valueField:'value',
	    textField:'label',
	    data: [
		{
			label: '이벤트 횟 수',
			value: 'event',
	    	selected: true
		},
	    {
	    	label: 'APP 가입자 수',
	    	value: 'user'
	    },
	    {
	    	label: 'WEB 접속 수',
	    	value: 'log'
	    }],
	    onSelect: function() {
	    	setSearchRangeBox();
	    	setSearchYearBox();
	    }
	});
	
	$('#search_year_box').combobox({
	    valueField:'value',
	    textField:'label',
	    data: [
	    {
	    	label: '2017',
	    	value: '2017'
	    },
	    {
	    	label: '2018',
	    	value: '2018',
	    	selected: true
	    }]
	});
	
	Chart.defaults.global.legend.display = true;
	Chart.defaults.global.tooltips.enabled = true;
	Chart.defaults.global.tooltips.titleFontSize = 15;
	Chart.defaults.global.maintainAspectRatio = false;

	lineChartElement = document.getElementById("lineChart");
	lineChart = new Chart(lineChartElement, config);
	
	setSearchYearBox();
	reload();
});

function checkBrower() {
	var agent = navigator.userAgent.toLowerCase();
	
	if ((navigator.appName == 'Netscape' 
			&& navigator.userAgent.search('Trident') != -1) 
			|| (agent.indexOf("msie") != -1)) {
		config.options.maintainAspectRatio = false;
	} else {
		config.options.maintainAspectRatio = true;
	}
	
	console.log(config.options.maintainAspectRatio);
}

function setSearchRangeBox() {
	var type = $("#search_type_box").combobox('getValue');
	var opts = $("#search_range_box").combobox('options');
	if (type == "event") {
		$("#search_range_box").combobox({data: eventRangeData});
		opts.data = eventRangeData;
	} else if (type == "user") {
		$("#search_range_box").combobox({data: userRangeData});
		opts.data = userRangeData;
	} else if (type == "log") {
		$("#search_range_box").combobox({data: logRangeData});
		opts.data = logRangeData;
	}
	$("#search_range_box").combobox('options', opts);
	$("#search_range_box").combobox('reload');
}

function setSearchYearBox() {
	var type = $("#search_type_box").combobox('getValue');
	var url = "";
	const jsonObj = {};
	
	if (type == "event") {
		url = "/select/girlSafe.getEventStatsYearList/action.do";
	} else if (type == "user") {
		url = "/select/girlSafe.getUserStatsYearList/action.do";
	} else if (type == "log") {
		url = "/select/girlSafe.getLogStatsYearList/action.do";
	}
	
	$('#search_year_box').combobox({
		url: url,
	    valueField: 'label',
	    textField: 'label',
	    queryParams : {
	    	param : JSON.stringify(jsonObj)
	    },
	    onLoadSuccess: function(items) {
	    	var opts = $(this).combobox('options');
	    	$(this).combobox('select', items[0][opts.valueField]);
	    }
	});
}

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

function getStatsList(data) {
	var length = data.length;
	for (var i = 0; i < length; i++) {
		addDataSet(data[i], i);
	}
}

function setStatsDatagrid(urlType, year, title) {
	var url = "/selectList" + urlType;
	const jsonObj = {};
	jsonObj.year = year;
	$('#statsList_table').datagrid({
	    url: url,
	    pagination: true,
	    pageSize: 3,
	    pageNumber: 1,
	    fitColumns: true,
	    queryParams : {
	    	param : JSON.stringify(jsonObj),
			pageSize : 3
	    },
	    columns: [[
	        {field: 'label', title: title, width: "50%",align: 'center'},
			{field: 'total', title: '총계', width: "50%",align: 'center'}
	    ]],
	    onLoadSuccess: function(data){
			if($('#statsList_table').datagrid('getData').rows == 'sessionOut'){
				sCnt++;
				if(sCnt == 1){
					alert('세션아웃 됐습니다.');
					//location.href="/";
					closeWindow();
				}
			}
			if(data && data.total > 0) {
				config.data.datasets = [];
				getStatsList(data.rows);
			}
		}
	});
}

function reload(){
	var type = $("#search_type_box").combobox('getValue');
	var range = $("#search_range_box").combobox('getValue');
	var year = $("#search_year_box").combobox('getValue');
	var title = "거주지(구)별";
	var urlType = "";
	var yearBoxUrl = "";
	config.data.datasets = [];
	
	if (type == "event") {
		if (range == "gu") {
			urlType = "/girlSafe.getEventGuStatsList/action.do";
		} else if (range == "dong") {
			urlType = "/girlSafe.getEventDongStatsList/action.do";
			title = "거주지(동)별";
		} else if (range == "hw") {
			urlType = "/girlSafe.getEventHwStatsList/action.do";
			title = "기기별"
		}
	} else if (type == "user") {
		if (range == "gu") {
			urlType = "/girlSafe.getUserGuStatsList/action.do";
		} else if (range == "dong") {
			urlType = "/girlSafe.getUserDongStatsList/action.do";
			title = "거주지(동)별";
		}
	} else if (type == "log") {
		urlType = "/girlSafe.getLogStatsList/action.do";
		title = "WEB ID별";
	}
	
	setStatsDatagrid(urlType, year, title);
	
	lineChart.update();
}
</script>



