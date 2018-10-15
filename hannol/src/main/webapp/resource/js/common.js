$(function(){
	//전체 메뉴 슬라이드 업다운
	$(".allMent_btn, .nav li").click(function(){
		if(!$(".all_menu_box").is(":visible")){
			var now = $(this).attr("class");
			
			if(now == "allMent_btn"){
				$(".all_menu_box").slideDown();
			}
			
		}else{
			$(".all_menu_box").slideUp();
		}
	});
});


