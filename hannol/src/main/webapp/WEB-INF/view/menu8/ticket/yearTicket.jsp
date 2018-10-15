<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>
.buy_info{
	width: 100%;
}

.img_area{
	float: left;
	position: relative;
	width: 45%;
}

.img_area img{
	width: 100%;
}


.ticket_result{
	float:left; 
	margin-left: 30px;
	width: 45%;
}

.ticket_title{
	display : block;
	font-weight : bold;
	width: 100%;
	font-size: 14px;
}

.ticket_content{
	width: 100%;
	font-size: 14px;
}

.note{
	border: 1px solid #e1e1e1;
    background: #f8f8f8;
    padding: 20px;
    margin-top: 30px;
}
</style>

<script>
$(function(){
	$(".btn-pay").click(function(){
		$("#saleForm").submit();
	});
	
	$(".btn-back").click(function(){
		location.href="<%=cp%>/reservation/ticket";
	});
});
</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="	glyphicon glyphicon-calendar"></span>예매</h3>
    </div>
    
    <div class="buy_info">
    	<div class="img_area">
    		<img alt="한놀 HANNOL" src="<%=cp%>/resource/images/hannol_logo.jpg">
    	</div> 
    	
    	<div class="ticket_result">
    		<span class="ticket_title">구분</span>
    		<span class="ticket_content">${ticket.gubunName}</span>
    		<span class="ticket_title" style="margin-top: 15px;">이용권명</span>
    		<span class="ticket_content">${ticket.goodsName}</span>
    		<span class="ticket_title" style="margin-top: 15px;">가격</span>
    		<span class="ticket_content"><fmt:formatNumber value="${ticket.goodsPrice}" type="number" pattern="#,###원"/></span>
    		
    		<div style="text-align: center; margin-top: 15px;">
	   			<button type="button" class="btn btn-defualt btn-back" style="width: 49%;">취소</button>
	   			<button type="button" class="btn btn-danger btn-pay" style="width: 49%;">결제</button>
	   		</div>
    		
    		<form action="<%=cp%>/pay/list" method="post" id="saleForm">
    			<input type="hidden" name="goodsCode" value="${ticket.goodsCode}">
    			<input type="hidden" name="gubunCode" value="${ticket.gubunCode}">
    			<input type="hidden" name="goodsName" value="${ticket.goodsName}">
    			<input type="hidden" name="goodsPrice" value="${ticket.goodsPrice}">
    			<input type="hidden" name="gubunName" value="${ticket.gubunName}">
    			<input type="hidden" name="parentCode" value="${ticket.parentCode}">
    			<input type="hidden" name="startDate" value="${startDate}">
    			<input type="hidden" name="endDate" value="${endDate}">
    			<input type="hidden" name="quantity" value="1">
    		</form>
    	</div>
    </div>
    
    <div style="clear: both; content: ''"></div>
    <div class="note">
    	<p style="font-size: 20px; font-weight: bold;">꼭 알아두세요</p>
    	<p style="margin-top: 10px; font-size: 16px;">연간회원권은 매직패스가 포함된 가격입니다</p>
    </div>
</div>