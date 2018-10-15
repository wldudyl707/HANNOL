<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>

var isIdChecked = false;
var isEmailChecked = false;

function idCheck() {
	var memberId = $("#memberId").val();
	
	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(memberId)) {  
		var str="아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.";
		$("#memberId").focus();
		$("#userIdSpan").html(str);
		return false;
	}
	
	var url = "<%=cp%>/member/userIdCheck";
	var type = "get";
	var query = "userId=" + memberId;
	
	
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success : function(data) {
			var state = data.passed;
			if(state=="true") { 
				isIdChecked = true; 
				var str="<span style='color:blue;font-weight: bold;'>"+memberId+"</span> 아이디는 사용가능 합니다.";
				$("#userIdSpan").html(str);
			} else if(state=="false") {
				var str="<span style='color:red;font-weight: bold;'>"+memberId+"</span> 아이디는 사용할수 없습니다.";
				$("#userIdSpan").html(str);
				$("#memberId").val("");
				$("#memberId").focus();
			}
		}
		,beforeSend : function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

var mode;

$(function() {
	mode = '${mode}';
	
	if(mode == 'update' && mode != null){
		var help = '${dto.help}';
		var strArray = help.split(",");
		for(var i = 0; i < strArray.length; i++){
			$("input[type=checkbox][class=" + strArray[i] + "]").prop("checked", "checked");
		}
	} else {
		isIdChecked = true;
		isEmailChecked = true;
	}
	
	$("select[name=selectEmail]").change(function () {
		var val = $("select[name=selectEmail] option:selected").val(); 
		if(val!='direct'){
			$("input[name=email2]").val(val);
			$("input[name=email2]").attr("readonly", true); 
			return;
		}
		$("input[name=email2]").attr("readonly", false); 
	});
});



function emailCheck() {
	var f = document.memberForm;
	var str;
	
    str = f.email1.value;
    if(!str) {
        f.email1.focus();
        return false;
    }

    str = f.email2.value;
    if(!str) {
        f.email2.focus();
        return false;
    }

    var email = f.email1.value + "@" + f.email2.value;
    
	var url = "<%=cp%>/member/userEmailCheck";
	var type = "get";
	var query = "email=" + email;
	
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success : function(data) {
			var state = data.passed;
			if(state=="true") { 
				isEmailChecked = true; 
				var str="<span style='color:blue;font-weight: bold;'>"+email+"</span> 이메일은 사용가능 합니다.";
				$("#emailSpan").html(str);
			} else if(state=="false") {
				var str="<span style='color:red;font-weight: bold;'>"+email+"</span> 이메일은 사용할수 없습니다.";
				$("#emailSpan").html(str);
				$("#email1").val("");
				$("#email2").val("");
				$("#email1").focus();
			}
		}
		,beforeSend : function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

function memberOk() {
	var f = document.memberForm;
	var str;
	
	str=f.memberId.value;
	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) { 
		f.memberId.focus();
		return false;
	}
	
	if(mode=='created' && isIdChecked==false){
		var str="<span style='color:red;font-weight: bold;'>아이디 중복여부를 확인하세요.</span>";
		$("#userIdSpan").html(str);
		f.memberId.focus();
		return false;
	}
	
	str = f.memberPwd.value;
	if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) { 
		f.memberPwd.focus();
		return false;
	}
	
	if(f.userPwdCheck.value != str) {
		$("#userPwdCheck + .help-block").html("패스워드가 일치하지 않습니다.");
		f.userPwdCheck.focus();
		return false;
	} else {
		$("#userPwdCheck + .help-block").html("패스워드를 한번 더 입력해주세요.");
	}
	
    str = f.memberName.value;
	str = $.trim(str);
    if(!str) {
        f.memberName.focus();
        return false;
    }
    f.memberName.value = str;

    str = f.email1.value;
    if(!str) {
        f.email1.focus();
        return false;
    }

    str = f.email2.value;
    if(!str) {
        f.email2.focus();
        return false;
    }

	if(mode=='created' && isEmailChecked==false){
		var str="<span style='color:red;font-weight: bold;'>이메일 중복여부를 확인하세요.</span>";
		$("#emailSpan").html(str);
		f.email1.focus();
		return false;
	}

    str = f.post.value;
    if(!str) {
        f.post.focus();
        return false;
    }
	
    str = f.addr1.value;
    if(!str) {
        f.addr2.focus();
        return false;
    }
	
    str = f.addr2.value;
    if(!str) {
        f.addr2.focus();
        return false;
    }
	
    str = f.tel1.value;
    if(!str) {
        f.tel1.focus();
        return false;
    }

    str = f.tel2.value;
    if(!/^(\d+)$/.test(str)) {
        f.tel2.focus();
        return false;
    }

    str = f.tel3.value;
    if(!/^(\d+)$/.test(str)) {
        f.tel3.focus();
        return false;
    }

    str = f.birth.value;
    if(!isValidDateFormat(str)) {
        f.birth.focus();
        return false;
    }

