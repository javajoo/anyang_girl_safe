/**
 * ChartGraph Default Setting
 * 김동식
 * 2018-01-26
 */
function iot_chart(data){
	console.log(data)
	var selThresholdHi = $('#iotM_graph_unit #unit_up').val();; //상한임계치
	var selThresholdLo = $('#iotM_graph_unit #unit_down').val();; //하한임계치
	var data3 = [];
	var arrData = [];
	var keysForChart = [];
	var valueForChart = [];
	var valueForChart2 = [];
	var valueForChart3 = [];
	var valueForChart4 = [];
	var jsJsonObj = new Object();
	$.ajax({
	type:"POST"
	,url: '/datas/selectDatasMT.do?searchCondition=M&siteno='+data.siteno
	,dataType: "json"
	,success: function(data2){
		//console.log(data2);
		data3 = (data2);
		keysForChart.push("hh");
		valueForChart.push("ou");
		valueForChart2.push("temperature");
		valueForChart3.push("humidity");
		valueForChart4.push("windspeed");
		for (var it = 0; it < data2.length; it++) { // data from an external json file. 
			//console.log(data2[it].hh);
			keysForChart.push(data2[it].hh);
			valueForChart.push(data2[it].ou);
			valueForChart2.push(data2[it].temperature);
			valueForChart3.push(data2[it].humidity);
			valueForChart4.push(data2[it].windspeed);
			//jsJsonObj[it] = data2[it].hh;
			//jsJsonObj[it] = data2[it].ou;
			jsJsonObj[0] = keysForChart
			jsJsonObj[1] = valueForChart;
			jsJsonObj[2] = valueForChart2;
			jsJsonObj[3] = valueForChart3;
			jsJsonObj[4] = valueForChart4;
		}
	
		//arrData.push(jsJsonObj);
		//console.log(jsJsonObj);
		//console.log(keysForChart);
		chart.load({
			unload: true,
			x: 'hh',
			xFormat: '%Y%m%d%H%M',
			columns: [
			          keysForChart,
			          valueForChart,
			          valueForChart2,
			          valueForChart3,
			          valueForChart4,
			          ],
	        type: 'line',
	        done: function() {
	         chart.hide();
	         chart.show(['ou']);
				chart.ygrids([
					  			{value: selThresholdHi, class: 'gridup'}, //상한임계치
					  			{value: selThresholdLo, class: 'griddown'}, //하한임계치
					  		]);
	        }
	        
	    });

	}
	,error: function(data2){
	//console.log(data);
	}
	});
	//iotM_graph_chenge();
	//iotM_graph_chenge2(1);
}
/*그래프 차트 선택*/
function iot_chart_select(sval){
	console.log(sval);
	switch(sval) {
    case '1':
    case 'ou':
    	chart.hide();
		chart.show(['ou']);
        break;
    case '2':
    case 'temperature':
    	chart.hide();
		chart.show(['temperature']);
        break;
    case '3':
    case 'humidity':
    	chart.hide();
		chart.show(['humidity']);
		break;
    case '4':
    case 'windspeed':
    	chart.hide();
		chart.show(['windspeed']);
		break;
    default:
    	chart.hide();
		chart.show(['ou']);
	}
}


