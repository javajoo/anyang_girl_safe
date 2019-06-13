/* 모니터링-조회 */
function search_iotM(){
	//조회 들어가야됨
	$('#iotM_table').datagrid('loadData', {"total":0,"rows":[]});
	$('#iotM_table').datagrid('options').url = "lasts/selectLasts.do";
	$('#iotM_table').datagrid('options').pageNumber = 1;
	$('#iotM_table').datagrid('load', {
		search: $("#search_iotM_nm").val()
    });
}
var p;	//악취농도
var p_l;	//악취농도_하한
var p_h;	//악취농도_상한
var c;	//온도
var c_l;	//온도_하한
var c_h;	//온도_상한
var g;	//습도
var g_l;	//습도_하한
var g_h;	//습도_상한
var m;	//풍속
var m_l;	//풍속_하한
var m_h;	//풍속_상한
/* 모니터링-리스트클릭 */
function selectIoTM(row, data){
	//변수 저장
	p = data.ou;	//악취농도
	p_l = data.ouLo;
	p_h = data.ouHi;
	c = data.temperature;	//온도
	c_l = data.temperatureLo;
	c_h = data.temperatureHi;
	g = data.humidity;	//습도
	g_l = data.humidityLo;
	g_h = data.humidityHi;
	m = data.windspeed;	//풍속
	m_l = data.windspeedLo;
	m_h = data.windspeedHi;

	var date = new Date();
	var endDate = (date.toLocaleString());
	date.setDate(date.getDate() -1);
	var startDate = date.toLocaleString();
	var iotDate = startDate + ' ~ ' + endDate;
	
	//console.log(iotDate);
	//console.log(data.date);
	
	//그래프 초기화
	iotM_graph_chenge2(1);
	$('#search_iotM_graph_tab .easyui-linkbutton:eq(0)').linkbutton('select');
	$('#search_iotM_graph_tab .easyui-linkbutton').linkbutton('resize', {height: 37});
	$('.l-btn-left').css('margin-top',0);

	//지도이동 및 선택레이어
	selectIoTGIS(row, data);
	
	//그래프 표출
	iot_graph('show','calc(100% - 370px)');
	$('#iot_event_adres').text(data.name);	//시설물명
	$('#iotM_event_term').text(iotDate);	//현재시간 24시간
	iot_chart(data);
}

/* 모니터링 더블클릭시 - 실시간 영상표출 */
/*function selectIotMRow(row, data){
	console.log("selectIotMRow! "+data.siteno);
	//document.AthenaStream.DAS_ConnectVideoStreamSingle("172.20.20.100", 10002, 20014, 0, "윤일로");
	selectFacilityToSiteno(data.siteno);
}*/

/*function selectFacilityToSiteno(siteno) {
	var object = new Object();
	object.siteno = siteno;
	$.ajax({
		url : encodeURI("/com/danusys/platform/selectFacilityToSiteno.do"),
		type : "get",
		data : object,
		success : function(datas, textStatus, jQxhr) {
			if(datas.length != 0) {
				console.log("selectFacilityToSiteno! "+datas[0].nodeIp+", "+datas[0].nodePort+", "+datas[0].nodeId+", "+datas[0].cctvNm);
				document.AthenaStream.DAS_ConnectVideoStreamSingle(datas[0].nodeIp, datas[0].nodePort, datas[0].nodeId, 0, datas[0].cctvNm);
			} else {
				alert("연결되어있는 카메라가 없습니다.");
			}
		},
		error : function(jqXhr, textStatus, errorThrown) {
			alert("데이터를 update하는데 실패했습니다.");
		}
	});
}*/

/* 환경단위 */
function fn_unit(s,v){
	var obj = [];
	obj[0] = ['name','현재악취','현재온도','현재습도','현재풍속']; //수치명
	obj[1] = ['unit','OU/㎥','ºC','%','m/s']; //수치단위
	obj[2] = ['up', p_h, c_h, g_h, m_h]; //상한임계치
	obj[3] = ['down', p_l, c_l, g_l, m_l]; //하한임계치
	obj[4] = ['real', p, c, g, m]; //현재수치
	return obj[s][v];
}

