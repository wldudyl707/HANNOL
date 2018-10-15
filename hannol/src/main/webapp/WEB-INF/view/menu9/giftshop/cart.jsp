<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
   int totalPrice = 0;
%>

<style>
.div_basket{
	border-bottom: 1px solid #ddd;
}

/* Table */
.tb{
	width: 100%;
	border-top: 2px solid #198292;
	border-collapse: separate;
}

/* checkBox */
.tb_th{
	border-right: 1px solid #ddd;
}

.tb th{
	text-align: center;
	font-size: 12px;
	height: 40px;
	line-height: 40px;
}

/* 상품 목록 */
.cart_list{
	border-top: 1px solid #ddd;
	height: 130px;
}

.tb td{
	text-align: center;
}

/* 전체 삭제 버튼*/
.btn-delete-all{
	font-size: 12px;
	padding: 3px;
}

.check_all{
	margin: 0px 25px 25px 6px;
    padding: 10px 0px;
}

/*결제 예상 테이블*/
.tb_total{
	width: 100%;
	border-collapse: collapse;
	border-spacing: 0;
}

.div_total{
	border-top: 2px solid #333;
	border-bottom: 1px solid #e1e1e1;
}

.th_price_sub{
	background: #f3f3f3;
	font-size: 20px;
	height: 50px;
	text-align: right;
	padding-right: 10px;
}

.th_price{
	border-top: 1px solid #ddd;
	color: tomato;
	font-size: 20px;
	font-weight: bold;
	height: 50px;
	text-align: right;
	padding-right: 10px;
}

.quantity{
    width: 30px;
    height: 21px;
    text-align: center;
    float: left;
}

.btn_minus{    
	width: 21px;
    height: 21px;
    background: url(/hannol/resource/images/minus.png) no-repeat -1px -1px;
    border: 0 none;
    float: left;
}

.btn_plus{
	width: 21px;
	height: 21px;
	line-height : 21px;
	background: url(/hannol/resource/images/plus.png) no-repeat -1px -1px;
	border: 0 none;
	float: left;
}

.num_box{
	width:72px; 
	margin:0 auto;
}

.cart_one button{
	padding: 5px;
}


</style>

<script>
$(function(){
	getTotalPrice();
	
	$(".btn_minus").click(function(){
		var $cnt = $(this).closest(".num_box").children(".quantity");
		var itemCount = $cnt.val();
		
		if(Number(itemCount-1) < 1){
			alert("최소 수량은 1개입니다.");
			return;
		}
		
		$cnt.val(Number(itemCount-1));
		$cnt.attr("value", Number(itemCount-1));
		var price = $cnt.attr("data-price");
		var itemPrice =Number(price)*Number(itemCount-1);
		$(this).closest(".cart_list").next().html(numberWithCommas(itemPrice)+"원");
		
		getTotalPrice();
	});
	
	$(".btn_plus").click(function(){
		var $cnt = $(this).closest(".num_box").children(".quantity");
		var itemCount = $cnt.val();
		
		if(Number(itemCount)+Number(1) > 4){
			alert("최대 수량은 4개입니다.");
			return;
		}
		
		$cnt.val(Number(itemCount)+Number(1));
		$cnt.attr("value", Number(itemCount)+Number(1));
		var price = $cnt.attr("data-price");
		var itemPrice =Number(price)*(Number(itemCount)+Number(1));
		$(this).closest(".cart_list").next().html(numberWithCommas(itemPrice)+"원");
		
		getTotalPrice();
	});
	
	$(".item-delete").click(function(){
		
		if(!confirm("정말 삭제하시겠습니까?")){
			return;
		}

		var data = "cartCode="+$(this).attr("data-cartCode");
		var url = "<%=cp%>/giftshop/deleteCart";
		var $btn = $(this);
		
		$.ajax({
			type:"POST"
			,url:url
			,data: data
			,success:function(data) {
				if(data.state=="true"){
					$btn.closest("tr").remove();				
				}else{
					alert("삭제에 실패했습니다. 다시 시도해 주세요");
				}
			}
		    ,error:function(e) {
		    	console.log(e.responseText);
		    }
		});
		
	});
});


