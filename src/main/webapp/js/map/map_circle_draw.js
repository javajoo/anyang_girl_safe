var circleDrawingFlag = false;
var centerPosition;
var drawingCircle;
var drawingLine;
var drawingOverlay;
var drawingDot;

var circles = [];

var mapCircleDrawClick = function(mouseEvent) {
	// 클릭 이벤트가 발생했을 때 원을 그리고 있는 상태가 아니면 중심좌표를 클릭한 지점으로 설정합니다
	if (!circleDrawingFlag) {

		// 상태를 그리고있는 상태로 변경합니다
		circleDrawingFlag = true;

		// 원이 그려질 중심좌표를 클릭한 위치로 설정합니다
		centerPosition = mouseEvent.latLng;

		// 그려지고 있는 원의 반경을 표시할 선 객체를 생성합니다
		if (!drawingLine) {
			drawingLine = new kakao.maps.Polyline({
				strokeWeight : 3, // 선의 두께입니다
				strokeColor : '#00a0e9', // 선의 색깔입니다
				strokeOpacity : 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
				strokeStyle : 'solid' // 선의 스타일입니다
			});
		}

		// 그려지고 있는 원을 표시할 원 객체를 생성합니다
		if (!drawingCircle) {
			drawingCircle = new kakao.maps.Circle({
				strokeWeight : 1, // 선의 두께입니다
				strokeColor : '#00a0e9', // 선의 색깔입니다
				strokeOpacity : 0.1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
				strokeStyle : 'solid', // 선의 스타일입니다
				fillColor : '#00a0e9', // 채우기 색깔입니다
				fillOpacity : 0.2
			// 채우기 불투명도입니다
			});
		}

		// 그려지고 있는 원의 반경 정보를 표시할 커스텀오버레이를 생성합니다
		if (!drawingOverlay) {
			drawingOverlay = new kakao.maps.CustomOverlay({
				xAnchor : 0,
				yAnchor : 0,
				zIndex : 1
			});
		}
	}
}

var mapCircleDrawMouseMove = function(mouseEvent) {
	// 마우스무브 이벤트가 발생했을 때 원을 그리고있는 상태이면
	if (circleDrawingFlag) {

		// 마우스 커서의 현재 위치를 얻어옵니다
		var mousePosition = mouseEvent.latLng;

		// 그려지고 있는 선을 표시할 좌표 배열입니다. 클릭한 중심좌표와 마우스커서의 위치로 설정합니다
		var linePath = [ centerPosition, mousePosition ];

		// 그려지고 있는 선을 표시할 선 객체에 좌표 배열을 설정합니다
		drawingLine.setPath(linePath);

		// 원의 반지름을 선 객체를 이용해서 얻어옵니다
		var length = drawingLine.getLength();

		if (length > 0) {

			// 그려지고 있는 원의 중심좌표와 반지름입니다
			var circleOptions = {
				center : centerPosition,
				radius : length,
			};

			// 그려지고 있는 원의 옵션을 설정합니다
			drawingCircle.setOptions(circleOptions);

			// 반경 정보를 표시할 커스텀오버레이의 내용입니다
			var radius = Math.round(drawingCircle.getRadius()), content = '<div class="info">반경 <span class="number">'
					+ radius + '</span>m</div>';

			// 반경 정보를 표시할 커스텀 오버레이의 좌표를 마우스커서 위치로 설정합니다
			drawingOverlay.setPosition(mousePosition);

			// 반경 정보를 표시할 커스텀 오버레이의 표시할 내용을 설정합니다
			drawingOverlay.setContent(content);

			// 그려지고 있는 원을 지도에 표시합니다
			drawingCircle.setMap(map);

			// 그려지고 있는 선을 지도에 표시합니다
			drawingLine.setMap(map);

			// 그려지고 있는 원의 반경정보 커스텀 오버레이를 지도에 표시합니다
			drawingOverlay.setMap(map);

		} else {

			drawingCircle.setMap(null);
			drawingLine.setMap(null);
			drawingOverlay.setMap(null);

		}
	}
}

var mapCircleDrawRightClick = function(mouseEvent) {
	if (circleDrawingFlag) {

		// 마우스로 오른쪽 클릭한 위치입니다
		var rClickPosition = mouseEvent.latLng;

		// 원의 반경을 표시할 선 객체를 생성합니다
		var polyline = new kakao.maps.Polyline({
			path : [ centerPosition, rClickPosition ], // 선을 구성하는 좌표 배열입니다. 원의
			// 중심좌표와 클릭한 위치로 설정합니다
			strokeWeight : 3, // 선의 두께 입니다
			strokeColor : '#00a0e9', // 선의 색깔입니다
			strokeOpacity : 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
			strokeStyle : 'solid' // 선의 스타일입니다
		});

		// 원 객체를 생성합니다
		var circle = new kakao.maps.Circle({
			center : centerPosition, // 원의 중심좌표입니다
			radius : polyline.getLength(), // 원의 반지름입니다 m 단위 이며 선 객체를 이용해서
			// 얻어옵니다
			strokeWeight : 1, // 선의 두께입니다
			strokeColor : '#00a0e9', // 선의 색깔입니다
			strokeOpacity : 0.1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
			strokeStyle : 'solid', // 선의 스타일입니다
			fillColor : '#00a0e9', // 채우기 색깔입니다
			fillOpacity : 0.2
		// 채우기 불투명도입니다
		});

		var radius = Math.round(circle.getRadius()), // 원의 반경 정보를 얻어옵니다
		content = getTimeHTML(radius); // 커스텀 오버레이에 표시할 반경 정보입니다

		// 반경정보를 표시할 커스텀 오버레이를 생성합니다
		var radiusOverlay = new kakao.maps.CustomOverlay({
			content : content, // 표시할 내용입니다
			position : rClickPosition, // 표시할 위치입니다. 클릭한 위치로 설정합니다
			xAnchor : 0,
			yAnchor : 0,
			zIndex : 1
		});

		// 원을 지도에 표시합니다
		circle.setMap(map);

		// 선을 지도에 표시합니다
		polyline.setMap(map);

		// 반경 정보 커스텀 오버레이를 지도에 표시합니다
		radiusOverlay.setMap(map);

		// 배열에 담을 객체입니다. 원, 선, 커스텀오버레이 객체를 가지고 있습니다
		var radiusObj = {
			'polyline' : polyline,
			'circle' : circle,
			'overlay' : radiusOverlay
		};

		// 배열에 추가합니다
		// 이 배열을 이용해서 "모두 지우기" 버튼을 클릭했을 때 지도에 그려진 원, 선, 커스텀오버레이들을 지웁니다
		circles.push(radiusObj);

		// 그리기 상태를 그리고 있지 않는 상태로 바꿉니다
		circleDrawingFlag = false;

		// 중심 좌표를 초기화 합니다
		centerPosition = null;

		// 그려지고 있는 원, 선, 커스텀오버레이를 지도에서 제거합니다
		drawingCircle.setMap(null);
		drawingLine.setMap(null);
		drawingOverlay.setMap(null);
	}
}

//지도에 표시되어 있는 모든 원과 반경정보를 표시하는 선, 커스텀 오버레이를 지도에서 제거합니다
function removeCircles() {         
    for (var i = 0; i < circles.length; i++) {
        circles[i].circle.setMap(null);    
        circles[i].polyline.setMap(null);
        circles[i].overlay.setMap(null);
    }         
    circles = [];
}