/* 모니터링 그래프 - 콤보데이터 변경 */ 
function iotM_graph_chenge(){
	//var val = $('#search_iotM_graph_gbn').combo('getValue');
	
	/*if(val==1){	//악취

		$('#iotM_graph_unit #unit_up').text(p_h);
		$('#iotM_graph_unit #unit_down').text(p_l);
		$('#unit_now em').text('현재악취');
		$('#unit_now_value').text(p);
		$('#unit_now_tag').text('OU/㎥');
		$('#unit_area em').text('OU/㎥');
	}
	else if(val==2){	//온도
		$('#iotM_graph_unit #unit_up').text(c_h);
		$('#iotM_graph_unit #unit_down').text(c_l);
		$('#unit_now em').text('현재온도');
		$('#unit_now_value').text(c);
		$('#unit_now_tag').text('ºC');
		$('#unit_area em').text('ºC');
	}
	else if(val==3){	//습도
		$('#iotM_graph_unit #unit_up').text(g_h);
		$('#iotM_graph_unit #unit_down').text(g_l);
		$('#unit_now em').text('현재습도');
		$('#unit_now_value').text(g);
		$('#unit_now_tag').text('%');
		$('#unit_area em').text('%');
	}
	else if(val==4){	//풍속
		$('#iotM_graph_unit #unit_up').text(m_h);
		$('#iotM_graph_unit #unit_down').text(m_l);
		$('#unit_now em').text('현재풍속');
		$('#unit_now_value').text(m);
		$('#unit_now_tag').text('m/s');
		$('#unit_area em').text('m/s');
	}*/
	
	$('#unit_now em').text(fn_unit(0,val)); // 수치단위명
	$('#unit_now_value').text(fn_unit(4,val)); // 수치값
	$('#unit_now_tag').text(fn_unit(1,val)); // 수치단위
	$('#iotM_graph_unit #unit_up').text(fn_unit(2,val)); // 상한임계치
	$('#iotM_graph_unit #unit_down').text(fn_unit(3,val));	// 하한임계치
	$('#iotM_graph_unit .unit_area em').text(fn_unit(1,val));	// 상하 임계치 수치단위

	//타입별 그래프 차트 선택
	iot_chart_select(val);

	//상한임계치, 하한임계치
	//iot_chart_updown(fn_unit(2,val),fn_unit(3,val))

}
/* 모니터링 그래프 - 탭데이터 변경 */ 
function iotM_graph_chenge2(v){
	var val = String(v);
	//var val = $('#search_iotM_graph_gbn').combo('getValue');
	
	/*if(val==1){	//악취

		$('#iotM_graph_unit #unit_up').text(p_h);
		$('#iotM_graph_unit #unit_down').text(p_l);
		$('#unit_now em').text('현재악취');
		$('#unit_now_value').text(p);
		$('#unit_now_tag').text('OU/㎥');
		$('#unit_area em').text('OU/㎥');
	}
	else if(val==2){	//온도
		$('#iotM_graph_unit #unit_up').text(c_h);
		$('#iotM_graph_unit #unit_down').text(c_l);
		$('#unit_now em').text('현재온도');
		$('#unit_now_value').text(c);
		$('#unit_now_tag').text('ºC');
		$('#unit_area em').text('ºC');
	}
	else if(val==3){	//습도
		$('#iotM_graph_unit #unit_up').text(g_h);
		$('#iotM_graph_unit #unit_down').text(g_l);
		$('#unit_now em').text('현재습도');
		$('#unit_now_value').text(g);
		$('#unit_now_tag').text('%');
		$('#unit_area em').text('%');
	}
	else if(val==4){	//풍속
		$('#iotM_graph_unit #unit_up').text(m_h);
		$('#iotM_graph_unit #unit_down').text(m_l);
		$('#unit_now em').text('현재풍속');
		$('#unit_now_value').text(m);
		$('#unit_now_tag').text('m/s');
		$('#unit_area em').text('m/s');
	}*/
	
	$('#unit_now em').text(fn_unit(0,val)); // 수치단위명
	$('#unit_now_value').text(fn_unit(4,val)); // 수치값
	$('#unit_now_tag').text(fn_unit(1,val)); // 수치단위
	$('#iotM_graph_unit #unit_up').text(fn_unit(2,val)); // 상한임계치
	$('#iotM_graph_unit #unit_down').text(fn_unit(3,val));	// 하한임계치
	$('#iotM_graph_unit .unit_area em').text(fn_unit(1,val));	// 상하 임계치 수치단위

	//타입별 그래프 차트 선택
	iot_chart_select(val);

	//상한임계치, 하한임계치
	//iot_chart_updown(fn_unit(2,val),fn_unit(3,val))

}

