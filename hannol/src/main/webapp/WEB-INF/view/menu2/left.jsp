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
       <div class="list-group-item lefthead"><i></i>소통</div>
       <a href="<%=cp%>/notice/list" class="list-group-item">공지</a>
       <a href="<%=cp%>/event/list" class="list-group-item">이벤트</a>
       <a href="<%=cp%>/faq/list" class="list-group-item">FAQ</a>
       <a href="<%=cp%>/question/question" class="list-group-item">1:1문의</a>
       <a href="<%=cp%>/review/list" class="list-group-item">이용후기</a>
</div>
