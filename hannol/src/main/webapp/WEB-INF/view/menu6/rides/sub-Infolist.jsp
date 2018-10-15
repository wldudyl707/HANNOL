<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

	<form name="ridesInfoForm" method="post" id="ridesInfoForm">
		<table class="modalTable">
			<tr>
				<th scope="row">테마명</th>
				<td>${vo.themeName}</td>
			</tr>
			<tr>
				<th scope="row">놀이기구명</th>
				<td>${vo.name}</td>
			</tr>
			<tr>
				<th scope="row">탑승인원</th>
				<td>
					<c:choose>
						<c:when test="${vo.passengers==0}">
							정보없음
						</c:when>
						<c:otherwise>
							${vo.passengers} 명	
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th scope="row">최소키</th>
				<td>
					<c:choose>
						<c:when test="${vo.minHeight==0}">
							정보없음
						</c:when>
						<c:otherwise>
							${vo.minHeight} cm	
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th scope="row">최대키</th>
				<td>
					<c:choose>
						<c:when test="${vo.maxHeight==0}">
							정보없음
						</c:when>
						<c:otherwise>
							${vo.maxHeight} cm	
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th scope="row">제한조건</th>
				<td>${vo.limit}</td>
			</tr>

			<tr>
				<th scope="row">위치사진</th>
				<td>
				<c:if test="${not empty vo.saveLocFilename}">
					<img src="/hannolAdmin/uploads/facility/${vo.saveLocFilename}" onerror="this.src='<%=cp%>/resource/images/noimage.png'" style="height:250px;">
				</c:if>
				<c:if test="${empty vo.saveLocFilename}">
					<img src="<%=cp%>/resource/images/noimage.png">
				</c:if>
				</td>
			</tr>
			
		</table>
	</form>