/* 히스토리-조회 */
function search_iotH(){
	$('#iotH_table').datagrid('loadData', {"total":0,"rows":[]});
	$('#iotH_table').datagrid('options').url = "lasts/getIotEventHistory.do";
	$('#iotH_table').datagrid('options').pageNumber = 1;
	$('#iotH_table').datagrid('load', {
		type: $('#search_iotH_gbn').combo('getValue'),
		search: $("#search_iotH_nm").val(),
		pageSize: 13
    });
	$('#iotH_table').datagrid({
		onLoadSuccess:function(data){
			console.log(data);
			createIconIoT();
		}});
}
/* 히스토리지도아이콘 */
function createIconIoT(){
	layerClean(eventLayer);
	var rows = $('#iotH_table').datagrid('getData').rows;
	for(var i=0; i<rows.length; i++){
		var data = rows[i];
		createFeatureIoT(data);
	}
}
/* 히스토리지도아이콘 표출 */
function createFeatureIoT(data){
	if(eventLayer == null){
		return;;
	}
	if(data.longitude > 0){
		var feature = new OpenLayers.Feature.Vector(
	            new OpenLayers.Geometry.Point(data.longitude,data.latitude).transform(projectionGroup["grs80"], projectionGroup["google"]),
	            {id:data.siteNo, gpsX:data.longitude, gpsY:data.latitude} ,
	            {externalGraphic: 'images/icons/man10r.png'/*+iconName*/, graphicHeight: 26, graphicWidth: 26, graphicXOffset:-13, graphicYOffset:-13}
	            );
		eventLayer.addFeatures(feature);
	}
}
/* 히스토리-리스트클릭 */
function selectIoTH(row, data){
	//console.log(data);
	//지도이동 및 선택레이어
	selectIoTGIS(row, data);

	//console.log(convertDate(data.date,12));
	
	//그래프 표출
	iot_graph('show','calc(100% - 370px)');
	$('#iot_event_adres').text(data.name);	//시설물명
	$('#iotH_event_de').text(data.date);	//날짜
	$('#iotH_event_term').text(convertDate(data.date,12));	// 앞뒤 12시간
	$('#iotH_graph_unit #unit_up').text(data.thresholdHi);	//상한임계치
	$('#iotH_graph_unit #unit_down').text(data.thresholdLo);	//하한임계치
	$('#iotH_graph_unit em').text(data.unit);	//단위
	
	iotH_chart(data);
}

/*리스트 클릭 시-= 지도아이콘 표출 및 센터 이동*/
function selectIoTGIS(row, data){
	layerClean(selectedImageLayer);
	if(data.longitude > 0){
		var feature = new OpenLayers.Feature.Vector(
		        new OpenLayers.Geometry.Point(data.longitude,data.latitude).transform(projectionGroup["grs80"], projectionGroup["google"]),
		        {} ,
		        {externalGraphic: 'images/icons/selected.png', graphicHeight: 32, graphicWidth: 32, graphicXOffset:-16, graphicYOffset:-16  }
		    );
		selectedImageLayer.addFeatures(feature);
		
		map.setCenter(new OpenLayers.LonLat(data.longitude,data.latitude).transform(new OpenLayers.Projection("EPSG:4326"),new OpenLayers.Projection("EPSG:900913")),14);
	}
	//else $.messager.alert("경고", "좌표값이 없습니다.",'warning');
}

