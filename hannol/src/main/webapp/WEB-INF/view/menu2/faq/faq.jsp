<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>
.body-title h3{
	margin-bottom: 0px;
}

.nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover{
	background-color: #337ab7;
	color: #fff;
}

.btn-search{
	width: 100%;
	margin: 0px;
	padding: 0px;
	float: none;
}

.qnaList{
	margin-top : 30px;
	border-top: 2px solid #000;
}

.qnaList li{
	border-bottom: 1px solid #e1e1e1;
}

.qnaList li > a{
	padding: 25px 30px 25px 105px;
	display: block;
	background: url('<%=cp%>/resource/images/qna_list_icon.png') no-repeat 30px center;
}

.tit{
	position: relative;
	font-size: 16px;
	color: #000;
	line-height: 25px;
	padding-right: 30px;
}

.qnaList li > a .tit span{
	display: block;
}

.type1{
	font-size: 14px;
	color: #555;
	margin-bottom: 2px;
}

.answerDiv{
	display : none;
	padding: 25px 30px 50px 105px;
	background: url('<%=cp%>/resource/images/qna_answer_icon.png') no-repeat 30px 30px #f8f8f8;
	font-size: 14px;
	line-height: 28px;
	border-top: 1px solid #e1e1e1; 
}
</style>

<script>
$(function(){
	//탭선택 EVENT
	$(".nav-link").click(function(){
		$('.nav-item').removeClass('active');
		$(this).parent(".nav-item").addClass("active");
		
		$(".select-menu").val("attrctn");
		$("#searchValue").val("");
		
		listPage(1);
	});
});

$(function(){
	//선택한 Tab으로 셋팅
	var tab = "${tab}";
	if(tab != ""){
		$('.nav-item').removeClass('active');
		$(".nav-link").each(function(){
			if($(this).attr("data-gubun") == tab){
				$(this).parent(".nav-item").addClass("active");
			}
		});
	}
	
	//page
	var page = "${page}";
	
	//body 그리기
	listPage(page);
});

//검색조건
function searchList(){
	//선택한 Tab 값 알아오기
	var tab = "";
	$(".nav-link").each(function(){
		if($(this).parent(".nav-item").hasClass("active")){
			tab = $(this).attr("data-gubun");
		}
	});
	
	$("#gubun-tab").val(tab);
	
	var f = document.searchForm;
	f.submit();
}

function listPage(page){
	var data = "page="+page;
	
	//tab 확인
	var tab = "";
	$(".nav-link").each(function(){
		if($(this).parent(".nav-item").hasClass("active")){
			tab = $(this).attr("data-gubun");
		}
	});
	data+="&tab="+tab;
	
	//searchValue 확인
	var searchValue = $("#searchValue").val();
	if(searchValue != "" && searchValue !== undefined){
		data+="&searchValue="+searchValue;
	}
	
	var url = "<%=cp%>/faq/ajaxList"
	
	$.ajax({
		type:"POST"
		,url:url
		,data: data
		,success:function(data) {
			$(".content-body").html(data);		
		}
	    ,error:function(e) {
	    	console.log(e.responseText);
	    }
	});
}

function showAnswer(obj){
	if($(obj).next().is(":visible")){
		$(obj).next().css("display", "none");	
	}else{
		$(obj).next().css("display", "block");	
	}
}

</script>



<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-tower"></span>FAQ</h3>
    </div>
    
    <div>
        <ul class="nav nav-tabs">
		  <li class="nav-item active" >
		    <a class="nav-link" data-gubun="all">전체</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" data-gubun="useinfo">이용정보</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" data-gubun="pre">우대정보</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" data-gubun="event">이벤트</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" data-gubun="years">연간회원</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" data-gubun="online">온라인예매</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" data-gubun="els">기타</a>
		  </li>
		</ul>
		
		<div style="width: 100%;">
		<form name="searchForm" method="post" action="<%=cp%>/faq/list">
			<div class="col-xs-8 col-xs-offset-2 btn-search">
		  		<div class="input-group">     
		            <input type="text" class="form-control" name="searchValue" id="searchValue" placeholder="검색할 키워드를 입력해 주세요..." value="${searchValue}">
		            <span class="input-group-btn">
		                <button class="btn btn-default btn-info" type="button" onclick="searchList()"><span class="glyphicon glyphicon-search"></span></button>
		                <input type="hidden" name="tab" id="gubun-tab">
		            </span>
		        </div>
			</div>
		</form>
		</div>
    </div>
    
    <div class="content-body">
    	
    </div>
</div>