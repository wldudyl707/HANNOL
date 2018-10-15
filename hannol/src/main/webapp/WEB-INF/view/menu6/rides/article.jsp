<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

	<div id="ridesInfoModel" class="modal">
		<form name="ridesInfoForm" method="post" id="ridesInfoForm">
			<table class="modalTable">
				<tr>
					<th scope="row">시설명</th>
					<td>
						<select class="selectField" id="name1" name="name" >
							<option value="">상태</option>
							<c:forEach var="vo" items="${list}">
								<option value=${vo.facilityCode }>${vo.name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row">상태</th>
					<td>
						<select class="selectField" id="state" name="state" >
							<option value="">상태</option>
							<option value=1>수리요청</option>
							<option value=2>요청확인</option>
							<option value=3>수리중</option>
							<option value=4>수리완료</option>
						</select>
					</td>
				</tr>
			</table>
	
	
			<div class="btnBox">
		        <button type="button" class="btn btn-info" id="sendOk">시설등록</button>
		        <button type="reset" class="btn btn-default">다시입력</button> 
		        <button type="button" class="btn btn-default" id="ridesInfoAdd_close_btn">등록취소</button>
		    </div>
		</form>
	</div>   