<%--현황

  Class Name : EgovLoginUsr.jsp
  Description : Login 인증 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2016.08.17  신대영          최초 생성
 
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import ="egovframework.com.cmm.LoginVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	LoginVO resultVO = (LoginVO)request.getSession().getAttribute("LoginVO");
%>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>시설물 관리 시스템 통계</title>
<link rel="shortcut icon" href="./images/layout/favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="./css/style.css">
<link rel="stylesheet" type="text/css" href="./css/jquery.jqplot.min.css" />
<style type="text/css">      
	html, body, #map{        
		margin: 0;        
		width: 100%;        
		height: 100%;  
		overflow:hidden;    
	}    
	
	.statwin{
    	display:inline-block;
    	background:transparent;
    	position:absolute;  
    	z-index:999999;  
	}
	
	.ol-zoom {
    	display: none;
    }
	
</style>

<script type="text/javascript" src="./js/jquery.min.js"></script>
<script type="text/javascript" src="./js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="./js/datagrid-bufferview.js"></script>
<script type="text/javascript" src="./js/OpenLayers.js"></script>
<script type="text/javascript" src="./js/jquery.jqplot.min.js"></script>
<script type="text/javascript" src="./js/plugins/jqplot.pieRenderer.min.js"></script>
<script type="text/javascript" src="./js/plugins/jqplot.barRenderer.min.js"></script>
<script type="text/javascript" src="./js/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script type="text/javascript" src="./js/plugins/jqplot.highlighter.js"></script>
<script type="text/javascript" src="./js/plugins/jqplot.pointLabels.min.js"></script>

