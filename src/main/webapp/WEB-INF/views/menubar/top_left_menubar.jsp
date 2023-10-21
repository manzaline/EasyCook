<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="./resources/css/top_left_menubar.css"/>
<script src="./resources/js/jquery.js"></script>
<script>
	//상단 검색바 이벤트 생성
	//topSearchbarEvent();
	
	//상단 검색창, 좌측 메뉴바 팝업 시 스크롤 정지
	top_search_scrollLock();
	
//////////////////////////// 페이지 흐림처리/////////////////////////////////////
	function windowBlurByMask(){  
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();
		
		$("#page_blur").css({"width":maskWidth, "height":maskHeight});
		
		$("#page_blur").fadeTo("normal", 0.6);
	}
	
	//mask 해제
	function windowBlurHide(){
		$("#page_blur").fadeOut("normal");
	}
//////////////////////////// 페이지 흐림처리 END ////////////////////////////////


	//상단 메뉴바 검색창, 좌측 메뉴바가 팝업되었을 경우 페이지 스크롤 중지
	function top_search_scrollLock(){
		$('#top_search_icon, #top_search_input, #left_menu, #page_blur').on('scroll touchmove mousewheel', function(e) {
			  e.preventDefault();
			  e.stopPropagation();
			  return false;
		});
	}

//////////////////////// 상단 메뉴바 검색아이콘 마우스 이벤트 //////////////////////////
	var topSearchFlag = 0;
	//function topSearchbarEvent(){
	$(document).ready(function(){
		$("#top_search_icon").click(function(){
			if(topSearchFlag == 1){
				$("#top_search_input").animate({
					width: "0",
					opacity: "0"
				}, 200);
				$("#top_search_input").val('');
				windowBlurHide();
				topSearchFlag = 0;
			}else if(topSearchFlag == 0){
				$("#top_search_input").animate({
					width: "60%",
					opacity: "1"
				}, 200);
				$("#top_search_input").focus();
				windowBlurByMask();
				top_search_scrollLock();
				topSearchFlag = 1;
			}
		});
	});
	//}
////////////////////// 상단 메뉴바 검색아이콘 마우스 이벤트 END ////////////////////////


//////////////////////// 좌측 메뉴바 팝업 & close 이벤트 ///////////////////////////
	$(document).ready(function(){
		$("#left_menubtn").click(function(){
			$("#left_menu").animate({
				width: "300px",
				opacity: "1",
				left: "0px"
			});
			$("#left_menubtn").animate({
				opacity: "0"
			});
			windowBlurByMask();
			top_search_scrollLock();
			$("#top_search_hide").unbind("mouseover");
			$("#top_search_hide").unbind("mouseout");
			$("#top_search_icon").unbind("mouseover");
		});
		$("#left_menuclosebtn").click(function(){
			$("#left_menu").animate({
				width: "0",
				opacity: "0",
				left: "-100px"
			});
			$("#left_menubtn").animate({
				opacity: "1"
			});
			windowBlurHide();
			//topSearchbarEvent();
		});
	});
////////////////////// 좌측 메뉴바 팝업 & close 이벤트 END /////////////////////////

	//좌측 메뉴바 링크 마우스 오버시 이벤트
	function iconActive(link){
		$(link).find("img").attr("src", "./resources/images/leftmenu_Linkactiveimage.png")
	}
	function iconInactive(link){
		$(link).find("img").attr("src", "./resources/images/leftmenu_Linkimage.png")
	}
	
	//상단 메뉴바 검색 이벤트
	$(document).ready(function(){
		$('#top_search_input').keydown(function(key){
			if(key.keyCode == 13){
				if(topSearchFlag == 1){
					location.href = 'recipeBoard_view?page=1&post=0&cpage=1&searchType=t&searchText='+$('#top_search_input').val();
				}
			}
		});
	});

