<%@page import="java.util.Dictionary"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
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

<script type="text/javascript">
function validOk() {
    var f = document.questionForm;
    
    var str = $("#gubun option:checked").val();
    if(!str) {
        $("#gubun").focus();
        return;
    }

	var str = f.subject.value;
    if(!str) {
        f.subject.focus();
        return;
    }
    
    var str = f.content.value;
    if(!str) {
        f.content.focus();
        return; 
    }

    if($("input:checkbox[id='aler']").is(":checked") == false){
    	$("#alerCheck").show();
    	return;
    }
    
	f.action="<%=cp%>/question/insertQuestion";
    f.submit();
}

$(function(){
	$("input:checkbox[id='aler']").click(function(){
		if($("input:checkbox[id='aler']").is(":checked")){
			$("#alerCheck").hide();
		}
	});
});
</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-pencil"></span> 1:1문의 </h3>
    </div>
    
    <div>
    	<img width="100%" src="<%=cp%>/resource/images/questionInfo.png">
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
						<select id="gubun" name="gubun">
							<option value="">:::문의유형:::</option>
							<option value="요금 문의">요금 문의</option>
							<option value="제휴 할인">제휴 할인</option>
							<option value="온라인 예매">온라인 예매</option>
							<option value="연간 회원">연간 회원</option>
							<option value="예약 문의">예약 문의</option>
							<option value="기타 문의">기타 문의</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" id="subject" name="subject" style="height: 30px; width: 100%;">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea id="content" name="content" rows="12" style="width: 100%; resize: none;"></textarea>
					</td>
				</tr>
		  </tbody>
		</table>
		
		<table class="custom_table">
			<tr>
				<td class="td_custom">
					<label>개인정보 수집, 이용동의서</label>
				</td>
			</tr>
			<tr>
				<td align="left">
					<textarea rows="8" style="width: 100%; resize: none; text-align: left; white-space: pre-line; padding-left: 15px;" readonly="readonly" disabled="disabled">
						개인 정보 수집, 이용 동의서
						본인은 방문 전 이용문의 작성과 관련하여 귀사가 아래와 같이 본인의 개인정보를 수집, 이용하는데 동의합니다.
						
						개인정보 수집, 이용에 관한 사항
						1.개인정보의 수집, 이용 목적
						   고객의 요청ㆍ문의사항 확인, 사실조사를 위한 연락ㆍ통지, 처리결과 통보 등의 목적
						
						2.수집하는 개인정보의 항목
						   ㆍ서비스 이용과정이나 사업처리 과정에서 아래와 같은 정보들이 생성되어 수집될 수 있습니다.
						   접속로그, 쿠키, 접속IP정보
						
						3.개인정보의 보유, 이용기간
						   수집, 이용에 관한 동의일로부터 1년(이후에는 제목, 작성 내용만 보관됩니다.)
						
						※ 귀하는 개인정보 수집, 이용에 대한 동의를 거부하실 권리가 있으며, 동의를 거부하실 경우 서비스 이용이 제한됩니다.
					</textarea>
				</td>
			</tr>
			<tr>
				<td>
					<input id="aler" name="aler" type="checkbox" style="vertical-align: middle;"><label style="margin-left: 5px;">개인정보 수집 및 이용에 동의합니다.</label>
				</td>
			</tr>
		</table>
		<div id="alerCheck" style="display: none;"><span style="color: red; margin-top: 5px; margin-left: 15px;">구매조건 확인 및 결제대행 서비스 약관에 동의하셔야 합니다.</span></div>	
		<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
			<tr height="40">
		    	<td align="center" width="100" class="td_custom">
		          	<button type="button" class="btn btn-info" style="font-weight: bold;" onclick="validOk();">문의하기</button>
		     	 	<button type="reset" class="btn btn-default" data-dismiss="modal" style="font-weight: bold;" onclick="isTermsCheck();">취소하기</button>
		     	</td>
		   	</tr>
		</table>
	</form>
    </div>
</div>   