<script type="text/javascript">
	var map;        
	//var gisDFMSUrl = "http://office-gm.danusys.com:10002/geoserver/yi_safety/wms";
	var gisDFMSUrl = "http://127.0.0.1:10002/geoserver/yi_safety/wms";
	var maxExtent = new OpenLayers.Bounds(188512.045682269, 528785.13660256, 198481.917950083, 538980.804884668); // anyang시 경계
	
	
	function init(){
		$.jqplot.getTarget =  function(l_object) {
	        if (typeof l_object == "string") return $("#" + l_object);
	        if (l_object instanceof jQuery) return l_object;
	        if (l_object.nodeType) return $(l_object);
	        return $(l_object);
	    }
		
		map = new OpenLayers.Map("map", { //"map"은 지도를 표출할 div 아이디명          		
		    displayProjection : new OpenLayers.Projection("EPSG:5186"), // 표출 좌표계          		
		    projection : new OpenLayers.Projection("EPSG:5186"), // 기본 좌표계
		    maxExtent : this.maxExtent, // 최대 영역
		    unit : "m", // 단위
		    controls:[]
		});           	            

		addWMS(); // WMS 기본지도 추가
		
		map.zoomToMaxExtent();
		
		setTimeout( function myFunction2(){
			chartSelect();
			chartSelect2();
		}, 1000);
	}
	
	function addWMS(){ // WMS 레이어 추가
		var layer = new OpenLayers.Layer.WMS(      				
		    "BOUNDARY", // 임의의 레이어 명칭     				
		    gisDFMSUrl, // WMS 경로      				
		    {      					
		      	layers : "lp_aa_emd_s",
		      	format: "image/png",
	            transparent: true
		    },{
		    	version: "1.3.0",
	            singleTile: true,
		    	isBaseLayer : true
		    }
		);      		
		map.addLayer(layer);   // 생성한 WMS 레이어 추가
	}

	function resizeMe(){
		if(map != undefined){
			setTimeout( function myFunction(){
				map.updateSize();
				map.zoomToMaxExtent();
				
				chartSelect();
			}, 500);
		}
	}
	
	function chartSelect(){
		$(".statwin").remove();
		
		var data = $("#detailStat").datagrid("getData");
		
		var maxVal = 0;
		var maxVal2 = 0;
		for(i = 0; i < data.rows.length; i++){
			if(maxVal < parseInt(data.rows[i].total))
				maxVal = parseInt(data.rows[i].total);
			if(maxVal2 < parseInt(data.rows[i].app))
				maxVal2 = parseInt(data.rows[i].app);
			if(maxVal2 < parseInt(data.rows[i].etc))
				maxVal2 = parseInt(data.rows[i].etc);
			if(maxVal2 < parseInt(data.rows[i].irrgl))
				maxVal2 = parseInt(data.rows[i].irrgl);
			if(maxVal2 < parseInt(data.rows[i].its))
				maxVal2 = parseInt(data.rows[i].its);
			if(maxVal2 < parseInt(data.rows[i].park))
				maxVal2 = parseInt(data.rows[i].park);
			if(maxVal2 < parseInt(data.rows[i].police))
				maxVal2 = parseInt(data.rows[i].police);
		}
		
		for(i = 0; i < data.rows.length; i++){
			var data2 = [[['APP장비', parseInt(data.rows[i].app)], ['기타시설물', parseInt(data.rows[i].etc)], ['불법주정차', parseInt(data.rows[i].irrgl)], ['ITS', parseInt(data.rows[i].its)], ['공원', parseInt(data.rows[i].park)], ['방범', parseInt(data.rows[i].police)]]];

			if($("#chartType").combobox("getValue") == "pie")
				addPieChart(data.rows[i].emdCd, data.rows[i].emdKorNm, parseFloat(data.rows[i].xPos), parseFloat(data.rows[i].yPos), data2, parseFloat(data.rows[i].total)/maxVal*1.5);
			else
				addBarChart(data.rows[i].emdCd, data.rows[i].emdKorNm, parseFloat(data.rows[i].xPos), parseFloat(data.rows[i].yPos), data2, maxVal2);
		}
	}
	
	
	function addPieChart(id, title, x, y, data, ratio){
		var pixel = map.getPixelFromLonLat(new OpenLayers.LonLat(x, y));
		
		var mapSize = map.getSize();
		
		var mySize = mapSize.w/4*ratio;
		
		if(mapSize.w > mapSize.h)
			mySize = mapSize.h/4*ratio;
		
		if(mySize < 120){
			mySize = 120;
		}
		
		div = $("<div />");
        div.attr("id", id);
        div.attr("class", 'statwin');
        div.css("top", (pixel.y-mySize/2)+"px");
        div.css("left", (pixel.x-mySize/2)+"px");
        div.css("width", mySize+"px");
        div.css("height", mySize+"px");

        $("#map").append(div);
        
        
        var plot1 = $.jqplot(id, data, {
        	animate: true,
            animateReplot: true,
        	title:'<b>'+title+'</b>',
        	seriesColors:['#85802b', '#00749F', '#73C774', '#C7754C', '#17BDB8', '#B802B8'],
            seriesDefaults:{
            	shadow: true,
            	renderer:$.jqplot.PieRenderer, 
                trendline:{ show:false }, 
                rendererOptions: { showDataLabels: true, fill: true, sliceMargin: 4,
                	animation: {
                        speed: 2000
                    }
                	}
            },
            grid: {
               	 	drawGridLines: false,        // wether to draw lines across the grid or not.
                    background: 'transparent',      // CSS color spec for background color of grid.
                    borderColor: 'transparent',     // CSS color spec for border around grid.
                    shadow: false               // draw a shadow for grid.
            },
            legend:{
                show:false
            },
            highlighter: {
                show: true,
                useAxesFormatters: false,
                tooltipFormatString: '%s'
            }
        });
		
	}

	function addBarChart(id, title, x, y, data, maxVal){
		var pixel = map.getPixelFromLonLat(new OpenLayers.LonLat(x, y));
		
		var mapSize = map.getSize();
		
		var mySize = mapSize.w/4;
		
		if(mapSize.w > mapSize.h)
			mySize = mapSize.h/4;
		
		if(mySize > 120){
			mySize = 120;
		}
		
		div = $("<div />");
        div.attr("id", id);
        div.attr("class", 'statwin');
        div.css("top", (pixel.y-mySize/2)+"px");
        div.css("left", (pixel.x-mySize/2)+"px");
        div.css("width", mySize+"px");
        div.css("height", mySize+"px");

        $("#map").append(div);
        
        
        $('#'+id).jqplot(data, {
        	animate: true,
            animateReplot: true,
            title:title,
            // Provide a custom seriesColors array to override the default colors.
            seriesColors:['#85802b', '#00749F', '#73C774', '#C7754C', '#17BDB8', '#B802B8'],
            seriesDefaults:{
                renderer:$.jqplot.BarRenderer,
                rendererOptions: {
                    // Set varyBarColor to tru to use the custom colors on the bars.
                    varyBarColor: true,
                	animation: {
                        speed: 2000
                    }
                }
            },
            grid: {
                drawGridLines: true,        // wether to draw lines across the grid or not.
                    gridLineColor: 'transparent',   // CSS color spec of the grid lines.
                    background: 'transparent',      // CSS color spec for background color of grid.
                    borderColor: 'transparent',     // CSS color spec for border around grid.
                    shadow: false
            },
            axes:{
                xaxis:{
                    renderer: $.jqplot.CategoryAxisRenderer
                },
                yaxis: {
                    min:0,
                    max:maxVal
                }
            }
        });
        
        $(".jqplot-yaxis-tick").hide();
        $(".jqplot-xaxis-tick").hide();
		
	}

	function chartSelect2(){
		if($("#chartType2").combobox("getValue") == "pie")
			addMainPieChart();
		else
			addMainBarChart();
	}
	
	function addMainBarChart(){
		try{
		$("#barchart").remove();
		
		div = $("<div />");
        div.attr("id", "barchart");
        div.css("width", "100%");
        div.css("height", "100%");

        $("#mainChart").append(div);
		
		var data = $("#mainStat").datagrid("getData");
		
        var line1 = [['APP장비', parseInt(data.rows[0].app)], ['기타시설물', parseInt(data.rows[0].etc)], ['불법주정차', parseInt(data.rows[0].irrgl)], ['ITS', parseInt(data.rows[0].its)], ['공원', parseInt(data.rows[0].park)], ['방범', parseInt(data.rows[0].police)]];
        
        $('#barchart').jqplot([line1], {
        	animate: true,
            animateReplot: true,
            title:'전체 CCTV 현황',
            // Provide a custom seriesColors array to override the default colors.
            seriesColors:['#85802b', '#00749F', '#73C774', '#C7754C', '#17BDB8', '#B802B8'],
            seriesDefaults:{
            	pointLabels: { show:true } ,
                renderer:$.jqplot.BarRenderer,
                rendererOptions: {
                    // Set varyBarColor to tru to use the custom colors on the bars.
                    varyBarColor: true,
                	animation: {
                        speed: 2000
                    }
                }
            },
            axes:{
                xaxis:{
                    renderer: $.jqplot.CategoryAxisRenderer
                }
            },
            legend:{
                show:false
            }       
        });
		}catch(excep){}
	}
	
	function addMainPieChart(){
		try{
		$("#barchart").remove();
		
		div = $("<div />");
        div.attr("id", "barchart");
        div.css("width", "100%");
        div.css("height", "100%");

        $("#mainChart").append(div);
		
		var data = $("#mainStat").datagrid("getData");
		
        var line1 = [[['APP장비', parseInt(data.rows[0].app)], ['기타시설물', parseInt(data.rows[0].etc)], ['불법주정차', parseInt(data.rows[0].irrgl)], ['ITS', parseInt(data.rows[0].its)], ['공원', parseInt(data.rows[0].park)], ['방범', parseInt(data.rows[0].police)]]];
        
        $("#barchart").jqplot(line1, {
        	animate: true,
            animateReplot: true,
        	title:'<b>전체 CCTV 형황</b>',
        	seriesColors:['#85802b', '#00749F', '#73C774', '#C7754C', '#17BDB8', '#B802B8'],
            seriesDefaults:{
            	shadow: true,
            	renderer:$.jqplot.PieRenderer, 
                trendline:{ show:false }, 
                rendererOptions: { showDataLabels: true, fill: true, sliceMargin: 4,
                	animation: {
                        speed: 2000
                    }
                	}
            },
            legend:{
                show:true
            },
            highlighter: {
                show: true,
                useAxesFormatters: false,
                tooltipFormatString: '%s'
            }       
        });
		}catch(excep){}
	}
	
	function collaspeAll(){
		$('#mainLayout').layout('collapse','south');
		$('#mainLayout2').layout('collapse','east');
		$('#map_expend').linkbutton('disable');
		$('#map_collapse').linkbutton('enable');
	}

	function expandAll(){
		$('#mainLayout').layout('expand','south');
		$('#mainLayout2').layout('expand','east');
		$('#map_expend').linkbutton('enable');
		$('#map_collapse').linkbutton('disable');
	}
