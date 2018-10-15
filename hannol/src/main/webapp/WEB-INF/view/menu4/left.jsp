<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
$(function(){
	var idx="${subMenu}";
	if(!idx) idx=1;
	var subMenu=$(".list-group-item")[idx];
	$(subMenu).addClass("active");
});
</script>

<div class="list-group">
       <div class="list-group-item lefthead"><i></i>오늘의 파크</div>
       <a href="#" class="list-group-item">놀이기구</a>
       <a href="<%=cp%>/todayPark/recommand" class="list-group-item">추천코스</a>
       <a href="<%=cp%>/todayPark/show" class="list-group-item">오늘의 공연</a>
</div>
