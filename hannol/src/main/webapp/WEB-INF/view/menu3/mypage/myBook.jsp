<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">


<script type="text/javascript">
$(function() {
	var pageNo = ${pageNo};
	
	$("#tab-${tab}").addClass("active");
	listPage(pageNo);
	
	$("ul.tabs li").click(function() {
		var tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function() {
			$(this).removeClass("active");
		});
		
		$("#tab-"+tab).addClass("active");
		listPage(1);
	});
});

function listPage(page) {
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	var gubunCode = $tab.attr("data-gubuncode");
	var url = "<%=cp%>/mybook/" + gubunCode + "/list";
	
	var query = "pageNo="+page+"&tab="+tab;
	var search = $("form[name=searchForm]").serialize();
	query += "&" + search;
	ajaxHTML(url, "get", query);
}

// ajax 공통함수
function ajaxHTML(url, type, query) {
	$.ajax({
		type:type,
		url:url,
		data:query,
		success:function(data){
			if($.trim(data)=="error"){
				listPage(1);
				return;
			}
			$("#tab-content").html(data);
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

function chkSingle(){
	$("input[name=chk]:checked").each(function(){
		var test = $(this).parent().next().next().next().next().next().next().next().text();
		//alert(test);
		
	});
}

//전체 체크박스
function checkAll(){
	if($("#chkAll").is(':checked')){      
		$("input[name=chk]").not(':disabled').prop("checked",true);
	}else{
		$("input[name=chk]").not(':disabled').prop("checked",false);
	}  
}

//ajax로 값들을 보낸다
$(function(){
	$(document).on("click","button[name=btnDelete]", function(){
		 
		var lists = new Array();
		$("input[name='chk']:checked").each(function(i){   //jQuery로 for문 돌면서 check 된값 배열에 담는다
			lists.push($(this).parent().next().next().text());
		});
		
		if(lists.length == 0){
			$("#resultLayout").html("삭제할 예약정보를 선택해주세요");
			return;
		}
		
		// check 된 애들의 개수
	 	var url="<%=cp%>/mybook/delete";
		var num = $(this).parent().next();
		var query = {"lists":lists};
		console.log(query);

			$.ajax({
				type:"POST",
				url:url,
				data:query,
				success:function(data){
					$("#resultLayout").html("삭제완료!");
					$("#tab-content").html(data);
				}
				,error:function(e){
					console.log(e.responseText);
					$("#resultLayout").html("에러발생!");	
				}
			}); 
	});
	
	// 무대 공연 - 예약 취소
	$(document).on("click","button[name=btnShowDelete]", function(){
		
		var showBookCode = new Array();
		$("input[name='chk']:checked").each(function(i){   //jQuery로 for문 돌면서 check 된값 배열에 담는다
			showBookCode.push($(this).attr('data-showBookCode'));
		});
		
		if(showBookCode.length == 0){
			$("#resultLayout").html("삭제할 예약정보를 선택해주세요");
			return;
		}
		
		// check 된 애들의 개수
	 	var url="<%=cp%>/mybook/deleteShow";
		var query = {"showBookCode":showBookCode};

		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				var state=data.state;
				if(state=="true") {		
					alert('예약이 취소되었습니다.');
					location.reload();
				} else if(state=="false") {
					$("#msg").text(data.msg);
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
	});
});
</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-tower"></span>내 예매 정보확인 </h3>
    </div>
    
    <div>
       <div style="clear: both;">
           <ul class="tabs">
		       <li id="tab-magicpass" data-tab="magicpass" data-gubuncode="1">매직패스</li>
		       <li id="tab-guide" data-tab="guide" data-gubuncode="2">가이드</li>
		       <li id="tab-stage" data-tab="stage" data-gubuncode="3">무대공연</li>
		       <li id="tab-facility" data-tab="facility" data-gubuncode="4">편의시설</li>
		   </ul>
	   </div>
	   <div id="tab-content" style="clear:both; padding: 20px 10px 0px;"></div>
    </div>
    
    <div id="resultLayout"></div>
</div>