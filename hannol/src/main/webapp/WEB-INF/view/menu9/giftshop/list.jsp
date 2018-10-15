<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>
.thumbnail>a>img {
	margin-bottom: 5%;
}

.giftList:after {
	content: '';
	display: block;
	clear: both;
}

.itemTitle {
	display: block;
	margin: 10px 0px;
}

.itemPrice {
	font-weight: 900;
	font-size: 14px;
}

.input-lg {
	height: 35px;
}

.col-xs-8:after {
	content: '';
	display: block;
	clear: both;
}

.col-xs-offset-2 {
	width: 60%;
}

.col-xs-8 {
	float: left;
	margin: 0px 0px;
}

.itemSelect {
	min-width: 120px;
	width: 30%;
	margin-bottom: 10px;
	float: right;
}

.giftSelect:after {
	content: '';
	display: block;
	clear: both;
}

.giftSelect {
	padding: 0px 15px;
	margin-top: 10px;
}

.gitf-form-control {
	background: url(<%=cp%>/resource/images/item_list.png) no-repeat right
		2px;
}

select {
	-webkit-appearance: none;
	appearance: none;
}

.nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover
	{
	background-color: #337ab7;
	color: #ffffff;
}

select::-ms-expand {
	display: none;
}

.body-title h3 {
	margin-bottom: 0px;
}

.div-paging ul{
	margin: 0px auto;
}
</style>

<script type="text/javascript">
var dataQuery ="";
var giftThema =0;
var giftsearchKey = "${searchKey}";
var giftsearchValue = "${searchValue}";
var giftorder = "${order}";
var giftthema = "${thema}";

$(function(){
	$('.nav-item').removeClass('active');
	$(".nav-item").each(function(){
		if( $(this).attr("data-gift-gubun") == giftthema){
			$(this).addClass("active");
			return;
		}
	});
	
	$(".gitf-form-control option").each(function(){
		if($(this).val()==giftorder){
			$(this).attr("selected","selected");
			return;
		}
	});
	
	if(giftsearchValue != ''){
		dataQuery = "searchKey="+giftsearchKey+"&searchValue="+encodeURIComponent(giftsearchValue);
	}
	if(dataQuery != ''){
		dataQuery+="&order="+giftorder+"&thema="+giftthema;
	}else{
		dataQuery="order="+giftorder+"&thema="+giftthema;
	}
	
	listPage("${page}", dataQuery);
	
	$(".nav-link").click(function(){
		$('.nav-item').removeClass('active');
		$(this).parent(".nav-item").addClass("active");
		
		giftThema = $(this).parent(".nav-item").data("gift-gubun");
		dataQuery = "";
		$("#searchValue").val("");
		$('.gitf-form-control option').attr("selected", false);
		$('.gitf-form-control option:eq(0)').attr("selected", "selected");
		
		listPage(1, dataQuery);
	});
});

function searchList() {
	var searchValue = $("#searchValue").val();
	dataQuery = "searchKey=goodsName&searchValue="+encodeURIComponent(searchValue);
	
	$('.gitf-form-control option:eq(0)').attr("selected", "selected");
	listPage(1, dataQuery);
}

function orderList(){
	var orderList = $('.gitf-form-control option:selected').val();
	
	if(dataQuery.indexOf("order=") == -1){
		dataQuery=dataQuery+"&order="+orderList;
	}else{
		var index = dataQuery.indexOf("order=");
		if(index == 0){
			dataQuery="order="+orderList;
		}else{
			var str = dataQuery.substring(0,index).trim();
			dataQuery=str+"&order="+orderList;
		}
	}
	
	listPage(1, dataQuery);
	
}

function listPage(page, query){
	if (query === undefined || query === null) {
		query = dataQuery;
	}
	
	var url = "<%=cp%>/giftshop/aJaxList"
	var data = "page="+page;
	
	if(query!=''){
		data+="&"+query;
	}
	
	data+="&thema="+giftThema;
	
	
	$.ajax({
		type:"GET"
		,url:url
		,data: data
		,success:function(data) {
			$(".giftList").html(data);			
			
		}
	    ,error:function(e) {
	    	console.log(e.responseText);
	    }
	});
}
</script>


<div class="bodyFrame2">
	<div class="body-title">
		<h3>
			<span class="glyphicon glyphicon-gift"></span> 기프트샵
		</h3>
	</div>

	<div>
		<ul class="nav nav-tabs">
			<li class="nav-item active" data-gift-gubun="0">
				<a class="nav-link">전체</a>
			</li>
			<c:forEach items="${listGubun}" var="gubun">
				<li class="nav-item" data-gift-gubun="${gubun.GUBUNCODE}"><a
					class="nav-link">${gubun.GUBUNNAME}</a></li>
			</c:forEach>
		</ul>

	</div>

	<div style="margin: 10px 0px;">
		<div class="col-xs-8 col-xs-offset-2">
			<div class="input-group">
				<input type="text" class="form-control" name="searchValue" id="searchValue" placeholder="검색할 키워드를 입력해 주세요..." value="${searchValue}">
	            <span class="input-group-btn">
	                <button class="btn btn-default btn-info" type="button" onclick="searchList()"><span class="glyphicon glyphicon-search"></span></button>
	            </span>
			</div>
		</div>

		<div class="giftSelect">
			<div class="itemSelect">
				<select class="form-control gitf-form-control" onchange="orderList();">
					<option value="newGoods">신상품순</option>
					<option value="minPrice">가격낮은순</option>
					<option value="maxPrice">가격높은순</option>
					<option value="likeGoods">인기상품순</option>
				</select>
			</div>
		</div>
	</div>


	<div class="giftList"></div>
	<div style="margin-left: 15px;">
		<button type="button" class="btn btn-default btn-refresh"
			onclick="javascript:location.href='<%=cp%>/giftshop/list'">새로고침</button>
	</div>
</div>








