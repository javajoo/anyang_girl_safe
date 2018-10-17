var nearFeatures = [];

/*마우스초기화*/
function initMouseControl(){
	controlGroup = {
			zoombox: new OpenLayers.Control.ZoomBox(),
			zoomboxout: new OpenLayers.Control.ZoomBox({out:true}),
			pantool: new OpenLayers.Control.Navigation({handleRightClicks:true}),
			history: new OpenLayers.Control.NavigationHistory()
	};
	for (var ky in controlGroup) {
		map.addControl(controlGroup[ky]);
	}
}

/*마우스컨트롤*/
function deactivateControls() {
	controlGroup.zoombox.deactivate();
	controlGroup.zoomboxout.deactivate();
	map.initMeasurement();
	//selectedImageLayer.deactivate();
	controlGroup.pantool.activate();
	
	$('#map_zoomin').linkbutton('unselect');
	$('#map_zoomout').linkbutton('unselect');
	$('#map_move').linkbutton('unselect');
	$('#map_info').linkbutton('unselect');
	$('#map_measure_len').linkbutton('unselect');
	$('#map_measure_area').linkbutton('unselect');
	
	map.events.unregister("click", map, handleSelection);
	if (typeof(facilitySelectControl) != "undefined") {
		facilitySelectControl.deactivate();
	}
}

var onPopupClose = function() {
	eventSelectControl.unselectAll();
	if(eventPopup != undefined) {
		map.removePopup(eventPopup);
	}
}

function sortEmergengy(features) {
	var tempFeatures = features;
	var listArray = [];
	
	for (var i in tempFeatures) {
		var data = tempFeatures[i].data;
		var emergency = data.emergency;
		if (emergency == 1) {
			listArray.push(tempFeatures[i]);
			tempFeatures.splice(i, 1);
			continue;
		}
	}
	
	for (var i in tempFeatures) {
		var data = tempFeatures[i].data;
		var emergency = data.emergency;
		listArray.push(tempFeatures[i]);
	}
	
	return listArray;
}

function popupListActiveClear() {
	var popupList = $('#popup_list_area li a');
	popupList.each(function(index) {
		$(this).removeClass('active');
	});
}

function setEventPopupValues(obj) {
	popupListActiveClear();
	$(obj).addClass('active');
	
	var name = $(obj).text();
	for ( var i in nearFeatures) {
		var data = nearFeatures[i].data;
		var featureName = data.name;
		if (featureName == name) {
			$('#event_popup_event_name').text(data.name);
			$('#event_popup_event_age').text(data.age);
			$('#event_popup_event_phoneNumber').text(data.phoneNumber);
			$('#event_popup_event_address').text(data.address);
			$('#event_popup_event_sPhoneNumber').text(data.sPhoneNumber);
		}
	}
}

function openFeaturePopup(feature) {
    var data = feature.data;
    var geoX = data.gpsX;
    var geoY= data.gpsY;
    
    if(selectedFeature != undefined) {
        if(selectedFeature.popup != null) {
            map.removePopup(selectedFeature.popup);
            selectedFeature.popup = null;
       }
    }

    eventPopup = new OpenLayers.Popup.FramedCloud("chicken", 
        feature.geometry.getBounds().getCenterLonLat(),
        new OpenLayers.Size(405,350), setEventPopupUi(feature),
        null, true, onPopupClose);
    
    eventPopup.autoSize=true;
    feature.popup = eventPopup;
    
    map.addPopup(eventPopup);
    
    selectedFeature = feature;
}

function openFeaturesListPopup(features) {
	var data = features[0].data;
    
    if(selectedFeature != undefined) {
        if(selectedFeature.popup != null) {
            map.removePopup(selectedFeature.popup);
            selectedFeature.popup = null;
       }
    }
	
    eventPopup = new OpenLayers.Popup.FramedCloud("chicken", 
            features[0].geometry.getBounds().getCenterLonLat(),
            new OpenLayers.Size(400,330), setEventPopupUi(features),
            null, true, onPopupClose);
    eventPopup.autoSize=true;
    features[0].popup = eventPopup;
    
    selectedFeature = features[0];

    map.addPopup(eventPopup);
}

