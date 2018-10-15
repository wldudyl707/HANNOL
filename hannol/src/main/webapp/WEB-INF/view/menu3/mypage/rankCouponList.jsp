<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>
.selectMenu{
	float: right;
}

.custom_th {
    border: solid #e4e4e4; 
    border-width: 0 1px 1px 0;
    background: #f8f8f8;
    padding: 7px 15px 7px 15px;
    font-weight: bold;
    text-align: center;    
}

.custom_td {
    border: solid #e4e4e4; 
    border-width: 0 1px 1px 0;
    padding: 7px 15px 7px 15px;
    text-align: center;    
}

.custom_table {
    width: 100%;
    border-top: 2px solid #cecece;
}
</style>

<script type="text/javascript">
$(function(){
	listPage(1);
});

function listPage(page){
	var order = $(".form-control").val();
	
	var data = "page="+page+"&order="+order;
	var url = "<%=cp%>/mypage/rankCouponListBody";
	
	$.ajax({
		type:"POST"
		,url:url
		,data: data
		,success:function(data) {
			$(".td-coupon").html(data);			
			
		}
	    ,error:function(e) {
	    	console.log(e.responseText);
	    }
	});
}
</script>

<div class="bodyFrame2">
	<div class="body-title">
		<h3>
			<span class="glyphicon glyphicon-tower"></span> 등급 혜택
		</h3>
	</div>


	<div>
		<div class="selectMenu">
			<select class="form-control" onchange="listPage('1')">
				<option value="recent">최근발급순</option>
				<option value="endDate">만료임박순</option>
			</select>
		</div>
	
		<div class="td-coupon">
			
		</div>
	</div>
	
	<div style="background-color: #ffffff; margin-top: 30px;">
		<div>
			<h3 style="margin: 3px;"><small>회원등급 산정기준</small></h3>
		</div>
		<div style="padding: 5px;">
			<table class="custom_table">
				<tr>
					<th class="custom_th">등급</th>
					<c:forEach var="dto" items="${glist}">
						<th class="custom_th">
							<img src="/hannolAdmin/uploads/grade/${dto.saveFileName}" width="40" height="40" style="padding: 1px;"> 
							${dto.gradeName}
						</th>
					</c:forEach>
				</tr>
				<tr>
					<td class="custom_td">조건</td>
					<c:forEach var="dto" items="${glist}">
						<th class="custom_td">
							<c:if test="${dto.gradeName eq 'FIRST'}">가입 고객</c:if>
							<c:if test="${dto.gradeName ne 'FIRST'}">연 ${dto.condition}만원 이상 구매 회원</c:if>
						</th>
					</c:forEach>
				</tr>
				<tr>
					<td class="custom_td">혜택</td>
					<c:forEach var="dto" items="${glist}">
						<th class="custom_td">${dto.benefit}</th>
					</c:forEach>
				</tr>
			</table>
		</div>
		<div>  
			<h5 style="margin: 3px;"><small>- 매년 1일을 기준으로 등급이 산정됩니다.</small></h5>
		</div>
	</div>	
</div>