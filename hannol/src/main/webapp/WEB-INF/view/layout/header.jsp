<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<div class="container"> 
    <div id="page-header">
        <div class="header-brand"><a href="<%=cp%>/"><img src="<%=cp%>/resource/images/hannol_logo.jpg" alt="로고"/></a></div>
				
        <div class="login header-login">
            <c:if test="${empty sessionScope.member}">
                <a href="<%=cp%>/member/login"><span class="glyphicon glyphicon-log-in"></span> 로그인</a> <i></i>
                <a href="<%=cp%>/member/member"><span class="glyphicon glyphicon-user"></span> 회원가입</a> 
            </c:if>
            <c:if test="${not empty sessionScope.member}">
                <span style="color:blue;">${sessionScope.member.memberName}</span>님 <i></i>
                <c:if test="${sessionScope.member.memberId=='admin'}">
                    <a href="#">관리자</a> <i></i>
                </c:if>
            	<a href="<%=cp%>/mypage/couponList">마이페이지</a><i></i>
            	<a href="<%=cp%>/giftshop/cart"><span class="glyphicon glyphicon-shopping-cart"></span> 장바구니</a><i></i>
            	<a href="<%=cp%>/member/logout"><span class="glyphicon glyphicon-log-out"></span> 로그아웃</a>
            </c:if>
        </div>
        <div class="clear"></div>
    </div>
</div>

