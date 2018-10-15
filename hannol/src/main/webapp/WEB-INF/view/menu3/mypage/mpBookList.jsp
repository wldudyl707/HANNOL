<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<script>
$(function(){
	$(".btn-cancle-magicpass").click(function(){
		var facilityCode = $(this).attr("data-facilityCode");
		var mpTime = $(this).attr("data-mpTime");
		var mpDate = $(this).attr("data-mpDate");
		
		var url = "<%=cp%>/mybook/deleteMagic";
		data = "facilityCode="+facilityCode+"&mpTime="+mpTime+"&mpDate="+mpDate;
		
		$.ajax({
			type:"POST"
			,url:url
			,data: data
			,dataType : "json"
			,success:function(data) {		
				if(data.state=="success"){
					alert("예약이 취소 되었습니다.");
					location.reload();
				}else{
					alert("예약취소를 하지 못했습니다. 다시 시도해 주세요.");
				}
			}
		    ,error:function(e) {
		    	console.log(e.responseText);
		    }
		});
	});
});
</script>

<div>
	<form name="bookForm" id="bookForm">
	
		<table class="table">
			    <colgroup>
			        <col style="text-align:center">
			        <col style="width: 20%; text-align:center">
			        <col style="width: 10%; text-align:center">
			        <col style="width: 10%; text-align:center">
			        <col style="width: 10%; text-align:center">
			    </colgroup>
    
		  <thead class="thead-light">
		    <tr>
		      <th scope="col" style="text-align: left;">어트랙션명</th>
		      <th scope="col" style="text-align: center;">예약시간</th>
		      <th scope="col" style="text-align: center;">예약날짜</th>
		      <th scope="col" style="text-align: center;">예약인원</th>
		      <th scope="col" style="text-align: center;">상태</th>
		    </tr>
		  </thead>
		  <tbody>
		  <c:forEach items="${list}" var="dto">
			  <tr>
			      <td style="text-align: left;">${dto.name}</td>
			      <td style="text-align: center;">${dto.mpTime}:00~${dto.mpTime+1}:00</td>
			      <td style="text-align: center;">${dto.mpDate}</td>
			      <td style="text-align: center;">${dto.cnt}</td>
			      <td style="text-align: center;">
			      	<c:if test="${dto.state==0}">
			      		탑승완료
			      	</c:if>
			      	<c:if test="${dto.state==1}">
			      		 <button type="button" class="btn btn-info btn-cancle-magicpass" data-facilityCode="${dto.facilityCode}"  data-mpTime="${dto.mpTime}" data-mpDate="${dto.mpDate}">예약취소</button>
			      	</c:if>
			     </td>
			    </tr>
		    </c:forEach>
		  </tbody>
		</table>
		
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
		   <tr height="35">
				<td align="center">
				        <c:if test="${dataCount==0 }">등록된 게시물이 없습니다.</c:if>
				   		<c:if test="${dataCount!=0 }">${paging}</c:if>
				</td>
		   </tr>
		</table>
	</form>
</div>