function getSearchRange() {
	var zoom = map.getZoom();
	var searchRange = 0;
	
	switch(zoom) {
		case 14 :
			searchRange = 0.002;
			break;
		case 15 :
			searchRange = 0.001;
			break;
		case 16 :
			searchRange = 0.0005;
			break;
		case 17 :
			searchRange = 0.0003;
			break;
		case 18 :
			searchRange = 0.0002;
			break;
		case 19 :
			searchRange = 0.00007;
			break;
		case 20 :
			searchRange = 0.00005;
			break;
		default :
			searchRange = 0;
			break;
	}
		
	return searchRange;
}

function getNearFeatures(point, features) {
	var searchRange = getSearchRange();
	var selectedFeatures = [];
	
	if (searchRange == 0) {
		alert("지도를 확대하고 시도해 주시기 바랍니다.");
		return selectedFeatures;
	}
	
	var range = {
		top: point.lat + searchRange,
		bottom: point.lat - searchRange,
		left: point.lon - searchRange,
		right: point.lon + searchRange
	}
	
	for (var i in features) {
		var lat = parseFloat(features[i].data.gpsX);
		var lon = parseFloat(features[i].data.gpsY);
		
		if ((range.left <= lat && range.right >= lat) &&
				(range.bottom <= lon && range.top >= lon)) {
			selectedFeatures.push(features[i]);
		}
	}
	
	return selectedFeatures;
}

function onEventPopup(feature) {
	var data = feature.data;
	var pos = {
		lon: parseFloat(data.gpsX),
		lat: parseFloat(data.gpsY)
	}
    
    nearFeatures = getNearFeatures(pos, eventLayer.features);
    nearFeatures = sortEmergengy(nearFeatures);
    var length = nearFeatures.length;
    
    if (length == 0) {
    	eventSelectControl.onUnselect(selectedFeature);
    } else if (length == 1) {
    	openFeaturePopup(nearFeatures[0]);
    } else if (length > 1) {
    	openFeaturesListPopup(nearFeatures);
    }
}

function handleSelection(e) {
	/*var lonlat = map.getLonLatFromViewPortPx(e.xy);
	
	var newPoint = lonlat.transform(new OpenLayers.Projection("EPSG:900913"),new OpenLayers.Projection("EPSG:4326"));
	
	search_castingN('map',newPoint.lat,newPoint.lon);*/
}

/*이전*/
function mapHistPrev() {
	controlGroup.history.previousTrigger();
}

/*이후*/
function mapHistNext() {
	controlGroup.history.nextTrigger();
}

/*확대*/
function mapZoomIn() {
	deactivateControls();
	controlGroup.zoombox.activate();

	$('#map').css('cursor', 'crosshair');
}

/*축소*/
function mapZoomOut() {
	deactivateControls();
	controlGroup.zoomboxout.activate();

	$('#map').css('cursor', 'crosshair');
}

/*이동*/
function mapMoveControl(){
	/*deactivateControls();
	
	$('#map').css('cursor', 'move');*/
	mapInfo();
}

/*전체영역*/
function mapFullExtent(){
	map.setCenter(new OpenLayers.LonLat(128.980592,35.21242).transform(new OpenLayers.Projection("EPSG:4326"),new OpenLayers.Projection("EPSG:900913")), 14); 
}

/*지도확장*/
function collaspeAll(){
	$('#gis_layout').layout('collapse','west');
	$('#gis_layout').layout('collapse','east');
	$('#gis_layout').layout('collapse','south');
}

/*거리측정*/
function mapCalcLen() {
	deactivateControls();
	for (var i = 0; i< map.controls.length; i++) {
	    if (map.controls[i].displayClass == "olControlNavigation") {
	        map.controls[i].deactivate();
	    }
	}
	map.calcDistance();
}

