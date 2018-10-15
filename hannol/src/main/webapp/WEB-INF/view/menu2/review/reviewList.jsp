<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>
.redHeart{
	background: url("<%=cp%>/resource/images/like_heart_icon.png") 0px 0px no-repeat;	
	width: 30px;
	height: 30px;
	background-size: 100% auto;
}
.grayHeart{
	background: url("<%=cp%>/resource/images/gray_heart_icon.png") 0px 0px no-repeat;	
	width: 30px;
	height: 30px;
	background-size: 100% auto;
}
</style>

<c:forEach items="${list}" var="dto">
    <div style="height: 70px;">
		<div style="width: 80%; float: left;" align="left" >
			<div>${dto.content}</div> 
			<div style="padding-top: 10px;">${dto.memberIdWithStar}&nbsp;&nbsp;|&nbsp;&nbsp;${dto.reviewDate} 방문</div>		
		</div>
    	<div style="width: 20%; float: left; background: " align="center" data-reviewCode="${dto.reviewCode}">
    		<div id="likeCount${dto.reviewCode}" class="${dto.myLike == 0 ? 'grayHeart':'redHeart'} heart"></div>

		    <input type="text" name="likeCount${dto.reviewCode}" style="text-align:center; background-color:transparent; border: none; " disabled="disabled" value="${dto.likecount}">		
    		
    		<div align="center">
    			<c:if test="${dto.memberId == sessionScope.member.memberId}">
		    		<button type='button' class='btn' style='padding: 10px 20px;' onclick="updateReview('${dto.reviewCode}')">수정</button>
		    		<button type='button' class='btn' style='padding: 10px 20px;' onclick="deleteReview('${dto.reviewCode}')">삭제</button>
    			</c:if>
    		</div>
		</div>
		<hr size="3">
    </div>
</c:forEach>    

<div align="center" style="clear: both;">
	${paging}
</div>