<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>
#dateList {
	height: 20%; 
	padding: 150px;
	margin-top: -30px;
}
#dateList > div {
	padding-bottom: 30px;
	cursor: pointer; 
} 
#dateList > div:nth-child(1) {
	margin-left: -35px;
}
#dateList > div:nth-child(1) ~ div {
	margin-left: -10px;
}

.activeDate {
	color:black; 
	font-size: 16px; 
	font-weight: bold;
}
.nActiveDate {
	font-size: 16px;
	font-weight: bold;
}
</style>
  
<script type="text/javascript">
$(function() {
	gubunCode = ${gubunCode};	
	subMenu = ${subMenu};
	initDateList();
}); 
var gubunCode;
var subMenu;

function ajaxHTML(url, type, query) {
	$.ajax({
		type:type,
		url:url,
		data:query,
		success:function(data){
			if($.trim(data)=="error"){
				listPage(1);
				return;
			}
			$("#showList").html(data);
		},
		beforeSend:function(jqXHR){
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR){
			if(jqXHR.status==403){
				location.href="<%=cp%>/member/login";
				return;
			}
			console.log(jqXHR.responseText);
		}
	});
}

function changeDate(dataDate, num) {
	for(var i = 0; i < 7; i++) {
		var $pDiv = $('#dateList div[class=col-md-2]').eq(i);
		$pDiv.children("img").removeAttr('src');
		$pDiv.children("img").attr('src', '<%=cp%>/resource/images/circle.PNG');
		$pDiv.find("span").removeClass();
		$pDiv.find("span").addClass('nActiveDate');
	}
 
	// 클릭한 태그 변경 적용
 	$pDiv = $('#dateList div[class=col-md-2]').eq(num-1);
 	$pDiv.children("img").removeAttr('src');
	$pDiv.children("img").attr('src', '<%=cp%>/resource/images/circle_line.png');	
	$pDiv.find("span").removeClass();
	$pDiv.find("span").addClass('activeDate');
		
	// showList.jsp - ajax
	var url = "<%=cp%>/reservation/show/detail";
	var query = "gubunCode=" + gubunCode + "&date=" + dataDate;
	ajaxHTML(url, "get", query);
}

function initDateList() { // d-오늘부터 일주일로 바꾸기
	var date = dateToString(new Date());
	var dateAry = '';
	var $dateListdiv = document.getElementById('dateList');
	
	for(var i = 0; i <= 6; i++) {
		dateAry = getDaysLater(date, i+1);
		var dataDate = dateAry;			// 2018-09-01
		
		dateAry = dateAry.substr(5);
		var m = dateAry.substr(0, 2);
		var d = dateAry.substr(3, 4);
		dateAry = m + "/" + d;			//	09/23
		
		var $image = document.createElement('img');
		$image.setAttribute('width', '100px');
		$image.setAttribute('height', '100px');
		$image.setAttribute('class', 'img-responsive');
		
		var $span = document.createElement('span');
		
		var $pDiv = document.createElement('div');
		$pDiv.setAttribute('class', 'col-md-2');
		$pDiv.setAttribute('data-num', i+1);
		$pDiv.setAttribute('onClick', "changeDate('" + dataDate + "', '" + (i+1) + "');");
   
		
		if(i == 0) { // image 흰색 원, 글씨 검정
			$image.setAttribute('src', '<%=cp%>/resource/images/circle_line.png');
			$span.setAttribute('class', 'activeDate');
		} else { // image 보라원, 글씨 흰색
			$image.setAttribute('src', '<%=cp%>/resource/images/circle.PNG');
			$span.setAttribute('class', 'nActiveDate');
		}
		$span.setAttribute('screenDate', dataDate);
		$span.innerText = dateAry;
		
		var $cDiv = document.createElement('div');
		$cDiv.setAttribute('class', 'carousel-caption');
		
		$pDiv.appendChild($image);
		$cDiv.appendChild($span);
		$pDiv.appendChild($cDiv);
		
		$dateListdiv.appendChild($pDiv);
	}

	var url = "<%=cp%>/reservation/show/detail";
	var query = "gubunCode=" + gubunCode + "&date=" + getDaysLater(date, 1);
	ajaxHTML(url, "get", query);
}  
 
function detailShow(showInfoCode) {
	var screenDate = $("span[class=activeDate]").attr('screenDate');
	
	var url = "<%=cp%>/show/article";
	var query = "subMenu=" + subMenu + "&showInfoCode=" + showInfoCode + "&screenDate=" + screenDate;
	location.href = url + "?" + query;
} 

function reservation(showInfoCode) {
	var screenDate = $("span[class=activeDate]").attr('screenDate');
	
	var url = "<%=cp%>/show/reseration";
	var query = "subMenu=" + ${subMenu} + "&showInfoCode=" + showInfoCode + "&screenDate=" + screenDate;
	location.href = url + "?" + query;
}
</script>
  
<div class="bodyFrame2">
	<div class="body-title">
		<h3><span class="glyphicon glyphicon-th-list"></span>&nbsp;&nbsp;&nbsp;금주의 ${gubun} </h3>
	</div>
	
	<div id="dateList" align="center"></div>

	<div id="showList"></div>
	
</div>



