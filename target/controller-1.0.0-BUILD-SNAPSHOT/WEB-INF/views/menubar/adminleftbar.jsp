<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="./resources/css/adminleftbar.css" />
<div id="menubar_wrap">

	<div id="top_menubar">
		<div id="top_login_join_btn">
			<form method="post" action="member_logout">
				<c:if test="${empty id}">
					<a href="login">Login</a>&nbsp;&nbsp; 
					<a href="join">Join</a> <br> 
				</c:if>
				<c:if test="${not empty id}">
					<a href="mypage_view">마이페이지</a> <br>
					<a href="admin">관리자 페이지</a><br>
				</c:if>
				<input type="submit" value="logout" />
			</form>
		</div>
	</div>

	<div id="left_menubar">
		<div id="left_menu">
			<div id="left_logo">
				<a href="/easycook"><img
					src="./resources/images/logo.png" /></a>
			</div>
			<div id="left_sessionInfo">ADMIN : ${id}</div>
			<div id="left_menulink">
				<div id="left_notice">
					<input type="checkbox" id="answer01"> 
					<label for="answer01">레시피</label>
					<div style="margin-top: 15px;">
						<a href="admin_post_list">레시피 게시글 관리</a>
					</div>
				</div>
				<div id="left_board">
					<input type="checkbox" id="answer02"> 
					<label for="answer02">회원</label>
					<div style="margin-top: 15px;" class="open">
						<a href="admin">회원 조회</a>
					</div>
				</div>
				<div id="left_news">
					<input type="checkbox" id="answer03"> 
					<label for="answer03">열린마당</label>
					<div style="margin-top: 15px;">
							<a href="adminnotice">공지사항 관리</a><br/><br/>
							<a href="adminfaq">FAQ 관리</a><br/><br/>
							<a href="admin_hotnews_list">핫뉴스 관리</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>