<div class="menu_box">
	<div class="container">
        <nav class="navbar navbar-default">
            <div class="container-fluid">
            	<div class="navbar-header">
                     <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                         <span class="sr-only">Toggle navigation</span>
                         <span class="icon-bar"></span>
                         <span class="icon-bar"></span>
                         <span class="icon-bar"></span>
                     </button>
               </div>
               
               <div id="navbar" class="navbar-collapse collapse">
                   <ul class="nav navbar-nav">
                       <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">회사소개<span class="caret"></span></a>
                              <ul class="dropdown-menu">
                                  <li><a href="<%=cp%>/company/info">인사말</a></li>
                                  <li><a href="<%=cp%>/company/way">오시는길</a></li>
                                  <li><a href="<%=cp%>/company/guideMap">가이드맵</a></li>
                                  <li><a href="<%=cp%>/ticket/list">이용요금</a></li>
                                  <li><a href="<%=cp%>/card/list">제휴카드</a></li>
                              </ul>
                          </li>
                          <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">오늘의 파크<span class="caret"></span></a>
                              <ul class="dropdown-menu">
                                  <li><a href="<%=cp%>/todayPark/rides">놀이기구</a></li>
                                  <li><a href="<%=cp%>/todayPark/recommand">추천코스</a></li>
                                  <li><a href="<%=cp%>/todayPark/show">오늘의 공연</a></li>
                              </ul>
                          </li>
                          <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">매직패스<span class="caret"></span></a>
                              <ul class="dropdown-menu">
                                  <li><a href="<%=cp%>/magicPass/rides">소개</a></li>
                                  <li><a href="<%=cp%>/magicPass/booking">예약</a></li>
                              </ul>
                          </li>
                          <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">즐길거리<span class="caret"></span></a>
                              <ul class="dropdown-menu">
                                  <li><a href="<%=cp%>/enjoy/rides">놀이기구</a></li>
                                  <li><a href="<%=cp%>/enjoy/giftshop">기프트 샵</a></li>
                                  <li><a href="<%=cp%>/show/list">공연</a></li>
                                  <li><a href="<%=cp%>/show/experience">체험</a></li>
                                  <li><a href="<%=cp%>/show/parade">퍼레이드</a></li>
                              </ul>
                          </li>
                          <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">편의시설<span class="caret"></span></a>
                              <ul class="dropdown-menu">
                                  <li><a href="<%=cp%>/facilities/info">안내소</a></li>
                                  <li><a href="<%=cp%>/facilities/baby">유모차대여소</a></li>
                                  <li><a href="<%=cp%>/facilities/bathchair">휠체어대여소</a></li>
                                  <li><a href="<%=cp%>/facilities/locker">보관함</a></li>
                              </ul>
                          </li> 
                          <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">예매/예약<span class="caret"></span></a>
                              <ul class="dropdown-menu">
                                  <li><a href="<%=cp%>/reservation/ticket">예매</a></li>
                                  <li><a href="<%=cp%>/guide/list">가이드</a></li>
                                  <li><a href="<%=cp%>/reservation/show">공연</a></li>
                                  <li><a href="<%=cp%>/amenities/list">편의시설</a></li>  
                              </ul>
                          </li>
                          <li>
                            <a href="<%=cp%>/giftshop/list">기프트샵</a>
                      </li>
                          <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">소통<span class="caret"></span></a>
                              <ul class="dropdown-menu">
                                  <li><a href="<%=cp%>/notice/list">공지</a></li>
                                  <li><a href="<%=cp%>/event/list">이벤트</a></li>
                                  <li><a href="<%=cp%>/faq/list">FAQ</a></li>
                                  <li><a href="<%=cp%>/question/question">1:1문의</a></li>
                                  <li><a href="<%=cp%>/review/list">이용후기</a></li>
                              </ul>
                          </li>
                   </ul>
                   
				   <p class="allMent_btn"><a href="#"><img src="<%=cp%>/resource/images/allMenu_btn2.png" alt="전체메뉴버튼"/></a></p>
               </div>
           </div>
       </nav>
	</div>
	
	<div class="all_menu_box">
      <div class="container">
          <ul class="all_nav">
              <li>
                  <a href="#">회사소개</a>
                  <ul>
                      <li><a href="<%=cp%>/company/info">인사말</a></li>
                       <li><a href="<%=cp%>/company/way">오시는길</a></li>
                       <li><a href="<%=cp%>/company/guideMap">가이드맵</a></li>
                       <li><a href="<%=cp%>/ticket/list">이용요금</a></li>
                       <li><a href="<%=cp%>/card/list">제휴카드</a></li>
                  </ul>
              </li>
               <li>
                   <a href="#">오늘의 파크</a>
                   <ul>
                       <li><a href="<%=cp%>/todayPark/rides">놀이기구</a></li>
                       <li><a href="<%=cp%>/todayPark/recommand">추천코스</a></li>
                       <li><a href="<%=cp%>/todayPark/show">오늘의 공연</a></li>
                   </ul>
               </li>
               <li>
                   <a href="#">매직패스</a>
                   <ul>
                       <li><a href="<%=cp%>/magicPass/rides">소개</a></li>
                       <li><a href="<%=cp%>/magicPass/booking">예약</a></li>
                   </ul>
               </li>
               <li>
                   <a href="#">즐길거리</a>
                   <ul>
                       <li><a href="<%=cp%>/enjoy/rides">놀이기구</a></li>
                       <li><a href="<%=cp%>/enjoy/giftshop">기프트샵</a></li>
                       <li><a href="<%=cp%>/show/list">공연</a></li>
                       <li><a href="<%=cp%>/show/experience">체험</a></li>
                       <li><a href="<%=cp%>/show/parade">퍼레이드</a></li>
                   </ul>
               </li>
               <li>
                   <a href="#">편의시설</a>
                   <ul>
                       <li><a href="<%=cp%>/facilities/info">안내소</a></li>
                       <li><a href="<%=cp%>/facilities/baby">유모차대여소</a></li>
                       <li><a href="<%=cp%>/facilities/bathchair">휠체어대여소</a></li>
                       <li><a href="#">보관함</a></li>
                   </ul>
               </li>
               <li>
                   <a href="#">예매/예약</a>
                   <ul>
                       <li><a href="<%=cp%>/reservation/reservate">예매</a></li>
                       <li><a href="<%=cp%>/guide/list">가이드</a></li>
                       <li><a href="<%=cp%>/reservation/show">공연</a></li>
                       <li><a href="#">편의시설</a></li>
                   </ul>
               </li>
               <li><a href="<%=cp%>/giftshop/list">기프트샵</a></li>
            <li>
               <a href="#">소통</a>
                   <ul>
                       <li><a href="<%=cp%>/notice/list">공지</a></li>
                       <li><a href="<%=cp%>/event/list">이벤트</a></li>                       
                       <li><a href="<%=cp%>/faq/list">FAQ</a></li>
                       <li><a href="<%=cp%>/question/question">1:1문의</a></li>
                       <li><a href="<%=cp%>/review/list">이용후기</a></li>
                   </ul>
               </li>
           </ul>
      </div>
   </div>
</div>
