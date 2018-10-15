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
          <h3><span class="glyphicon glyphicon-tower"></span> 가이드맵</h3>
    </div>
    
    <div>
    	<div style="position: relative;">
	    	<img alt="가이드맵" src="<%=cp%>/resource/images/guide_map.png" style="width: 100%;">
	    	<a href="<%=cp%>/resource/files/guide_map.pdf" style="position: absolute; top: 30%; left: 5%;"><button class="btn btn-info">PDF 다운로드</button></a>    	
    	</div>
    </div>
</div>