/*면적측정*/
function mapCalcArea() {
	deactivateControls();
	controlGroup.pantool.deactivate();
	
	for (var i = 0; i< map.controls.length; i++) {
	    if (map.controls[i].displayClass == "olControlNavigation") {
	        map.controls[i].deactivate();
	    }
	}
	map.calcArea();
}

/*위성 map*/
function addAirTMS() {
	l = new OpenLayers.Layer.TMS(
			"airLayer", // 레이어 명, 임의로 지정 가능
			gisAir2012Url, // 레이어를 호출할 경로
			{
				isBaseLayer: false,
				type: "jpeg", // 이미지 타입(일반적으로 PNG나 JPG  이용)
				transitionEffect: 'resize', // 지도 이동시 효과
				buffer:1,
				getURL: function(bounds) {  // 영상 가져오는 공식 지정
					var res = this.map.getResolution(); // 지도의 해상도 얻어오기
					var x = Math.round((bounds.left - this.maxExtent.left) / (res * this.tileSize.w)); // X의 위치
					var y = Math.round((this.maxExtent.top - bounds.top) / (res * this.tileSize.h)); // Y의 위치
					var z = this.map.getZoom(); // 줌 레벨
					var limit = Math.pow(2, z); // 지정 위치 이상일 때 처리위한 변수
					if(z >= 19) {
						return "images/blank.jpeg"; // 19레벨 이상일때 보여줄 이미지
						}else if (y < 0 || y >= limit) { // 영역을 벗어 났을 대 이미지
							return "images/blank.jpeg";
						} else {
							x = ((x % limit) + limit) % limit;
							return this.url + z + "/" + x + "/" + y + "." + this.type;
						}
					}
			});
	map.addLayer(l); // 지도에 레이어 추가
	l.visibility = false;
	//map.setBaseLayer(l); // 추가한 레이어를 기본 레이어로 설정
}

/*출력*/
function showPrintMap(){
	// 로그기록용. 의미없다.
	$.ajax({
		url: "printPageLog.do",
		success: function(response, status){
			
		}
	});
	//--- 로그기록용
	$("#printmap").attr("src", "printPage.do?pos_x="+(map.getCenter().lat)+"&pos_y="+(map.getCenter().lon)+"&zoom="+map.getZoom());
    $("#printdlg").dialog({top:254,left:525}).dialog("open");
}

/*정보*/
function mapInfo(){
	deactivateControls();
	//selectedImageLayer.activate();
	$('#map').css('cursor', 'pointer');
	
	map.events.register("click", map, handleSelection);
}

/*일반 map*/
function addBaseTMS() {
	l = new OpenLayers.Layer.TMS(
			"baseLayer", // 레이어 명, 임의로 지정 가능
			gisBase2012Url, // 레이어를 호출할 경로
			{
				isBaseLayer: false,
				type: "png", // 이미지 타입(일반적으로 PNG나 JPG  이용)
				transitionEffect: 'resize', // 지도 이동시 효과
				buffer:1,
				getURL: function(bounds) {  // 영상 가져오는 공식 지정
					var res = this.map.getResolution(); // 지도의 해상도 얻어오기
					var x = Math.round((bounds.left - this.maxExtent.left) / (res * this.tileSize.w)); // X의 위치
					var y = Math.round((this.maxExtent.top - bounds.top) / (res * this.tileSize.h)); // Y의 위치
					var z = this.map.getZoom(); // 줌 레벨
					var limit = Math.pow(2, z); // 지정 위치 이상일 때 처리위한 변수
					if(z >= 19) {
						return "images/blank.jpeg"; // 19레벨 이상일때 보여줄 이미지
					}else if (y < 0 || y >= limit) { // 영역을 벗어 났을 대 이미지
						return "images/blank.jpeg";
					} else {
						x = ((x % limit) + limit) % limit;
						return this.url + z + "/" + x + "/" + y + "." + this.type;
					}
				}
			});
	map.addLayer(l); // 지도에 레이어 추가
	map.setBaseLayer(l); // 추가한 레이어를 기본 레이어로 설정        
}