/*IoT센서모니터링 - 이벤트히스토리*/
function iotH_chart(data){
	var selSiteno = data.siteNo;
	var selDate = data.date.replace(/(\s*)/gi, '').replace(/\-/g, "").replace(/\:/g, "");
	var selType = data.type;
	var selH = selDate.slice(8,10);
	var selHH = selDate.slice(0,12);
	var selThresholdHi = data.thresholdHi; //상한임계치
	var selThresholdLo = data.thresholdLo; //하한임계치
	var data3 = [];
	var arrData = [];
	var keysForChart = [];
	var valueForChart = [];
	var valueForChart2 = [];
	var valueForChart3 = [];
	var valueForChart4 = [];
	var jsJsonObj = new Object();
	$.ajax({
	type:"POST"
	,url: '/datas/selectDatasHT.do?searchCondition=H&siteno='+selSiteno+'&hh='+selDate+'00'
	,dataType: "json"
	,success: function(data2){
		//console.log(data2);
		data3 = (data2);
		keysForChart.push("hh");
		valueForChart.push("ou");
		valueForChart2.push("temperature");
		valueForChart3.push("humidity");
		valueForChart4.push("windspeed");
		for (var it = 0; it < data2.length; it++) { // data from an external json file. 
			//console.log(data2[it].hh);
			keysForChart.push(data2[it].hh);
			valueForChart.push(data2[it].ou);
			valueForChart2.push(data2[it].temperature);
			valueForChart3.push(data2[it].humidity);
			valueForChart4.push(data2[it].windspeed);
			//jsJsonObj[it] = data2[it].hh;
			//jsJsonObj[it] = data2[it].ou;
			jsJsonObj[0] = keysForChart
			jsJsonObj[1] = valueForChart;
			jsJsonObj[2] = valueForChart2;
			jsJsonObj[3] = valueForChart3;
			jsJsonObj[4] = valueForChart4;
		}
	
		//arrData.push(jsJsonObj);
		//console.log(jsJsonObj);
		//console.log(arrData);
		chart.load({
			unload: true,
			x: 'hh',
			xFormat: '%Y%m%d%H',
			columns: [
			          keysForChart,
			          valueForChart,
			          valueForChart2,
			          valueForChart3,
			          valueForChart4,
			          ],
	        type: 'line',
	        done: function() {
	         chart.hide();
	         //chart.show(['ou']);
	         iot_chart_select(selType);
		     //console.log(selType);
				chart.xgrids([
					  			{value: selHH, text: 'CHOOSE'} //선택된 이벤트
					  		]);
				chart.ygrids([
					  			{value: selThresholdHi, class: 'gridup'}, //상한임계치
					  			{value: selThresholdLo, class: 'griddown'}, //하한임계치
					  		]);
	        },
		});

	}
	,error: function(data2){
	//console.log(data);
	}
	});

}

/*기간검색*/
function iotStatH_chart(data){
	//날짜형식
	var dateFormat = (data.searchGubun=='y'?'%Y':data.searchGubun=='m'?'%Y%m':data.searchGubun=='d'?'%Y%m%d':data.searchGubun=='h'?'%Y%m%d%H':'');
	//console.log('===== dateFormat:'+dateFormat);
	d3.json("/datas/selectDatasHS.do?search=1&startDate="+data.startDate+"&endDate="+data.endDate+"&searchGubun="+data.searchGubun,function(error,data){
		//data.forEach(function(d){console.log(d)})
		//console.log(data);
		if(data.length<1){console.log('1 데이터가 없습니다.');alert('출력할 악취 데이터가 없습니다.');}
		
		charth1.load({
			xFormat: dateFormat,
			json:data,
            keys: {
                x: 'hh', // it's possible to specify 'x' when category axis
                value: ['s1', 's102', 's103', 's104', 's105', 's106', 's107', 's108', 's109', 's110', 's1101', 's1102', 's1103', 's1104', 's1105', 's1106', 's1107', 's1108', 's1109', 's1110', 's1111', 's1112', 's1113', 's1114', 's1115', 's1116', 's1117'],
            }
		});
	});
	d3.json("/datas/selectDatasHS.do?search=2&startDate="+data.startDate+"&endDate="+data.endDate+"&searchGubun="+data.searchGubun,function(error,data){
		//data.forEach(function(d){console.log(d)})
		//console.log(data);
		if(data.length<1){console.log('2 데이터가 없습니다.');alert('출력할 온도 데이터가 없습니다.');};
		charth2.load({
			xFormat: dateFormat,
	        json:data,
            keys: {
                x: 'hh', // it's possible to specify 'x' when category axis
                value: ['s1', 's102', 's103', 's104', 's105', 's106', 's107', 's108', 's109', 's110', 's1101', 's1102', 's1103', 's1104', 's1105', 's1106', 's1107', 's1108', 's1109', 's1110', 's1111', 's1112', 's1113', 's1114', 's1115', 's1116', 's1117'],
            }
		});
	});			
	d3.json("/datas/selectDatasHS.do?search=3&startDate="+data.startDate+"&endDate="+data.endDate+"&searchGubun="+data.searchGubun,function(error,data){
		//data.forEach(function(d){console.log(d)})
		//console.log(data);
		if(data.length<1){console.log('3 데이터가 없습니다.');alert('출력할 습도 데이터가 없습니다.');};
		charth3.load({
			xFormat: dateFormat,
	        json:data,
            keys: {
                x: 'hh', // it's possible to specify 'x' when category axis
                value: ['s1', 's102', 's103', 's104', 's105', 's106', 's107', 's108', 's109', 's110', 's1101', 's1102', 's1103', 's1104', 's1105', 's1106', 's1107', 's1108', 's1109', 's1110', 's1111', 's1112', 's1113', 's1114', 's1115', 's1116', 's1117'],
            }
		});
	});
	d3.json("/datas/selectDatasHS.do?search=4&startDate="+data.startDate+"&endDate="+data.endDate+"&searchGubun="+data.searchGubun,function(error,data){
		//data.forEach(function(d){console.log(d)})
		//console.log(data);
		if(data.length<1){console.log('4 데이터가 없습니다.');alert('출력할 풍속 데이터가 없습니다.');};
		charth4.load({
			xFormat: dateFormat,
	        json:data,
            keys: {
                x: 'hh', // it's possible to specify 'x' when category axis
                value: ['s1', 's102', 's103', 's104', 's105', 's106', 's107', 's108', 's109', 's110', 's1101', 's1102', 's1103', 's1104', 's1105', 's1106', 's1107', 's1108', 's1109', 's1110', 's1111', 's1112', 's1113', 's1114', 's1115', 's1116', 's1117'],
            }
		});
	});
}

