<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<style>
.thumbnail{
	text-align: center;
}

.gift-thema{
	display: block;
	margin: 10px 0px;
	font-size: 12px;
}

.gift-title{
	font-size: 16px;
	font-weight: bold;
}
</style>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-tower"></span>${title}</h3>
    </div>
    
    <div>
        <c:forEach items="${list}" var="dto">
		<div style="width: 100%;">
			<div class="col-lg-4">
				<div class="thumbnail">
					<a href="${articleUrl}&facilityCode=${dto.facilityCode}">
					<img src="/hannolAdmin/uploads/facility/${dto.saveMainFilename}" onerror="this.src='<%=cp%>/resource/images/noimage.png'" style="height:250px;">
					<span class="gift-thema">${dto.themeName}</span>
					<span class="gift-title">${dto.name}</span>
					</a>
				</div>
			</div>
		</div>
	</c:forEach>
	
	<div class="div-paging" style="width: 100%; text-align: center; margin: 0px auto; clear: both;">${paging}</div>
    </div>
</div>