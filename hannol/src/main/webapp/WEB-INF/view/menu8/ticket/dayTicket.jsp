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

.price_area{
	float:left; 
	margin-left: 30px;
	width: 45%;
}

#ticket_gubun, #ticket_person, #ticket_count{
	padding: 3px;
	width: 100%;
	font-size: 14px;
	margin-top: 15px;
}

.ticket_result{
	font-size: 14px;
	margin-top: 15px;
	width: 100%;
	border-top: 1px solid #e2e2e2;
}

.input-count{
	width: 42px;
	text-align: center;
}

.btn_delete{
  width: 21px;
  height: 21px;
  background: url('<%=cp%>/resource/images/delete.png') no-repeat -1px -1px;
  border: none;
  line-height : 21px;
  float: right;
}

.note{
	border: 1px solid #e1e1e1;
    background: #f8f8f8;
    padding: 20px;
    margin-top: 30px;
}
</style>

<script>
var selectDate = "${day}";
var limit = "${limit}";


$(function(){
	
	$(".day_title").html("[${day}] | 구매 가능 매수 : "+(4-Number(${limit})));
	
	$("#ticket_gubun").change(function(){
		$("#ticket_person option").css("display", "none");
		$("#ticket_person").val("");
		$("#ticket_count").val("");
		
		if($(this).val() == ""){
			$("#ticket_person").attr("disabled", true);
		}else{
			var gubunItem = $(this).val();
			if(gubunItem==1){
				$(".oneDay").css("display", "block");
			}else if(gubunItem==2){
				$(".oneDayMasic").css("display", "block");
			}else if(gubunItem==3){
				$(".after").css("display", "block");
			}else if(gubunItem==4){
				$(".afterMasic").css("display", "block");
			}else if(gubunItem==5){
				$(".big").css("display", "block");
			}
			
			$("#ticket_person").attr("disabled", false);
		}
	});
	
	$("#ticket_person").change(function(){
		$("#ticket_count").val("");
		$("#ticket_count").attr("disabled", false);
	});
	
	$("#ticket_count").change(function(){
		
		var $item = $("#ticket_person option:selected");
		var goodsCode = $item.val();
		var goodsName = $item.attr("data-goodsName");
		var goodsPrice = $item.attr("data-goodsPrice");
		var gubunCode = $item.attr("data-gubunCode");
		var gubunName = $item.attr("data-gubunName");
		var parentCode = $item.attr("data-parentCode");
		var quantity = $(this).val();
		var state = "false";
		
		//같은 이용권 선택시 수량만 변경
		$("li").each(function(){
			if($(this).attr("data-goodsCode")==goodsCode){
				var minus = $(this).find(".input-count").html().substring(1);
				var total = Number(totalCount())+Number(quantity)-minus+Number(limit);
				if(total <=4){
					$(this).find(".input-count").html("X"+quantity);
					$(this).find("input[name='quantity']").val(quantity);
					state ="true";
					return;
				}
			}
		});
		
		//변경된 값있는지 확인
		if(state=="true"){
			return;
		}
		
		//전체 수량검사
		var total = totalCount()+Number($(this).val());
		if(total > Number(4-limit)){
			alert( "하루에 최대 구매 가능 개수는 4매입니다.");
			return;
		}
		
		//실제로 보여지고 server쪽으로 넘길 값 hidden
		var html ="<li data-goodsCode="+goodsCode+">";
		html+="<span>["+$("#ticket_gubun option:selected").text()+"]</span>";
		html+="<span>"+goodsName+"</span>";
		html+="<span class='input-count'>X"+$(this).val()+"</span>";
		html+="<span><button type='button' class='btn_delete'></button></span>";
		html+="<input type='hidden' name='goodsCode' value="+goodsCode+">";
		html+="<input type='hidden' name='gubunCode' value="+gubunCode+">";
		html+="<input type='hidden' name='goodsName' value="+goodsName+">";
		html+="<input type='hidden' name='goodsPrice' value="+goodsPrice+">";
		html+="<input type='hidden' name='gubunName' value="+gubunName+">";
		html+="<input type='hidden' name='parentCode' value="+parentCode+">";
		html+="<input type='hidden' name='quantity' value="+quantity+">";
		html+="<input type='hidden' name='startDate' value="+selectDate+">";
		html+="<input type='hidden' name='endDate' value="+selectDate+">";
		html+="</li>";
			
		$(".ticket_result").find("ul").append(html);
	});
	
	$(document).on("click",".btn_delete",function(){
		$(this).closest("li").remove();
	});
	
	$(".btn-pay").click(function(){
		if(Number(totalCount())== 0){
			alert("이용권을 1개 이상 선택해 주세요");
			return;
		}
		
		$("#saleForm").submit();
	});
	
	$(".btn-back").click(function(){
		location.href="<%=cp%>/reservation/dayCalendar";
	});
});

