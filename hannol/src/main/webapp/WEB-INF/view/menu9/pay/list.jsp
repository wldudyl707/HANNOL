<%@page import="java.util.Dictionary"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
	int n = 0;
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

.custom_h2 {
    padding-left: 2px;
    margin-bottom: 8px;
    font-size: 20px;
    font-weight: 700;
    color: #333;
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

.pay_price {
    border-top: 2px solid #cecece;
}

.col_title {
    vertical-align: top;
    text-align: right;
    padding-right: 10px;
    border-right: 1px solid #e4e4e4;
    border-bottom: 1px solid #e4e4e4;
    background: #f4f4f4;
}

.price {
    display: inline-block;
    padding-left: 17px;  
    padding-bottom: 10px;
    width: 100px;
}

.table_col{
	border-bottom: 1px solid #e4e4e4;
}

select {
    height: 23px;
    font-size: 12px;
    vertical-align: middle;
}

.pay-type-section {
    padding: 10px 0;
    margin: 0;
    line-height: 21px;
    border-bottom: 1px solid #e4e4e4;
}

.line-title {
    display: inline-block;
    width: 90px;
    font-size: 12px;
    font-weight: bold;
    margin: 0;
    vertical-align: middle;
    padding-left: 15px;
}

.pay-type-section .line-title:before {
    content: "";
    position: relative;
    display: inline-block;
    width: 3px;
    height: 3px;
    margin-left: 2px;
    margin-right: 4px;
    vertical-align: middle;
    background: #55575f;
}

.modal_th {
    width: 30%;
    border: solid #e4e4e4;
    border-width: 0 1px 1px 0;
    padding: 7px 10px 7px 15px;
    font-weight: bold;
    text-align: left;
    background: #f4f4f4;
}

.modal_td {
	width: 70%;
    border-bottom: 1px solid #e4e4e4;
    padding: 10px 16px;
}

.btn_delete{
  width: 21px;
  height: 21px;
  background: url('<%=cp%>/resource/images/delete.png') no-repeat -1px -1px;
  border: none;
  line-height : 21px;
  float: left;
}
</style>

<script type="text/javascript">
$(function(){
	$("#readTermsInfo").click(function(){
		$("#terms-info").slideUp();
		if(!$(this).next().is(":visible"))
		{
			$(this).next().slideDown();
		}else{
			$(this).next().slideUp();
		}
	});
});

$(function(){
	$("input:checkbox[id='termsCheck']").click(function(){
		if($("input:checkbox[id='termsCheck']").is(":checked")){
			$("#alerCheck").hide();
		}
	});
});

function isTermsCheck(){
	var str = $("#cardSelect option:checked").val();
    if(!str) {
        alert("카드사를 선택하세요.");
        $("#cardSelect").focus();
        return;
    }else if($("input:checkbox[id='termsCheck']").is(":checked")){
    	$("#payModal").modal();
	}else{
		$("#alerCheck").show();
	}
}

$(function() {
    $(".nextInput").keyup (function () {
        var charLimit = $(this).attr("maxlength");
        if (this.value.length >= charLimit) {
            $(this).next('.nextInput').focus();
            return false;
        }
    });
});

$(function(){
	$("#paySectionSelect").change(function(){
		var sectionType = $("#paySectionSelect option:selected").val();
		$("#paySectionType").html(sectionType);
		$("#paySection").val(sectionType);
	});
});

$(function(){
	$("#cardSelect").change(function(){
		var cardType = $("#cardSelect option:selected").val();
		$("#cardType").html(cardType);
		$("#cardCo").val(cardType);
	});
});


function totalCount(){
	var total = Number(0);
	$(".input-count").each(function(){
		total=Number(total)+Number(1);
	});
	
	return total;
}

$(function(){
	var couponName;
	var couponCode;
	var couponPrice;
	
	$("select").not("#paySectionSelect").change(function(){
		
		priceCheck();
	});
		
	
	$(document).on("click",".btn_delete",function(){
		
		
		$(this).closest("li").remove();
		console.log($(this).closest("span").prev().text());
		var option = $("<option value='"+$(this).closest("span").next().val()+"' data-couponName='"+$(this).closest("span").prev().text()+"' data-couponCode='"+$(this).closest("li").attr("data-couponCode")+"'>"+$(this).closest("span").prev().text()+" | "+numberWithCommas($(this).closest("span").next().val())+"원</option>");
        $("#couponSelect").append(option);
		priceCheck();
	});
});

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function priceCheck(){
	var price = $("#price").text(); /* 총가격 */
	var card = $("#cardSelect option:selected").val();
	
	var $coupon = $("#couponSelect option:selected");
	couponPrice = $coupon.val();
	
	var gubunCode = ${gubunCode};
	var realGubunCode = ${realGubunCode};
	var total = totalCount();
	if(total < ${usableCount}){
		if(couponPrice != 0){
			couponCode = $coupon.attr("data-couponCode"); 
			couponName = $coupon.attr("data-couponName");
		
		
			var html ="<li data-couponCode="+couponCode+">";
				html+="<span class='input-count'></span>";
				html+="<span style='float:left; margin-right:10px;'>"+couponName+"</span>";
				html+="<span><button type='button' class='btn_delete'></button></span>";
					html+="<input type='hidden' name='couponPrice' value="+couponPrice+">";
					html+="<input type='hidden' name='couponCode' value="+couponCode+">";
					html+="<input type='hidden' name='couponName' value="+couponName+">";
					html+="</li>";
		
				$("#coupon_result").find("ul").append(html);
				
			$("#couponSelect option:selected").remove();
			$("#couponSelect > option[value='0']").attr("selected","selected");
			
		}
	}else if(gubunCode == 1 && realGubunCode != 8){
		$("#couponSelect").val("0");
	}
	
	
	couponPrice = 0;
	$("input[name='couponPrice']").each(function(){
		couponPrice += Number($(this).val());
	});
	
	
	<c:forEach items="${dto}" var="dto">
		<c:if test="${dto.gubunCode == 4 || dto.gubunCode == 5 || dto.gubunCode == 6 || dto.gubunCode == 3}">
			<c:set var= "sum" value="${sum + (dto.goodsPrice * dto.quantity)}"/>
		</c:if>
	</c:forEach>

	var	dcTicketPay = 0;
	<c:if test="${not empty sum}">
		dcTicketPay = ${sum};
		dcTicketPay = dcTicketPay-couponPrice;
	</c:if>
	
	var url = "<%=cp%>/pay/price";
	var query = "price="+price+"&card="+card+"&couponPrice="+couponPrice
		+"&dcTicketPay="+dcTicketPay;
	
	$.ajax({
		type : "post",
		url : url,
		data : query,
		dataType : "json",
		success : function(data){
			var dcPrice = data.dcPrice;
			var payPrice = data.payPrice;
			$("#dcPrice").html(dcPrice);
			$("#payPrice").html(payPrice);
			$("#payPrice2").html(payPrice);
			var html = "<input type='hidden' name='payPrice' value='"+data.payPrice2+"'>";
				html += "<input type='hidden' name='dcPrice' value='"+data.dcPrice2+"'>";
				html += "<input type='hidden' name='useCoupon' value='"+data.useCoupon+"'>";
				html += "<input type='hidden' name='couponPriced' value='"+data.couponPrice+"'>";
				html += "<input type='hidden' name='cardPriced' value='"+data.cardPrice+"'>";
			$("#hiddenPay").html(html);	
			
			if(data.payPrice2 < 50000){
				$("#paySectionSelect > option[value='일시불']").attr("selected","selected");
				$("#paySectionSelect").attr("disabled", true);
			}
				
		},
		beforeSend : function(jqXHR){
			jqXHR.setRequestHeader("AJAX", true);
		},
		error : function(jqXHR){
			if(jqXHR.status == 403){
				location.href="<%=cp%>/member/login";
				return;
			}
			
			console.log(jqXHR.responseText);
		}
	});

}

/* input type이 패스워드인경우 */
$(function() { 
	$("input").keypress(
		function (event) { 
			if (event.which && (event.which <= 47 || event.which >= 58) && event.which != 8) 
			{ 
				event.preventDefault(); 
			} 
	});
}); 
/* input type이 text인경우 */
function onlyNumber(event){
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
        return;
    else
        return false;
}
 
function removeChar(event) {
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
        return;
    else
        event.target.value = event.target.value.replace(/[^0-9]/g, "");
}

function isValidMM(){
	var data = $("input[name='validM']").val();
	var regexp = /[01][0-9]/;
    if(! regexp.test(data))
        return false;

    if(data<1||data>12) 
    	return false;
		
	return true;  
}

function validOk() {
    var f = document.modalForm;

	var str = f.cardNum1.value;
    if(!str || str.length != 4) {
        f.cardNum1.focus();
        return;
    }
    
    var str = f.cardNum2.value;
    if(!str || str.length != 4) {
        f.cardNum2.focus();
        return;
    }
    
    var str = f.cardNum3.value;
    if(!str || str.length != 4) {
        f.cardNum3.focus();
        return;
    }
    
    var str = f.cardNum4.value;
    if(!str || str.length != 4) {
        f.cardNum4.focus();
        return;
    }

    var str = f.validM.value;
    var valid = isValidMM();
    if(!str || str.length != 2 || !valid) {
        f.validM.focus();
        return;
    }

    var str = f.validY.value;
    if(!str || str.length != 2) {
        f.validY.focus();
        return;
    }

    var str = f.pwd.value;
    if(!str || str.length != 2) {
        f.pwd.focus();
        return;
    }

    var str = f.cvcNum.value;
    if(!str || str.length != 3) {
        f.cvcNum.focus();
        return;
    }
    
	f.action="<%=cp%>/pay/insertPay";
    f.submit();
}

</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-credit-card"></span> 결제 </h3>
    </div>
    <form role="form" name="modalForm" method="post"> 
    <div>
	    <h2 class="custom_h2">상품정보</h2>
		<table class="custom_table">
		  <tbody>
			<c:forEach var="dto" items="${dto}">
				<tr>
					<td class="custom_col1">
						<input type="hidden" name="plist[<%=n%>].goodsCode" value="${dto.goodsCode}">
						<input type="hidden" name="plist[<%=n%>].goodsName" value="${dto.goodsName}">
						<input type="hidden" name="plist[<%=n%>].cartCode" value="${dto.cartCode}">
						<input type="hidden" name="plist[<%=n%>].gubunCode" value="${dto.gubunCode}">
						<input type="hidden" name="plist[<%=n%>].endDate" value="${dto.endDate}">
						<input type="hidden" name="plist[<%=n%>].startDate" value="${dto.startDate}">
						<input type="hidden" name="parentCode" value="${dto.parentCode}">
						${dto.goodsName}
					</td>
					<td class="customer_col2">
						<input type="hidden" name="plist[<%=n%>].quantity" value="${dto.quantity}">
						각 <fmt:formatNumber value="${dto.goodsPrice}" type="number" pattern="#,###원"/> / 수량 ${dto.quantity}개
					</td>
				</tr>
			<% n++; %>
			</c:forEach>
		  </tbody>
		</table>
		
		
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
		   <tr height="35">
			<td align="center">
			        <c:if test="${dataCount==0 }"><span style="color: red;">선택한 상품이 없습니다.</span></c:if>
			        <c:if test="${dataCount!=0 }">${paging}</c:if>
			 </td>
		   </tr>
		</table>
		
		<h2 class="custom_h2">결제정보</h2>
		<table class="pay_price">
		    <colgroup width="144">
		    </colgroup>
		  
		  <tbody>
				<tr class="table_col">
					<th class="col_title">총 상품 가격</th>
					<td>
						<strong id="price" class="price" ><fmt:formatNumber value="${price}" type="number" pattern="#,###원"/></strong>
					</td>
				</tr>
				<tr class="table_col">
					<th class="col_title">쿠폰</th>
					<td>
						<div style="padding-left: 15px;">
						<select id="couponSelect" ${gubunCode == 1 && realGubunCode != 8? '':"disabled='disabled'"}>
							<option value="0">쿠폰선택</option>
							<c:if test="${not empty mcouponlist}">
								<c:forEach var="mdto" items="${mcouponlist}">
									<option value="${mdto.price}" data-couponName="${mdto.couponMngName}" data-couponCode="${mdto.couponCode}">${mdto.couponMngName} | <fmt:formatNumber value="${mdto.price}" type="number" pattern="#,###원"/></option>
								</c:forEach>
							</c:if>
						</select>
						</div>
						<div id="coupon_result" style="padding-left: 15px;" >
							<ul style="margin: 5px 0px;">
	    						<li>
	    					
	    						</li>
	    					</ul>
						</div>
					</td>
				</tr>
				<tr class="table_col">
					<th class="col_title">할인 금액</th>
					<td>
						<strong id="dcPrice" class="price"><fmt:formatNumber value="${dcPrice}" type="number" pattern="#,###원"/></strong>
					</td>
				</tr>
				<tr class="table_col">
					<th class="col_title">총 결제 금액</th>
					<td>
						<strong id="payPrice" class="price" style="color: red;"><fmt:formatNumber value="${payPrice}" type="number" pattern="#,###원"/></strong>
					</td>
				</tr>
				<tr class="table_col">
					<th class="col_title">결제 카드</th>
					<td>
						<ul>
							<li class="pay-type-section">
								<label class="line-title">카드종류</label>
								<div style="display: inline;">
									<select id="cardSelect">
										<option value="">카드 선택</option>
										<option value="현대">현대 카드</option>
										<option value="신한">신한 카드</option>
										<option value="우리">우리 카드</option>
										<option value="BC">BC 카드</option>
										<option value="씨티">씨티 카드</option>
										<option value="롯데">롯데 카드</option>
										<option value="국민">국민 카드</option>
										<option value="농협">농협 카드</option>
										<option value="하나">하나 카드</option>
										<option value="삼성">삼성 카드</option>
									</select>
								</div>
								<c:if test="${gubunCode == 1}">
								<div style="display: inline-block; padding-left: 10px;">
									<span style="color:#888888;">* 제휴카드는 카드 선택시 자동으로 제휴할인이 적용됩니다.</span>
								</div>
								</c:if>
							</li>
							<li class="pay-type-section">
								<label class="line-title">할부기간</label>
								<div style="display: inline;">
									<select id="paySectionSelect">
										<option value="일시불">일시불</option>
										<option value="2개월">2개월(무이자)</option>
										<option value="3개월">3개월(무이자)</option>
										<option value="4개월">4개월</option>
										<option value="5개월">5개월</option>
										<option value="6개월">6개월</option>
										<option value="7개월">7개월</option>
										<option value="8개월">8개월</option>
										<option value="9개월">9개월</option>
										<option value="10개월">10개월</option>
										<option value="11개월">11개월</option>
										<option value="12개월">12개월</option>
									</select>
									<span style="display: inline-block; margin-left: 10px; vertical-align: center; color:#888888;">* 할부는 50,000원 이상만 가능합니다.</span>
									<div style="margin-left: 20px; margin-top: 10px;">
										<img width="70%;" src="<%=cp%>/resource/images/pay_section.png">
									</div>
								</div>
							</li>
						</ul> 
					</td>
				</tr>
		  </tbody>
		</table>
		
		<div style="margin-top: 5px;">
			<input id="termsCheck" type="checkbox"><span style="vertical-align: center;"> (필수) 구매조건 확인 및 결제대행 서비스 약관 동의</span><a id="readTermsInfo" style="cursor: pointer;">  [보기]</a>
			<div id="terms-info" style="margin-left: 15px; display: none;">
				<div><span>서비스 이용 약관 동의</span></div>								
				<div><span>개인정보 수집 및 이용 동의</span></div>								
				<div><span>개인정보 제공 및 위탁 동의</span></div>							
			</div>
		</div>
		<div id="alerCheck" style="display: none;"><span style="color: red; margin-top: 5px; margin-left: 15px;">구매조건 확인 및 결제대행 서비스 약관에 동의하셔야 합니다.</span></div>		
		
		<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
		   <tr>
		   	  <td align="center" width="100" style="padding-top: 5px; padding-bottom: 5px;">
		      	<span>위 주문 내용을 확인하였으며, 결제에 동의합니다.</span>
		      </td>
		   </tr>
		   <tr height="40">
		      <td align="center" width="100">
		          <button id="payButton" type="button" class="btn btn-danger" style="font-weight: bold;" onclick="isTermsCheck();">결제하기</button>
		      </td>
		   </tr>
		</table>
    </div>
    
    
    <div style="display: none;" id="payModal" role="dialog" class="modal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
		    	<div class="modal-header">
 					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
  					<span aria-hidden="true">×</span></button>
 					<div align="center">
 						<h4 class="modal-title" id="myModalLabel">신용카드</h4>
 					</div>
				</div>
				<div class="modal-body">
					<table class="custom_table" style="border-bottom: 2px solid #cecece;">
		  				<tbody>
							<tr>
								<th class="modal_th">상품명</th>
								<td class="modal_td">
								<c:forEach var="dto" items="${dto}">
									${dto.goodsName}/
								</c:forEach>
								</td>
							</tr>
							<tr>
								<th class="modal_th">결제금액</th>
								<td class="modal_td"><strong id="payPrice2" style="color: red;"><fmt:formatNumber value="${payPrice}" type="number" pattern="#,###원"/></strong></td>
							</tr>
		  				</tbody>
					</table>
					
					<table class="custom_table" style="border-bottom: 2px solid #cecece; margin-top: 10px;">
		  				<tbody>
							<tr>
								<th class="modal_th">카드종류</th>
								<td id="cardType" class="modal_td"></td>
							</tr>
							<tr>
								<th class="modal_th">카드번호</th>
								<td class="modal_td">
									<div>
										<input type="password" name="cardNum1" id="cardNum1" size="8" maxlength="4" class="nextInput" tabindex="1" placeholder="****"> - 
										<input type="password" name="cardNum2" id="cardNum2" size="8" maxlength="4" class="nextInput" tabindex="1" placeholder="****"> - 
										<input type="password" name="cardNum3" id="cardNum3" size="8" maxlength="4" class="nextInput" tabindex="1" placeholder="****"> - 
										<input type="password" name="cardNum4" id="cardNum4" size="8" maxlength="4" class="nextInput" tabindex="1" placeholder="****">
									</div>
								</td>
							</tr>
							<tr>
								<th class="modal_th">유효기간</th>
								<td class="modal_td">
									<input type="text" name="validM" id="validM" size="4" maxlength="2" class="nextInput" onkeydown="return onlyNumber(event)" onkeyup="return removeChar(event)" tabindex="1" placeholder="MM"> / 
									<input type="text" name="validY" id="validY" size="4" maxlength="2" class="nextInput" onkeydown="return onlyNumber(event)" onkeyup="return removeChar(event)" tabindex="1" placeholder="YY">
								</td>
							</tr>
							<tr>
								<th class="modal_th">비밀번호</th>
								<td class="modal_td">
									<input type="password" name="pwd" id="pwd" size="3" maxlength="2" class="nextInput" tabindex="1" placeholder="**">**
								</td>
							</tr>
							<tr>
								<th class="modal_th">CVC</th>
								<td class="modal_td">
									<input type="password" name="cvcNum" id="cvcNum" size="4" maxlength="3" tabindex="1" placeholder="***"> 뒤 3자리 입력
								</td>
							</tr>
							<tr>
								<th class="modal_th">할부기간</th>
								<td id="paySectionType" class="modal_td">일시불</td>
							</tr>
		  				</tbody>
					</table>
					
					<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
		   				<tr height="40">
		      				<td align="center" width="100">
		      					<input type="hidden" name="price" value="${price}">
		      					<input type="hidden" id="cardCo" name="cardCo">
		      					<input type="hidden" id="paySection" name="paySection">
		      					<input type="hidden" id="curDate" name="curDate">
		      					<div id="hiddenPay"></div>
		          				<button type="button" class="btn btn-danger" style="font-weight: bold;" onclick="validOk();">확인</button>
		     	 				<button type="button" class="btn btn-default" data-dismiss="modal" style="font-weight: bold;" onclick="isTermsCheck();">취소</button>
		     	 			</td>
		   				</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
  </form>  
</div>   