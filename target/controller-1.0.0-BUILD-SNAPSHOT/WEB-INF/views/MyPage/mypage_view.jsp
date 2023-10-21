<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
<link rel="stylesheet" type="text/css" href="./resources/css/mypage_view.css" />
<script src="./resources/js/jquery.js"></script>

<script>

</script>

<body>
<%@ include file="../menubar/top_left_menubar.jsp"%>
	<div id="mp_header">
		<b style="font-size: 200%;">마이 페이지</b>
	</div>
	
	<div id="mp_member_info">
			<img id="mp_info_img" src="./resources/images/human_icon.png" width="230" height="230"/>
			<input type="button" id="mp_info_update" value="회원정보 수정" onclick="location.href='member_edit';"/>				
			
		</div>
		
	<div id="mp_panel">
		
			<div id="mp_title_list">
				<input type="button" id="mp_btn_recipe" value="나의 레시피" onclick="location.href='mp_recipe_list?page=1';"/>			
				<input type="button" id="mp_btn_home" value="홈으로 돌아가기" onclick="location.href='mypage_view';"/>				
				<input type="button" id="mp_btn_comment" value="나의 댓글" onclick="location.href='mp_comment_list?page=1';"/>				
			</div>
			<div id="mp_contents">		
			<img id="mp_cont_img" src="./resources/images/logo_B.png" width="250" height="250"/><br/>
			레시피를 직접 올려보세요!<br/>
			자랑하고 싶은 나만의  레시피! 공유하고 싶은 멋진 레시피를 올려 주세요!
			<input type="button" id="mp_write_recipe" value="레시피 등록하기" onclick="location.href='recipeBoard_write';"/>				
			</div>
	</div>

</body>
</html>