/*그래프 표시 유/무 이벤트*/
function iot_graph(flag,height){
	$('#map').css('height',height);
	if (map != undefined) {
		setTimeout(function myFunction() {
			map.updateSize();
		}, 300);
	}
	
	if(flag == 'hide') $('.iot_graph_area').hide();
	else{
		$('.iot_graph_area').show();
		if(menuNm == 'iotM'){
			$('#iotM_graph_text').show();
			$('#iotM_graph_unit').show();
			$('#iotH_graph_text').hide();
			$('#iotH_graph_unit').hide();
		}
		else {
			$('#iotM_graph_text').hide();
			$('#iotM_graph_unit').hide();
			$('#iotH_graph_text').show();
			$('#iotH_graph_unit').show();
		}
	}
}

/** 날짜 포맷 형식 00 또는 0X */
function zeroPad(number) {
	return ( ( number < 10 ) ? "0" : "" ) + String(number);
}

/*년도-월-일*/
function myformatter(date){
    var y = date.getFullYear();
    var m = date.getMonth()+1;
    var d = date.getDate();
    var h = date.getHours();
    var mi= date.getMinutes();
    var s = date.getSeconds();
    return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
}
/*년도-월-일 시:분:초*/
function myformatterHMS(date){
    var y = date.getFullYear();
    var m = date.getMonth()+1;
    var d = date.getDate();
    var h = date.getHours();
    var mi= date.getMinutes();
    var s = date.getSeconds();
    return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d)+'T'+(h<10?('0'+h):h)+':'+(mi<10?('0'+mi):mi)+':'+(s<10?('0'+s):s);
}
/*년도-월-일 시:분*/
function myformatterHM(date){
    var y = date.getFullYear();
    var m = date.getMonth()+1;
    var d = date.getDate();
    var h = date.getHours();
    var mi= date.getMinutes();
    var s = date.getSeconds();
    return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d)+' '+(h<10?('0'+h):h)+':'+(mi<10?('0'+mi):mi);
}
function myparser(s){
    if (!s) return new Date();
    var ss = (s.split('-'));
    var y = parseInt(ss[0],10);
    var m = parseInt(ss[1],10);
    var d = parseInt(ss[2],10);
    if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
        return new Date(y,m-1,d);
    } else {
        return new Date();
    }
}
/* 특정시간 내 좌, 우 시간 간격 출력용 함수 
 * 김동식 2018-02-13
 * convertDate('2018-03-01 14:25:00',1);
*/
function convertDate(d,h){
	var pd = new Date(d.substr(0,4),d.substr(5,2)-1,d.substr(8,2),d.substr(11,2),d.substr(14,2));
	var ph = (1000*60*(h*60));
	var sDate = new Date(Date.parse(pd)-ph);
	var eDate = new Date(Date.parse(pd)+ph);
	var iotDate = sDate.toLocaleString() + ' ~ ' + eDate.toLocaleString();
	return iotDate;
}
/* 실시간 과거 시간 출력 함수 */
function convertDate2(d,h){
	var pd = new Date(d.substr(0,4),d.substr(5,2)-1,d.substr(8,2),d.substr(11,2),d.substr(14,2));
	var ph = (1000*60*(h*60));
	var sDate = new Date(Date.parse(pd)-ph);
	var eDate = new Date(Date.parse(pd));
	var iotDate = sDate.toLocaleString() + ' ~ ' + eDate.toLocaleString();
	return iotDate;
}
/* 기간검색 */
function search_iotStatH(){
		var data = {};
		data.startDate = $("#startDate").datebox('getValue').replace(/\//g, '');
		data.endDate = $("#endDate").datebox('getValue').replace(/\//g, '');
		data.searchGubun = $('#searchGubun').combo('getValue');
		var iotDate = data.startDate.toLocaleString() + ' ~ ' + data.endDate.toLocaleString();
		//console.log(iotDate);
		var currDay = 24*60*60*1000;
		var currMonth = currDay*30;
	    var currYear = currMonth*12;
		var setDiff = (new Date(data.endDate))-(new Date(data.startDate));
	    var setDay = parseInt(setDiff/currDay);
	    var setMonth = parseInt(setDiff/currMonth);
	    var setYear = parseInt(setDiff/currYear)

	    //console.log(setDiff);	    

		$('#iotStatH_management .table_title em').text(iotDate);
		if (!data.startDate||!data.endDate){
			alert('기간검색 날짜를 선택해주세요.');
			return;
		}else{
		    if(data.searchGubun=='d'&&setDay>24){alert('일일통계는 24일 이내로만 조회가 가능합니다.');return;}
		    else if(data.searchGubun=='m'&&setMonth>12){alert('월간통계는 12개월 이내로만 조회가 가능합니다.');return;}
		    else if(data.searchGubun=='m'&&setMonth<2){alert('월간통계는 2개월 이상으로만 조회가 가능합니다.');return;}
		    else if(data.searchGubun=='y'&&setYear<2){alert('연간통계는 2년 이상으로만 조회가 가능합니다.');return;}
		    else{
		    	iotStatH_chart(data);
		    }
		}
	
}


/* 실시간모니터링 */
var statMInter;
function search_iotStatM(){
		var data = {};
		//data.startDate = $("#startDate").datebox('getValue').replace(/\//g, '');
		//data.endDate = $("#endDate").datebox('getValue').replace(/\//g, '');
		var d = new Date();
		var pd = new Date(d.getFullYear(),d.getMonth(),d.getDate(),d.getHours(),d.getMinutes(),d.getSeconds());
		var ph = (1000*60*(24*60));
		var sDate = new Date(Date.parse(pd)-ph);
		var eDate = new Date();
		data.startDate = myformatterHMS(sDate);	
		data.endDate = myformatterHMS(eDate);
		data.searchGubun = 'h';
		//data.searchGubun = $('#searchGubun').combo('getValue');
		console.log(data);
		var iotDate = data.startDate + ' ~ ' + data.endDate;
		var currDay = 24*60*60*1000;
		var currMonth = currDay*30;
	    var currYear = currMonth*12;
		var setDiff = (new Date(data.endDate))-(new Date(data.startDate));
	    var setDay = parseInt(setDiff/currDay);
	    var setMonth = parseInt(setDiff/currMonth);
	    var setYear = parseInt(setDiff/currYear)

	    //console.log(setDiff);	    

		$('#iotStatM_management .table_title em').text(myformatterHM(eDate));
	    
	    statMInter = setInterval(function () {
	    	$('#iotStatM_management .table_title em').text(myformatterHM(new Date()));
	        //data.columns[0].push(Math.round(Math.random()*100));
	        //data.columns[0].splice(1,1);
	        //chart1.flow(data);
	        //chart2.load(data);
	    	iotStatM_chart(data);
	    }, 60000); 

		/*if (!data.startDate||!data.endDate){
			alert('기간검색 날짜를 선택해주세요.');
			return;
		}else{
		    if(data.searchGubun=='d'&&setDay>24){alert('일일통계는 24일 이내로만 조회가 가능합니다.');return;}
		    else if(data.searchGubun=='m'&&setMonth>12){alert('월간통계는 12개월 이내로만 조회가 가능합니다.');return;}
		    else if(data.searchGubun=='m'&&setMonth<2){alert('월간통계는 2개월 이상으로만 조회가 가능합니다.');return;}
		    else if(data.searchGubun=='y'&&setYear<2){alert('연간통계는 2년 이상으로만 조회가 가능합니다.');return;}
		    else{
		    	iotStatM_chart(data);
		    }
		}*/
	
}
function search_iotStatM_stop(){
	    	$('#iotStatM_management .table_title em').text('0000-00-00 00:00');
	    	//$('#iotStatM_management .stat_list_condi .list a').text('Start');
	    	//alert('모니터링이 진행중입니다.');
	    	console.log(statMInter);
	    	if(statMInter){clearInterval(statMInter);}
}