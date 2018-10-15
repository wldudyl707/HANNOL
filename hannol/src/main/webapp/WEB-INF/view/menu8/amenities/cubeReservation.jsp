<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>

</style> 
 
<script type="text/javascript">
	
	
</script> 


<div class="bodyFrame2">
	<div class="body-title">
		<h3>
			<span class="glyphicon glyphicon-calendar"></span> 보관함
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
							<c:if test="${not empty selectDay}">  
								<input type="text" name="useDate" class="noStyle_tf" value="${selectDay}" readonly="readonly"> 
								<input type="hidden" id="endDate" value="${searchPayList.get(0).get('ENDDATE')}">
							</c:if>  
							<c:if test="${empty selectDay}">    
								<select id="useDate" name="useDate" class="TFbox" data-name="예약날짜를">
									<option value="">선택</option> 
									<c:forEach var="vo" items="${searchPayList}">
										<option value="${vo.ENDDATE}">${vo.ENDDATE}</option>  	
									</c:forEach>    
								</select>
							</c:if>
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
						<th>입장권</th>
						<td><span id="ticket"></span></td>
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
				<input type="hidden" id="usersCode" name="usersCode" value="${usersCode}"> 
				<input type="hidden" id="gubunCode" name="gubunCode" value="${gubunCode}">
				<input type="hidden" id="assetsCode" name="assetsCode">
				<button type="button" class="btn btn-danger" style="font-weight:bold;" onclick="sendOk();">예약하기</button>
			</div>  
		</form>
	</div>
</div> 