/*실시간모니터링*/
function iotStatM_chart(data){
	d3.json("/datas/selectDatasMS.do?search=1&startDate="+data.startDate+"&endDate="+data.endDate+"&searchGubun="+data.searchGubun,function(error,data){
		//data.forEach(function(d){console.log(d)})
		//console.log(data);
		//if(data.length<1){console.log('1 데이터가 없습니다.');alert('출력할 악취 데이터가 없습니다.');}
		chartm1.load({
	        json:data,
            keys: {
                x: 'hh', // it's possible to specify 'x' when category axis
                value: ['s1', 's102', 's103', 's104', 's105', 's106', 's107', 's108', 's109', 's110', 's1101', 's1102', 's1103', 's1104', 's1105', 's1106', 's1107', 's1108', 's1109', 's1110', 's1111', 's1112', 's1113', 's1114', 's1115', 's1116', 's1117'],
            }
		});
	});
	d3.json("/datas/selectDatasMS.do?search=2&startDate="+data.startDate+"&endDate="+data.endDate+"&searchGubun="+data.searchGubun,function(error,data){
		//data.forEach(function(d){console.log(d)})
		//console.log(data);
		//if(data.length<1){console.log('2 데이터가 없습니다.');alert('출력할 온도 데이터가 없습니다.');};
		chartm2.load({
	        json:data,
            keys: {
                x: 'hh', // it's possible to specify 'x' when category axis
                value: ['s1', 's102', 's103', 's104', 's105', 's106', 's107', 's108', 's109', 's110', 's1101', 's1102', 's1103', 's1104', 's1105', 's1106', 's1107', 's1108', 's1109', 's1110', 's1111', 's1112', 's1113', 's1114', 's1115', 's1116', 's1117'],
            }
		});
	});			
	d3.json("/datas/selectDatasMS.do?search=3&startDate="+data.startDate+"&endDate="+data.endDate+"&searchGubun="+data.searchGubun,function(error,data){
		//data.forEach(function(d){console.log(d)})
		//console.log(data);
		//if(data.length<1){console.log('3 데이터가 없습니다.');alert('출력할 습도 데이터가 없습니다.');};
		chartm3.load({
	        json:data,
            keys: {
                x: 'hh', // it's possible to specify 'x' when category axis
                value: ['s1', 's102', 's103', 's104', 's105', 's106', 's107', 's108', 's109', 's110', 's1101', 's1102', 's1103', 's1104', 's1105', 's1106', 's1107', 's1108', 's1109', 's1110', 's1111', 's1112', 's1113', 's1114', 's1115', 's1116', 's1117'],
            }
		});
	});
	d3.json("/datas/selectDatasMS.do?search=4&startDate="+data.startDate+"&endDate="+data.endDate+"&searchGubun="+data.searchGubun,function(error,data){
		//data.forEach(function(d){console.log(d)})
		//console.log(data);
		//if(data.length<1){console.log('4 데이터가 없습니다.');alert('출력할 풍속 데이터가 없습니다.');};
		chartm4.load({
	        json:data,
            keys: {
                x: 'hh', // it's possible to specify 'x' when category axis
                value: ['s1', 's102', 's103', 's104', 's105', 's106', 's107', 's108', 's109', 's110', 's1101', 's1102', 's1103', 's1104', 's1105', 's1106', 's1107', 's1108', 's1109', 's1110', 's1111', 's1112', 's1113', 's1114', 's1115', 's1116', 's1117'],
            }
		});
	});
}