function totalCount(){
	var total = Number(0);
	$(".input-count").each(function(){
		total=Number(total)+Number($(this).text().substring(1));
	});
	
	return total;
}
</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="	glyphicon glyphicon-calendar"></span>예매</h3>
    </div>
    
    <div class="buy_info">
    	<div class="img_area">
    		<img alt="한놀 HANNOL" src="<%=cp%>/resource/images/hannol_logo.jpg">
    	</div>
    	
    	<div class="price_area">
    		<h4 class="day_title"></h4>
    		<div class="goods_option">
    			<select id="ticket_gubun">
    				<option value="">::권종선택::</option>
    				<c:forEach items="${oneDay}"></c:forEach>
    				<c:if test="${not empty oneDay}">
    					<option value="1">종일권</option>
    				</c:if>
    				<c:if test="${not empty oneDayMasic}">
    					<option value="2">종일권+매직패스</option>
    				</c:if>
    				<c:if test="${not empty after}">
    					<option value="3">야간권</option>
    				</c:if>
    				<c:if test="${not empty afterMasic}">
    					<option value="4">야간권+매직패스</option>
    				</c:if>
    				<c:if test="${not empty big}">
    					<option value="5">BIG5</option>
    				</c:if>
    			</select>
    			
    			<select id="ticket_person" disabled="disabled">
    				<option value="">::구분::</option>
    				<c:forEach items="${oneDay}" var="item">
    					<option value="${item.goodsCode}" class="oneDay" style="display: none;" data-goodsName="${item.goodsName}" data-gubunCode="${item.gubunCode}"
    					 data-goodsPrice="${item.goodsPrice}" data-gubunName="${item.gubunName}" data-parentCode="${item.parentCode}">${item.goodsName}[${item.goodsPrice}원]</option>
    				</c:forEach>
    				<c:forEach items="${oneDayMasic}" var="item">
    					<option value="${item.goodsCode}" class="oneDayMasic" style="display: none;"data-goodsName="${item.goodsName}" data-gubunCode="${item.gubunCode}"
    					 data-goodsPrice="${item.goodsPrice}" data-gubunName="${item.gubunName}" data-parentCode="${item.parentCode}">${item.goodsName}[${item.goodsPrice}원]</option>
    				</c:forEach>
    				<c:forEach items="${after}" var="item">
    					<option value="${item.goodsCode}" class="after" style="display: none;"data-goodsName="${item.goodsName}" data-gubunCode="${item.gubunCode}"
    					 data-goodsPrice="${item.goodsPrice}" data-gubunName="${item.gubunName}" data-parentCode="${item.parentCode}">${item.goodsName}[${item.goodsPrice}원]</option>
    				</c:forEach>
    				<c:forEach items="${afterMasic}" var="item">
    					<option value="${item.goodsCode}" class="afterMasic" style="display: none;"data-goodsName="${item.goodsName}" data-gubunCode="${item.gubunCode}"
    					 data-goodsPrice="${item.goodsPrice}" data-gubunName="${item.gubunName}" data-parentCode="${item.parentCode}">${item.goodsName}[${item.goodsPrice}원]</option>
    				</c:forEach>
    				<c:forEach items="${big}" var="item">
    					<option value="${item.goodsCode}" class="big" style="display: none;"data-goodsName="${item.goodsName}" data-gubunCode="${item.gubunCode}"
    					 data-goodsPrice="${item.goodsPrice}" data-gubunName="${item.gubunName}" data-parentCode="${item.parentCode}">${item.goodsName}[${item.goodsPrice}원]</option>
    				</c:forEach>
    				
    			</select>
    			
    			<select id="ticket_count" disabled="disabled">
    				<option value="">::수량::</option>
    				<option value="1">1</option>
    				<option value="2">2</option>
    				<option value="3">3</option>
    				<option value="4">4</option>
    			</select>
    		</div>
    		
    		<div class="ticket_result">
	    		<form action="<%=cp%>/pay/list" method="post" id="saleForm">
	    			<ul style="margin: 15px 0px;">
	    				<li>
	    					
	    				</li>
	    			</ul>
	    		</form>
	    		<div style="text-align: center;">
	    			<button type="button" class="btn btn-defualt btn-back" style="width: 49%;">취소</button>
	    			<button type="button" class="btn btn-danger btn-pay" style="width: 49%;">결제</button>
	    		</div>
    		</div>
    	</div>
    	
    	<div style="clear: both; content: ''"></div>
	    <div class="note">
	    	<p style="font-size: 20px; font-weight: bold;">꼭 알아두세요</p>
	    	<p style="margin-top: 10px; font-size: 16px;">우대권을 구매한 경우에는 매표소에서 필요서류를 요구할 수 있습니다.</p>
	    </div>
    </div>
</div>