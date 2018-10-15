<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
function deleteGuide(data) {
		var query = "${query}";
		var url = "<%=cp%>/guide/delete?" + query+"&usersCodeM=${dto.usersCodeM}";
		
		if(confirm("위 자료를 삭제 하시 겠습니까 ? ")) {
				location.href=url;
		}
}

function bookGuide(){
	
	 var url = "<%=cp%>/guide/book?mode=created&schCode=${dto.schCode}";
	
	location.href=url; 
}

function sendOk() {
	
    var f = document.infoForm;
    
    var str = f.nameM.value;
    if(!str) {
        alert("예약자 이름을 입력하세요. ");
        f.nameM.focus();
        return;
    }

	str = f.tel.value;
    if(!str) {
        alert("예약자 연락처를 입력하세요. ");
        f.tel.focus();
        return;
    }
    
	f.action="<%=cp%>/guide/createBook?schCode=${dto.schCode}";
    f.submit(); 
}
</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-tower"></span> 가이드 예약</h3>
    </div>
    
    <div style="width: 900px; border-spacing: 0px;">
		<form  name="infoForm" id="infoForm" method="post" >

			<div style="float: left; width: 40%">
				
				<div class="form-group" style="margin: 60px auto 0px;">
					<label for="workDate" class="col-sm-5 control-label text-right"><mark>*</mark>&nbsp;근무일자</label>
					<div class="col-sm-7">
						<input type="text" name="workDate" class="form-control input-sm"
							id="workDate" placeholder="근무일자" value="${dto.workDate}" disabled="disabled"
							readonly="readonly">
					</div>
				</div>
				
				<br>
				<div class="form-group" style="margin: 20px auto 0px;">
					<label for="timezoneInfo" class="col-sm-5 control-label text-right"><mark>*</mark>&nbsp;구분</label>
					<div class="col-sm-7">
							<input type="text" class="form-control input-sm"
								id="timezoneInfo" placeholder="(오전/오후)" value="${dto.timezone==1?'오전':'오후'}" readonly="readonly">
					</div>
				</div>
				<br>
				<div class="form-group" style="margin: 20px auto 0px;">
					<label for="role" class="col-sm-5 control-label text-right"><mark>*</mark>&nbsp;역할</label>
					<div class="col-sm-7">
							<input type="text" name="role"
								class="form-control input-sm" id="role" placeholder="역할"
								value="${dto.role}" readonly="readonly">
					</div>
				</div>
				<br>
				<div class="form-group" style="margin: 20px auto 0px;">
					<label for="memo" class="col-sm-5 control-label text-right"><mark>*</mark>&nbsp;상세정보</label>
					<div class="col-sm-7">
							<input type="text" name="memo"
								class="form-control input-sm" id="memo" placeholder="상세정보"
								value="${dto.memo}" readonly="readonly">
					</div>
				</div>
				<br>
			</div>

				<div style="width: 30%; float: left;" class="text-center">
					<img alt="" src="<%=cp%>/resource/images/${roleImg}"
						style="padding: 10px; margin-top: 10px; width: 200px; height: 250px;"><br>
				</div>



			<!-- 여기부터 예약자가 입력하기 -->
			<div style="clear: both"></div>
			
			<c:if test="${mode=='created'}">
				<div>
			
				<div class="form-group"
					style="margin: 20px auto 0px; border-spacing: 0px;">
					<label for="memberId" class="col-sm-2 control-label text-right">예약자회원아이디</label>
					<div class="col-sm-6" style="padding: 0 0 15px 15px;">
							<input type="text" class="form-control" name="memberId"
								placeholder="예약자회원아이디" value="${dto.memberId}"
								style='border: none;' readonly="readonly">
					</div>
				</div>

				<br>
				<br>

				<div class="form-group"
					style="margin: 20px auto 0px; border-spacing: 0px;">
					<label for="nameM" class="col-sm-2 control-label text-right">예약자이름</label>
					<div class="col-sm-6" style="padding: 0 0 15px 15px;">
							<input type="text" class="form-control" name="nameM"
								placeholder="예약자이름" value="${dto.nameM}"
								style='border: none;'>
					</div>
				</div>

				<br>
				<br>
				
				<div class="form-group"
					style="margin: 20px auto 0px; border-spacing: 0px;">
					<label for="tel" class="col-sm-2 control-label text-right">예약자 연락처</label>
					<div class="col-sm-6" style="padding: 0 0 15px 15px;">
							<input type="text" class="form-control" name="tel"
								placeholder="연락처" value="${dto.tel}" 
								style='border: none;'>
					</div>
				</div>

				<br>
				<br>

				<div class="form-group"
					style="margin: 20px auto 0px; border-spacing: 0px;">
					<label for="bookDate" class="col-sm-2 control-label text-right">예약일자</label>
					<div class="col-sm-6" style="padding: 0 0 15px 15px;">
							<input type="text" class="form-control" name="bookDate" id="bookDate"
								placeholder="예약후 자동으로 생성됩니다" value="${dto.bookDate}" 
								style='border: none;' readonly="readonly">
					</div>
				</div>
				
				<br><br>
				<br>
				
				<input type="hidden" id="usersCode" name="usersCode" value="${dto.usersCode }">
				<input type="hidden" id="usersCodeM" name="usersCodeM" value="${dto.usersCodeM }">
				

				<table style="margin: 0px auto; border-spacing: 0px;">
					<tr height="30">
						<td align="center">
							<c:if test="${mode=='created'}">
								
								<button type="button" name="sendButton" class="btn btn-default"
									onclick="sendOk();">입력확인</button>
							</c:if>
							
							<button type="button" class="btn btn-default"
								onclick="javascript:location.href='<%=cp%>/guide/list?${query }';">리스트</button>
						</td>
					</tr>
					<tr height="30">
						<td align="center" style="color: blue;">${message}</td>
					</tr>
				</table>

			</div>
			</c:if>
			
			

			<c:if test="${mode=='info'}">
				<div>
			
				<div class="form-group"
					style="margin: 20px auto 0px; border-spacing: 0px;">
					<label for="memberId" class="col-sm-2 control-label text-right">예약자회원아이디</label>
					<div class="col-sm-6" style="padding: 0 0 15px 15px;">
							<input type="text" class="form-control" id="memberId" 
								placeholder="예약자회원아이디" value="${dto.usersCodeM==0?'없음':dto.memberId}" readonly="readonly"
								style='border: none;'>
					</div>
				</div>

				<br>
				<br>

				<div class="form-group"
					style="margin: 20px auto 0px; border-spacing: 0px;">
					<label for="nameM" class="col-sm-2 control-label text-right">예약자이름</label>
					<div class="col-sm-6" style="padding: 0 0 15px 15px;">
							<input type="text" class="form-control" id="nameM" 
								placeholder="예약자이름" value="${dto.nameM}" readonly="readonly"
								style='border: none;'>
					</div>
				</div>

				<br>
				<br>
				
				<div class="form-group"
					style="margin: 20px auto 0px; border-spacing: 0px;">
					<label for="tel" class="col-sm-2 control-label text-right">예약자 연락처</label>
					<div class="col-sm-6" style="padding: 0 0 15px 15px;">
							<input type="text" class="form-control" id="tel"
								placeholder="연락처" value="${dto.tel}" readonly="readonly"
								style='border: none;'>
					</div>
				</div>

				<br>
				<br>

				<div class="form-group"
					style="margin: 20px auto 0px; border-spacing: 0px;">
					<label for="bookDate" class="col-sm-2 control-label text-right">예약일자</label>
					<div class="col-sm-6" style="padding: 0 0 15px 15px;">
							<input type="text" class="form-control" id="bookDate" 
								placeholder="예약일자" value="${dto.bookDate}" readonly="readonly"
								style='border: none;'>
					</div>
				</div>
				
				<br><br>
				<br>
				
				<input type="hidden" id="usersCode" name="usersCode" value="${dto.usersCode }">
				<input type="hidden" id="usersCodeM" name="usersCodeM" value="${dto.usersCodeM }">
				<input type="hidden" id="timezone" name="timezone" value="${dto.timezone }">
				<input type="hidden" id="schCode" name="schCode" value="${dto.schCode }">
				

				<table style="margin: 0px auto; border-spacing: 0px;">
					<tr height="30">
						<td align="center">
							<c:if test="${dto.usersCodeM==''}">
								<button type="button" name="bookButton" class="btn btn-default"
									onclick="bookGuide('${dto.schCode}');">예약하기</button>
							</c:if>
							
							<button type="button" class="btn btn-default"
								onclick="javascript:location.href='<%=cp%>/guide/list?${query }';">리스트</button>
						</td>
					</tr>
					<tr height="30">
						<td align="center" style="color: blue;">${message}</td>
					</tr>
				</table>

			</div>
			</c:if>
			
			

			<div id="resultStaff"></div>
		</form>

	</div>
</div>