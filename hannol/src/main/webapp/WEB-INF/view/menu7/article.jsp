<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<style>
.content-top img{
	width: 100%;
	padding: 0px 50px 50px 50px;
}

.content-body img{
	width: 100%;
	padding: 10px 40px 40px 40px;
}

.note{
	border: 1px solid #e1e1e1;
	border-radius : 5px;
    background: #ffffff;
    padding: 20px;
    margin-top: 15px;
    min-height: 150px;
}

.note-title{
	font-size: 14px;
	font-weight: bold;
}

.note-content{
	margin-bottom: 10px;
}
</style>

<script>
$(function(){
	$(".btn-history-back").click(function(){
		location.href="<%=cp%>/facilities/${pageName}?page="+${page};
	});
});
</script>


<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-tower"></span>기프트샵</h3>
    </div>
    
    <div>
    	<div class="content-top">
    		<img src="/hannolAdmin/uploads/facility/${dto.saveMainFilename}" onerror="this.src='<%=cp%>/resource/images/noimage.png'">
    	</div>
    	<div class="content-body">
	    	<div class="note">
	    		<p class="note-title">테마</p>
	        	<p class="note-content">${dto.themeName}</p>
	        	<p class="note-title">시설명</p>
	        	<p class="note-content">${dto.name}</p>
	        	<p class="note-title">상세정보</p>
	        	<p class="note-content">${dto.memo}</p>
	        	<p class="note-title">위치</p>
	        	<p>
	        		<img src="/hannolAdmin/uploads/facility/${dto.saveLocFilename}" onerror="this.src='<%=cp%>/resource/images/noimage.png'">
	        	</p>
	        </div>
    	</div>
    	<div style="text-align: center; margin-top: 15px;">    	
    		<button type="button" class="btn btn-info btn-history-back">돌아가기</button>
    	</div>
    </div>
</div>