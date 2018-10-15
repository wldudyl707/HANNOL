<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>
.priceList{
	width: 50%;
	border: 1px solid #e1e1e1;
	float: left;
}

.titArea{
	padding: 20px;
	background: #f8f8f8;
	font-size: 24px;
	color: #550adf;
	font-weight: bold;
	text-align: center;
}

.txtArea{
	padding: 20px;
	height: 120px;
	background: #fff;
}

.priceUi{
	background: #fff;
	list-style: none;
}

.priceUi p{
	font-size: 18px;
	float: left;
	padding-right: 10px;
	background: #fff;
	width: 35%;
}

.priceUi p:last-child{
	float: right;
	padding-right: 0px;
	font-weight: bold;
}

.txtArea{
	font-size: 18px;
}

.note{
	border: 1px solid #e1e1e1;
    background: #f8f8f8;
    padding: 20px;
    margin-top: 30px;
}
</style>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-credit-card"></span>이용요금</h3>
    </div>	
    
    <div>
	    <div class="priceList">
    		<div class="titArea">종일권(1일)</div>
    		<c:if test="${not empty oneDay}">
	    		<div class="txtArea">
	    			<ul class="priceUi">
	    				<c:forEach var="item" items="${oneDay}">
							<li>
								<p>${item.goodsName}</p>
								<p><fmt:formatNumber value="${item.goodsPrice}" type="number"/>원</p>
							</li>
			   			</c:forEach>
	    			</ul>
	    		</div>
    		</c:if>
    		
    		<c:if test="${empty oneDay}">
    			<div class="txtArea" style="text-align: center;">
    				현재 이용권이 없습니다
    			</div>
    		</c:if>
    	</div>
	     
	     <div class="priceList">
    		<div class="titArea">야간권(15:00~)</div>
    		<c:if test="${not empty after}">
	    		<div class="txtArea">
	    			<ul class="priceUi">
	    				<c:forEach var="item" items="${after}">
							<li>
								<p>${item.goodsName}</p>
								<p><fmt:formatNumber value="${item.goodsPrice}" type="number"/>원</p>
							</li>
			   			</c:forEach>
	    			</ul>
	    		</div>
    		</c:if>
    		
    		<c:if test="${empty after}">
    			<div class="txtArea" style="text-align: center;">
    				현재 이용권이 없습니다
    			</div>
   			</c:if>
    	</div>
    </div>
    
    <div style="margin-top: 20px;">
	    <div class="priceList" style="margin-top: 30px;">
    		<div class="titArea">BIG5</div>
    		<c:if test="${not empty big}">
	    		<div class="txtArea">
	    			<ul class="priceUi">
	    				<c:forEach var="item" items="${big}">
							<li>
								<p>${item.goodsName}</p>
								<p><fmt:formatNumber value="${item.goodsPrice}" type="number"/>원</p>
							</li>
			   			</c:forEach>
	    			</ul>
	    		</div>
    		</c:if>
    		
    		<c:if test="${empty big}">
    			<div class="txtArea" style="text-align: center;">
    				현재 이용권이 없습니다
    			</div>
    		</c:if>
    	</div>
	    
	     <div class="priceList" style="margin-top: 30px;">
	   		<div class="titArea">연간이용권</div>
	   		<c:if test="${not empty years}">
	    		<div class="txtArea">
	    			<ul class="priceUi">
	    				<c:forEach var="item" items="${years}">
							<li>
								<p>${item.goodsName}</p>
								<p><fmt:formatNumber value="${item.goodsPrice}" type="number"/>원</p>
							</li>
			   			</c:forEach>
	    			</ul>
	    		</div>
	   		</c:if>
	   		
	   		<c:if test="${empty years}">
    			<div class="txtArea" style="text-align: center;">
    				현재 이용권이 없습니다
    			</div>
    		</c:if>
	   	</div>
    </div>
    
    
    <div>
    	<div class="priceList" style="margin-top: 30px; width: 100%;">
    		<div class="titArea">매직패스</div>
    		<div class="txtArea" style="text-align: center; padding-top: 50px;">
   				<ul class="priceUi">
					<li>
						<p>매직패스</p>
						<p>30,000원</p>
					</li>
    			</ul>
   			</div>
    	</div>
    </div>
    
    <div style="clear: both; content: ''"></div>
    <div class="note">
    	<p style="font-size: 20px; font-weight: bold;">꼭 알아두세요</p>
    	<p style="margin-top: 30px; font-size: 16px; font-weight: bold;">＊ 연령에 따른 우대</p>
    	<p style="margin-top: 10px; font-size: 16px;">-36개월 미만 : 무료이용</p>
    	<p style="margin-top: 10px; font-size: 16px;">-소인 : 36개월 ~ 만 12세</p>
    	<p style="margin-top: 10px; font-size: 16px; font-weight: bold;">＊ 우대</p>
    	<p style="margin-top: 10px; font-size: 16px;">장애인우대(장애인등록증 제시)</p>
    	<p style="margin-top: 10px; font-size: 16px;">국가유공자우대(증명서류 제시)</p>
    	<p style="margin-top: 10px; font-size: 16px; font-weight: bold;">＊ 연간회원권은 매직패스가 포함된 가격입니다</p>
    </div>
</div>