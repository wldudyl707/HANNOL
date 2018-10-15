<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script>
function myReservation() {
	location.href="<%=cp%>/mypage/myBook?tab=stage";
}

</script>
  
<div class="bodyFrame2">
	<div class="body-title">
		<h3><span class="glyphicon glyphicon-th-list"></span>예약 완료</h3>
	</div>
	
	<div align="center">
		<div style="height: 300px; padding-top: 200px;"><h2>예약이 완료되었습니다.</h2></div>
		<div>
			<button class="btn btn-default btn-info" type="button" onclick="myReservation();">&nbsp;내 예약확인</button>
		</div> 
	</div>
</div>