<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<style>
.custom_h2 {
    margin-bottom: 8px;
    font-size: 20px;
    font-weight: 700;
    color: #333;
}
</style>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-pencil"></span> 문의완료 </h3>
    </div>
    <div align="center">
	    <div>
    	<img width="100%" src="<%=cp%>/resource/images/questionResult.png">
    	</div>
		
		<table style="width: 100%; margin: 20px auto; border-spacing: 0px;">
		   	<tr height="40">
		      	<td align="center" width="100">
		          	<button type="button" class="btn btn-default" style="font-weight: bold;" onclick="javascript:location.href='<%=cp%>/question/question'">다른 문의하기</button>
		     	 	<button type="button" class="btn btn-info" style="font-weight: bold;" onclick="javascript:location.href='<%=cp%>/mypage/question'">내 문의내역 보기</button>
		     	 </td>
		   	</tr>
		</table>
	</div>
</div>   