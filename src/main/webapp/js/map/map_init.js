//baseMap 본래 지도
var mapOption = { 
		        center: new kakao.maps.LatLng(37.38951588413914, 126.98812045295553), // 지도의 중심좌표 //안양
		        level: 6, // 지도의 확대 레벨
		        maxLevel: 7
		    };
	
var mapContainer = document.getElementById('map'); // 지도를 표시할 div
var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

//var mapTypeControl = new kakao.maps.MapTypeControl();
//map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

//var zoomControl = new kakao.maps.ZoomControl();
//map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

map.addOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC);

//미니맵,기본맵 드래그시 동일한 중심좌표로 변화
//미니맵에서 좌측 클릭시 해당 위치를 중심좌표로 변화
//기본맵에서 우측 클릭시 해당 위치 미니맵에 마커로 표출 
//indexMap 미니맵 지도
var indexMapContainer = document.getElementById("index_map"),
	indexMapOption = {
		center: new kakao.maps.LatLng(37.390032, 126.959082), // 이미지 지도의 중심 좌표 안양
        level: 9, // 이미지 지도의 확대 레벨
        maxLevel:9,
        minLevel:9
	};

var indexMap = new kakao.maps.Map(indexMapContainer, indexMapOption);
	
//시작시 기본마커 생성
var markerbase = new kakao.maps.Marker({
    position: new kakao.maps.LatLng(37.241016, 127.177943),
    draggable: true
});
markerbase.setMap(indexMap);

kakao.maps.event.addListener(markerbase, 'dragend', function() {
	centerMove(indexMap,map); //기본 맵이 움직일때 -> 인덱스 맵의 변화
})

//기본지도 중심변화시 이벤트
kakao.maps.event.addListener(map, 'center_changed', function () {
	centerMove(map,indexMap); //기본 맵이 움직일때 -> 인덱스 맵의 변화 
	//console.log(indexMap.getCenter().toString());
});
//인덱스지도 중심변화시 이벤트
/*kakao.maps.event.addListener(indexMap, 'center_changed', function () {
	centerMove(indexMap,map); //인덱스 맵이 움직일때 -> 기본 맵이 변화 
});*/

//맵중심 상호 이동 함수
function centerMove(sel_map,chg_map){ //sel_map:드래그한 맵, chg_map:변화될 맵
	
	/* var ind_str = (sel_map.getCenter().toString()).indexOf("(");
	var ind_end = (sel_map.getCenter().toString()).indexOf(")");
	var ind_com = (sel_map.getCenter().toString()).indexOf(","); */
	
	//변화된 지도중심의 좌표값
	var lat = sel_map.getCenter().getLat()/* (sel_map.getCenter().toString()).substring(ind_str+1,ind_com); */ 
	var lng = sel_map.getCenter().getLng();/* (sel_map.getCenter().toString()).substring(ind_com+1,ind_end); */
	
	if(sel_map.getNode().id == 'index_map') {
		lat = markerbase.getPosition().getLat(); 
		lng = markerbase.getPosition().getLng();
	}
	
	//지도영역 제한
	/* if(chg_map==indexMap){
		//제한을 줄 영역의 SW/NE 중심좌표
		var sw_lat = 37.10448774593404; //좌측하단의 위도
		var sw_lng = 127.04931953439599; //좌측하단의 경도
		var ne_lat = 37.336704563835866; //우측상단의 위도
		var ne_lng = 127.42646028934392; //우측상단의 경도
		
		//중심의 좌표가 제한영역 중심 좌표를 벗어나면 제한
		if((lat>ne_lat)&&(lng<sw_lng)){ //NW 영역
			lat = ne_lat;
			lng = sw_lng;
		} else if((lat>ne_lat)&&(lng>sw_lng)&&(lng<ne_lng)){ //N 영역
			lat = ne_lat;
			lng = lng;	
		} else if((lat>=ne_lat)&&(lng>=ne_lng)){ //NE 영역
			lat = ne_lat;
			lng = ne_lng;					
		} else if((lat>sw_lat)&&(lat<ne_lat)&&(lng>ne_lng)){ //E 영역
			lat = lat;
			lng = ne_lng;					
		} else if((lat<sw_lat)&&(lng>ne_lng)){ //SE 영역
			lat = sw_lat;
			lng = ne_lng;					
		} else if((lat<sw_lat)&&(lng>sw_lng)&&(lng<ne_lng)){ //S 영역
			lat = sw_lat;
			lng = lng;									
		} else if((lat<=sw_lat)&&(lng<=sw_lng)){ //SW 영역
			lat = sw_lat;
			lng = sw_lng;									
		} else if((lat>sw_lat)&&(lat<ne_lat)&&(lng<sw_lng)){ //W 영역
			lat = lat;
			lng = sw_lng;									
		}
	}
	 */
	chg_map.setCenter(new kakao.maps.LatLng(lat,lng)); //중심이동
	sel_map.setCenter(new kakao.maps.LatLng(lat,lng)); //중심이동
	markerbase.setPosition(new kakao.maps.LatLng(lat,lng)); //마커 위치이동	
}