</script>
</head>
<body onload="init()">
<div id="mainLayout" class="easyui-layout" style="width:100%;">
    <!-- header -->
    <div data-options="region:'north'" style="height:85px;padding:15px 10px 0 10px;border:0;border-bottom:1px solid #3774b3;">
        <h1 class="blind">시설물관리시스템</h1>
        <h2 class="logo_tit">시설물관리시스템 현황</h2>
        <!-- utill_cont -->
        <div class="utill_cont">
            <select class="easyui-combobox" name="statType" id="statType" style="width:200px;">
                <option value="0" selected>CCTV 종류별 현황</option>
            </select>
            <div class="btn_area">
                <a href="#" id="map_expend" onclick="collaspeAll();" class="easyui-linkbutton" data-options="iconCls:'icon-expand',toggle:false">지도확장</a>
                <a href="#" id="map_collapse" onclick="expandAll();" class="easyui-linkbutton" data-options="iconCls:'icon-collapse',toggle:false,disabled:true">지도축소</a>
            </div>
        </div>
        <!-- //utill_cont -->
    </div>
    <!-- //header -->

    <div data-options="region:'center'" style="width:100%;height:70%;">
		<div id="mainLayout2" class="easyui-layout" style="width:100%;height:100%;">
        	<!-- Map -->
            <div id="map" data-options="region:'center', onResize:function(){resizeMe();}" style="padding:15px;">
            </div>
        	<!-- //Map -->

        	<!-- east Conntents -->
            <div data-options="region:'east',split:true, collapsedSize:0" style="width:50%;padding:15px;">
                <div class="hr10 t_right">
                    <select class="easyui-combobox" data-options="onSelect:chartSelect" name="chartType" id="chartType" style="width:100px;">
                        <option value="pie" selected>파이차트</option>
                        <option value="bar">바차트</option>
                    </select>
                </div>
                <!-- table_box -->
                <div class="table_box">
                <table id="detailStat" class="easyui-datagrid" title="지역별 CCTV 현황" style="width:100%;height:300px"
                    data-options="singleSelect:true,collapsible:true,url:'cw/safety/danusys/com/selectCctvStatList.do?gbn=0',method:'get'">
                    <thead>
                        <tr>
                            <th data-options="field:'emdKorNm',width:100">동명칭</th>
                            <th data-options="field:'app',width:100">APP 장비</th>
                            <th data-options="field:'irrgl',width:100">불법주정차</th>
                            <th data-options="field:'its',width:100">ITS</th>
                            <th data-options="field:'park',width:100">공원</th>
                            <th data-options="field:'police',width:100">방범</th>
                            <th data-options="field:'etc',width:100">기타</th>
                            <th data-options="field:'total',width:100">계</th>
                            <th data-options="field:'xPos',width:100,hidden:true">X</th>
                            <th data-options="field:'yPos',width:100,hidden:true">Y</th>
                            <th data-options="field:'emdCd',width:100,hidden:true">동명칭</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>

                </table>
                </div>
                <!-- //table_box -->
            </div>
        	<!-- //east Conntents -->
        </div>

    </div>
    <!-- //상단 Contents -->

    <!-- 하단 Contents -->
    <div  data-options="region:'south',split:true, collapsedSize:40" style="width:100%;height:30%;">
        <div class="easyui-layout" style="width:100%;height:100%;">
            <div id="mainChart" data-options="region:'center'" style="padding:15px;">
            </div>
            <div data-options="region:'east',split:true,onResize:function(){chartSelect2();}"  style="width:50%;padding:15px;">
                <div class="hr10 t_right">
                    <select class="easyui-combobox" data-options="onSelect:chartSelect2" name="chartType2" id="chartType2" style="width:100px;">
                        <option value="pie">파이차트</option>
                        <option value="bar" selected>바차트</option>
                    </select>
                </div>
                
                <div class="table_box">
					<table id="mainStat" class="easyui-datagrid" title="전체  CCTV 현황" style="width:100%;height:200px"
            			data-options="singleSelect:true,collapsible:true,url:'cw/safety/danusys/com/selectCctvStatList.do?gbn=1',method:'get'">
        				<thead>
            				<tr>
                				<th data-options="field:'app',width:100">APP 장비</th>
                				<th data-options="field:'irrgl',width:100">불법주정차</th>
                				<th data-options="field:'its',width:100">ITS</th>
                				<th data-options="field:'park',width:100">공원</th>
                				<th data-options="field:'police',width:100">방범</th>
                				<th data-options="field:'etc',width:100">기타</th>
                				<th data-options="field:'total',width:100">계</th>
            				</tr>
        				</thead>
    				</table>
        		</div>
    		</div>
        </div>
    </div>
</div>
<footer>
<div class="cont">Copyright All rights Reserved 2016 by Anyang City</div>
</footer>
</body>
</html>