var mapPrint=function(){
	var id = "";
	var top = 3;
	var left = 3;
	var maxw = 300;
	var endalpha = 95;
	var alpha = 70;
	var tt,t,c,b,h;
	var ie = document.all ? true : false;
	return{
		show:function(seq, e,v,w,pos,ll){
			id = "mprn"+seq;
			if(document.getElementById(id) == null){
				tt = document.createElement('div');
				tt.setAttribute('id',id);
				tt.setAttribute('lon',ll.lon);
				tt.setAttribute('lat',ll.lat);
				t = document.createElement('div');
				t.setAttribute('id',id + 'top');
				c = document.createElement('div');
				c.setAttribute('id',id + 'cont');
				b = document.createElement('div');
				b.setAttribute('id',id + 'bot');
				tt.appendChild(t);
				tt.appendChild(c);
				tt.appendChild(b);
				document.body.appendChild(tt);
				tt.style.opacity = 100;
				tt.style.filter = 'alpha(opacity=100)';
			}
			tt.style.zIndex = 9999;

			tt.style.display = 'block';
			c.innerHTML = v;
			tt.style.width = w ? w + 'px' : 'auto';
			if(ie){
				t.style.display = 'none';
				b.style.display = 'none';
				//tt.style.width = eval(v.length*8)+ 'px';
				t.style.display = 'block';
				b.style.display = 'block';
			}
			var u = null;
			var l = null;
			if (e != null) {
				u = ie ? event.clientY : e.pageY;
				l = ie ? event.clientX : e.pageX;
			} else {
				u = pos.y;
				l = pos.x;
			}
			tt.style.fontFamily = "Lucida Console";
			t.style.color = "#fff";
			t.style.fontColor = "#fff";
			t.style.backgroundColor = "#555";
			
			b.style.color = "#fff";
			b.style.fontColor = "#fff";
			b.style.backgroundColor = "#555";
			c.style.color = "#fff";
			c.style.fontColor = "#fff";
			tt.style.fontSize = "12px";
			tt.style.color = "#fff";
			tt.style.fontColor = "#fff";
			tt.style.backgroundColor = "#555";
			tt.style.padding = "3px";
			tt.style.position = "absolute";
			//tt.style.top = (u-parseInt(tt.offsetHeight)) + 'px';
			tt.style.top = u + 'px';
			tt.style.left = l + 'px';

			if(tt.offsetWidth > maxw){tt.style.width = maxw + 'px'}
			h = parseInt(tt.offsetHeight) + top;
		},
		fade:function(d){
			var a = alpha;
			if((a != endalpha && d == 1) || (a != 0 && d == -1)){
				var i = speed;
				if(endalpha - a < speed && d == 1){
					i = endalpha - a;
				}else if(alpha < speed && d == -1){
					i = a;
				}
				alpha = a + (i * d);
				tt.style.opacity = alpha * .01;
				tt.style.filter = 'alpha(opacity=' + alpha + ')';
			}else{
				if(d == -1){tt.style.display = 'none'}
			}
		},
		hide:function(){
			try{
				tt.style.display = 'none';
			}catch(expp){}
		}
	};
}();

