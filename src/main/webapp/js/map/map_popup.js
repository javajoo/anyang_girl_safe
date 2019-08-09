var popupOverlay;
function openPopup(overlay) {
	popupOverlay.setMap(map);
}

function closePopupOverlay() {
	if(popupOverlay) {
		popupOverlay.setMap(null);
	}
}
//이벤트 마커 오버레이
function createEventPopupOverlay(mapMarkersList, selectedMarker) {
	return new kakao.maps.CustomOverlay({
		content: getEvnetPopupContent(mapMarkersList, selectedMarker),
		map: map,
		position: selectedMarker.getPosition(),
		zIndex: 3
	});
}
//응급상황 마커 오버레이
function createEmergencyPopupOverlay(mapMarkersList, selectedMarker) {
	if(marker != null){
		return new kakao.maps.CustomOverlay({
			content: getEmergencyPopupContent(mapMarkersList, selectedMarker),
			map: map,
			position: selectedMarker.getPosition(),
			zIndex: 3
		});
	}else{
		return;
	}
	
}

function getEvnetPopupContent(mapMarkersList, selectedMarker) {
	var length = mapMarkersList.length;
	var data = null;
	
	if(typeof mapMarkersList == "undefined") {
		data = selectedMarker;
	} else {
		data = mapMarkersList[0].data;
	}
	
	var name = data.name;
	var birthAge = data.birthAge;
	var phoneNumber = data.phoneNumber;
	var address = data.address;
	var sPhoneNumber = data.sPhoneNumber;
	var sensorId = data.sensorId;
	var emergency = data.emergency;
	
	var contents = "";
	
	if (typeof length != "undefined") {
		contents = '<div class="popup_wrap">';
		contents += '<div class="popup_info">';
	    contents += '<div class="popup_close" onclick="closePopupOverlay()" title="닫기"></div>';
	    contents += '</div>';
		contents += "<div id=\"popup_left_area\" class=\"popup_left_area\">";
		contents += "<ul id=\"popup_list_area\" class=\"popup_list_area\">";
			for ( var i in mapMarkersList) {
				var listName = mapMarkersList[i].data.name;
				var curPhoneNumber = mapMarkersList[i].data.phoneNumber;
				if (i == 0) {
					contents += "<li><a href=\"#\" class=\"active\" onclick=\"setEventPopupValues(this,'" + curPhoneNumber +"')\">" + listName + "</a></li>";
				} else {
					contents += "<li><a href=\"#\" onclick=\"setEventPopupValues(this,'" + curPhoneNumber +"')\">" + listName + "</a></li>";
				}
			}
		contents += "</ul>";
	    contents += "<div class=\"popup_bottom_area\">";
	    contents += "<p>total : " + length + "</p>";
	    contents += "</div>";
		contents += "</div>";
	} else {
		contents += "<div class='event_popup'>";
	}
	contents += "<div id=\"popup_right_area\" class=\"popup_right_area\">";
	contents += "<span id=\"popup_sensor_id\" style=\"display: none;\">" + sensorId +"</span>";
	contents += "<table class=\"event_popup_table\">";
	contents += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">이름</div></td>";
	contents += "<td><div class=\"event_popup_col\" id=\"event_popup_event_name\">" + name + "</div></td></tr>";
	contents += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">생년월일(나이)</div></td>";
    contents += "<td><div class=\"event_popup_col\" id=\"event_popup_event_age\">" + birthAge + "</div></td></tr>";
    contents += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">연락처</div></td>";
    contents += "<td><div class=\"event_popup_col\" id=\"event_popup_event_phoneNumber\">" + phoneNumber + "</div></td></tr>";
    contents += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">주소</div></td>";
    contents += "<td><div class=\"event_popup_col\" id=\"event_popup_event_address\">" + address + "</div></td></tr>";
    contents += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">보호자 연락처</div></td>";
    contents += "<td><div class=\"event_popup_col\" id=\"event_popup_event_sPhoneNumber\">" + sPhoneNumber + "</div></td></tr>";
    contents += "</table></div>";
    if (emergency == 1) {
		contents += "<div class=\"popup_btn_area\" id=\"popup_btn_area\">";
    } else {
		contents += "<div class=\"popup_btn_area\" id=\"popup_btn_area\" style=\"display: none;\">";
    }
    if(rank <= 2){
    	contents += "<a href=\"#\" class=\"eventR_button_list\" onclick=\"updateEventEnd('" + sensorId + "')\">응급상황 종료</a>"
    }
	contents += "</div>";
    contents += '</div>';
	return contents;
}

/*function getEmergencyPopupContent(data) {
	var length = features.length;
	var data = null;
	
	if(typeof length == "undefined") {
		data = features.data;
	} else {
		data = features[0].data;
	}
	
	var name = data.name;
	var birthAge = data.birthAge;
	var phoneNumber = data.phoneNumber;
	var address = data.address;
	var sPhoneNumber = data.sPhoneNumber;
	var sensorId = data.sensorId;
	var emergency = data.emergency;
	
	var contents = "";
	
	if (typeof length != "undefined") {
		contents += "<div class='event_popup_big'>";
		contents += "<div id=\"popup_left_area\" class=\"popup_left_area\">";
		contents += "<ul id=\"popup_list_area\" class=\"popup_list_area\">";
			for ( var i in features) {
				var listName = features[i].data.name;
				var curPhoneNumber = features[i].data.phoneNumber;
				if (i == 0) {
					contents += "<li><a href=\"#\" class=\"active\" onclick=\"setEventPopupValues(this,'" + curPhoneNumber +"')\">" + listName + "</a></li>";
				} else {
					contents += "<li><a href=\"#\" onclick=\"setEventPopupValues(this,'" + curPhoneNumber +"')\">" + listName + "</a></li>";
				}
			}
		contents += "</ul>";
	    contents += "<div class=\"popup_bottom_area\">";
	    contents += "<p>total : " + length + "</p>";
	    contents += "</div>";
		contents += "</div>";
	} else {
		contents += "<div class='event_popup'>";
	}
	contents += "<div id=\"popup_right_area\" class=\"popup_right_area\">";
	contents += "<span id=\"popup_sensor_id\" style=\"display: none;\">" + sensorId +"</span>";
	contents += "<table class=\"event_popup_table\">";
	contents += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">이름</div></td>";
	contents += "<td><div class=\"event_popup_col\" id=\"event_popup_event_name\">" + name + "</div></td></tr>";
	contents += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">생년월일(나이)</div></td>";
    contents += "<td><div class=\"event_popup_col\" id=\"event_popup_event_age\">" + birthAge + "</div></td></tr>";
    contents += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">연락처</div></td>";
    contents += "<td><div class=\"event_popup_col\" id=\"event_popup_event_phoneNumber\">" + phoneNumber + "</div></td></tr>";
    contents += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">주소</div></td>";
    contents += "<td><div class=\"event_popup_col\" id=\"event_popup_event_address\">" + address + "</div></td></tr>";
    contents += "<tr class=\"event_popup_row\"><td><div class=\"event_popup_col\">보호자 연락처</div></td>";
    contents += "<td><div class=\"event_popup_col\" id=\"event_popup_event_sPhoneNumber\">" + sPhoneNumber + "</div></td></tr>";
    contents += "</table></div>";
    if (emergency == 1) {
		contents += "<div class=\"popup_btn_area\" id=\"popup_btn_area\">";
    } else {
		contents += "<div class=\"popup_btn_area\" id=\"popup_btn_area\" style=\"display: none;\">";
    }
	contents += "</div>";
    contents += "</div>";
	
	return contents;
}*/