$(function(){
	$("#checkbox_all").click(function(){
		var $checkBox = $( "input[name='select_item']");
		
		if($checkBox==undefined){
			return;
		}
		
		if($checkBox.length != undefined){
			for(var i=0; i<$checkBox.length; i++){
				if($("#checkbox_all").is(":checked")){
					$($checkBox[i]).prop('checked', true);
					$("#input-delete-all").prop('checked', true);
				}else{
					$($checkBox[i]).prop('checked', false);
					$("#input-delete-all").prop('checked', false);
				}
			}
		}else{
			if($("#checkbox_all").is(":checked")){
				$("#checkbox_all").prop('checked', true);
			}else{
				$("#checkbox_all").prop('checked', false);
			}
		}
		
		var $items = $(this).closest("table").find(".num_box").find("input");
		if(!$(this).is(":checked")){
			$items.each(function(){
				$(this).prop("disabled", true);
			});
		}else{
			$items.each(function(){
				$(this).prop("disabled", false);
			});
		}
		
		getTotalPrice();
	});
	

	
	$(".btn-delete-all").click(function(){
		if(!confirm("정말로 삭제하시겠습니까?")){
			return;
		}
		
		var sql ="";
		$(".tb input[name='select_item']").each(function(){
			if($(this).is(":checked")){
				sql+="cartCode="+$(this).attr("data-cartCode")+"&";
			}
		});

		var url = "<%=cp%>/giftshop/deleteCart";
		
		$.ajax({
			type:"POST"
			,url:url
			,data: sql
			,success:function(data) {
				if(data.state=="true"){
					location.href="<%=cp%>/giftshop/cart";			
				}else{
					alert("삭제에 실패했습니다. 다시 시도해 주세요");
				}
			}
		    ,error:function(e) {
		    	console.log(e.responseText);
		    }
		});		
	});
	
	$(".order-all").click(function(){
		$("#saleForm").submit();
	});
});

$(function(){
	$(".tb input[name='select_item']").click(function(){
		var $items = $(this).closest("tr").find(".num_box").find("input");
		if(!$(this).is(":checked")){
			$items.each(function(){
				$(this).prop("disabled", true);
			});
		}else{
			$items.each(function(){
				$(this).prop("disabled", false);
			});
		}
		
		getTotalPrice();
	});
	
	$(".tb button[name='item-order']").click(function(){
		var $item = $(this).closest("tr").find(".num_box");
		var gubunCode = $item.find("input[name='gubunCode']").val();
		var goodsCode = $item.find("input[name='goodsCode']").val();
		var goodsName = $item.find("input[name='goodsName']").val();
		var goodsPrice = $item.find("input[name='goodsPrice']").val();
		var quantity = $item.find("input[name='quantity']").val();
		var gubunName = $item.find("input[name='gubunName']").val();
		var parentCode = $item.find("input[name='parentCode']").val();
		var cartCode = $item.find("input[name='cartCode']").val();
		
		$("#oneSaleForm").find("input[name='gubunCode']").val(gubunCode);
		$("#oneSaleForm").find("input[name='goodsCode']").val(goodsCode);
		$("#oneSaleForm").find("input[name='goodsName']").val(goodsName);
		$("#oneSaleForm").find("input[name='goodsPrice']").val(goodsPrice);
		$("#oneSaleForm").find("input[name='quantity']").val(quantity);
		$("#oneSaleForm").find("input[name='gubunName']").val(gubunName);
		$("#oneSaleForm").find("input[name='parentCode']").val(parentCode);
		$("#oneSaleForm").find("input[name='cartCode']").val(cartCode);
		
		$("#oneSaleForm").submit();
	});
});

