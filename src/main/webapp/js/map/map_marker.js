
var mapMarkers = [];
var selectedMarker;

function getMarker(data) {
	for (var i in mapMarkers) {
		if (mapMarkers[i].marker.getTitle() == data.callNumber) {
			return mapMarkers[i];
		}
	}
	return null;
}

function mapEventClear() {
	setMapMarker(null);	//마커 클리어
	closePopupOverlay();
	if(selectedMarker) selectedMarker.setMap(null);
}

function setMapMarker(map) {
	setMapMarkers(map);
}
function setMapMarkers(map) {
	for (var i = 0; i < mapMarkers.length; i++) {
		mapMarkers[i].marker.setMap(map);
	}
	mapMarkers = [];
}