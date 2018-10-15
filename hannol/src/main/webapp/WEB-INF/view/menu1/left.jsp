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
       <div class="list-group-item lefthead"><i></i> 회사소개</div>
       <a href="<%=cp%>/company/info" class="list-group-item">인사말</a>
       <a href="<%=cp%>/company/way" class="list-group-item">오시는길</a>
       <a href="<%=cp%>/company/guideMap" class="list-group-item">가이드맵</a>
       <a href="<%=cp%>/ticket/list" class="list-group-item">이용요금</a>
       <a href="<%=cp%>/card/list" class="list-group-item">제휴카드</a>
</div>
