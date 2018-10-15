<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>
.nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover
	{
	background-color: #337ab7;
	color: #ffffff;
}

.body-title h3 {
	margin-bottom: 0px;
}

.tit{
	font-size: 20px;
	font-weight: bold;
	margin: 15px 0px 0px 10px;
}

.subway li, .bus li{
	list-style: none;
	font-size: 15px;
	margin-top: 10px;
}

.label-subway{
	display: inline-block;
	font-size: 15px;
}

.subway-green{
	background: #5ab254;
	display: inline-block;
	width: 25px;
	height: 25px;
	border-radius: 12.5px;
	margin-right: 10px;
	line-height: 25px;
	color: #fff;
	text-align: center;
	font-size: 15px;
}

.subway-air{
	background: #58a9ff;
	display: inline-block;
	width: 40px;
	height: 25px;
	border-radius: 12.5px;
	margin-right: 10px;
	line-height: 25px;
	color: #fff;
	text-align: center;
	font-size: 15px;
}

.subway-center{
	background: #44cc94;
	display: inline-block;
	width: 70px;
	height: 25px;
	border-radius: 12.5px;
	margin-right: 10px;
	line-height: 25px;
	color: #fff;
	text-align: center;
	font-size: 15px;
}

.bus-gisun{
	background: #62af1e;
	display: inline-block;
	width: 40px;
	height: 25px;
	border-radius: 12.5px;
	margin-right: 10px;
	line-height: 25px;
	color: #fff;
	text-align: center;
	font-size: 15px;
}

.bus-kang{
	background: #d63945;
	display: inline-block;
	width: 40px;
	height: 25px;
	border-radius: 12.5px;
	margin-right: 10px;
	line-height: 25px;
	color: #fff;
	text-align: center;
	font-size: 15px;
}

.bus-gan{
	background: #366fc6;
	display: inline-block;
	width: 40px;
	height: 25px;
	border-radius: 12.5px;
	margin-right: 10px;
	line-height: 25px;
	color: #fff;
	text-align: center;
	font-size: 15px;
}

.subway p {
	display: inline-block;
}
</style>

<script>
$(function(){
	$(".nav-link").click(function(){
		$(".nav-item").removeClass("active");
		$(this).parent(".nav-item").addClass("active");
		
		$(".subway").css("display", "none");
		$(".bus").css("display", "none");
		
		if($(this).attr("data-gubun") == "subway"){
			$(".subway").css("display", "block");
		}
		
		if($(this).attr("data-gubun") == "bus"){
			$(".bus").css("display", "block");
		}
	});
});

$(function(){
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new daum.maps.LatLng(37.5575312,126.9222782), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };
	
	var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	// 마커가 표시될 위치입니다 
	var markerPosition  = new daum.maps.LatLng(37.5575312,126.9222782); 
	
	// 마커를 생성합니다
	var marker = new daum.maps.Marker({
	    position: markerPosition
	});
	
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
});
</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-tower"></span> 오시는 길 </h3>
    </div>
    
    <div>
		<ul class="nav nav-tabs">
		  <li class="nav-item active">
		    <a class="nav-link" href="#" data-gubun="bus">버스&지도</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="#" data-gubun="subway">지하철</a>
		  </li>
		</ul>
		
		<div class="subway" style="display: none;">
			<div>
				<img alt="지하철노선도" src="<%=cp%>/resource/images/img_subway.png" style="width: 100%;">
			</div>
			<div>
				<p class="tit">지하철 이용시</p>
				<ul>
					<li>
						<p class="label-subway" style="color: #5ab254">
							<span class="subway-green">2</span>
							2호선
						</p>
						<p>홍대역 2번 출구</p>
					</li>
					<li>
						<p class="label-subway" style="color: #58a9ff">
							<span class="subway-air">공항</span>
							공항철도
						</p>
						<p>홍대역 2번 출구</p>
					</li>
					<li>
						<p class="label-subway" style="color: #44cc94">
							<span class="subway-center">경의중앙</span>
							경의중앙선
						</p>
						<p>홍대역 2번 출구</p>
					</li>
				</ul>
			</div>
		</div>
		
		
		<div class="bus">
			<div>
				<div id="map" style="width:100%;height:350px;"></div>
				<p class="tit">버스 이용시</p>
				<ul>
					<li>
						<p class="label-subway">
							<span class="bus-gisun">지선</span>
						</p>
						<p>3317번, 3313번, 3314번, 3315번, 3317번, 3411번, 3414번, 4319번</p>
					</li>
					<li>
						<p class="label-subway">
							<span class="bus-kang">광역</span>
						</p>
						<p>1100번, 1700번, 2000번, 6900번, 7007번, 8001번</p>
					</li>
					<li>
						<p class="label-subway">
							<span class="bus-gan">간선</span>
						</p>
						<p>301번, 341번, 360번, 362번</p>
					</li>
				</ul>
			</div>
		</div>
				
    </div>
</div>