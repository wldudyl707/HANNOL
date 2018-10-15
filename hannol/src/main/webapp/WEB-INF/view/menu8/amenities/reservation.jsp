<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>
	.contents_title{margin-left:3px; margin-bottom:10px; font-weight:bold; font-size:20px;} 
	
	/*table_01*/
	.table_01 tr{border-bottom:1px solid #e4e4e4;}
	.table_01 tr:first-child{border-top: 2px solid #cecece;}  
	.table_01 th,
	.table_01 td{padding:10px 19px;}      
	.table_01 th{text-align:right; background:#f4f4f4; border-right:1px solid #e4e4e4}  
	
	select{height:25px;} 
	input[type=radio],  
	.radioSpan{margin:0; vertical-align:middle;}
	.radioSpan{margin-right:13px; margin-left:2px;}     
	.TFbox{width:200px; padding:0 5px;}        
	.tel{width:60px; text-align:center; box-sizing:border-box;}    
	
	.btnBox{margin-top:50px; text-align:right;}  
	
	.noStyle_tf{background-color:transparent; border:0 none;}  
	
	.warning{color:tomato;}  
</style> 
 
<script type="text/javascript">
	var elementsName = [];
	var elementsNameText = [];
	
	$(function(){
		var elements = $("form[name=reservationForm] input, form[name=reservationForm] select").not("input[type=radio]");  
		  
		for(var i=0; i<elements.length; i++){
			elementsName[i] = elements[i];
			elementsNameText[i] = elements[i].getAttribute("data-name");
		}	
	}); 
		
	
	$(function(){
		//이용권을 구매하지 않았다면 구매페이지로
		var state = "${state}";
		if(state=="noTicket"){
			alert("편의시설은 이용권 구매 후 이용하실 수 있습니다."); 
			location.href="<%=cp%>/reservation/ticket";
		} 
		
		//예약 내역이 있는지 검색해서 있다면 다시 편의시설 선택 페이지로(예약은 구분(편의시설)별로 한사람당 한번만)
		var useDate = $("input[name=useDate]").val();
		searchReseation(useDate);  
		
	});
	
	//테마 선택하면 대여소의 자산검색
	$(function(){
		$("#theme").change(function(){ 
			var themeCode = $(this).val(); //테마 코드
			var gubunCode = $("#gubunCode").val(); //구분코드
			var useDate = $("input[name=useDate]").val(); //선택날짜 
			 
			var url = "<%=cp%>/amenities/assetsSerach";
			var query = "themeCode="+themeCode+"&gubunCode="+gubunCode+"&useDate="+useDate; 
			
			$.ajax({
				type:"get",
				url:url,
				data:query,
				dataType:"json",
				success:function(data){ 
					$("#rental").text("");
					$("#assetsCode").val("");
					  
					if(data.searchFacility!=null){ 
						$("#rental").removeClass("warning").text(data.searchFacility.NAME);  
						$("#assetsCode").val(data.searchFacility.ASSETSCODE);     
					}else if($("#theme").val()==0){    
						$("#rental").addClass("warning").text("테마를 선택하세요.");  
					} else{
						$("#rental").addClass("warning").text("예약 가능한 대여소가 없습니다.");
						//$("#theme").val(0).trigger("change");    
					}       
				},
				error:function(e){
					console.log(e.responseText);
				}
			});  
		});
	});
	
	//이용권리스트중 선택
	$(function(){
		$("body").on("change", "select[name=ticketsCode]", function(){
			var ticketCode = $(this).val();
			var ticketGubun = $(this).children("option:selected").attr("data-gubun");
			     
			$("#ticketCode").val(ticketCode); 
			
			//야간이용권이면 종일대여는 할 수 없다.
			if(ticketGubun==5||ticketGubun==6){
				$("#pm_time").prop("checked", true); 
				$("#all_time").prop("disabled", true);
			}else{   
				$("#all_time").prop("disabled", false);   
			}
		});
	});

	//연락처 숫자만
	$(function(){
		$("input.tel").keypress(function(){
			if(event.keyCode<48 || event.keyCode>57){
				try{ 
					event.preventDefault(); //발생된 이벤트를 취소
						
				}catch (e) {
					event.returnValue = false; //ie낮은 버전 이벤트 취소
				}  
			}
				
		});
	});
	
	//빈칸 체크 및 예약 전송
	function sendOk(){
		var f = document.reservationForm; 
		
		for(var i=0 ; i<elementsName.length ; i++){
			if(elementsName[i].value==0){
				elementsName[i].focus();
				alert(elementsNameText[i]+" 입력해주세요.");  
				return false;  
				
			}else if(!elementsName[i].value){
				elementsName[i].focus();
				alert(elementsNameText[i]+" 입력해주세요.");
				return false;
				
			} 
		} 
		
		f.action = "<%=cp%>/amenities/reservation";	  		
		f.submit();
	} 
	
	//이용권 검색(연간회원권일때만 선택할 수 있는 사용날짜 값이 넘어온다면 이용권 검색)
	<%-- <c:if test="${not empty selectDay}"> 
		$(function(){
			var usersCode = $("#usersCode").val(); //회원 번호 
			var endDate = $("#endDate").val(); //연간회원권 종료날짜  
			
			var useDate  = $("input[name=useDate]").val();//예약날짜
			searchReseation(useDate); //예약내역 있는지 검색     
			
			var url = "<%=cp%>/amenities/searchPayment";  
			var query = "useDate="+endDate+"&usersCode="+usersCode;      
			alert(query);
			 
			$.ajax({
				type:"get",
				url:url,
				data:query,
				dataType:"json",
				success:function(data){ 
					if(data.searchPayment2!=null){ 
						$("#ticket").text(data.searchPayment2.GOODSNAME);       
					}       
				},
				error:function(e){
					console.log(e.responseText);
				}
			});
		});
	</c:if> --%>
	
	
	//예약내역이 있는지 검색
	function searchReseation(useDate){
		var url = "<%=cp%>/amenities/searchReservation";
		var query = "useDate="+useDate+"&gubunCode=${gubunCode}"; 
		
		$.ajax({
			type:"post",
			url:url,
			data:query,
			dataType:"json",
			success:function(data){   
				if(data.state=="existence"){
					alert("이미 예약되어 있습니다.");
					location.href="<%=cp%>/amenities/list";  
				}
			},
			error:function(e){
				console.log(e.responseText);
			}
		}); 	
	}
	
</script> 


<div class="bodyFrame2">
	<div class="body-title">
		<h3>
			<span class="glyphicon glyphicon-calendar"></span> 편의시설
		</h3>
	</div>
	
	<div class="contents"> 
		<h3 class="contents_title">${title} 예약</h3>   
		<form name="reservationForm" method="post">
			<table class="table_01">
			    <colgroup>
			   		<col style="width:17%;"/>  
			    </colgroup>
			  	
				<tbody>
					<tr>
						<th>테마</th>
						<td>
							<select id="theme" name="themeCode" class="TFbox" data-name="테마를">
								<option value="0">선택</option>  
								<c:forEach var="list" items="${listTheme}">
									<option value="${list.THEMECODE}">${list.THEMENAME}</option>  
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>대여소</th>
						<td>
							<span id="rental" class="warning">테마를 선택하세요.</span>  
						</td>
					</tr>
					<tr>
						<th>예약 날짜</th>
						<td>
							<input type="text" name="useDate" value="${selectDay}" readonly="readonly" class="noStyle_tf"> 
						</td>
					</tr>
					<tr>
						<th>이용권</th>
						<td>
							<select name="ticketsCode" class="TFbox" data-name="이용권을">
								<option value="0">선택</option>  
								<c:forEach var="list" items="${ticketList}">
									<option value="${list.TICKETSCODE}" data-gubun="${list.TICKETGUBUN}">[${list.GOODSNAME}] ${list.GUBUNNAME}</option>
								</c:forEach>  
							</select>
						</td>
					</tr> 
					<tr>
						<th>시간</th> 
						<td> 
							<input type="radio" id="pm_time" name="bookTime" value="0" checked="checked"/> <span class="radioSpan">오후</span> 
							<input type="radio" id="all_time" name="bookTime" value="1"/> <span class="radioSpan">종일 </span> 
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							<input type="text" name="name" class="TFbox" data-name="이름을">
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>
							<select class="tel" name="tel1" data-name="연락처를">
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="017">017</option>
								<option value="016">016</option>
								<option value="019">019</option>
							</select> - <input type="text" name="tel2" class="tel" maxlength="4" data-name="연락처를"> - <input type="text" name="tel3" class="tel" maxlength="4" data-name="연락처를">
						</td>
					</tr> 
			  	</tbody>
			</table>
			
			<div class="btnBox">
				<input type="hidden" id="gubunCode" name="gubunCode" value="${gubunCode}">
				<input type="hidden" id="assetsCode" name="assetsCode" data-name="대여소를 ">
				<input type="hidden" id="ticketCode" name="ticketCode"> 
				<button type="button" class="btn btn-danger" style="font-weight:bold;" onclick="sendOk();">예약하기</button>
			</div>  
		</form>
	</div>
</div> 