/*트리로딩필터*/
function convertTreeData(rows){
	function exists(rows, parentId){
		for(var i=0; i<rows.length; i++){
			if (rows[i].id == parentId) return true;
		}
		return false;
	}
	
	var nodes = [];
	// get the top level nodes
	for(var i=0; i<rows.length; i++){
		var row = rows[i];
		if (!exists(rows, row.parentId)){
			if(row.iconCls != null && row.iconCls != "")
				nodes.push({
					id:row.id,
					text:row.name,
					state:row.state,
					checked:$.parseJSON(row.checked),
					iconCls:row.iconCls
				});
			else{
				nodes.push({
					id:row.id,
					text:row.name,
					state:row.state,
					checked:$.parseJSON(row.checked),
					iconCls:'icon-tree-folder'
				});
			}
			/*else if(row.id == 1){
				nodes.push({
					id:row.id,
					text:row.name,
					state:row.state,
					checked:$.parseJSON(row.checked),
					iconCls:'icon-tree-folder'
				});
			}
			else if(row.id == 2){
				nodes.push({
					id:row.id,
					text:row.name,
					state:row.state,
					checked:$.parseJSON(row.checked),
					iconCls:'icon-tree-cctv'
				});
			}*/
		}
	}
	var toDo = [];
	for(var i=0; i<nodes.length; i++){
		toDo.push(nodes[i]);
	}
	
	while(toDo.length){
		
		var node = toDo.shift();    // the parent node
		// get the children nodes
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			if (row.parentId == node.id){
				var child = {id:row.id,text:row.name,state:row.state,checked:$.parseJSON(row.checked)};
				if(row.iconCls != null && row.iconCls != "")
					child = {id:row.id,text:row.name,state:row.state,checked:$.parseJSON(row.checked), iconCls:row.iconCls};
				
				if (node.children){
					node.children.push(child);
				} else {
					node.children = [child];
				}
				toDo.push(child);
			}
		}
	}
	
	return nodes;
}

/*트리로딩*/
function mapLateChange(){
	var nodes = $('#layer_tree').tree('getChecked');
	var s = '';
	for(var i=0; i<nodes.length; i++){
		if(nodes[i].children != undefined)
    		continue;
	    if (s != '') s += ',';
	    s += nodes[i].id;
	}
	console.log(s);
	setTimeout(function() { 
		addWMS(s); 
	}, 1000);
	
	$('.easyui-tree > li:nth-of-type(3) .tree-checkbox').removeClass('tree-checkbox');
}

/*트리체크*/
function mapChange(){
	var nodes = $('#layer_tree').tree('getChecked');
	var s = '';
	for(var i=0; i<nodes.length; i++){
		if(nodes[i].children != undefined)
    		continue;
	    if (s != '') s += ',';
	    s += nodes[i].id;
	}
	console.log(s);
	addWMS(s);
}

/*map resize*/
function resizeMap(left,width,height) {
	$('#map').css('left',left);
	$('#map').css('width',width);
	$('#map').css('height',height);
	if (map != undefined) {
		setTimeout(function myFunction() {
			map.updateSize();
		}, 300);
	}
}

/*index map*/
function indexMap(){
	var gisProjection 	= 'EPSG:900913';
	var gisBoundsLeft = '127.021673';
	var gisBoundsBottom = '37.333728';
	var gisBoundsRight = '127.208942';
	var gisBoundsTop = '37.480887';
	// var gisBoundsLeft 	= '128.773846';
	// var gisBoundsBottom = '34.984663';
	// var gisBoundsRight 	= '129.093233';
	// var gisBoundsTop 	= '35.242487';
	_bounds = new OpenLayers.Bounds(Number(gisBoundsLeft), Number(gisBoundsBottom), Number(gisBoundsRight), Number(gisBoundsTop));
	_bounds.transform(new OpenLayers.Projection("WGS84"), new OpenLayers.Projection(gisProjection));
	$(document).ready(function(){
		$('#gis_layout').append('<div id="indexMapDiv"><div id="indexMap"><img id="indexMapPointer" class="scaled animated" src="/images/icons/pointer_icon.png"/></div></div>');
		var indexMapImage = new Image();
		indexMapImage.src = '/images/gis/indexMap.jpg';
		$(indexMapImage).bind('load', function() {
			var indexMapWidth = indexMapImage.width;
			var indexMapHeight = indexMapImage.height;
			$('#indexMapDiv').css({ 'display' : 'block', 'width' : indexMapWidth+6, 'height' : indexMapHeight+6 });
			$('#indexMap').css({ 'display' : 'block', 'background' : 'url("' + indexMapImage.src + '") no-repeat', 'width' : indexMapWidth, 'height' : indexMapHeight });
		});
		var pointerImage = new Image();
		pointerImage.src = 'images/icons/pointer_icon.png';
		$(pointerImage).bind('load', function() {
			var pointerWidth = pointerImage.width / 2;
			var pointerHeight = pointerImage.height / 2;
			$('#indexMapPointer').css({'width' : pointerWidth, 'height' : pointerHeight});
		});
		$('#indexMap').click(function(evt) {//console.log(evt)
				var indexMap = $('#indexMap').get(0);
				var offset = {
					x : evt.offsetX,
					y : evt.offsetY,
					width : indexMap.offsetWidth,
					height : indexMap.offsetHeight
				};
				var x = offset.x / offset.width;
				var y = offset.y / offset.height;
				var lon = _bounds.left + ((_bounds.right - _bounds.left) * x);
				var lat = _bounds.top - ((_bounds.top - _bounds.bottom) * y);
				map.setCenter(new OpenLayers.LonLat(lon, lat), map.getZoom());
		});
	});
	
	
}

