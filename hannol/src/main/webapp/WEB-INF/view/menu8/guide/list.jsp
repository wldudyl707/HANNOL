<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">

	var dataset = [
     <c:forEach var="listview" items="${guideList}" varStatus="status">
	        {
	        	"id":'<c:out value="${listview.schCode}" />'
		        ,"title":'<c:out value="${listview.name} ( ${listview.role} )" />'
		        ,"start":"<c:out value="${listview.workDate}" />"
		        ,"url":"<%=cp%>/guide/info?schCode=${listview.schCode}"
		        	<c:if test="${listview.timezone==1}">,"color" : "#7FB3D5"</c:if>
		        	<c:if test="${listview.timezone==2}">,"color" : "#2980B9"</c:if>
		        	<c:if test="${listview.bookCode!=''}">,"color" : "#E74C3C"</c:if>
	        }  
	        <c:if test="${!status.last}">,</c:if>
	</c:forEach> 
];

$(document).ready(function() {
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
	
	var startDay = "${startDay}";
	var endDay ="${endDay}";
	
	$('#calendar').fullCalendar({
		locale:'ko',
	    header: {
	        left: 'prev,next today',
	        center: 'title',
	         right: 'month,basicWeek,basicDay' 
	    },
	    defaultDate: new Date(),
	    navLinks: true, 
	    editable: false,
	    displayEventTime: false,
	    eventLimit: true,
	    monthNames: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
	    monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
	    dayNames: ["일요일","월요일","화요일","수요일","목요일","금요일","토요일"],
	    dayNamesShort: ["일","월","화","수","목","금","토"],
	    buttonText: {
		    today : "오늘",
		    month : "월별",
		    week : "주별",
		    day : "일별",
	    },
	    validRange: {
	         start: startDay,
	    	 end: endDay
	    },
	    events: dataset,
	    eventClick: function(calEvent, jsEvent, view) {
	
	    		if (event.url) {
	    	      window.open(event.url);
	    	      return false;
	    	    } 
	      }
	});
});


$(function(){
	$(document).on("click","button[name=insertBtn]",function(){
		
		$("#insertModal").dialog({
			title:"가이드 일정 추가",
			width:350,
			height:300, 
			modal:true,
			show:"clip",
			hide:"clip"
		});
	});
});

function sendGuide(){
	var url = "<%=cp%>/guide/insertGuide";
	
 	var query = $("#insertForm").serialize();
 	
	// AJAX-POST
	 $.ajax({
		type:"post"
		,url:url	//서버의 주소
		,data:query	//서버로 보내는 값
		,dataType:"json"
		,success:function(data){
			$("#resultLayout").html("추가완료!");
			location.href="<%=cp%>/guide/list"
		}
		,error:function(e){
			console.log(e.responseText);
			$("#resultLayout").html("에러발생!");	
		}
	});   
}

	$(function() {
		$("#startDate").datepicker({
			showMonthAfterYear : true,
			showOn : "button",
			buttonImage : "<%=cp%>/resource/images/calendar.gif",
			buttonImageOnly : true,
			showMonthAfterYear : true
			,onClose: function( selectedDate ) {
	              $("#endDate").datepicker( "option", "minDate", selectedDate );
	           }

		})
	})
	
	$(function() {
		$("#endDate").datepicker({
			showMonthAfterYear : true,
			showOn : "button",
			buttonImage : "<%=cp%>/resource/images/calendar.gif",
			buttonImageOnly : true,
			showMonthAfterYear : true
			,onClose: function( selectedDate ) {
	               $("#startDate").datepicker( "option", "maxDate", selectedDate );
	           }

		})
	})
	
</script>
<script type="text/javascript" src="<c:url value='/resource/fullcalendar/fullcalendar.min.js'/>"></script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-tower"></span> 가이드 예매</h3>
    </div>
    
    <div>
        <div id="calendar"></div>
    </div>
    
    <div id="stateLayout">${msg }</div>
    <div id="resultLayout"></div>
</div>