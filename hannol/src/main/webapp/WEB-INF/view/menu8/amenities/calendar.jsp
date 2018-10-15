<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>
	/*풀캘린더*/
	.fc-unthemed td.fc-today{background:none;}
	td.fc-other-month .fc-day-number{visibility:hidden;}
	.fc-other-month{background:#d7d7d7; opacity:.3;}
	
	.btnBox{margin-top:20px; text-align:right;}  
</style>

<script type="text/javascript" src="<c:url value='/resource/fullcalendar/fullcalendar.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resource/fullcalendar/locale-all.js'/>"></script>
<script type="text/javascript">
	//전체달력
	$(function(){
		var startDay = "${startDay}";
		var endDay = "${endDay}";   
		var selectDay = "";
		
		$("#calendar").fullCalendar({
			 header:{
				 left:"prev, today",     
				 center:"title",
				 right:"next"    
			 },
			 locale:"ko",
			 validRange:{//사용자가 이동할 수 있는 날짜와 이벤트 위치 제한
				 start:startDay,
				 end:endDay
			 },
			 defaultView:"month",
			 selectable:false, 
			 dayClick:function(date){
				 //fc-other-month가 이번달에서 지난 요일들만 클래스를 주기때문에 그부분을 못찾으면 못찾는 부분들만 실행
				 if($(this).attr("class").indexOf("fc-other-month") == -1){
					 $("td img").remove(); 
					 $(this).css({"text-align":"center",    
						 			"vertical-align":"middle"}).append("<img src='<%=cp%>/resource/images/hannol_logo_one.png' alt='선택날짜' style='width:50px;'>")
					 
					selectDay = date.format("YYYY-MM-DD");
				 }       
			 }
		});
		
		//날짜 선택(예약하기)
		$("#daySelect").click(function(){
			if(selectDay==""){
				alert("날짜를 선택해 주세요.");
				return;
			}  
			
			
			location.href="<%=cp%>/amenities/checkTicket?gubunCode=${gubunCode}&selectDay="+selectDay;         
		});   
	});
	

</script>


<div class="bodyFrame2">
	<div class="body-title">
		<h3>
			<span class="glyphicon glyphicon-calendar"></span> 편의시설  
		</h3>
	</div>
	
	<div>
		<div id="calendar"></div>
	</div>

	<div class="btnBox">
    	<button type="button" id="daySelect" class="btn btn-info">예약하기</button>
    </div>
</div>








