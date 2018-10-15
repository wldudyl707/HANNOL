<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.lbl {
   position:absolute; 
   margin-left:15px; margin-top: 17px;
   color: #999999; font-size: 11pt;
}
.loginTF {
  width: 300px; height: 35px;
  padding: 5px;
  padding-left: 15px;
  border:1px solid #999999;
  color:#333333;
  margin-top:5px; margin-bottom:5px;
  font-size:14px;
  border-radius:4px;
}
.loginwithkakao {
	cursor: pointer;
}
</style>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
function bgLabel(ob, id) {
    if(!ob.value) {
	    document.getElementById(id).style.display="";
    } else {
	    document.getElementById(id).style.display="none";
    }
}

function sendLogin() {
    var f = document.loginForm;

	var str = f.userId.value;
    if(!str) {
        alert("아이디를 입력하세요. ");
        f.userId.focus();
        return;
    }

    str = f.userPwd.value;
    if(!str) {
        alert("패스워드를 입력하세요. ");
        f.userPwd.focus();
        return;
    }

    f.action = "<%=cp%>/member/login";
    f.submit();
}

var memberId;
var memberName;
var email;

Kakao.init('5b33a44dcabba4ece4cb2555523ab8af');
function loginWithKakao() {
      Kakao.Auth.login({										// 로그인 - 사용자가 앱에 로그인할 수 있도록 로그인 팝업창을 띄우는 함
          success: function(authObj) {
	          Kakao.API.request({									// 로그인 성공 시 유저 정보를 요구
	                url: '/v2/user/me',
	                success: function(res) {
	             	    console.log(JSON.stringify(res));

	             	    memberId = res.id;
	             	    memberName = res.properties.nickname;
	             	    email= res.kakao_account.email;
	             	    //alert(memberId + "::" + memberName + "::" + email);
	             	    
<%-- 	                    var query = "memberId=" + memberId + "&memberName=" + memberName + "&email=" + email;
	                    alert(query);
  	              	    location.href = "<%=cp%>/member/kakao_oauth?" + query;
 --%>
	             	    
		                /* $.ajax({
		                      type:"post",
		               		  dataType:"json",
		                      url:"/indb.jsp",
		                      data : {
		                         "email":res.kaccount_email,
		                         "id":res.id,
		                         "nickname":res.properties.nickname,
		                      },
		                      success:function(data){
		                       	 if(data.login == "success"){
		                           alert("로그인되었습니다");
		                           location.href="/";					// 로그인 이후 
		                       	 }
		                      },
		                      error:function(data){
		                         alert('error:'+data.result);
		                      }
		                }); */
	                },
	                fail: function(error) {
	                  alert(JSON.stringify(error));
	                }
	              });
	         },
         fail: function(err) {
              alert(JSON.stringify(err));
         }
      });
      

};
</script>

<div class="body-container">
    <div style="margin: 0px auto; padding-top:100px; width:440px;" align="center">
		<form name="loginForm" method="post" action="">
		  <table style="margin: 15px auto; width: 360px; border-spacing: 0px;" >
		  <tr align="center"> 
		      <td height="60"> 
		        <input type="text" name="userId" id="userId" class="loginTF" maxlength="15"
		                   tabindex="1"
                           onfocus="document.getElementById('lblUserId').style.display='none';"
                           onblur="bgLabel(this, 'lblUserId');" style="border: none; border-bottom: 1px solid #ccc" placeholder="아이디">
		      </td>
		      <td rowspan="2">
		        <button type="button" onclick="sendLogin();" class="btnConfirm">로그인</button>
		      </td>
		  </tr>
		  <tr align="center" height="60"> 
		      <td>
		        <input type="password" name="userPwd" id="userPwd" class="loginTF" maxlength="20" 
		                   tabindex="2"
                           onfocus="document.getElementById('lblUserPwd').style.display='none';"
                           onblur="bgLabel(this, 'lblUserPwd');" style="border: none; border-bottom: 1px solid #ccc" placeholder="패스워드">
		      </td>
		  </tr>

		  <tr align="center" height="45">
		      <td colspan="2">
		       		<a href="<%=cp%>/">아이디찾기</a>
		       		&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
		       		<a href="<%=cp%>/">패스워드찾기</a>
		      </td>
		  </tr>
 		  <tr align="center" height="45">
		      <td colspan="2">
		      		<img class="loginwithkakao" alt="" src="<%=cp%>/resource/images/kakao_account_login_btn_medium_narrow_ov.png" onclick="javascript:loginWithKakao()">
		      </td>
		  </tr>
		  
		  
		  
		  <tr align="center" height="40" >
		    	<td><span style="color: blue;">${message}</span></td>
		  </tr>
		  </table>
		</form>           
	</div>
</div>

<a id="kakao-login-btn"></a>
<a href="http://developers.kakao.com/logout"></a>
<script type='text/javascript'>
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('5b33a44dcabba4ece4cb2555523ab8af');
    // 카카오 로그인 버튼을 생성합니다.
    Kakao.Auth.createLoginButton({
      container: '#kakao-login-btn',
      success: function(authObj) {
        alert(JSON.stringify(authObj));
      },
      fail: function(err) {
         alert(JSON.stringify(err));
      }
    });
  //]]>
</script>