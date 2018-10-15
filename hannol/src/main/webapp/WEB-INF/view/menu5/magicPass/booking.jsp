<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>
.form-control {
	width: 20%;
	float: left;
	padding: 5px 5px;
}

.col-xs-offset-2 {
	margin-left: 0px;
	margin-bottom: 15px;
}

.txtTitle {
	float: left;
	font-size: 14px;
	font-weight: bold;
	vertical-align: middle;
	margin: 5px;
}

.img img{
	width: 150px;
	height: 150px;
}

.img{
	width: 160px;
	vertical-align: middle;
	display: table-cell;
}

.div-box a{
	display: table;
	width: 100%;
	line-height: 0;
}

.div-box{
	float: left;
	width: 100%;
	margin: 5px;
	border: 1px solid #eee;
	box-shadow: 1px 1px #ececec;
    font-size: 2.5em;
    font-weight: bold;
    min-width: 300px;
}

.txt{
	display: table-cell;
	vertical-align: middle;
	width: 100%;
	padding: 10px;
}

.txt li{
	margin-bottom: 10px;
}

.btn-magicPass, .btn-magicPass-p{
	width: 150px;
	height: 150px;
	display: table-cell;
	vertical-align: middle;
}

.select-Time{
	float: none;
}

.check-ticket input{
	vertical-align: middle;
	margin: 0px 10px 0px 10px;
}

.check-ticket{
	display: block;
	clear: both;
	margin-left: 10px;
	vertical-align: middle;
	
}

.modal-body{
	min-height: 300px;
}
</style>

<script>
function searchList(){
	var f=document.searchForm;
	f.submit();
}

$(function(){
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
	
	var thema = "${thema}";
	$(".form-control option").each(function(){
		if($(this).val()==thema){
			$(this).attr('selected',true);
		}
	})
	
	//예약하기 모달창 띄우기
	$(".btn-magicPass").click(function(){
		var facilityCode = $(this).attr("data-facilityCode");
		var url = "<%=cp%>/magicPass/getReservation";
		var data = "facilityCode="+facilityCode;
		$(".txt-hidden").val(facilityCode);
		
		//초기화
		$(".select-Time option").each(function(){
			$(this).attr("disabled", false);
		});
		$(".check-ticket").html("");
		$(".select-Time").val("");
		 
		
		//시간별 탑승가능 여부 확인
		$.ajax({
			type:"GET"
			,url:url
			,data: data
			,success:function(data) {
				
				$(".select-Time option").not(":first").each(function(){
					//지난 시간 예약불가
					if(Number($(this).val()) <= Number(data.timeStamp)){
						$(this).attr("disabled", true);
					}
					
					for(var i=0; i < data.list.length; i++){	
						//100명이상 예약 불가
						if($(this).val() == data.list[i].mpTime && data.list[i].state==1){
							$(this).attr("disabled", true);
						}	
					}
				});	
					
				//이용권 추가
				var html = "";
				for(var i=0; i < data.ticketList.length; i++){
					html+="<span class='check-ticket'><input type='checkbox' name='ticketCode' data-gubun="+data.ticketList[i].ticketGubun+" value="+data.ticketList[i].ticketsCode+">"+"["+data.ticketList[i].gubunName+"]"+data.ticketList[i].goodsName+"</span>";
				}
				
				$(".p-ticket").html(html);
				
				$("#myModal").modal();
				
			}
		    ,error:function(e) {
		    	console.log(e.responseText);
		    }
		});
		
	});
	
	$(".btn-magicpass-rsv").click(function(){
		var times = $(".select-Time").val();
		if(times == ""){
			alert("시간대를 선택해 주세요");
			return;
		}
		
		var $tickets = $("input[name$='ticketCode']");
		var state = "false";
		for(var i=0; i<$tickets.length; i++){
			if($($tickets[i]).is(":checked")){
				state = "true";
				
				if($($tickets[i]).attr("data-gubun")=="6" && (Number(times) < Number("16"))){
					alert("야간권+매직패스권은 오후 4시부터 예약이 가능합니다.");
					return;
				}
			}
		}
		
		if(state=="false"){
			alert("선택된 이용권이 없습니다.");
			return;
		}
		
		var f = document.reservationForm;
		f.submit();
	});
});
</script>

