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

.custom_table {
    width: 60%;
    border-top: 2px solid #cecece;
}

.custom_table2 {
    width: 80%;
    border-top: 2px solid #cecece;
}

.custom_h2 {
    margin-bottom: 8px;
    font-size: 20px;
    font-weight: 700;
    color: #333;
}

.table_th {
    width: 30%;
    border: solid #e4e4e4;
    border-width: 0 1px 1px 0;
    padding: 7px 10px 7px 15px;
    font-weight: bold;
    text-align: left;
    background: #f4f4f4;
}

.table_td {
	width: 70%;
    border-bottom: 1px solid #e4e4e4;
    padding: 10px 16px;
}

.table_th2 {
    width: 30%;
    border: solid #e4e4e4;
    border-width: 0 1px 1px 0;
    padding: 7px 10px 7px 15px;
    font-weight: bold;
    text-align: center;
    background: #f4f4f4;
    font-size: 13px;
}

.table_td2 {
	width: 30%;
    border-bottom: 1px solid #e4e4e4;
    padding: 10px 16px;
    font-weight: bold;
    text-align: center;
    font-size: 13px;
}
</style>


<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-credit-card"></span> 결제완료 </h3>
    </div>
    <div align="center">
	    <h2 class="custom_h2">상품의 결제가 성공적으로 완료되었습니다.</h2>
	    
	    <table class="custom_table" style="margin-top: 30px;">
		  	<tbody>
				<tr>
					<th class="table_th">결제금액</th>
					<td class="table_td"><fmt:formatNumber value="${dto.payPrice}" type="number" pattern="#,###원"/></td>
				</tr>
				<tr>
					<th class="table_th">결제카드</th>
					<td class="table_td">${dto.cardCo}</td>
				</tr>
				<tr>
					<th class="table_th">카드번호</th>
					<td class="table_td">${dto.cardNum}</td>
				</tr>
				<tr>
					<th class="table_th">결제일자</th>
					<td class="table_td">${dto.payDate}</td>
				</tr>
		  	</tbody>
		</table>
		
		<table class="custom_table2" style="margin-top: 30px;">
		  <tbody>
				<tr>
					<th class="table_th2">상품금액</th>
					<th class="table_th2">할인금액</th>
					<th class="table_th2" style="color: red;">총 결제금액</th>
				</tr>
				<tr>
					<td class="table_td2">
						<fmt:formatNumber value="${dto.price}" type="number" pattern="#,###원"/>
					</td>
					<td class="table_td2">
						<fmt:formatNumber value="${dto.dcPrice}" type="number" pattern="#,###원"/>
					</td>
					<td class="table_td2" style="color: red;">
						<fmt:formatNumber value="${dto.payPrice}" type="number" pattern="#,###원"/>
					</td>
				</tr>
		  </tbody>
		</table>
		
		<table style="width: 100%; margin: 20px auto; border-spacing: 0px;">
		   	<tr height="40">
		      	<td align="center" width="100">
		          	<button type="button" class="btn btn-danger" style="font-weight: bold;" onclick="javascript:location.href='<%=cp%>/mypage/paylist'">구매내역 확인</button>
		     	 	<button type="button" class="btn btn-default" style="font-weight: bold;" onclick="javascript:location.href='<%=cp%>/giftshop/list'">${dto.parentCode == 2? '쇼핑 계속하기' : '기프트샵으로 이동'}</button>
		     	 </td>
		   	</tr>
		</table>
	</div>
</div>   