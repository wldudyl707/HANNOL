<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<table class="table">
	<colgroup>
		<col style="width: 10%; text-align: center">
		<col style="text-align: center">
		<col style="width: 10%; text-align: center">
		<col style="width: 10%; text-align: center">
		<col style="width: 10%; text-align: center">
	</colgroup>

	<thead class="thead-light">
		<tr>
			<th scope="col">쿠폰번호</th>
			<th scope="col">쿠폰명</th>
			<th scope="col">발급일</th>
			<th scope="col">만료일</th>
			<th scope="col">사용여부</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list}" var="dto">
			<tr>
				<td>${dto.couponCode}</td>
				<td>${dto.couponName}</td>
				<td>${dto.startDate }</td>
				<td>${dto.endDate}</td>
				<c:if test="${dto.state==0}">
					<td>미사용</td>
				</c:if>
				<c:if test="${dto.state==1}">
					<td>사용완료</td>
				</c:if>
				<c:if test="${dto.state==2}">
					<td>기간만료</td>
				</c:if>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div class="div-paging" style="width: 100%; text-align: center; margin: 0px auto; clear: both;">${paging}</div>