</script>
<c:if test="${empty id}">
	<div id="menubar_wrap">
		<div id="page_blur"></div>
		
		<div id="top_menubar">
			<div id="top_login_join_btn">
				<a href="login">Login</a>&nbsp;&nbsp;
				<a href="join">Join</a>
				<br>
			</div>
			<div id="top_search">
				<img id="top_search_icon" src="./resources/images/top_search.png" width="30" height="30"/>
				<input id="top_search_input" type="text"/>
			</div>
			<div id="top_search_hide"></div>
			
		</div>
		
		<div id="left_menubar">
			<div id="left_menubtn">
				<img src="./resources/images/left_menubtn.png" width="40" height="40"/>
			</div>
			<div id="left_menu">
				<div id="left_menuclosebtn">
					<img src="./resources/images/left_menuclosebtn.png" width="40" height="40"/>
				</div>
				<div id="left_logo">
					<a href="/easycook"><img src="./resources/images/logo.png"/></a>
				</div>
				<div id="left_sessionInfo">
					[로그인이 필요합니다.]
				</div>
				<div id="left_menulink">
					<a href="Notice">
						<div id="left_notice" onmouseover="iconActive(this);" onmouseout="iconInactive(this);">
							공지사항
							<img src="./resources/images/leftmenu_Linkimage.png" width="33px" height="33px"/>
						</div>
					</a>
					<a href="recipeBoard_view">
						<div id="left_board" onmouseover="iconActive(this);" onmouseout="iconInactive(this);">
							레시피 게시판
							<img src="./resources/images/leftmenu_Linkimage.png" width="33px" height="33px"/>
						</div>
					</a>
					<a href="hotNewsBoard_view">
						<div id="left_news" onmouseover="iconActive(this);" onmouseout="iconInactive(this);">
							<img src="./resources/images/leftmenu_Linkimage.png" width="33px" height="33px"/>
							핫뉴스
						</div>
					</a>
					<a href="FAQ">
						<div id="left_faq" onmouseover="iconActive(this);" onmouseout="iconInactive(this);">
							FAQ
							<img src="./resources/images/leftmenu_Linkimage.png" width="33px" height="33px"/>
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>
</c:if>

<c:if test="${!empty id}">
	<div id="menubar_wrap">
		<div id="page_blur"></div>
		
		<div id="top_menubar">
			<div id="top_login_join_btn">
				<form method="post" action="member_logout">
					<a href="mypage_view">마이페이지</a> 
					<br> 			
						<c:if test="${state == 3}">
							<a href="admin">관리자 페이지</a>
							<br>
						</c:if>
					<input type="submit" value="logout" />
					
				</form>
			</div>
			
			<div id="top_search">
				<img id="top_search_icon" src="./resources/images/top_search.png" width="30" height="30"/>
				<input id="top_search_input" type="text"/>
			</div>
			<div id="top_search_hide"></div>
			
		</div>
		
		<div id="left_menubar">
			<div id="left_menubtn">
				<img src="./resources/images/left_menubtn.png" width="40" height="40"/>
			</div>
			<div id="left_menu">
				<div id="left_menuclosebtn">
					<img src="./resources/images/left_menuclosebtn.png" width="40" height="40"/>
				</div>
				<div id="left_logo">
					<a href="/easycook"><img src="./resources/images/logo.png"/></a>
				</div>
				<div id="left_sessionInfo">
					[${id}님]<br>[로그인을 환영합니다!]
				</div>
				<div id="left_menulink">
					<a href="Notice">
						<div id="left_notice" onmouseover="iconActive(this);" onmouseout="iconInactive(this);">
							공지사항
							<img src="./resources/images/leftmenu_Linkimage.png" width="33px" height="33px"/>
						</div>
					</a>
					<a href="recipeBoard_view">
						<div id="left_board" onmouseover="iconActive(this);" onmouseout="iconInactive(this);">
							레시피 게시판
							<img src="./resources/images/leftmenu_Linkimage.png" width="33px" height="33px"/>
						</div>
					</a>
					<a href="hotNewsBoard_view">
						<div id="left_news" onmouseover="iconActive(this);" onmouseout="iconInactive(this);">
							<img src="./resources/images/leftmenu_Linkimage.png" width="33px" height="33px"/>
							핫뉴스
						</div>
					</a>
					<a href="FAQ">
						<div id="left_faq" onmouseover="iconActive(this);" onmouseout="iconInactive(this);">
							FAQ
							<img src="./resources/images/leftmenu_Linkimage.png" width="33px" height="33px"/>
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>
</c:if>