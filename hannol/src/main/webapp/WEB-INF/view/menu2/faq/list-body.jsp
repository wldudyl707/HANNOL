<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<c:if test="${dataCount!=0}">
	<ul class="qnaList">
		<c:forEach items="${list}" var="dto">
			<li>
				<a href="javascript:void(0);" onclick="showAnswer(this)">
					<p class="tit">
						<span class="type1">${dto.gubunName}</span>
						<span style="word-wrap: break-word;white-space: pre-wrap;">${dto.subject}</span>
					</p>
				</a>
				<div class="answerDiv">
					<p>${dto.content}</p>
				</div>
			</li>
		</c:forEach>
	</ul>
	<div class="div-paging" style="width: 100%; text-align: center; margin: 0px auto; clear: both;">${paging}</div>
</c:if>
<c:if test="${dataCount==0}">
	<div style="text-align: center; margin-top: 30px; border: 1px solid #e1e1e1; padding: 30px; border-top:2px solid #000">데이터가 없습니다.</div>
</c:if>









