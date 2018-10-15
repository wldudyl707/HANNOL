<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<div>
	<form name="bookForm" id="bookForm">
	
		<table class="table">
			    <colgroup>
			        <col style="width: 2%; text-align:center">
			        <col style="width: 5%; text-align:center">
			        <col style="width: 10%; text-align:center">
			        <col style="width: 10%; text-align:center">
			        <col style="width: 15%; text-align:center">
			        <col style="text-align:center">
			        <col style="width: 5%; text-align:center">
			        <col style="width: 10%; text-align:center">
			        <col style="width: 10%; text-align:center">
			    </colgroup>
    
		  <thead class="thead-light">
		    <tr>
		      <th scope="col"><input type="checkbox" name="chkAll" id="chkAll" value="chkAll" onclick="checkAll();"></th>
		      <th scope="col">번호</th>
		      <th scope="col">예약코드</th>
		      <th scope="col">예약이름</th>
		      <th scope="col">연락처</th>
		      <th scope="col">예약내용</th>
		      <th scope="col">구분</th>
		      <th scope="col">이용예정일</th>
		      <th scope="col">예약한일자</th>
		    </tr>
		  </thead>
		  <tbody>
		  
			  	<c:forEach var="dto" items="${list}">
				    <tr>
				      <th><input type="checkbox" name="chk" value="chk" onclick="chkSingle();"></th>
				      <th scope="row">${dto.listNum}</th>
				      <td>${dto.bookCode}</td>
				      <td>${dto.name}</td>
				      <td>${dto.tel}</td>
				      <td>${dto.role}</td>
				      <td>${dto.timezone==1?"오전":"오후"}</td>
				      <td>${dto.workDate}</td>
				      <td>${dto.bookDate}</td>
				    </tr>
			    </c:forEach>
			    
		  </tbody>
		</table>
		
		
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
		   <tr height="35">
				<td align="left" width="100">
						<button type="button" class="btn btn-default" onclick="javascript:location.href='<%=cp%>/mypage/myBook';">새로고침</button>
				</td>
				<td align="center">
				        <c:if test="${dataCount==0 }">등록된 게시물이 없습니다.</c:if>
				   		<c:if test="${dataCount!=0 }">${paging}</c:if>
				</td>
				<td align="right" width="100">
						<button type="button" id="btnDelete" name="btnDelete" class="btn btn-default">예약삭제</button>
				</td>
		   </tr>
		</table>
	</form>
</div>