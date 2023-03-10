<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>


<link rel="stylesheet" href="${cpath }/resources/css/footer/footer.css" type="text/css">

<div id="main">
	<div id="fBody">
		<div id="fRoot">
			<div class="come_title">
				<div class="come_title_L">오시는길</div>
				<div class="come_title_R">Home > 오시는길</div>
			</div>
			<div id="map"></div>
			<div class="come_main">
				<div class="come_img">
					<img src="${cpath }/resources/img/지아고빌딩.jpg" class="comeImg">
				</div>
				<div >
					<ul class="come_ul">
						<li class="come_li">
							<dl class="come_dl">
								<dt class="come_dt">주 소</dt>
								<dd class="come_dd">부산 해운대구 센텀2로 25 센텀드림월드 11층</dd>
							</dl>
						</li>
					</ul>
					
					<ul class="come_ul">
						<li class="come_li_2">
							<dl class="come_dl">
								<dt class="come_dt">교 통 편</dt>
								<dd class="come_dd">
									<div>
										<p class="come_p_title">
											지하철
										</p>
										<div>
											<p class="come_p_center">
												<span class="come_span_subway">2호선</span>
												<span class="come_span">센텀시티역 9번 출구에서 193m</span>
											</p>
										</div>
									</div>
									<div>
										<p class="come_p_title">
											버스
										</p>
										<div>
											<p class="come_p_center">
												<span class="come_span_bus1">지선</span>
												<span class="come_span">1002, 1115, 181</span>
											</p>
											<p class="come_p_center">
												<span class="come_span_bus2">간선</span>
												<span class="come_span">101, 707, 108, 103</span>
											</p>
											<p class="come_p_center">
												<span class="come_span_bus3">광역</span>
												<span class="come_span">1002</span>
											</p>
										</div>
									</div>
								</dd>
							</dl>
						</li>
					</ul>
				</div>

			</div>
		</div>
		
	</div>
	
	
	
	
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2138103522bb5cc0b51caf1b45ef9917"></script>

<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(35.167020, 129.132918), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 
var markerPosition  = new kakao.maps.LatLng(35.167020, 129.132918); 

//마커를 생성합니다
var marker = new kakao.maps.Marker({
 position: markerPosition
});

//마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

var iwContent = '<div style="padding:5px;">지아고 본진 <br><a href="https://map.kakao.com/link/map/Hello World!,35.167020, 129.132918" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/Hello World!,35.167020, 129.132918" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    iwPosition = new kakao.maps.LatLng(35.167020, 129.132918); //인포윈도우 표시 위치입니다

// 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
    position : iwPosition, 
    content : iwContent 
});
  
// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
infowindow.open(map, marker); 
</script>
	
	
	
    
	
	
</div>

<%@ include file="../footer.jsp" %>
</body>
</html>