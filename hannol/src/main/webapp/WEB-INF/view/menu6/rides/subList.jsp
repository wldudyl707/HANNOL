<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<style>
	/**table**/
	.table{table-layout:fixed;}
	.table th,
	.table td{text-align:center;}
	.table td{text-overflow:ellipsis; overflow:hidden; white-space:nowrap;}
	.table th:nth-child(2),
	.table td:nth-child(2),
	.table th:nth-child(3),
	.table td:nth-child(3),
	.table td:nth-child(4){text-align:left;}
	
	.listData_no{text-align:center;}
	
	.noLine{border:0 none;}
	.btfTel.noLine{width:36px; padding-left:0; padding-right:0;}
	
	
	
	/**modal**/
	.modalTable{width:100%; margin-top:20px; color:#444444;}
	.modalTable th,
	.modalTable td{padding:10px 0;} 
	.modalTable th{width:110px; padding-top:13px; padding-right:20px; text-align:right; vertical-align:top;}
	
	.boxTF,
	.boxTA{width:280px; vertical-align:middle;}
	.boxTA[disabled]{background-color:#f3f3f3; padding:10px 15px;}
	.selectField{padding:5px; vertical-align:middle;}
	.boxTF.btfName{width:120px;}
	.btfTel{width:60px; text-align:center;}
	
	
	.btnBox{margin:40px 0; text-align:center;}
	.btnBox .btn{margin:0 3px;}
	
	
	/**dialog new style**/
	.ui-widget{font-family:"Nanum Gothic";}
	.ui-widget input, 
	.ui-widget select, 
	.ui-widget textarea, 
	.ui-widget button{font-family:"Nanum Gothic"; font-size:13px;}
	.ui-widget-header{color:#ffffff; background:#4c4c4c;}
	.ui-dialog .ui-dialog-title{font-size:16px;}
	.ui-dialog .ui-dialog-titlebar{padding:11px 1em;}
	.ui-dialog{padding:0;}
	.ui-draggable .ui-dialog-titlebar{border-bottom-left-radius:0; border-bottom-right-radius:0;}
</style>


<script type="text/javascript">

 function info(code){
		//var code = $("#info").attr("value");
		//alert(code);
		var url = "<%=cp%>/enjoy/dialog";
		var data = "code="+code;
		ajaxHTML2(data,"get",url);
 }
 
 /*다이얼 로그*/
		function ajaxHTML2(data,type,url) {
			//alert("?");
			 $.ajax({
				type:type,
				url:url,
				data:data,
				success:function(data){
					if($.trim(data)=="error"){
						listPage(1);
						alert("에러남");
						return;
					}
					$("#ridesInfoModel").html(data);
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
		
		$("#ridesInfoModel").dialog({
			title : "놀이기구 정보",
			width : 580,
			height : 700,
			modal : true,
			open : function() {
				$(".btnBox").empty();
				$(".infoHidden").remove();
				}
			});
		
		$("body").on("click", "#ridesInfoAdd_close_btn", function() {
			$("#ridesInfoModel").dialog("close");
		}); 
	}


</script>

<div style="float:left; margin: 0px 15px; clear: both;">${dataCount}개 (${page}/${total_page})</div>
<div style="clear: both;">
	<c:forEach items="${list}" var="dto">
		<div style="width: 100%;">
			<div class="col-lg-4">
				<div class="thumbnail">
					<c:if test="${not empty dto.saveMainFilename}">
						<img src="/hannolAdmin/uploads/facility/${dto.saveMainFilename}" onerror="this.src='<%=cp%>/resource/images/noimage.png'" style="height:250px;">
					</c:if>
					<c:if test="${empty dto.saveMainFilename}">
						<img src="<%=cp%>/resource/images/noimage.png" style="height:250px; width: 300px;">
					</c:if>
					 <span class="itemTitle">${dto.name}</span>
					 <input type="button" id="info" value="상세보기" onClick="info(${dto.facilityCode});">
				</div>
			</div>
		</div>
	</c:forEach>
</div>

<div id="ridesInfoModel" class="modal">

</div>   

<div class="div-paging" style="width: 100%; text-align: center; margin: 0px auto; clear: both;">${paging}</div>