//기본지도 클릭시 //우측 마우스 클릭시
kakao.maps.event.addListener(map, 'rightclick',function(mouseEvent){
	var latlng = mouseEvent.latLng; //클릭된 포인트의 좌표
	markerbase.setPosition(latlng); //마커 이동
});
//인덱스지도 클릭시 //좌측 마우스 클릭시
/*kakao.maps.event.addListener(indexMap, 'click',function(mouseEvent){
	var latlng = mouseEvent.latLng;
	marker.setPosition(latlng); //마커이동
	map.setCenter(latlng); //기본지도 중심이동
	indexMap.setCenter(latlng); //인덱스지도 중심이동
});*/

//인덱스맵 On/Off
$("#addIndexBtn").bind("click", function(){
	if($(this).val() == "+"){
		//On
		$(this).val("-");
		$("#index_map").css("visibility","visible");
	} else {
		//Off
		$(this).val("+");
		$("#index_map").css("visibility","hidden");		
	}
});

function setMapType(maptype) {
    if (maptype === 'base') {
        map.setMapTypeId(kakao.maps.MapTypeId.ROADMAP);
	        if($('#map_air').hasClass('btn_ty') == true){
	        	$('#map_air').removeClass('btn_ty');
	        	$('#map_air').removeClass('l-btn-selected');
	        	$('#map_base').addClass('btn_ty');
	        	$('#map_base').addClass('l-btn-selected');
	        }else{
	        	$('#map_base').addClass('btn_ty');
	        	$('#map_base').addClass('l-btn-selected');
	        }
    } else {
        map.setMapTypeId(kakao.maps.MapTypeId.HYBRID);
	        if($('#map_base').hasClass('btn_ty') == true){
	        	$('#map_base').removeClass('btn_ty');
	        	$('#map_base').removeClass('l-btn-selected');
	        	$('#map_air').addClass('btn_ty');
	        	$('#map_air').addClass('l-btn-selected');
	        }else{
	        	$('#map_air').removeClass('btn_ty');
	        	$('#map_air').addClass('l-btn-selected');
	        }
    }
}

$("#add_address_btn").bind("click", function(){
	if($(this).val() == "+") {
		$(this).val("-");
		$("#menu_wrap").show();
	}
	else {
		$(this).val("+");
		$("#menu_wrap").hide();		
	}
});

// 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
function zoomIn() {
    map.setLevel(map.getLevel() - 1);
}

// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
function zoomOut() {
    map.setLevel(map.getLevel() + 1);
}

//마커를 담을 배열입니다
var markers = [];

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();
// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {
    var keyword = document.getElementById('keyword').value;
    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }
    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {
        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
        alert('검색 결과가 존재하지 않습니다.');
        return;
    } else if (status === kakao.maps.services.Status.ERROR) {
        alert('검색 결과 중 오류가 발생했습니다.');
        return;
    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {
    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {
        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
            
            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해 LatLngBounds 객체에 좌표를 추가합니다
            bounds.extend(placePosition);
            
            // 마커와 검색결과 항목에 mouseover 했을때 해당 장소에 인포윈도우에 장소명을 표시합니다
			// mouseout 했을 때는 인포윈도우를 닫습니다
			(function(marker, title) {
				
				itemEl.onmouseout =  function () {
					$(this).click(function(e) {
						var target = e.currentTarget.firstChild.classList[1];
						var selNo = target.substr(target.indexOf('_')+1)-1;
						
						map.setCenter(new kakao.maps.LatLng(places[selNo].y, places[selNo].x));
						
						$('#loading').hide();
					})
				};
			})
            (marker, places[i].place_name);
            fragment.appendChild(itemEl);
            
            //$('#loading').hide();
	}
    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {
    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
    
    itemStr += '  <span class="tel">' + places.phone  + '</span>' + '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = '../../images/icons/marker_number_blue.png';
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}


