var drawType = '';

var mapMarkers = [];
var selectedMarker;

//지도 거리측정, 면적측정, 지우개
function changeEventListener(type) {
	clearEventListener();
	drawType = type;
	if (type == 'distance') {
		kakao.maps.event.addListener(map, 'click', mapLineDrawClick);
		kakao.maps.event.addListener(map, 'mousemove', mapLineDrawMouseMove);
		kakao.maps.event.addListener(map, 'rightclick', mapLineDrawRightClick);
	} else if (type == 'area') {
		kakao.maps.event.addListener(map, 'click', mapAreaDrawClick);
		kakao.maps.event.addListener(map, 'mousemove', mapAreaDrawMouseMove);
		kakao.maps.event.addListener(map, 'rightclick', mapAreaDrawRightClick);
	} else if (type == 'radius') {
		kakao.maps.event.addListener(map, 'click', mapCircleDrawClick);
		kakao.maps.event.addListener(map, 'mousemove', mapCircleDrawMouseMove);
		kakao.maps.event.addListener(map, 'rightclick', mapCircleDrawRightClick);
	} else if (type == 'clear'){
		removeLine();
		removeArea();
		removeCircles();
	}
}

function clearEventListener() {
	if (drawType == 'distance') {
		kakao.maps.event.removeListener(map, 'click', mapLineDrawClick);
		kakao.maps.event.removeListener(map, 'mousemove', mapLineDrawMouseMove);
		kakao.maps.event.removeListener(map, 'rightclick', mapLineDrawRightClick);
	} else if (drawType == 'area') {
		kakao.maps.event.removeListener(map, 'click', mapAreaDrawClick);
		kakao.maps.event.removeListener(map, 'mousemove', mapAreaDrawMouseMove);
		kakao.maps.event.removeListener(map, 'rightclick', mapAreaDrawRightClick);
	} else if (drawType == 'radius') {
		kakao.maps.event.removeListener(map, 'click', mapCircleDrawClick);
		kakao.maps.event.removeListener(map, 'mousemove', mapCircleDrawMouseMove);
		kakao.maps.event.removeListener(map, 'rightclick', mapCircleDrawRightClick);
	}
}

function changeDrawSelect(obj) {
	$('.drawControlBar > ul > li > img').each(function() {
		$(this).removeClass('selected');
	});
	$(obj).addClass('selected');
}

function clearDrawSelect() {
	$('.drawControlBar > ul > li > img').each(function() {
		$(this).removeClass('selected');
	});
}

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
		search_home(s);
	}, 1000);
	
	$('.icon-tree-folder').hide();
	$('.easyui-tree > li:nth-of-type(3) .tree-checkbox').removeClass('tree-checkbox');
}

/*트리체크*/
function mapChange(){
	mapEventClear();
	var nodes = $('#layer_tree').tree('getChecked');
	var s = '';
	for(var i=0; i<nodes.length; i++){
		if(nodes[i].children != undefined)
    		continue;
	    if (s != '') s += ',';
	    s += nodes[i].id;
	}
	console.log(s);
	search_home(s);
}

/*map resize*/
function resizeMap(left,width,height) {
	$('#map').css('left',left);
	$('#map').css('width',width);
	$('#map').css('height',height);
	if (map != undefined) {
		setTimeout(function myFunction() {
			//map.updateSize();
		}, 300);
	}
}

/*function printMap(){
	// 로그기록용. 의미없다.
	$.ajax({
		url: "printPageLog.do",
		success: function(response, status){
		}
	});
	//$("#printmap").attr("src", mapImage);
    $("#printdlg").dialog({top:254,left:525}).dialog("open");
}

function printMap1() {
	var page = '/print';
    $("#printdlg").html("");
    $("#printdlg").load("/action/page.do", { path : page }, function() {
    });
    
    $('#printdlg').dialog({
        title: '상태정보',
        width: 1135,
        height: 610,
        closed: false,
        cache: false,
        modal: true,
		onClose: function() {
			
		}
    });
    $('#printdlg').dialog('open');
}*/

/*function popupListActiveClear() {
	var popupList = $('#popup_list_area li a');
	popupList.each(function(index) {
		$(this).removeClass('active');
	});
}*/

function openMarkerListPopup(marker, dataMarker) {
	var mapMarkersList = getNearMarker(marker, dataMarker);
	var selectedMarker = mapMarkersList[0].marker;
	popupOverlay = createEventPopupOverlay(mapMarkersList, selectedMarker);
}

function getNearMarker(marker, dataMarker) {
	var mapMarkersList = [];
	var markerLat = marker.getPosition().getLat();
	var markerLon = marker.getPosition().getLng();
	var markerName = marker.getTitle();
	for (var i in mapMarkers) {
		var lat = mapMarkers[i].marker.getPosition().getLat();
		var lon = mapMarkers[i].marker.getPosition().getLng();
		var name =  mapMarkers[i].marker.getTitle();
		var emergency = mapMarkers[i].data.emergency;
			if (markerLat == lat && markerLon == lon) {
				mapMarkersList.push(mapMarkers[i]);
			}
	}
	return mapMarkersList;
}

function setEventPopupValues(obj, phoneNumber) {
	popupListActiveClear();
	$(obj).addClass('active');
	
	for ( var i in mapMarkers) {
		var data = mapMarkers[i].data;
		var markerPhone = data.phoneNumber;
		if (markerPhone == phoneNumber) {
			$('#event_popup_event_name').text(data.name);
			$('#event_popup_event_age').text(data.birthAge);
			$('#event_popup_event_phoneNumber').text(data.phoneNumber);
			$('#event_popup_event_address').text(data.address);
			$('#event_popup_event_sPhoneNumber').text(data.sPhoneNumber);
			$('#popup_sensor_id').text(data.sensorId);
			if (data.emergency == 1) {
				$('#popup_btn_area').css('display', 'inline');
			} else {
				$('#popup_btn_area').css('display', 'none');
			}
			break;
		}
	}
}

function popupListActiveClear() {
	var popupList = $('#popup_list_area li a');
	popupList.each(function(index) {
		$(this).removeClass('active');
	});
}