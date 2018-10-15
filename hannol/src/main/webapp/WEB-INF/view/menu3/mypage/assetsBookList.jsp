<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<style>
	.table th,
	.table td{text-align:center; vertical-alilgn:middle;}  
	.table td:nth-child(6){text-align:left;} 
	 
	.table>tbody>tr>td{vertical-align:middle;}
	#chkAll{margin:0; vertical-align:middle;}   
</style>
<script>
	//편의시설 예약 삭제
	$(function(){
		$("button[name=assetsDelete]").off().on("click", function(){ 
			if(!confirm("예약을 취소하시겠습니까?")){
				return;
			}  
			
			var data = ""; 
			
			//체크된것들 리스트에 넣음
			$("input[name=chk]:checked").each(function(){
				data+="bookCodes="+$(this).attr("data-num")+"&"
			});
			data=data.substring(0, data.length-1);
		
			if(data.length == 0){
				alert("삭제할 예약정보를 선택해주세요");
				return false;       
			} 
			
			 
			var url = "<%=cp%>/mybook/deleteAssets"; 
			
			$.ajax({
				type:"post",
				url:url,
				data:data,
				dataType:"json",
				success:function(data){
					if(data.state=="true"){
						location.reload();
					}else{
						alert("예약삭제를 실패하였습니다. 다시시도하세요."); 
					} 
				}
				,error:function(e){
					console.log(e.responseText);
					$("#resultLayout").html("에러발생!"); 
				}
			}); 
		});
	});   
</script>
<div>
	<form name="assetsBookForm" id="assetsBookForm">
		<table class="table">
			<colgroup>
				<col style="width:2%;">
				<col style="width:5%;">
				<col style="width:8%;">
				<col style="width:8%;"> 
				<col style="width:15%;">   
				<col style=""> 
				<col style="width:10%;">
				<col style="width:10%;">
				<col style="width:10%;">
				<col style="width:10%;">  
			</colgroup>

			<thead class="thead-light">
				<tr>
					<th scope="col"><input type="checkbox" name="chkAll" id="chkAll" value="chkAll" onclick="checkAll();"></th>
					<th scope="col">번호</th>
					<th scope="col">예약코드</th>
					<th scope="col">예약이름</th>
					<th scope="col">연락처</th>
					<th scope="col">시설</th>
					<th scope="col">예약시간</th>
					<th scope="col">이용예정일</th>
					<th scope="col">예약한일자</th>
					<th scope="col">상태</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach var="dto" items="${list}">
					<tr>
						<td><input type="checkbox" name="chk" value="chk" onclick="chkSingle();" data-num="${dto.bookCode}" <c:if test="${dto.state!=0}">disabled="disabled"</c:if>></td>
						<td scope="row">${dto.listNum}</td> 
						<td>${dto.bookCode}</td>
						<td>${dto.name}</td> 
						<td>${dto.tel}</td>
						<td>${dto.facName}</td> 
						<td>${dto.bookTime==0?"오후":"종일"}</td>  
						<td>${dto.useDate}</td>
						<td>${dto.bookDate}</td>
						<td>${dto.state==0?"예약":(dto.state==1?"반납완료":(dto.state==2?"대여중":"기간만료"))}</td>  
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
				<td align="right" width="100">
					<button type="button" id="assetsDelete" name="assetsDelete" class="btn btn-default">예약삭제</button>
				</td>
		   </tr>
		</table>
	</form>
</div>