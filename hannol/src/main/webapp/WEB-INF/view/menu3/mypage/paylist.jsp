<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
	int rank = 0;
%>

<style>
.gitf-form-control{
	background: url(<%=cp%>/resource/images/item_list.png) no-repeat right 2px;
}

.col-xs-8:after{
	content:''; display:block; clear:both;
}

.col-xs-offset-2{
	width: 40%;
}

.col-xs-8{
 	float: none;
 	margin: 10px auto;
}

.note{
	border: 1px solid #e1e1e1;
    background: #f8f8f8;
    padding: 20px;
    margin-top: 30px;
}

th {
    width: 30%;
    border: solid #e4e4e4; 
    border-width: 0 1px 1px 0;
    background: #f8f8f8;
    padding: 7px 15px 7px 15px;
    font-weight: bold;
    text-align: center;    
}

td {
    width: 30%;
    border: solid #e4e4e4; 
    border-width: 0 1px 1px 0;
    padding: 7px 15px 7px 15px;
    text-align: center;    
}

.modal_th {
    width: 40%;
    border: solid #e4e4e4;
    border-width: 0 1px 1px 0;
    padding: 7px 10px 7px 15px;
    font-weight: bold;
    text-align: left;
    background: #f4f4f4;
}

.modal_td {
	width: 60%;
    border-bottom: 1px solid #e4e4e4;
    padding: 10px 16px;
}

.custom_table {
    width: 100%;
    border-top: 2px solid #cecece;
}

.custom_col1 {
    width: 50%;
    border: solid #e4e4e4;
    border-width: 0 1px 1px 0;
    padding: 7px 10px 7px 15px;
    font-weight: bold;
    text-align: left;
}

.customer_col2 {
	width: 50%;
    border-bottom: 1px solid #e4e4e4;
    padding: 10px 16px;
}

.custom_h2 {
    padding-left: 2px;
    margin-bottom: 8px;
    font-weight: 700;
    color: #333;
    text-align: left;
}
</style>

<script type="text/javascript">
$(function(){
	$("#yearSelect").change(function(){
		var year = $("#yearSelect option:selected").val();
		location.href="<%=cp%>/mypage/paylist?year="+year;
	});
	$("#yearSelect > option[value='${year}']").attr("selected","selected");
});

function refundCheck(payCode){
    $("#refundModal"+payCode).modal();
}

