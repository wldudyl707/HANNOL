<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<style>
.heart{
	cursor: pointer;
}
</style>


<script>

$(function(){
	listPage(1);
	$("#reviewForm").hide();
	
	$(".btn-review").click(function(){
		var $reviewForm = $("#reviewForm");
		var isVisible = $reviewForm.is(':visible');
		console.log(isVisible);
			
		if(isVisible) {
			$reviewForm.hide();
		} else {
			var url = "<%=cp%>/review/createForm";
			var type = "get";
			var query = "";
			var divId = "reviewForm";
			
			ajaxHTML(url, type, query, divId);
			$reviewForm.show();
		}
	});
	
	$("body").on("click", ".grayHeart", function () {
		if(!confirm('좋아요 하시겠습니까?')){
			return;
		}
		var reviewCode = $(this).parent().attr('data-reviewCode');
		reviewLike(reviewCode);
	});
	
	$("body").on("click", ".redHeart", function () {
		if(!confirm('좋아요 취소 하시겠습니까?')){
			return;
		}		
		var reviewCode = $(this).parent().attr('data-reviewCode');
		reviewLikeCancel(reviewCode);		
	});
	
});

function reviewLike(reviewCode) {
	var type = "get";
	var url = "<%=cp%>/review/like"
	var query = "reviewCode=" + reviewCode;
	
	
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			var state=data.state;
			if(state=="true") {			
				// 좋아요 수 갱신
				var count = data.likeCount;
				$("input[name=likeCount"+reviewCode+"]").val(count);
				// 아이콘 빨간 하트로 변경 - prev
				$("#likeCount"+reviewCode).removeClass('grayHeart');
				$("#likeCount"+reviewCode).addClass('redHeart');
			} else if(state=="false") {
				$("#msg").text(data.msg);
			}
		}
		,beforeSend : function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		location.href="<%=cp%>/member/login";
	    		return;
	    	}
	    	
	    	if(jqXHR.status==200) {
	    		location.href="<%=cp%>/member/login";
	    		return;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
	
}

function reviewLikeCancel(reviewCode) {
	var type = "get";
	var url = "<%=cp%>/review/likeCancel"
	var query = "reviewCode=" + reviewCode;
	
	
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			var state=data.state;
			if(state=="true") {			
				// 좋아요 수 갱신
				var count = data.likeCount;
				$("input[name=likeCount"+reviewCode+"]").val(count);
				// 아이콘 회색 하트로 변경
				$("#likeCount"+reviewCode).removeClass('redHeart');
				$("#likeCount"+reviewCode).addClass('grayHeart');
			} else if(state=="false") {
				$("#msg").text(data.msg);
			}
		}
		,beforeSend : function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		location.href="<%=cp%>/member/login";
	    		return;
	    	}
	    	
	    	if(jqXHR.status==200) {
	    		location.href="<%=cp%>/member/login";
	    		return;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}


// ajax-json : 후기 등록
function createReview(mode) {
 	var f = document.reviewCreateForm;
	
	var val = f.reviewDate.value;
	if(!val) {
		alert('날짜를 선택하세요');
		return;
	}
	
	val = f.content.value.length;
	if(!val || val < 10) {
		alert('10자이상 입력하세요');
		return;
	}
	
	var url = "<%=cp%>/review/" + mode;
	
	var query = $("#reviewCreateForm").serialize();
	ajaxJSON(url, "post", query);
}

function updateReview(reviewCode) {
	if(!confirm('수정하시겠습니까?')){
		return;
	}
	
	$("#reviewForm").show();
	var url = "<%=cp%>/review/update";
	var type = "get";
	var query = "reviewCode=" + reviewCode;
	var divId = "reviewForm";
	ajaxHTML(url, type, query, divId);
}

function deleteReview(reviewCode) {
	var url = "<%=cp%>/review/delete";
	var query = "reviewCode=" + reviewCode;
	ajaxJSON(url, "get", query);
}

function listPage(page) {
	var url = "<%=cp%>/review/listReview";
	var query = "pageNo=" + page;
	var divId = "listReview";
	ajaxHTML(url, "get", query, divId);
}

//ajax-text 공통함수
function ajaxHTML(url, type, query, divId) {
	$.ajax({
		type:type,
		url:url,
		data:query,
		success:function(data){
			if($.trim(data)=="error"){
				alert('잘못된 요청입니다.');
				listPage(1);
				return;
			}
			$("#"+divId).html(data);
		},
		beforeSend:function(jqXHR){
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR){
			if(jqXHR.status==403){
				location.href="<%=cp%>/member/login";
				return;
			}
			
			if(jqXHR.status==200) {
	    		location.href="<%=cp%>/member/login";
	    		return;
	    	}
			console.log(jqXHR.responseText);
		}
	});
}

// ajax-json 공통함수
function ajaxJSON(url, type, query) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			var state=data.state;
			if(state=="true") {
				listPage(1);
				$("#reviewForm").hide();				
//				var count = data.boardLikeCount;
//				$("#boardLikeCount").text(count);
			} else if(state=="false") {
				$("#msg").text(data.msg);
			}
		}
		,beforeSend : function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		location.href="<%=cp%>/member/login";
	    		return;
	    	}
	    	
	    	if(jqXHR.status==200) {
	    		location.href="<%=cp%>/member/login";
	    		return;
	    	}
	    	
	    	console.log(jqXHR.responseText);
	    }
	});
}
</script>

<div class="bodyFrame2">
    <div class="body-title">
        <h3><span class="glyphicon glyphicon-pencil"></span> 이용후기 </h3>
    </div>
    
    <div class="alert alert-info">
        <i class="glyphicon glyphicon-info-sign"></i> 방문 소감을 남겨 주세요.<br>
	 	<span style='font-weight: bold;' > - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span> 
    </div>

	<div align="right">
		<button type='button' class='btn btn-info btn-review' style='padding: 10px 20px;'>후기 등록</button>
		<div id="reviewForm"></div>
	</div>
	
	<div align="center" id="msg"  style="color: red; font-weight: bold;"></div>
	
	<div id="listReview" style="padding: 15px;"></div>

</div>