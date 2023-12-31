var areaDrawingFlag = false;
var drawigPolygon;
var polygon;
var areaOverlay;

var mapAreaDrawClick = function(mouseEvent) {
	// 마우스로 클릭한 위치입니다
	var clickPosition = mouseEvent.latLng;

	// 지도 클릭이벤트가 발생했는데 다각형이 그려지고 있는 상태가 아니면
	if (!areaDrawingFlag) {

		// 상태를 true로, 다각형을 그리고 있는 상태로 변경합니다
		areaDrawingFlag = true;

		// 지도 위에 다각형이 표시되고 있다면 지도에서 제거합니다
		if (polygon) {
			polygon.setMap(null);
			polygon = null;
		}

		// 지도 위에 면적정보 커스텀오버레이가 표시되고 있다면 지도에서 제거합니다
		if (areaOverlay) {
			areaOverlay.setMap(null);
			areaOverlay = null;
		}

		// 그려지고 있는 다각형을 표시할 다각형을 생성하고 지도에 표시합니다
		drawingPolygon = new kakao.maps.Polygon({
			map : map, // 다각형을 표시할 지도입니다
			path : [ clickPosition ], // 다각형을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
			strokeWeight : 3, // 선의 두께입니다
			strokeColor : '#00a0e9', // 선의 색깔입니다
			strokeOpacity : 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
			strokeStyle : 'solid', // 선의 스타일입니다
			fillColor : '#00a0e9', // 채우기 색깔입니다
			fillOpacity : 0.2
		// 채우기 불투명도입니다
		});

		// 그리기가 종료됐을때 지도에 표시할 다각형을 생성합니다
		polygon = new kakao.maps.Polygon({
			path : [ clickPosition ], // 다각형을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
			strokeWeight : 3, // 선의 두께입니다
			strokeColor : '#00a0e9', // 선의 색깔입니다
			strokeOpacity : 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
			strokeStyle : 'solid', // 선의 스타일입니다
			fillColor : '#00a0e9', // 채우기 색깔입니다
			fillOpacity : 0.2
		// 채우기 불투명도입니다
		});

	} else { // 다각형이 그려지고 있는 상태이면

		// 그려지고 있는 다각형의 좌표에 클릭위치를 추가합니다
		// 다각형의 좌표 배열을 얻어옵니다
		var drawingPath = drawingPolygon.getPath();

		// 좌표 배열에 클릭한 위치를 추가하고
		drawingPath.push(clickPosition);

		// 다시 다각형 좌표 배열을 설정합니다
		drawingPolygon.setPath(drawingPath);

		// 그리기가 종료됐을때 지도에 표시할 다각형의 좌표에 클릭 위치를 추가합니다
		// 다각형의 좌표 배열을 얻어옵니다
		var path = polygon.getPath();

		// 좌표 배열에 클릭한 위치를 추가하고
		path.push(clickPosition);

		// 다시 다각형 좌표 배열을 설정합니다
		polygon.setPath(path);
	}
}

var mapAreaDrawMouseMove = function(mouseEvent) {
	// 지도 마우스무브 이벤트가 발생했는데 다각형을 그리고있는 상태이면
	if (areaDrawingFlag) {

		// 마우스 커서의 현재 위치를 얻어옵니다
		var mousePosition = mouseEvent.latLng;

		// 그려지고있는 다각형의 좌표배열을 얻어옵니다
		var path = drawingPolygon.getPath();

		// 마우스무브로 추가된 마지막 좌표를 제거합니다
		if (path.length > 1) {
			path.pop();
		}

		// 마우스의 커서 위치를 좌표 배열에 추가합니다
		path.push(mousePosition);

		// 그려지고 있는 다각형의 좌표를 다시 설정합니다
		drawingPolygon.setPath(path);
	}
}

var mapAreaDrawRightClick = function(mouseEvent) {
	// 지도 오른쪽 클릭 이벤트가 발생했는데 다각형을 그리고있는 상태이면
	if (areaDrawingFlag) {

		// 그려지고있는 다각형을 지도에서 제거합니다
		drawingPolygon.setMap(null);
		drawingPolygon = null;

		// 클릭된 죄표로 그릴 다각형의 좌표배열을 얻어옵니다
		var path = polygon.getPath();

		// 다각형을 구성하는 좌표의 개수가 3개 이상이면
		if (path.length > 2) {

			// 지도에 다각형을 표시합니다
			polygon.setMap(map);

			var area = Math.round(polygon.getArea()), // 다각형의 총면적을 계산합니다
			content = '<div class="AreaToolDetail">';
			content += '<ul class="info">';
			content += '<li>';
			content += '<span class="detailToolLabel">총면적</span><strong class="number">' + area + '</strong>m<sup>2</sup>';
			content += '</li>';
			content += '</ul>';
			content += '</div>';

			// 면적정보를 지도에 표시합니다
			areaOverlay = new kakao.maps.CustomOverlay({
				map : map, // 커스텀오버레이를 표시할 지도입니다
				content : content, // 커스텀오버레이에 표시할 내용입니다
				xAnchor : 0,
				yAnchor : 0,
				position : path[path.length - 1]
			// 커스텀오버레이를 표시할 위치입니다. 위치는 다각형의 마지막 좌표로 설정합니다
			});

		} else {

			// 다각형을 구성하는 좌표가 2개 이하이면 다각형을 지도에 표시하지 않습니다
			polygon = null;
		}

		// 상태를 false로, 그리지 않고 있는 상태로 변경합니다
		areaDrawingFlag = false;
	}
}

function removeArea() {
	deleteArea();
	deletePolygon();
}

//그려지고 있는 선의 총거리 정보와 
//선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 삭제하는 함수입니다
function deleteArea() {
	if (areaOverlay) {
		areaOverlay.setMap(null);
		areaOverlay = null;
	}
}

//클릭으로 그려진 선을 지도에서 제거하는 함수입니다
function deletePolygon() {
  if (polygon) {
	  polygon.setMap(null);
	  polygon = null;
  }
}