function refund(){
	var f = document.submitForm;
	f.action="<%=cp%>/mypage/refundPay";
    f.submit();
}
</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-list-alt"></span> 구매내역 </h3>
    </div>
    
    <div>
    	<div align="right">
    		<select id="yearSelect" style="height: 30px; width: 80px;">
    			<option value="${curDate}">${curDate}</option>
    			<option value="${curDate-1}">${curDate-1}</option>
    			<option value="${curDate-2}">${curDate-2}</option>
    		</select>
    	</div>
    	
    	
    	
    	<c:set var="parentCode" value="1"/>
		<c:set var="gubun" value="이용권"/>
		<c:set var="payDate" value="${lastPayDate}"/>
		
		<c:forEach var="dto" items="${list}" varStatus="status" >
      		<c:if test="${status.first || parentCode!=dto.parentCode || payDate!=dto.payDate}">
      			<c:set var="parentCode" value="${dto.parentCode}"/>
      				<c:if test="${dto.parentCode==1}">
	           			<c:set var="gubun" value="이용권"/>
	      			</c:if>
          			<c:if test="${dto.parentCode==2}">
	            		<c:set var="gubun" value="기프트콘"/>
	      			</c:if>
	      			<c:set var="payDate" value="${dto.payDate}"/>
	      			
	      			
	      			<c:if test="${! status.first}">
			     		</table>
			     		</div>
			     		</div>
		  			</c:if>
		  			
		  			
		  			<div style="border: 1px solid #e1e1e1; margin-top: 15px;">
		  			
		  			<form role="form" name="submitForm" method="post"> 
		  			
		  			<div style="background-color: #e1e1e1;">
    					<div style="padding: 10px;">
    						<h5 style="display: inline;">구매일</h5>
    						<h5 style="font-weight: bold; display: inline; margin-left: 10px;">${dto.payDate}</h5>
    					</div>
    				</div>
		  				
		  			<div style="margin: 15px;">
		  				<table style="border: 1px solid #e1e1e1;">
		  					<tr>
		             			<th rowspan="${dto.rowspan}" style="width: 15%">${gubun}</th>
		             			<th>상품명</th>
		             			<th>가격 / 수량</th>
		             			<th rowspan="${dto.rowspan}" style="width: 15%">
		             				<p><fmt:formatNumber value="${dto.payPrice}" type="number" pattern="#,###원"/></p>
		             				<c:forEach var="vo" items="${uselist}">	
		             				<c:if test="${dto.payCode == vo.PAYCODE && dto.state eq '결제취소'}"><h5>결제취소</h5></c:if>
		             				<c:if test="${dto.state eq '승인완료'}">
		             				<c:if test="${(dto.payCode == vo.PAYCODE || empty uselist) && dto.gubunCode != 8}">
		             					<button type="button" class="btn btn-danger" onclick="refundCheck(${dto.payCode});">구매취소</button>
		             					
		             					<!-- 모달창시작 -->
		             					<div style="display: none;" id="refundModal${dto.payCode}" role="dialog" class="modal" tabindex="-1">
											<div class="modal-dialog">
												<div class="modal-content">
											    	<div class="modal-header">
									 					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									  					<span aria-hidden="true">×</span></button>
									 					<div align="center">
									 						<h4 class="modal-title" id="myModalLabel">구매취소</h4>
									 					</div>
													</div>
													<div class="modal-body">
														<h5 class="custom_h2">결제일자 : ${dto.payDate}</h5>			
														<table class="custom_table" style="border-bottom: 2px solid #cecece; margin-bottom: 15px;">
											  				<tbody>
											  				<c:forEach var="vo" items="${list}" varStatus="status" >
											  				<c:if test="${dto.payCode == vo.payCode}">
																<tr>
																	<td class="custom_col1">
																		${vo.gubunName} - ${vo.goodsName}
																	</td>
																	<td class="customer_col2">
																		<fmt:formatNumber value="${vo.price}" type="number" pattern="#,###원"/> / ${vo.quantity}개
																	</td>
																</tr>
															</c:if>
															</c:forEach>
											  				</tbody>
														</table>
														
														<h5 class="custom_h2">환불정보</h5>
														<table class="custom_table" style="border-bottom: 2px solid #cecece; margin-top: 10px;">
											  				<tbody>
																<tr>
																	<th class="modal_th">환불금액</th>
																	<td id="payPrice" class="modal_td"><fmt:formatNumber value="${dto.payPrice}" type="number" pattern="#,###원"/></td>
																</tr>
																<tr>
																	<th class="modal_th">환불쿠폰</th>
																	<td id="coupon" class="modal_td">${dto.couponCount}개</td>
																</tr>
																<tr>
																	<th class="modal_th">결제카드</th>
																	<td id="cardType" class="modal_td">${dto.cardCo}</td>
																</tr>
																<tr>
																	<th class="modal_th">할부기간</th>
																	<td id="paySectionType" class="modal_td">${dto.paySection}</td>
																</tr>
											  				</tbody>
														</table>
														
														<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
											   				<tr height="40">
											      				<td align="center" width="100">
											      					<input type="hidden" name="payCode" value="${dto.payCode}">
											          				<button type="button" class="btn btn-danger" style="font-weight: bold;" onclick="refund();">환불하기</button>
											     	 				<button type="button" class="btn btn-default" data-dismiss="modal" style="font-weight: bold;">취소하기</button>
											     	 			</td>
											   				</tr>
														</table>
													</div>
												</div>
											</div>
										</div>
		             					<!-- 모달창끝 -->
		             					
		             				</c:if>
		             				</c:if>
		             				</c:forEach>
		             			</th>
		      				</tr>
      		</c:if>
      		<tr>
      			<td>${dto.gubunName} - ${dto.goodsName}</td>
      			<td><fmt:formatNumber value="${dto.price}" type="number" pattern="#,###원"/> / ${dto.quantity}개</td>
      		</tr>
      	</c:forEach>
      	
      	<c:if test="${list.size()>0}">
		     </table>
		     </div>
		     </form>
		     </div>
		 </c:if>	
    	
    	
		<div style="width: 100%; margin-top: 10px; border-spacing: 0px;">
		   <div>
			 <div align="center">
			        <c:if test="${dataCount==0}">최근 구매내역이 없습니다.</c:if>
			        <c:if test="${dataCount!=0}">${paging}</c:if>
			 </div>
			</div>
		</div>
		
		<div class="note">
    		<p style="font-size: 16px; font-weight: bold;">꼭 알아두세요</p>
    		<p style="margin-top: 10px; font-size: 12px;">이용권 구매 취소 시 관련된 모든 예약이 취소됩니다.</p>
    	</div>

    </div>
</div> 