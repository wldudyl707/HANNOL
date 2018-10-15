<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>
.topArea{
	background: url('<%=cp%>/resource/images/magicpass.jpg') no-repeat center 0;
	padding: 130px 0;
	text-align: center;
	color: #fff;
}

.tit{
	font-size: 40px;
	font-weight: bold;
}

.txt{
	font-size: 16px;
	line-height: 26px;
	margin-top: 30px;
}

.note{
	border: 1px solid #e1e1e1;
    background: #f8f8f8;
    padding: 20px;
    margin-top: 30px;
}
</style>

<script type="text/javascript">
$(function(){
	var msg = "${msg}";
	if(msg !=""){
		alert(msg);
	}
});
</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-tower"></span> 매직패스 </h3>
    </div>
    
    <div>
        <div class="topArea">
        	<p class="tit">매직패스란(MAGICPASS)?</p>
        	<p class="txt">
        		HANNOL 어드벤처만의 어트랙션 탑승 예약 서비스이며<br>
        		인기있는 어트랙션들을 짧은 대기시간으로 즐기면서 보다 편하게, 보다 알차게 모험을 즐기세요!
        	</p>
        </div>
    </div>
    
    <div class="note">
    	<p style="font-size: 20px; font-weight: bold;">꼭 알아두세요</p>
    	<p style="margin-top: 30px; font-size: 16px;">매직패스는 매직패스가 결합된 당일 입장 티켓과 연간회원권에 한해 이용 가능합니다.</p>
    	<p style="margin-top: 10px; font-size: 16px;">각 어트랙션별 예약 가능한 매직패스는 한전되어 있으며, 일부 어트랙션은 조기에 예약이 종료될 수 있습니다.</p>
    	<p style="margin-top: 10px; font-size: 16px;">예약은 한 시간당 한 번만 가능합니다.</p>
    	<p style="margin-top: 10px; font-size: 16px;">예약된 시간 외에는 어트랙션을 탑승하실 수 없습니다.</p>
    	<p style="margin-top: 10px; font-size: 16px;">상황에 따라 일부 어트랙션은 매직페스 제도를 예고 없이 시행하지 않을 수 있습니다.</p>
    	<p style="margin-top: 10px; font-size: 16px;">모든 어트랙션이 매직패스 제도를 시행하는 것이 아닙니다.</p>
    </div>
</div>