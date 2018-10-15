<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>
	.cube_box{margin:20px 0; padding:15px; text-align:center; background-color:#fafafa; border:1px solid #efefef;}
	.cube_box{margin:auto;}
	.cube_box_subject{padding:10px; font-weight: bold;}
	/* .cube_box1 td{position:relative; width:120px; height:70px; text-align:center; color:#757575; background-color:##9999cc; border:1px solid #ccc; cursor:pointer;}
	.cube_box1 td:hover{background-color:#f8f8f8; z-index:1;}  */
	#cube1{background-color: #ffccff;}
	#cube2{background-color: #9999cc;}
	#cube3{background-color: #ffffcc;}
	#cube4{background-color: #99ffff;}
	#cube5{background-color: #ffcc99;}
	.cube_box td{position:relative; width:120px; height:70px; text-align:center; color:#757575; border:1px solid #ccc; cursor:pointer;}
	.cube_box td:hover{background-color:#f8f8f8; z-index:1;} 
	.cube_box .st_rent{font-weight:600; color:#ffffff; background-color:#676fa2;}
	.cube_box .st_rent:hover{background-color:#636b9d;}
	.cube_box td span{display:block;}
	.cube_num{position:absolute; top:10px; width:100%; 
	font-size:12px;}
	.cube_rant{font-size:13px;}
	
	.boxTF,
	.boxTA,
	.modalTable .selectField{width:280px; vertical-align:middle;}
	.boxTF[readonly]{background-color:#ffffff;}
	.boxTA[disabled]{background-color:#f3f3f3; padding:10px 15px;}
	.selectField{padding:5px; vertical-align:middle;}
	.boxTF.btfName{width:120px;}
	.btfTel{width:60px; text-align:center;}
	.datepickerBox{display:inline-block;}
	.datepickerBox .datepicker{width:203px;}   
	.datepicker + img{width:22px; margin:0px 0px 0px -31px; padding-left:8px; border-left:1px solid #dddddd; cursor:pointer;}
</style> 
 
<script type="text/javascript">
$(function(){
	var check='${check}';
	//if(check=='날짜중복' || check=='예약 완료!' || check=='회원님은 예약된 보관함이 있습니다.' ||check=='현재 가능한 이용권이 없습니다.' || check =='해당 날짜의 가능한 이용권이 없습니다.' ||check =='취소완료'){
		if(!check)
			return false;
		alert(check);
});

var day;
$(function(){
	var day='${day}';
	var date='${date}';
	
	listPage(day,date);
});

function listPage(day, pickDate){
	var url="<%=cp%>/amenities/cube";
	ajaxHTML(url, "post", day, pickDate);
};

//list ajaxHTML
function ajaxHTML(url, type, day, pickDate){
	$.ajax({
		type:type,
		url:url,
		data:{day:day, pickDate:pickDate},
		success:function(data){
			if($.trim(data)=="error"){
				listPage("프린세스빌리지","에러");
				alert("에러남");
				return;
			}
			$("#showlayout").html(data);
		},
		beforeSend:function(jqXHR){
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR){
			if(jqXHR.status==403){
				location.href="<%=cp%>/member/login";
				return;
			}
			console.log(jqXHR.responseText);
		}
	});
}

//날짜 선택
var day;
function check(){
	//alert("선택 날짜 리스트 보여주기")
	pickDate = $("input[name=useDate]").val();
	
	if(!pickDate){
		alert("날짜를 선택하세요.");
		return false;
	}
	
	day = document.getElementById('day');
	day = day.value;
	//alert(day);
	
	listPage(day, pickDate);
}

//datepicker
var pickDate;

$(function(){
	$("input[name=useDate]").datepicker({
		dateFormat:'yy-mm-dd',
		showOn:"button",
        buttonImage:"<%=cp%>/resource/images/date24.png",
        buttonImageOnly:true,
        showAnim:"slideDown",
        buttonText:"선택",
        maxDate:6,
        minDate:0,
        onSelect:function(selected){
      		//alert($("input[name=useDate]").val());
        	userDate = $("input[name=useDate]").val();
        }
	});
 });

//보관함 선택 시
var idnum;
function clickTrEvent(trObj) {
	//alert(trObj.id);
	idnum = trObj.id;
	reservation(idnum);
}

//예약체크
function reservation(idnum){

	pickDate = $("input[name=useDate]").val();
	
	if(!pickDate){
		alert("날짜를 선택하세요.");
		return false;
	}
	
	
	var name;
	name = $("#name").val();
	
	if(!name){
		alert("이름을 입력하세요.");
		$("#name").focus();
		return false;
	}

	var tel;
	tel = $("#usertel").val();
	
	if(!tel){
		alert("전화번호를 입력하세요.");
		$("#usertel").focus();
		return false;
	}
	
	var url="<%=cp%>/amenities/reservationCube";
	
	ajaxHTML2(url, "post", idnum, pickDate, day, name, tel)
	
}

function ajaxHTML2(url, type, idnum, pickDate, day, name, tel){
	$.ajax({
		type:type,
		url:url,
		data:{day:day, pickDate:pickDate, idnum:idnum, name:name, tel:tel},
		success:function(data){
			if($.trim(data)=="error"){
				listPage("프린세스빌리지","에러");
				alert("에러남");
				return;
			}
			$("#showlayout").html(data);
		},
		beforeSend:function(jqXHR){
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR){
			if(jqXHR.status==403){
				location.href="<%=cp%>/member/login";
				return;
			}
			console.log(jqXHR.responseText);
		}
	});
	
}

function cancel(){
	alert("예약취소을 취소합니다.");
	
	location.href="<%=cp%>/amenities/cancel?pickDate="+pickDate+"&day="+day; 
}

</script>


<div class="bodyFrame2">
	<div class="body-title">
		<h3>
			<span class="glyphicon glyphicon-calendar"></span> 보관함  
		</h3>
	</div>
	
	
	사용날짜 :	<span class="datepickerBox"><input type="text" name="useDate" class="boxTF datepicker"readonly="readonly"></span>
	
	&nbsp;
	
	<select class="selectField" name="day" id="day">
		<option value="오후">오후</option>
		<option value="종일">종일</option>
	</select>
	<button class="btn" onclick="check();">선택</button>
	
	
	<br>
	이름 : <input type="text" id="name">
	전화번호 : <input type="text" id="usertel">
	<!-- <button type="button" > 예약하기 </button> -->
	
	<div id="showlayout"></div>
	
	<button class="btn" onclick="cancel();">예약 취소</button>
				
</div>


 





