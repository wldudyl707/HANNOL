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
       <div class="list-group-item lefthead"><i></i>예매/예약</div>
       <a href="<%=cp %>/reservation/ticket" class="list-group-item">예매</a>
       <a href="<%=cp %>/guide/list" class="list-group-item">가이드</a>
       <a href="<%=cp%>/reservation/show" class="list-group-item">공연</a>
       <a href="<%=cp%>/amenities/list" class="list-group-item">편의시설</a> 
</div>
