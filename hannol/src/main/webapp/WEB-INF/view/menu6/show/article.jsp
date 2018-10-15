<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<style>
.articleBox:after {
	content:"";
	display: block;
	clear: both;
}
.infoBox {
	width: 30%; 
	height: 400px; 
	background-color: #efefef; 
	float: left;
	margin: 5px 5px;
}

.infoBox > img {
	margin: 40px;
}

.boldH{
	font-weight: bold;
}
</style>

<div class="bodyFrame2">
    <div class="body-title" align="center">
          <h3> ${dto.showName} </h3>
    </div>
    
    <div align="center" >
    	<h4>${dto.memo}</h4><br><br>
    	<c:if test="${empty dto.saveFilename}"><img src="<%=cp %>/resource/images/noimage.png"  style="padding: 5px; width:100%;" onerror="this.src='<%=cp%>/resource/images/noimage.png'"></c:if>
    	<c:if test="${not empty dto.saveFilename}"><img src="/hannolAdmin/uploads/show/${dto.saveFilename}"  style="padding: 5px; width:100%;" onerror="this.src='<%=cp%>/resource/images/noimage.png'"></c:if>
    </div>
    <br><br>
    <div class="articleBox"> 
    	<div align="center" > 
    	   	<div style="width: 3%; height: 400px; float: left; "></div>
	    	<div class="infoBox">
	    		<img alt="" src="<%=cp%>/resource/images/showCalendar.png"><br>
	    		<h4>공연기간</h4><br><br><br>
	    		<h4 class="boldH">${dto.startDate}</h4>~<br><h4 class="boldH">${dto.endDate}</h4>
	    	</div>
    		<div class="infoBox">
    			<img alt="" src="<%=cp%>/resource/images/showTime.png">
    			<h4>공연시간</h4><br><br><br><br>
    			<h4 class="boldH">
    				<c:forEach items="${dto.showTime}" var="vo" varStatus="status">
							${vo}&nbsp;${(status.last) ? "" : " | "} 
					</c:forEach>
					<c:if test="${empty dto.showTime}">금일 휴연</c:if>
    			</h4>	
    		</div>
    		<div class="infoBox">
    			<img alt="" src="<%=cp%>/resource/images/runningTime.png">
    			<h4>소요시간</h4><br><br><br><br>
    			<h4 class="boldH">${dto.runningTime}분</h4>  
    		</div>
    	</div>
    </div>
    <br><br>
        <div align="center" >
    	<h4 class="boldH">공연 장소</h4><br><br>
    	<small>${dto.name}</small><br><br>
    	<c:if test="${empty dto.saveFilename}"><img src="<%=cp%>/resource/images/noimage.png"  style="padding: 5px; width:100%;" onerror="this.src='<%=cp%>/resource/images/noimage.png'"></c:if>
    	<c:if test="${not empty dto.saveLocFilename}"><img src="/hannolAdmin/uploads/facility/${dto.saveLocFilename}"  style="padding: 5px; width:100%;" onerror="this.src='<%=cp%>/resource/images/noimage.png'"></c:if>
    </div>
    <br><br><br>
    
    <div align="center" >
	    <button type="button" class="btn" onclick="javascript:window.history.back(-1);">뒤로가기</button>
    </div>
</div>