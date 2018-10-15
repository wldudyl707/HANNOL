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

<script type="text/javascript">
var couponType = "${thema}";
var page = "${page}";

$(function(){
	$('.nav-item').removeClass('active');
	$(".nav-item").each(function(){
		if( $(this).attr("data-coupon-gubun") == couponType){
			$(this).addClass("active");
			return;
		}
	});
	
	listPage("${page}");
	
	$(".nav-link").click(function(){
		$('.nav-item').removeClass('active');
		$(this).parent(".nav-item").addClass("active");
		
		couponType = $(this).parent(".nav-item").data("coupon-gubun");
		
		listPage(1);
	});
});


function listPage(pagec){	
	page = pagec;
	
	var url = "<%=cp%>/mypage/ajaxCouponList";
	var data = "page="+page;
	
	
	data+="&couponType="+couponType;
	
	
	$.ajax({
		type:"GET"
		,url:url
		,data: data
		,success:function(data) {
			$(".couponList").html(data);			
		}
	    ,error:function(e) {
	    	console.log(e.responseText);
	    }
	});
}

$("body").on("click", "#useCoupon", function(){
	var couponCode = $(this).attr("data-couponCode");	
	$("#couponModal"+couponCode).modal();
});

$("body").on("click", "#useCouponButton", function(){
	var couponCode = $(this).attr("data-couponCode");	/* giftCode */
	var gubunCode = $(this).attr("data-gubunCode");
	var url = "<%=cp%>/mypage/ajaxCouponUse"
	var data = "couponCode="+couponCode+"&page="+page+"&thema="+couponType+"&gubunCode="+gubunCode;
	
	$.ajax({
		type : "post",
		url : url,
		data : data,
		dataType : "json",
		success : function(data){
			location.href = "<%=cp%>/mypage/couponList?page="+page+"&thema="+couponType;
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
});
</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-star"></span> 쿠폰함</h3>
    </div>  

	<div>
		<ul class="nav nav-tabs">
			<li class="nav-item active" data-coupon-gubun="0">
				<a class="nav-link">기프트콘함</a>
			</li>
			<li class="nav-item" data-coupon-gubun="1">
				<a class="nav-link">티켓함</a>
			</li>
		</ul>

	</div>

	<div class="couponList" style="width: 100%;">
	
	</div>
	
	<div class="note">
    	<p style="font-size: 16px; font-weight: bold;">꼭 알아두세요</p>
    	<p style="margin-top: 10px; font-size: 12px;">쿠폰 사용 버튼을 누르면 사용이 완료되어 더이상 사용이 불가능하니 주의하십시오.</p>
    	<p style="margin-top: 10px; font-size: 12px;">쿠폰 사용 여부에 문제가 있을 경우 관리자에게 문의하여 주십시오.</p>
    </div>
</div>