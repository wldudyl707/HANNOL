<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<script type="text/javascript">

<div class="assetsContents">
	<div class="cube_box_subject">
	프린세스 빌리지
	</div>
		<div class="princess cube">
			<table class="cube_box" id="cube1"> 
				<tr>
				<c:choose>
					<c:when test="${dto.lock1_1==1}">
						<td id=1 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">1</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=1 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">1</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>
					
				<c:choose>
					<c:when test="${dto.lock1_2==2}">
						<td id=2 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">2</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=2 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">2</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock1_3==3}">
						<td id=3 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">3</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=3 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">3</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock1_4==4}">
						<td id=4 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">4</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=4 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">4</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock1_5==5}">
						<td id=5 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">5</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=5 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">5</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>
				</tr>
				
				<tr>
				<c:choose>
					<c:when test="${dto.lock1_6==6}">
						<td id=6 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">6</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=6 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">6</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock1_7==7}">
						<td id=7 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">7</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=7 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">7</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock1_8==8}">
						<td id=8 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">8</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=8 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">8</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock1_9==9}">
						<td id=9 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">9</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=9 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">9</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock1_10==10}">
						<td id=10 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">10</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=10 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">10</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>
				</tr>
			</table>
		</div>
	
	<div class="cube_box_subject">
	토이스토리
	</div>
		<div class="toystory cube">
			<table class="cube_box" id="cube2"> 
				<tr>
				<c:choose>
					<c:when test="${dto.lock2_1==11}">
						<td id=11 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">11</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=11 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">11</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock2_2==12}">
						<td id=12 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">12</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=12 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">12</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock2_3==13}">
						<td id=13 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">13</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=13 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">13</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>
					
				<c:choose>
					<c:when test="${dto.lock2_4==14}">
						<td id=14 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">14</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=1 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">14</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock2_5==15}">
						<td id=15 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">15</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=15 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">15</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>
				</tr>
				
				<tr>
				<c:choose>
					<c:when test="${dto.lock2_6==16}">
						<td id=16 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">16</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=16 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">16</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock2_7==17}">
						<td id=17 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">17</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=17 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">17</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock2_8==18}">
						<td id=18 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">18</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=18 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">18</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock2_9==19}">
						<td id=19 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">19</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=19 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">19</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock2_10==20}">
						<td id=20 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">20</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=20 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">20</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>
				</tr>
				
			</table>
		</div>		
	<div class="cube_box_subject">
	미니언즈
	</div>
		<div class="minians cube">
			<table class="cube_box" id=cube3> 
				<tr>
				<c:choose>
					<c:when test="${dto.lock3_1==21}">
						<td id=21 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">21</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=21 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">21</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>
					
				<c:choose>
					<c:when test="${dto.lock3_2==22}">
						<td id=22 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">22</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=22 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">22</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock3_3==23}">
						<td id=23 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">23</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=23 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">23</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock3_4==24}">
						<td id=24 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">24</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=24 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">24</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock3_5==25}">
						<td id=25 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">25</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=25 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">25</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>
				</tr>
				
				<tr>
				<c:choose>
					<c:when test="${dto.lock3_6==26}">
						<td id=26 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">26</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=26 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">26</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock3_7==27}">
						<td id=27 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">27</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=27 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">27</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock3_8==28}">
						<td id=28 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">28</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=28 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">28</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock3_9==29}">
						<td id=29 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">29</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=29 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">29</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock3_10==30}">
						<td id=30 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">30</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=30 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">30</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>
				</tr>
			</table>
		</div>		
	
	
	<div class="cube_box_subject">
	라이언킹
	</div>	
		<div class="princess cube">
			<table class="cube_box" id=cube4> 
				<tr>
				<c:choose>
					<c:when test="${dto.lock4_1==31}">
						<td id=31 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">31</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=31 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">31</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>
					
				<c:choose>
					<c:when test="${dto.lock4_2==32}">
						<td id=32 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">32</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=32 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">32</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock4_3==33}">
						<td id=33 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">33</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=33 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">33</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock4_4==34}">
						<td id=34 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">34</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=34 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">34</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock4_5==35}">
						<td id=35 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">35</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=35 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">35</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>
				</tr>
				
				<tr>
				<c:choose>
					<c:when test="${dto.lock4_6==36}">
						<td id=36 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">36</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=36 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">36</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock4_7==37}">
						<td id=37 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">37</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=37 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">37</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock4_8==38}">
						<td id=38 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">38</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=38 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">38</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock4_9==39}">
						<td id=39 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">39</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=39 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">39</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock4_10==40}">
						<td id=40 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">40</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=40 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">40</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>
				</tr>
			</table>
		</div>		
		
	<div class="cube_box_subject">
	니모
	</div>
		<div class="princess cube">
			<table class="cube_box" id=cube5> 
				<tr>
				<c:choose>
					<c:when test="${dto.lock5_1==41}">
						<td id=41 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">41</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=41 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">41</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>
					
				<c:choose>
					<c:when test="${dto.lock5_2==2}">
						<td id=42 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">42</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=42 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">42</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock5_3==43}">
						<td id=43 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">43</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=43 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">43</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock5_4==44}">
						<td id=44 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">44</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=44 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">44</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock5_5==45}">
						<td id=45 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">45</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=45 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">45</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>
				</tr>
				
				<tr>
				<c:choose>
					<c:when test="${dto.lock5_6==46}">
						<td id=46 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">46</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=46 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">46</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock5_7==47}">
						<td id=47 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">47</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=47 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">47</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock5_8==48}">
						<td id=48 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">48</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=48 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">48</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock5_9==49}">
						<td id=49 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">49</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=49 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">49</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${dto.lock5_10==50}">
						<td id=50 onclick="javascript:clickTrEvent(this)" style="background-color: #ff0000">
							<span class="cube_num">50</span>
							<span class="cube_rant">사용중</span>
						</td>
					</c:when>
					<c:otherwise>
						<td id=50 onclick="javascript:clickTrEvent(this)">
							<span class="cube_num">50</span>
							<span class="cube_rant">예약선택가능</span>
						</td>
					</c:otherwise>
				</c:choose>
				</tr>
			</table>
		</div>
	</div>
