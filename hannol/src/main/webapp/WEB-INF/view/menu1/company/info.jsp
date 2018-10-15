<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>
.note{
	border: 1px solid #e1e1e1;
    background: #f8f8f8;
    padding: 20px;
    margin-top: 30px;
}
</style>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-tower"></span> 인사말 </h3>
    </div>
    
    <div>
        <img alt="HANNOL" src="<%=cp%>/resource/images/main_map.jpg" style="width: 100%;">
        <div class="note">
        	<p style="font-size: 16px;">HANNOL(한놀)에서는 노는것, 먹는것, 쇼핑하는 것은 물론 서로 즐겁게 이야기하고 웃는 것 모두가 엔터테인먼트입니다.</p>
        	<p style="margin-top: 10px; font-size: 16px;">수많은 다양한 쇼핑 시설, 각각의 개성적 테마를 가진 시설이 모여 서로의 가치를 높이며 도시에 근접한 새로운 형태의 제재형 테마 리조트로서 항상 성장해 나가고 있습니다.</p>
        </div>
    </div>
</div>