function getTotalPrice(){
	var $input = $( "input[name='quantity']");
	var totalPrice = 0;
	$input.each(function(){
		if($(this).closest("tr").find("input[name='select_item']").is(":checked")){
			totalPrice += Number($(this).attr("data-price")*$(this).val());
		}
	});
	
	$(".th_price").html(numberWithCommas(totalPrice)+"원");
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
</script>

<div class="bodyFrame2">
	<div class="body-title">
		<h3>
			<span class="glyphicon glyphicon-shopping-cart"></span>장바구니
		</h3>
	</div>
	
	<div class="div_basket">
	<form action="<%=cp%>/pay/list" method="post" id="saleForm">
		<table class="tb">
			<thead>
				<tr>
					<th>
						<input type="checkbox" id="checkbox_all" checked>
					</th>
					<th class="tb_th" style="width: 40%">
						상품/정보
					</th>
					<th class="tb_th">
						수량
					</th>
					<th class="tb_th">
						상품금액
					</th>
					<th>
						주문
					</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${empty list }">
				<tr>
					<td class="cart_list" colspan="5">
						장바구니에 담겨있는 상품이 없습니다.
					</td>
				</tr>
			</c:if>
			
			<c:if test="${not empty list}">
				<c:forEach var="dto" items="${list}">
					<tr data-cartCode="${dto.cartCode}">
						<td class="cart_list">
							<input type="checkbox" name="select_item" id="select_item" data-cartCode="${dto.cartCode}" checked>
						</td>
						<td class="cart_list tb_th" style="text-align: left;">
							<span>
								<img src="/hannolAdmin/uploads/giftShopGoods/${dto.thumbnail}" onerror="this.src='<%=cp%>/resource/images/noimage.png'" width="50" height="50">
							</span>
							<span>
								[${dto.gubunName }] ${dto.goodsName }
							</span>
						</td>
						<td class="cart_list tb_th">
							<div class="num_box">
								<button type="button" class="btn_minus"></button>
								<input type="text" class="quantity" value="${dto.quantity}" data-price="${dto.price}" name="quantity">
								<input type="hidden" value="${dto.gubunCode}" name="gubunCode">
								<input type="hidden" value="${dto.goodsCode}" name="goodsCode">
								<input type="hidden" value="${dto.goodsName}" name="goodsName">
								<input type="hidden" value="${dto.price}" name="goodsPrice">
								<input type="hidden" value="${dto.gubunName}" name="gubunName">
								<input type="hidden" value="${dto.parentCode}" name="parentCode">
								<input type="hidden" value="${dto.cartCode}" name="cartCode">
								<button type="button" class="btn_plus"></button>
							</div>
						</td>
						<td class="cart_list tb_th" style="font-weight: bold;">
							<fmt:formatNumber value="${dto.price* dto.quantity}" type="number" pattern="#,###원"/>
						</td>
						<td class="cart_list cart_one">
							<button type="button" class="btn btn-default item-delete" data-cartCode="${dto.cartCode}">삭제하기</button>
							<button type="button" class="btn btn-danger" name="item-order" data-cartCode="${dto.cartCode}">주문하기</button>
						</td>
					</tr>
				</c:forEach>
			</c:if>
			</tbody>
		</table>
		</form>
	</div>
	
	<div class="check_all">
		<input type="checkbox" id="input-delete-all" checked>
		<button type="button" class="btn btn-default btn-delete-all" >선택삭제</button>
	</div>
	
	<div class="div_total">
		<table class="tb_total">
			<thead>
				<tr>
					<th class="th_price_sub">
						결제 예정금액
					</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td class="th_price">
						원
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div style="text-align: center; margin-top: 20px;">
		<button type="button" class="btn btn-default">쇼핑 계속하기</button>
		<button type="button" class="btn btn-danger order-all">주문결제</button>
	</div>
</div>

<div>
	<form action="<%=cp%>/pay/list" method="post" id="oneSaleForm">
		<input type="hidden" value="" name="quantity">
		<input type="hidden" value="" name="gubunCode">
		<input type="hidden" value="" name="goodsCode">
		<input type="hidden" value="" name="goodsName">
		<input type="hidden" value="" name="goodsPrice">
		<input type="hidden" value="" name="gubunName">
		<input type="hidden" value="" name="parentCode">
		<input type="hidden" value="" name="cartCode">
	</form>
</div>