/* 	str = f.emailChk.value;
    if(!str) {
        f.emailChk.focus();
        return false;
    } */
    

    var mode="${mode}";
    if(mode=="created") {
    	str = f.agree.value;
        if(!str) {
            f.agree.focus();
            return false;
        }
        
    	f.action = "<%=cp%>/member/member";
    } else if(mode=="update") {
    	f.action = "<%=cp%>/member/update";
    }
    
    f.submit();
}


function execPostCode() {
    new daum.Postcode({
        oncomplete: function(data) {
           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

           // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
           var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
           var extraRoadAddr = ''; // 도로명 조합형 주소 변수

           // 법정동명이 있을 경우 추가한다. (법정리는 제외)
           // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
           if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
               extraRoadAddr += data.bname;
           }
           // 건물명이 있고, 공동주택일 경우 추가한다.
           if(data.buildingName !== '' && data.apartment === 'Y'){
              extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
           }
           // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
           if(extraRoadAddr !== ''){
               extraRoadAddr = ' (' + extraRoadAddr + ')';
           }
           // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
           if(fullRoadAddr !== ''){
               fullRoadAddr += extraRoadAddr;
           }

           $("[name=post]").val(data.zonecode);
           $("[name=addr1]").val(fullRoadAddr);
       }
    }).open();
}
</script>


<div class="body-container"> 
    <div class="body-title">
        <h3><span style="font-family: Webdings">2</span> ${mode=="created"?"회원 가입":"회원 정보"} </h3>
    </div>
    
    <div>
		<form name="memberForm" method="post">
			<h4 class="joinSubTitle">기본 정보</h4>
			
			<div align="center" style="padding: 50px;">
				<c:if test="${mode=='update'}">
						<div style="width:30%;" class="text-center"> 
					    	<span class="glyphicon glyphicon-heart-empty"></span><h3><mark>${dto.memberName}</mark>님의 2018년 회원등급</h3><br>
					    	<img alt="" src="<%=cp%>/resource/images/first.jpg"" style="padding: 10px;"><br>
					    	<button class="btn btn-default .btn-sm" onclick="">구매 등급정보</button>
						</div>
				</c:if>
			</div>
			
		  <table class="joinTable">
			  <tr>
					<th>
						<label>아이디</label>
					</th>
					<td>
			        <p>
			            <input type="text" name="memberId" id="memberId" value="${dto.memberId}"
	                        ${mode=="update" ? "readonly='readonly' ":""}
	                        maxlength="15" class="boxTF" placeholder="아이디">
				        <button type="button" class="btn1" onclick="idCheck()">아이디 중복확인</button>
			        	<span class="help-block" id="userIdSpan">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</span>
			        </p>
			      </td>
			  </tr>
			
			  <tr>
			      <th>
			      	<label>비밀번호</label>
			      </th>
			      <td>
			        <p>
			            <input type="password" name="memberPwd" maxlength="15" class="boxTF"
			                       placeholder="비밀번호">
			        	<span class="help-block">비밀번호는 5~10자 이내이며, 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</span>
			        </p>
			      </td>
			  </tr>
			
			  <tr>
			      <th>
			            <label>비밀번호 확인</label>
			      </th>
			      <td>
			        <p>
			            <input type="password" name="userPwdCheck" maxlength="15" class="boxTF"
			                       placeholder="비밀번호 확인">
			            <span class="help-block">비밀번호를 한번 더 입력해주세요.</span>
			        </p>
			      </td>
			  </tr>
			  
			  <tr>
			      <th>
			            <label>이름</label>
			      </th>
			      <td>
			        <p>
			            <input type="text" name="memberName" value="${dto.memberName}" maxlength="30" class="boxTF"
		                      
		                      ${mode=="update" ? "readonly='readonly' ":""}
		                      placeholder="이름">
			        </p>
			      </td>
			  </tr>
			
			  <tr>
			      <th>
			            <label>이메일</label>
			      </th>
			      <td>
			        <p>
			            <input type="text" name="email1" value="${dto.email1}" size="13" maxlength="30"  class="boxTF"
			            	${mode=="update" ? "readonly='readonly' ":""}>
			            @ 
			            <input type="text" name="email2" value="${dto.email2}" size="13" maxlength="30"  class="boxTF" readonly="readonly">
			        	<select name="selectEmail" class="selectField">
			                <option value="">선 택</option>
			                <option value="naver.com" ${dto.email2=="naver.com" ? "selected='selected'" : ""}>네이버 메일</option>
			                <option value="hanmail.net" ${dto.email2=="hanmail.net" ? "selected='selected'" : ""}>한 메일</option>
			                <option value="hotmail.com" ${dto.email2=="hotmail.com" ? "selected='selected'" : ""}>핫 메일</option>
			                <option value="gmail.com" ${dto.email2=="gmail.com" ? "selected='selected'" : ""}>지 메일</option>
			                <option value="direct">직접입력</option>
			            </select>
			            <button type="button" class="btn1" onclick="emailCheck()">이메일 중복확인</button>
			        </p> 
		            <span class="help-block" id="emailSpan">이메일 중복여부를 확인해주세요.</span>
			      </td>
			  </tr>
			  
			  <tr>
			      <th>
			            <label>우편번호</label>
			      </th>
			      <td>
			        <p>
			            <input type="text" name="post" value="${dto.post}"
			                       class="boxTF" readonly="readonly">
			            <button type="button" class="btn" onclick="execPostCode();" >우편번호</button>          
			        </p>
			      </td>
			  </tr>
			  
			  <tr>
			      <th>
			            <label>주소</label>
			      </th> 
			      <td>
			        <p>
			            <input type="text" name="addr1" value="${dto.addr1}" maxlength="50" 
			                       class="boxTF" style="width: 80%;" placeholder="기본 주소" readonly="readonly">
			        </p>
			        <p>
			            <input type="text" name="addr2" value="${dto.addr2}" maxlength="50" 
			                       class="boxTF" style="width: 80%;" placeholder="나머지 주소">
			        </p>
			      </td>
			  </tr> 
			  
			  
			  <tr>
			      <th>
			            <label>전화번호</label>
			      </th>
			      <td>
			        <p>
			            <select class="selectField" id="tel1" name="tel1" >
			                <option value="">선 택</option>
			                <option value="010" ${dto.tel1=="010" ? "selected='selected'" : ""}>010</option>
			                <option value="011" ${dto.tel1=="011" ? "selected='selected'" : ""}>011</option>
			                <option value="016" ${dto.tel1=="016" ? "selected='selected'" : ""}>016</option>
			                <option value="017" ${dto.tel1=="017" ? "selected='selected'" : ""}>017</option>
			                <option value="018" ${dto.tel1=="018" ? "selected='selected'" : ""}>018</option>
			                <option value="019" ${dto.tel1=="019" ? "selected='selected'" : ""}>019</option>
			            </select>
			            -
			            <input type="text" name="tel2" value="${dto.tel2}" class="boxTF telTF" maxlength="4">
			            -
			            <input type="text" name="tel3" value="${dto.tel3}" class="boxTF telTF" maxlength="4">
			        </p>
			      </td>
			  </tr>
			  
			  <tr>
			      <th>
			           <label>생년월일</label>
					</th>
			      <td>
			        <p>
			            <input type="text" name="birth" value="${dto.birth}" maxlength="10" 
			                       class="boxTF" placeholder="생년월일">
			            <span class="help-block">생년월일은 2000-01-01 형식으로 입력 합니다.</span>
			        </p>
			        
			      </td>
			  </tr>
			  <tr>
                <th>
                     <label>우대조건</label>
               </th>
               <td>
                  <p>
                     <input type="checkbox" name="help" class="chk1" value="chk1">장애인
                     <input type="checkbox" name="help" class="chk2" value="chk2">어르신
                     <input type="checkbox" name="help" class="chk3" value="chk3">국가유공자 
               </td>
           </tr>
		</table>
			
