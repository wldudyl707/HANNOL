<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<footer class="bs-docs-footer" role="contentinfo">
	<div class="footer_top nounderline">
		<a href="<%=cp%>/company/info">테마파크 소개</a>&nbsp;&nbsp;&nbsp; <a href="<%=cp%>/company/way">오시는길</a>&nbsp;&nbsp;&nbsp;<a href="#">제휴 및 입점 문의</a>&nbsp;&nbsp;&nbsp;
		<a href="#">이용약관</a>&nbsp;&nbsp;&nbsp; <a href="#"
			style="color: tomato;">개인정보취급방침</a>&nbsp;&nbsp;&nbsp; <a href="<%=cp%>/faq/list">고객센터</a>&nbsp;&nbsp;&nbsp;
		<a href="<%=cp%>/notice/list">채용 및 공지</a>&nbsp;&nbsp;&nbsp; <a href="#">사이트맵</a>&nbsp;&nbsp;&nbsp;
	</div>

	<div align="center" style="clear: both; display: block;">
		<div style="width: 50%;">
			<div style="float: left;">
				<p>
					<img width="100px;" src="<%=cp%>/resource/images/footericon.png" style="margin-top: 20px; margin-right: 30px;">
				</p>
			</div>
			<div style="margin-top: 20px;" align="left" class="subfooter">
				<p>
					<span>서울특별시 마포구 서교동 447-5 한놀 어드벤처</span> 
					<span>대표   : 이지영</span>
				</p>
				<p>
					<span>사업자등록번호 : 219-85-00014</span> 
					<span>통신판매업신고번호   : 송파 제5513호</span><br> 
					<span>전화 : 1661-2000</span>
				</p>
				<p style="float: left; margin-top: 15px;" align="left">
					<span>COPYRIGHT 2018 HANNOL. ALL RIGHTS RESERVED.</span>
				</p>
			</div>
		</div>
	</div>
</footer>
