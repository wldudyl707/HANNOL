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
       <div class="list-group-item lefthead"><i></i>편의시설</div>
       <a href="<%=cp%>/facilities/info" class="list-group-item">안내소</a>
       <a href="<%=cp%>/facilities/baby" class="list-group-item">유모차대여소</a>
       <a href="<%=cp%>/facilities/bathchair" class="list-group-item">휠체어대여소</a>
       <a href="<%=cp%>/facilities/locker" class="list-group-item">보관함</a>
</div>
