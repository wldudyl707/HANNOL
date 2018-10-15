<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<style>
.assetsContents {
	text-align: center;
	margin-top: 60px
}

.assets_box {
	display: inline-block;
	position: relative;
	width: 23.8%;
	margin-left: 1.5%;
	border: 1px solid #d5d5d5;
	border-radius: 3px;
}

.assets_box:first-child {
	margin-left: 0;
}

.assets_box:hover {
	cursor: pointer;
}

.assets_box:before {
	content: '';
	position: absolute;
	top: -1px;
	left: -1px;
	width: calc(100% + 2px);
	height: calc(100% + 2px);
	z-index: 5;
}

.assets_box:hover:before {
	box-shadow: 10px 10px 15px rgba(0, 0, 0, 0.2);
	transition: .3s ease;
}

.assets_box dt img {
	width: 100%;
}

.assets_box dd {
	position: relative;
	padding: 30px;
	text-align: left;
	color: #666666;
}

.assets_box .as_title {
	margin-top: 20px;
	font-size: 19px;
	font-weight: 700;
}

.assets_box .as_subTitle {
	margin-top: 2px;
}

.assets_box .as_btn {
	position: absolute;
	right: 31px;
	bottom: 32px;
	opacity: 0.5;
}

.running_time {
	display: inline-block;
	position: relative;
	width: 23%;
	margin-left: 1.5%;
	border: 1px solid #d5d5d5;
	border-radius: 3px;
}

.running_time dt img {
	width: 100%;
}

.running_time dd {
	position: relative;
	padding: 30px;
	text-align: left;
	color: #666666;
}

.running_time .as_title {
	margin-top: 20px;
	font-size: 19px;
	font-weight: 700;
}

.running_time .as_subTitle {
	margin-top: 2px;
}

.container-bottom {
	margin-top: 50px;
	position: relative;
}

.newsDiv {
	padding: 28px 20px;
	width: 422px;
	height: 148px;
	float: left;
	position: relative;
	border: 1px solid #d9d9d9;
}

.mainCont4Tit{
	font-size: 22px;
	font-weight: bold;
	color: #000;
}

.tit{
	width : 70%;
	float:left;
	line-height : 30px;
	font-size: 16px;
	color: #000;
}

.date{
	float:right;
	line-height : 30px;
	font-size: 16px;
	color: #000;
}

/*모바일*/
@media all and (min-width: 768px) and (max-width: 991px) {
	dl.assets_box{display:inline-block; width:35%; margin:0 2% 5% 2%;}
	.running_time{display:inline-block; width:35%; margin:0 2% 5% 2%;}
	.assets_box:first-child{margin-left: 1.5%;}
} 

@media (max-width: 767px){
	.assets_box{display:block; width:90%; margin:0 5% 10% 5%;}  
	.assets_box:first-child{margin-left:5%;}
	.running_time{display:block; width:90%; margin:0 5% 10% 5%;}
	.running_time:first-child{margin-left:5%;}
} 
</style>

<div id="myCarousel" class="carousel slide" data-ride="carousel">
	<!-- Indicators -->
	<ol class="carousel-indicators">
		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		<li data-target="#myCarousel" data-slide-to="1"></li>
	</ol>

	<!-- Wrapper for slides -->
	<div class="carousel-inner main_slide" role="listbox">
		<div class="item active">
			<img src="<%=cp%>/resource/images/slideImg01.jpg" alt="첫번째 슬라이드">
			<div class="carousel-caption"></div>
		</div>

		<div class="item">
			<img src="<%=cp%>/resource/images/slideImg02.jpg" alt="두번째 슬라이드">
			<div class="carousel-caption"></div>
		</div>
	</div>

	<!-- Left and right controls -->
	<a class="left carousel-control" href="#myCarousel" role="button"
		data-slide="prev"> <span class="glyphicon glyphicon-chevron-left"
		aria-hidden="true"></span> <span class="sr-only">Previous</span>
	</a> <a class="right carousel-control" href="#myCarousel" role="button"
		data-slide="next"> <span class="glyphicon glyphicon-chevron-right"
		aria-hidden="true"></span> <span class="sr-only">Next</span>
	</a>
</div>

<div class="main_content">
	<div class="container">
		<div class="assetsContents">

			<dl id="stroller" class="assets_box facility"
				onclick="javascript:location.href='<%=cp%>/reservation/ticket'">
				<dt>
					<img src="<%=cp%>/resource/images/ticket.jpg" alt="티켓구매">
				</dt>
				<dd>
					<p class="as_title">티켓구매</p>
					<p class="as_btn">
						<img src="<%=cp%>/resource/images/btn_01.png">
					</p>
				</dd>
			</dl>

			<dl id="wheelchair" class="assets_box facility"
				onclick="javascript:location.href='<%=cp%>/magicPass/booking'">
				<dt>
					<img src="<%=cp%>/resource/images/magicPass.png" alt="매직패스">
				</dt>
				<dd>
					<p class="as_title">매직패스</p>
					<p class="as_btn">
						<img src="<%=cp%>/resource/images/btn_01.png">
					</p>
				</dd>
			</dl>

			<dl id="storageBox" class="assets_box"
				onclick="javascript:location.href='<%=cp%>/todayPark/rides'">
				<dt>
					<img src="<%=cp%>/resource/images/todaysPark.png" alt="오늘의파크">
				</dt>
				<dd>
					<p class="as_title">오늘의파크</p>
					<p class="as_btn">
						<img src="<%=cp%>/resource/images/btn_01.png">
					</p>
				</dd>
			</dl>
			<dl id="storageBox" class="running_time">
				<dt>
					<img src="<%=cp%>/resource/images/time.png" alt="운영시간">
				</dt>
				<dd>
					<p class="as_title">오늘의파크</p>
				</dd>
			</dl>
		</div>
	</div>
</div>