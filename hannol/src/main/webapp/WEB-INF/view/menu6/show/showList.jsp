<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
  
<div id="showList">
	<table style="width: 100%; height: 15m; margin: 0px auto; border-spacing: 0px; border-collapse: collapse; border-top: 2px solid #005dab;">
		<c:forEach items="${list}" var="dto">
			<tr align="center" height="100em" style="border-bottom: 1px solid #cccccc;">
				<td rowspan="2" width="30%">
				    <c:if test="${empty dto.saveFilename}"><img src="<%=cp %>/resource/images/noimage.png"  style="padding: 5px;" onerror="this.src='<%=cp%>/resource/images/noimage.png'"></c:if>
			 		<c:if test="${not empty dto.saveFilename}"><img src="/hannolAdmin/uploads/show/${dto.saveFilename}" style="padding: 5px; width: 250px;" onerror="this.src='<%=cp%>/resource/images/noimage.png'"></c:if>
				</td>
				<td colspan="2" width="70%" height="30%" align="left" style="padding-left: 1em; padding-right: 1em;">
					<h3 style="font-weight: bold;">${dto.showName}</h3>
				</td>
			</tr>
			<tr style="border-bottom: 1px solid #cccccc;">
				<td width="70%" height="80%" align="left" style="padding-left: 1em; padding-right: 1em; ">
					<div style="margin-bottom: 15px;"><h4>${dto.memo}</h4></div>
					<span style="font-weight: bold;">공연시간</span>&nbsp;&nbsp;
						<c:forEach items="${dto.showTime}" var="vo" varStatus="status">
							${vo}&nbsp;${(status.last) ? "" : " | "}
						</c:forEach>
					<br> 
					<span style="font-weight: bold;">공연장소</span>&nbsp;&nbsp;${dto.name}<br><br>
					<c:if test="${gubunCode == '3' && dto.seatCount != 0}">
						<button class="btn btn-default btn-info" type="button" onclick="reservation('${dto.showInfoCode}')"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;좌석예약</button>
					</c:if>
				</td>
				<td width="15%" valign="bottom" style="padding: 10px;">
					<button type="button" class="btn" onclick="detailShow('${dto.showInfoCode}')">상세보기</button>
				</td>
			</tr>
		</c:forEach>	
	</table>
	<br><br>
</div>