/*index map 포인터 영역 초과시 자르기*/
function pointerImageClip(x, y, mapWidth) {
	var width = $('#indexMapPointer').width();
	var height = $('#indexMapPointer').height();
	var rectLeft = width + Math.abs(x);
	var rectTop = height - Math.abs(y);
	var minLeft = width / 2;
	var minTop = height - 3;
	var maxRight = mapWidth - minLeft - 1;
	var left = minLeft - x;
	var top = minTop - y;
	var rightClip = width - (x - maxRight);
	if (x < minLeft && y < minTop) {
		$('#indexMapPointer').css({'clip' : 'rect(' + top +'px,' + width + 'px,' + height + 'px,' + left + 'px)'});
	} else if (x > maxRight && y < minTop) {
		$('#indexMapPointer').css({'clip' : 'rect(' + top +'px,' + rightClip + 'px,' + height + 'px,0px)'});
	} else if (x < minLeft) {
		$('#indexMapPointer').css({'clip' : 'rect(0px,' + width + 'px,' + height + 'px,' + left + 'px)'});
	} else if (x > maxRight) {
		$('#indexMapPointer').css({'clip' : 'rect(0px,' + rightClip + 'px,' + height + 'px,0px)'});
	} else if (y < minTop) {
		$('#indexMapPointer').css({'clip' : 'rect(' + top + 'px,' + width + 'px,' + height + 'px,0px)'});
	} else {
		$('#indexMapPointer').css({'clip' : ''});
	}
}

/*index map 포인터 이동*/
var moveIndexMapPointer =  function(event) {
	if (!_bounds.containsLonLat(map.getCenter())) {
		$('#indexMapPointer').css({'display' : 'none'});
		return;
	} else {
		$('#indexMapPointer').css({'display' : 'block'});
	}
	$('#indexMapPointer').removeClass('scaled');
	var lon = map.getCenter().lon;
	var lat = map.getCenter().lat;
	
	var indexMap = $('#indexMap').get(0);
	var width = indexMap.offsetWidth;
	var height = indexMap.offsetHeight;
	
	var pointer = $('#indexMapPointer').get(0);
	var pointerWidth = (pointer.offsetWidth / 2) - 3;
	var pointerHeight = (pointer.offsetHeight / 2) + 7;
	
	var mapX = lon - _bounds.left;
	var mapY = _bounds.top - lat;
	
	var boundsX = mapX / _bounds.getWidth();
	var boundsY = mapY / _bounds.getHeight();
	var pointX = (width * boundsX);
	var pointY = (height * boundsY);
	
	var left = pointX - pointerWidth;
	var top = pointY - pointerHeight;
	
	pointerImageClip(pointX, pointY, width);
	
	$('#indexMapPointer').css({'left' : left, 'top': top});
	$('#indexMapPointer').addClass('scaled');
}
