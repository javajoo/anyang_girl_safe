<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> </title>
<link type="text/css" rel="stylesheet" href="./css/print/print.css?ver=1">
<style type="text/css">
	html {
		height: 100%;
	}
	html::-webkit-scrollbar-track {
		-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
		background-color: #434343;
		border-radius: 5px;
	}
	html::-webkit-scrollbar {
		width: 12px;
		background-color: #434343;
		border-radius: 5px;
	}
	html::-webkit-scrollbar-thumb {
		-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
		background-color: #747474;
		border-radius: 5px;
	}
</style>
<script type="text/javascript" src="./js/jquery.min.js"></script>
<script type="text/javascript" src="./js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="./js/OpenLayers.js"></script>
<script type="text/javascript" src="./js/DFMSMap.js"></script>
<script type="text/javascript" src="./js/proj4js-compressed.js"></script>
<script type="text/javascript" src="./js/print/printMap.js?ver=1" charset="UTF-8"></script>

<script type="text/javascript">
var HKEY_Root, HKEY_Path, HKEY_Key;  
HKEY_Root = "HKEY_CURRENT_USER";  
HKEY_Path = "\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";

var map;
var tiltMap;
var mapCenter;

$(document).ready(function() {
	fnBaseMapAddIt();
	$("#tbDate").text("□ 출력일 : " + getDate());
});

function fnBaseMapAddIt() {
	map = new Map("mapImage", { //"map"은 지도를 표출할 div 아이디명          		
	    displayProjection : new OpenLayers.Projection("EPSG:5186"), // 표출 좌표계          		
	    projection : new OpenLayers.Projection("EPSG:900913"), // 기본 좌표계
	    maxResolution : 156543.0339, // 최대 해상도 (구글이나 Vworld 사용시 고정값)         		
	    maxExtent : this.maxExtent, // 최대 영역
	    restrictedExtent : new OpenLayers.Bounds(-20037508.34, -20037508.34, 20037508.34, 20037508.34),
	    numZoomLevels : 20, // 줌의 갯수 (구글이나 Vworld 사용시 고정값)          		
	    unit : "m", // 단위
	    controls:[new OpenLayers.Control.Navigation()]
	});           	            
	
    var layers = new Array();
    
    for(var i = 0; i < top.map.layers.length; i++){
    	if(!top.map.layers[i].visibility)
    		continue;
    	else {
    		layers.push(top.map.layers[i].clone());
    	}
    }

   	map.addLayers(layers);

   	mp = new OpenLayers.LonLat(<%=request.getParameter("pos_y")%>, <%=request.getParameter("pos_x")%>);
   	map.setCenter(mp, <%=request.getParameter("zoom")%>);

    PageUpdate('A4');
}


function getDate() {
	var d = new Date();
	
	var s = leadingZero(d.getFullYear(),4) + "-" + 
			leadingZero(d.getMonth() + 1,2) + "-" +
			leadingZero(d.getDate(),2);
			/*  + " "+
			leadingZero(d.getHours(),2) + ":" +
			leadingZero(d.getMinutes(),2) + ":" +
			leadingZero(d.getSeconds(),2);
			*/
	
	return s;

}

function leadingZero(n, digits) {
	var zero = "";
	n = n.toString();
	
	if(n.length < digits) {
		for(var i=0; i < digits - n.length; i++) {
			zero += "0";
		}
	}
	return zero + n;
}

</script>
</head>
<body leftmargin="0" topmargin="0" style="border:none; padding:0px; margin:0px; background: url('./images/print_bg.png') repeat center center;">

<table id="tlb_titile" border="0" width="880" >
    <tr>
        <td id="tbTitle" align="center" noWrap><div id="title" style="color: #000;">제목</div></td>
    </tr>
</table>
<table id="tlb_position" border="0" width="880" >
    <tr>
        <td id="tbPosition" align="left"><div id="position"></td>
        <td id="tbDate" align="right" width="200" ></td>
    </tr>
</table>
<div id="maps" style="position:relative; top:0px; left:8px; width:878px; height:490px; border:2px solid #000000; overflow:hidden;">
	<div id="mapImage" style="position:absolute;top:0px;left:-1px; background:white; width:878px; height:534px; z-index:1;"></div>
	<div id="tiltMapImage" style="position:absolute;top:0px;left:0px; width:878px; height:490px; z-index: 2;" ></div>
</div>
<div class="ClassDot">
<div style=" z-index: -6; width:100%; height:100%; border: #FFFF00 0px solid; position: absolute; top:0px; left:0px; display:inline;"></div>
<table border="0" width="100%" >
    <tr>
        <td align="center"><img src="./images/print/non.gif" height="84"></td>
    </tr>
</table>
</div>
<table id="tlb_content" border="0" width="880" style="margin:0px 0px 0px 0px">
    <tr>        
        <td id="tbContent" align="left" valign="top" width="100%" height="1"><div id="contents"><img src="./images/print/non.gif"></div></td>
    </tr>   
</table>
<table border="0" width="0" >
    <tr>
        <td align="left" style="position:relative;font-size:9pt">
            <div id="secret_sentence" style="position:relative;font-size:9pt">
                * 본 지도은 실제와 다소 다를 수 있고, 공개제한 지리정보가 포함되어 있으므로 무단 복제 및 배포를 금하오니 사용에 유의하시기 바랍니다.
            </div>
        </td>
    </tr>
</table>

</body>
</html>