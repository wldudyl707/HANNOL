<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<div style="clear: both;">
		<div>
			<table class="table">
			    <colgroup>
			        <col style="width: 15%; text-align:center">
			        <col style="text-align:center">
			        <col style="width: 15%; text-align:center">
			        <col style="width: 10%; text-align:center">
			        <col style="width: 15%; text-align:center">
			    </colgroup>
    
		  	<thead class="thead-light">
		    	<tr>
		      	<th scope="col">쿠폰번호</th> <!-- 시리얼번호 -->
		      	<th scope="col">상품명</th>
		      	<th scope="col">만료일</th>
		      	<c:if test="${couponType == 0}">
		      	<th scope="col">사용여부</th>
		      	<th scope="col">사용일</th>
		      	</c:if>
		    	</tr>
		  	</thead>
		  	<tbody>
			  <c:forEach var="dto" items="${list}">
			    <c:if test="${couponType == 0}">
			    	<c:set var="code" value="${dto.giftCode}"></c:set>
			    </c:if>
			    <c:if test="${couponType == 1}">
			    	<c:set var="code" value="${dto.ticketCode}"></c:set>
			    </c:if>
			    <tr>
			      <th scope="row">${dto.listNum}
			      </th>
			      <td>
			      	<div id="useName${code}">
			      	<c:if test="${couponType == 0 and dto.quantity eq 0 and empty dto.useDate}"><div style="color: red;">${dto.gubunName}-${dto.goodsName}(품절!)</div></c:if>
			      	<c:if test="${couponType == 0 and (not empty dto.useDate and (dto.quantity gt 0)) or (dto.quantity eq 0 and not empty dto.useDate) or dto.endDate}"><div style="color: gray;">${dto.gubunName}-${dto.goodsName}</div></c:if>
			      	<c:if test="${couponType == 0 and empty dto.useDate and (dto.quantity gt 0)}"><a id="useCoupon" style="color: black; cursor: pointer;" data-couponCode='${code}'>${dto.gubunName}-${dto.goodsName}</a></c:if>
			      	<c:if test="${couponType == 1 and (dto.startDate eq '0001-01-01')and dto.gubunCode != 8}"><div style="color: gray;">${dto.gubunName}-${dto.goodsName}</div></c:if>
			      	<c:if test="${couponType == 1 and dto.startDate ne '0001-01-01' and dto.gubunCode != 8}"><a id="useCoupon" style="color: black; cursor: pointer;" data-couponCode='${dto.ticketCode}'>${dto.gubunName}-${dto.goodsName}</a></c:if>
			      	<c:if test="${couponType == 1 and dto.gubunCode == 8}"><a id="useCoupon" style="color: orange; cursor: pointer;" data-couponCode='${dto.ticketCode}'>${dto.gubunName}-${dto.goodsName}</a></c:if>
			      	</div>
			      </td>
			      <td>${dto.endDate}</td>
			      <c:if test="${couponType == 0}">
			      <td>
			      	<div id="useState${code}">
			      		<c:if test="${not empty dto.useDate}">
			      			사용
			      		</c:if>
			      		<c:if test="${empty dto.useDate}">
			      			미사용
			      		</c:if>
			      	</div>
			      </td>
			      <td><div id="useDate${code}">${dto.useDate}</div></td>
			      </c:if>
			    </tr>
			    
			    <div style="display: none;" id="couponModal${code}" role="dialog" class="modal" tabindex="-1">
					<div class="modal-dialog modal-sm">
						<div class="modal-content">
		    				<div class="modal-header">
 								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
  								<span aria-hidden="true">×</span></button>
 								<div align="center">
 									<h5 class="modal-title" id="myModalLabel">해당 쿠폰을 사용하시겠습니까?</h5>
 								</div>
							</div>
							<div class="modal-body">
									<div align="center" style="margin: 30px auto;">
										<h5>${dto.gubunName} - ${dto.goodsName}</h5>
									</div>
									<div align="center" style="width: 100%; margin: 30px auto; border-spacing: 0px;">
										<c:if test="${dto.parentCode == 2 || dto.gubunCode == 8 || now eq dto.endDate}">
		   								<button id="useCouponButton" type="button" class="btn btn-info" style="font-weight: bold;" data-couponCode='${code}' data-gubunCode='${dto.gubunCode}'>${couponType == 0?"사용" : "입장"}</button>
		     	 						</c:if>
		     	 						<button type="button" class="btn btn-default" data-dismiss="modal" style="font-weight: bold;">취소</button>
									</div>
							</div>
						</div>
					</div>
				</div>
				
			   </c:forEach>
		  	</tbody>
		</table>
    </div>
</div>
<div class="div-paging" style="width: 100%; text-align: center; margin: 0px auto; clear: both;">
	<c:if test="${dataCount==0}">사용가능한 쿠폰이 없습니다.</c:if>
	<c:if test="${dataCount!=0}">${paging}</c:if>
</div>
