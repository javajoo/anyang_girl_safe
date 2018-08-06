<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="logo_tit"></div>
       	<h2 class="logo_tit_text">
       		여성 안심 서비스
       	</h2>
       	<header>
       	<div class="cont">
			<nav class="gnb">
			    <ul class="gnb_ul">
			    	<li><a id="topmenu_home" href="javascript:menuDisplay('menu_home')" class="selected">HOME</a></li>
			    	<li data-action="/include/girl_safe_list"><a id="topmenu_userList" href="javascript:menuDisplay('menu_userList')">가입자 현황</a></li>
					<li><a id="topmenu_eventSearch" href="javascript:menuDisplay('menu_eventSearch')">이벤트 검색</a></li>
					<li><a id="topmenu_hwCheck" href="javascript:menuDisplay('menu_hwCheck')">단말 상태 체크</a></li>
					<li><a id="topmenu_statistics" href="javascript:menuDisplay('menu_statistics')">통계자료</a></li>
					<li><a id="topmenu_board" href="javascript:menuDisplay('menu_eventR')">게시판</a></li>
					<!-- <li><a id="topmenu_system" href="javascript:menuDisplay('menu_system')">시스템설정</a></li> -->
			    </ul>
			</nav>
		</div>
		</header>
       	<div class="account_area">
			<div class="account">${admin.USER_NM_KO}</div>
			<div id="login_pop" class="login_pop_down"></div>
			<span class="login_image"></span>
		</div>
		
		<script>
			$(".gnb ul.gnb_ul").children("li").off("click").on({
		    	"click" : function(e) {	
		    		e.preventDefault();
		    		e.stopPropagation();
		    		alert($(this).attr("data-action"));
		    		$("#path").val($(this).attr("data-action"));
		    		
		    		
		    		$("#pageParam").val($(this).attr("data-param"));
		    		$(".gnb ul.gnb_ul").children("li").removeClass("active");
		    		$(this).addClass("active");
	                $("#menu_userList_cont1").html("");
	                $("#menu_userList_cont1").load("/action/page.do", { path : $(this).attr("data-action") }, function() {
	                	e.preventDefault();
			    		e.stopPropagation();
	                });
		    	}
		    });
			
			function menuDisplay(flag){
				alert(flag);
				mapMoveControl();
				
				
				//select 이벤트
				$(".gnb_next li a").removeClass("selected");
				$('#'+flag+"_cont1_tit").addClass("selected");
				
			/* 	$('.gnb_next').hide();	//전체 소메뉴 hide
				$('#'+flag).show();		//선택 소메뉴 show */
				
				//선택 import jsp show
				
				if(flag == 'menu_setting') changeWidth('admin');
				else changeWidth();

				
				layerClean(eventLayer);
				layerClean(facilityLayer);
				clearInterval(eventM);
				$("#west-panel").show();
				if(flag == 'menu_home'){
					$("#west-panel").hide();
					changeWidth("start");
					search_home();
				}
				else if(flag == 'menu_userList') {
					$('.west_cont').hide();			//기존 import jsp hide
					$('#'+flag+"_cont1").show();
					
					search_userList();	
				}
				else if(flag == 'menu_system'){
					$('.west_cont').hide();			//기존 import jsp hide
					$('#'+flag+"_cont2").show();
				}
			}
		</script>
</body>
</html>