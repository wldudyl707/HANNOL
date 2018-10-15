<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>
.body-content img{
	width: 100%;
}
</style>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-tower"></span> 추천코스 </h3>
    </div>
    
    <div class="body-content">
    	<img alt="갑자기 비가 온다면 이코스로~" src="<%=cp%>/resource/images/recommend_hn01.jpg">
    	<img alt="우리 아이가 꺄르르 행복한 코스" src="<%=cp%>/resource/images/recommend_hn02.jpg">
    	<img alt="스릴 매니아를 위한 핵심 어트랙션" src="<%=cp%>/resource/images/recommend_hn03.jpg">
    	<img alt="부모님과 함께 효도 나들이" src="<%=cp%>/resource/images/recommend_hn04.jpg">
    </div>
</div>