<!-- 		<h4 class="joinSubTitle">부가 정보 입력</h4>
			<table class="joinTable"> 
				<tr>
					<th><label>이메일 수신여부</label></th>
					<td>
						<input type="radio" name="emailChk" value="email_chk" checked="checked">수신 
						<input type="radio" name="emailChk" value="email_nochk">수신거부
					</td>
				</tr>
			</table> -->
						
			<c:if test="${mode=='created'}">
				<table class="joinTable"> 
					<tr>
						<th><label>약관 동의</label></th>
						<td>
							<input id="agree" name="agree" type="checkbox" checked="checked"
			                         onchange="form.sendButton.disabled = !checked"> <a href="#">이용약관</a>에 동의합니다.
						</td>
					</tr>
				</table>
			</c:if> 
			
			<table style="width: 100%; margin: 50px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" >
			        <button type="button" name="sendButton" class="btn2 btnBlue" onclick="memberOk();">${mode=="created"?"회원가입":"정보수정"}</button>
			        <button type="reset" class="btn2">다시입력</button>
			        <button type="button" class="btn2" onclick="javascript:location.href='<%=cp%>/';">${mode=="created"?"가입취소":"수정취소"}</button>
			        
			        <c:if test="${mode == 'update'}">
				        <button type="button" class="btn2 btn-danger" onclick="javascript:location.href='<%=cp%>/member/pwd?dropout';">회원탈퇴</button>
			        </c:if>
			        
			      </td>
			    </tr>
			    <tr height="30">
			        <td align="center" style="color: blue;">${message}</td>
			    </tr>
		  </table>
		</form>
	</div>
</div>
