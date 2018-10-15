<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<script type="text/javascript" src="<c:url value='/resource/fullcalendar/fullcalendar.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resource/fullcalendar/locale-all.js'/>"></script>

<style>
.fc-unthemed td.fc-today{
	background: none;
}

td.fc-other-month .fc-day-number{
   visibility: hidden;
}

.fc-other-month{
	background : #d7d7d7;
	opacity : .3;
}
</style>
<script>
$(function(){
	var startDay = "${startDay}";
	var endDay ="${endDay}";
	var selectDay = "";
	
	$('#calendar').fullCalendar({
	    selectable: false,
	    locale : "ko",
	    header: {
	      left: 'prev',
	      center: 'title',
	      right: 'next'
	    },
	    dayClick: function(date) {
	    	if($(this).attr("class").indexOf("fc-other-month") == -1){
	  	      $("td img").remove();
		      $(this).css("vertical-align", "middle");
		      $(this).css("text-align", "center");
		      $(this).append("<img src='<%=cp%>/resource/images/hannol_logo_one.png' alt='선택날짜' style='width:50px;'>")
		      
		      selectDay = date.format();
	    	}  	

	    },
	    defaultView: 'month',
	    validRange: {
	         start: startDay,
	    	 end: endDay
	    }
	  });
	
	$(".btn-dayTicket").click(function(){
		if(selectDay==""){
			alert("날짜를 선택해 주세요.");
			return;
		}
		
		
		var url = "<%=cp%>/reservation/checkUser";
		var data = "day="+selectDay;
		console.log(selectDay);
		
		$.ajax({
			type:"GET"
			,url:url
			,data: data
			,success:function(data) {
				if(Number(data.limit)==4){  //구매수량 최대 4장
					alert("최대 구매수량을 초과할 수 없습니다.");
					return;
				}else if(Number(data.limit) < 4){
					if(!confirm("예약하시는 날짜가 "+selectDay+"가 맞습니까?")){
						return;
					}
					
					location.href="<%=cp%>/reservation/dayTicket?day="+selectDay+"&limit="+data.limit;
				}else if(data.state=="fail"){ //로그인체크
					alert("로그인 후 이용해 주세요");
					location.href="<%=cp%>/member/login";
				}else if(data.state=="close"){  //시스템적 에러
					alert("죄송합니다 해당날짜는 구매가 마감되었습니다");			
				}else{
					alert("죄송합니다 고객님의 요청을 완료하지 못했습니다. 다시 시도해 주세요");
				}
			}
		    ,error:function(e) {
		    	console.log(e.responseText);
		    }
		});
		
		
		
		
	});
});
</script>

<style>
.fc-scroller-y {
   overflow: hidden !important;
}
</style>
<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="	glyphicon glyphicon-calendar"></span>예매</h3>
    </div>
		<div id="calendar"></div>    
    <div>
    
    <div style="margin-top: 20px; float: right;">
    	<button type="button" class="btn btn-info btn-dayTicket">예약하기</button>
    </div>
    
    </div>
</div>