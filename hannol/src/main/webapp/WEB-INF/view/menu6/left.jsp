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
       <div class="list-group-item lefthead"><i></i> 즐길거리</div>
       <a href="<%=cp%>/enjoy/rides" class="list-group-item">놀이기구</a>
       <a href="<%=cp%>/enjoy/giftshop" class="list-group-item">기프트샵</a>
       <a href="<%=cp%>/show/list" class="list-group-item">공연</a>
       <a href="<%=cp%>/show/experience" class="list-group-item">체험</a>
       <a href="<%=cp%>/show/parade" class="list-group-item">퍼레이드</a>
</div>
