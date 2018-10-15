<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<div style="float:left; margin: 0px 15px; clear: both;">${dataCount}개 (${page}/${total_page})</div>

<div style="clear: both;">
	<c:forEach items="${list}" var="dto">
		<div style="width: 100%;">
			<div class="col-lg-4">
				<div class="thumbnail">
					<c:if test="${not empty dto.saveMainFilename}">
						<img src="/hannolAdmin/uploads/facility/${dto.saveMainFilename}" onerror="this.src='<%=cp%>/resource/images/noimage.png'" style="height:250px;">
					</c:if>
					<c:if test="${empty dto.saveMainFilename}">
						<img src="<%=cp%>/resource/images/noimage.png" style="height:250px; width: 300px;">
					</c:if>
					 <span class="itemTitle">${dto.name}</span>
					
					<c:if test="${dto.waiting!=-1}">			
						<div class="ridesState"><fmt:formatNumber value="" type="number"/>상태 : 
							<c:choose>
								<c:when test="${dto.waiting < 9}">
									여유
								</c:when>
								<c:when test="${dto.waiting < 29}">
									보통
								</c:when>
								<c:when test="${dto.waiting < 69}">
									조금많음
								</c:when>
								<c:when test="${dto.waiting < 99}">
									많음
								</c:when>
								<c:otherwise>
									혼잡
								</c:otherwise>
							</c:choose>
						</div>
					</c:if>
					<c:if test="${dto.waiting==-1}">
						<div>
							혼잡
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</c:forEach>
</div>
<div class="div-paging" style="width: 100%; text-align: center; margin: 0px auto; clear: both;">${paging}</div>


