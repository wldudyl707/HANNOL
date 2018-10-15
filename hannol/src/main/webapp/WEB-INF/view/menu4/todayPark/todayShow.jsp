<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>
.body-content img{
	width: 100%;
}
</style>


<script>
$(function() {
	var date = dateToString(new Date());
	var url = "<%=cp%>/show/detail";
	var query = "gubunCode=3&date=" + date;
	ajaxHTML(url, "get", query);
});

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
			$("#showList").html(data);
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


function detailShow(showInfoCode) {
	var screenDate = dateToString(new Date());
	
	var url = "<%=cp%>/show/article";
	var query = "subMenu=3&showInfoCode=" + showInfoCode + "&screenDate=" + screenDate;
	location.href = url + "?" + query;
} 

function reservation(showInfoCode) {
	var screenDate = dateToString(new Date());
	
	var url = "<%=cp%>/show/reseration";
	var query = "subMenu=3&showInfoCode=" + showInfoCode + "&screenDate=" + screenDate;
	location.href = url + "?" + query;
}
</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-tower"></span> 오늘의 공연 </h3>
    </div>

	<div id="showList"></div>
	
</div>