<div class="bodyFrame2">
	<div class="body-title">
		<h3>
			<span class="glyphicon glyphicon-tower"></span> 매직패스 예약
		</h3>
	</div>

	<div>
		<form name="searchForm" method="post" action="<%=cp%>/magicPass/booking">
			<div>
				<span class="txtTitle">테마</span> <span> 
				<select	class="form-control" name="thema">
						<option value="0">전체</option>
						<option value="3">미니언즈</option>
						<option value="1">프린세스빌리지</option>
						<option value="5">라이언킹</option>
						<option value="6">니모</option>
						<option value="2">토이스토리</option>
				</select>
				</span>
			</div>
	
			<div class="col-xs-8 col-xs-offset-2">
				<span class="txtTitle">어트랙션명</span>
				<div class="input-group">
					<input type="text" style="height: 35px;" class="form-control" name="searchValue" id="searchValue" placeholder="검색할 키워드를 입력해 주세요..." value="${searchValue}"> 
						<span class="input-group-btn">
						<button class="btn btn-info" type="button" onclick="searchList()">
							<span class="glyphicon glyphicon-search"></span>
						</button>
					</span>
				</div>
			</div>
		</form>
		
		<c:forEach items="${list}" var="dto">
			<div class="div-box">
	        		<p class="img">
	        			<img alt="${dto.name}" src="/hannolAdmin/uploads/facility/${dto.saveMainFileName}" onerror="this.src='<%=cp%>/resource/images/noimage.png'">
	        		</p>
	        		<ul class="txt">
	        			<li>${dto.name }</li>
	        			<c:if test="${dto.congestion==0}">
	        				<li style="color : tomato;">혼잡</li>
	        			</c:if>
	        			<c:if test="${dto.congestion==1}">
	        				<li style="color : blue;">보통</li>
	        			</c:if>
	        			<c:if test="${dto.congestion==2}">
	        				<li style="color : green;">원활</li>
	        			</c:if>
	        			
	        		</ul>
	        		<p class="btn-magicPass-p">	
	        			<button type="button" class="btn btn-info btn-magicPass" data-facilityCode="${dto.facilityCode}">예약하기</button>
	        		</p>
	        </div>
        </c:forEach>
        
        
	    <div style="text-align: center;">${paging}</div>
    
    	<!-- Modal -->
	  <div class="modal fade" id="myModal" role="dialog">
	    <div class="modal-dialog">
	    
	    <form name="reservationForm" action="<%=cp%>/magicPass/reservation" method="POST">
	      <!-- Modal content-->
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		          <h4 class="modal-title">매직패스 예약하기</h4>
		        </div>
		        <div class="modal-body">
		          <p>
		          	<span class="txtTitle">시간대</span>
		          	<span>
			          	<select class="form-control select-Time" name="mpTime">
			          		<option value="">시간선택</option>
			          		<option value="9">9:00~10:00</option>
			          		<option value="10">10:00~11:00</option>
			          		<option value="11">11:00~12:00</option>
			          		<option value="12">12:00~13:00</option>
			          		<option value="13">13:00~14:00</option>
			          		<option value="14">14:00~15:00</option>
			          		<option value="15">15:00~16:00</option>
			          		<option value="16">16:00~17:00</option>
			          		<option value="17">17:00~18:00</option>
			          		<option value="18">18:00~19:00</option>
			          		<option value="19">19:00~20:00</option>
			          		<option value="20">20:00~21:00</option>
			          	</select>
		          	</span>
		          </p>
		          <p style="margin-top: 10px;">
		          	<span class="txtTitle">이용권</span>
		          </p>
		          <p class="p-ticket">
		          </p>
		        </div>
		        <div class="modal-footer">
		          <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
		          <button type="button" class="btn btn-info btn-magicpass-rsv">예약하기</button>
		          <input type="hidden" name="facilityCode" class="txt-hidden">
		        </div>
		      </div>
	      </form>
	      
	    </div>
	  </div>
		
	</div>
</div>