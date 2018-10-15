<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<style>
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
    width: 100%;
    border-top: 2px solid #cecece;
    margin-top: 15px;
}

select {
    height: 30px;
    font-size: 12px;
    vertical-align: middle;
}

th {
    width: 25%;
    border: solid #e4e4e4;
    border-width: 0 1px 1px 0;
    padding: 7px 10px 7px 15px;
    font-weight: bold;
    text-align: left;
    background: #f4f4f4;
}

td {
	width: 75%;
    border-bottom: 1px solid #e4e4e4;
    padding: 10px 16px;
}

.td_custom {
	width: 75%;
	border-bottom: #ffffff;
    padding: 10px 16px;
}
</style>

<script>
$("body").on("click", "#delete", function(){
	$("#deleteModal").modal();
});
</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-pencil"></span> 문의내역</h3>
    </div>

    <div align="center">
    <form name="questionForm" method="post">
    	<table class="custom_table">
		    <colgroup width="144">
		    </colgroup>
		  
		  <tbody>
				<tr>
					<th>문의유형</th>
					<td>
						${dto.gubun}
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						${dto.subject}
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td align="left" valign="top" height="300">
						${dto.content}
					</td>
				</tr>
		  </tbody>
		</table>
		
		<div style="display: none;" id="deleteModal" role="dialog" class="modal" tabindex="-1">
					<div class="modal-dialog modal-sm">
						<div class="modal-content">
		    				<div class="modal-header">
 								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
  								<span aria-hidden="true">×</span></button>
 								<div align="center">
 									<h5 class="modal-title" id="myModalLabel">해당 문의글을 삭제하시겠습니까?</h5>
 								</div>
							</div>
							<div class="modal-body">
									<div align="center" style="margin: 30px auto;">
										<p>[${dto.gubun}]</p>
										<p>${dto.subject}</p>
									</div>
									<div align="center" style="width: 100%; margin: 30px auto; border-spacing: 0px;">
		   								<button id="deleteButton" type="button" class="btn btn-info" style="font-weight: bold;" onclick="javascript:location.href='<%=cp%>/mypage/questionDelete?num=${dto.qnaCode}&page=${page}';">삭제</button>
		     	 						<button type="button" class="btn btn-default" data-dismiss="modal" style="font-weight: bold;">취소</button>
									</div>
							</div>
						</div>
					</div>
				</div>
		
		<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
			<tr height="40">
			    <td width="300" align="left" class="td_custom">
			    <c:if test="${usersCode == dto.usersCode}">
			         <button type="button" class="btn btn-default" style="font-weight: bold;" onclick="javascript:location.href='<%=cp%>/mypage/questionModify?num=${dto.qnaCode}&page=${page}';">수정하기</button>
			         <button id="delete" type="button" class="btn btn-default" style="font-weight: bold;">삭제하기</button>
			    </c:if>
			    </td>
			
			    <td align="right" class="td_custom">
			        <button type="reset" class="btn btn-default" data-dismiss="modal" style="font-weight: bold;" onclick="javascript:location.href='<%=cp%>/mypage/question?page=${page}';">리스트</button>
			    </td>
			</tr>
		</table>
	</form>
	
	<c:if test="${not empty adminAnswer}">
	<table class="custom_table">
		    <colgroup width="144">
		    </colgroup>
		  
		  <tbody>
				<tr>
					<th>답변</th>
					<td align="left" valign="top" height="100">
						${adminAnswer.content}
					</td>
				</tr>
		  </tbody>
	</table>
	</c:if>
    </div>
</div>