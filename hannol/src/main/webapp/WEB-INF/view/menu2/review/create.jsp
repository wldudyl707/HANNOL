<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<style>
	.table td{text-align:center;}
	.table td{text-overflow:ellipsis; overflow:hidden; white-space:nowrap;}

	.datepickerBox{display:inline-block;}
	.datepickerBox .datepicker{width:203px;} 
	
	.datepicker + img{width:22px; margin:0px 0px 0px -31px; padding-left:8px; border-left:1px solid #dddddd; cursor:pointer;}
	  
</style>

<script>
$(function() {
	$("input[name=reviewDate]").datepicker({
		dateFormat:'yy-mm-dd',
		showOn:"both",
	    buttonImage:"<%=cp%>/resource/images/date24.png",
	    buttonImageOnly:true,
	    showAnim:"slideDown",
	    buttonText:"선택",
	    maxDate:0,
	});	
});
</script>

<div style="margin: 10px 0px;" class="reviewLayout">
	<form name="reviewCreateForm" id="reviewCreateForm" method="post">
		<table style='width: 80%; margin: 15px auto 0px; border-spacing: 0px;'>
			<tr>
				<th width="15%">방문날짜</th>
				<td>
					<span class="datepickerBox"><input type="text" name="reviewDate" class="boxTF datepicker" readonly="readonly" value="${dto.reviewDate}"></span> 
				</td>
			</tr>
			<tr>
				<th>후 기</th>
				<td>
					<textarea class='boxTA'	style='width: 99%; height: 70px;' name="content" placeholder="10자이상 입력하세요">${dto.content}</textarea>
				</td>
			</tr>
		</table>
		
		<c:if test="${mode == 'update'}">
			<input type="hidden" name="reviewCode" value="${dto.reviewCode}">
		</c:if>
		
		<div align="center">
			<button type='button' class='btn' style='padding: 10px 20px;' onclick="createReview('${mode}')">
				${mode == 'update' ? '수정' : '등록'}</button>
		</div>
	</form>
</div>  