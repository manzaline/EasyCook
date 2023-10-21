<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link rel="stylesheet" type="text/css" href="./resources/css/admin.css" />
<script src="./resources/js/jquery.js"></script>
<script src="./resources/js/member.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body id="admin_body">
	<%@ include file="./menubar/adminleftbar.jsp"%>
	<div id="admin_header">
		<h3 style="font-size: 200%; text-align: center; padding: 10px; margin: 0 0 0 0;">회원 관리</h3>
	</div>
	
	<!-- 회원정보 조회 및 수정 영역 -->
	<div id="admin_member"> 
		<div id="admin_member_table">
			<div id="admin_member_header">
				<span id="info_title">회원 정보 관리</span>
			</div>
			<form method="post" name="m" action="admin_member_edit_ok" onsubmit="return edit_check();">
			<div id="admin_member_cont">
				<div id="admin_member_id">
					<strong id="member_id" class="member_text">아이디</strong> 
					<input type="text" name="join_id_box" id="join_id_box" class="member_info" value="${m.join_id_box}" readonly />
					<br/><br/>
				</div>
				<div id="admin_member_email">
					<strong id="member_email" class="member_text">이메일</strong> 
					<input type="text" name="join_email_1_box" id="join_email_1_box" class="member_info" value="${m.join_email_1_box}" />
					@&nbsp;<input type="text" name="join_email_2_box" id="join_email_2_box" class="member_info" value="${m.join_email_2_box}" readonly />&nbsp;
					<select name="join_email_3_box" id="join_email_3_box" class="member_info" onchange="emailselect();" onblur="domain_check();" >
						<c:forEach var="mail" items="${email}">
							<option value="${mail}"
							<c:if test="${m.join_email_2_box == mail}">
							${'selected'}</c:if>>${mail}</option>
						</c:forEach>
					</select>
					<br/><br/>
				</div>
				<div id="admin_member_name">
					<strong id="member_name" class="member_text">이름</strong>
					<input type="text" id="join_name_box" name="join_name_box" class="member_info" value="${m.join_name_box}" >
					<br/><br/>
				</div>
				<div id="admin_member_nickname">
					<strong id="member_nickname" class="member_text">닉네임</strong> 
					<input type="text" name="join_nickname_box" id="join_nickname_box" class="member_info" value="${m.join_nickname_box}"/>
					<br/><br/>
				</div>
				<div id="admin_member_tel">
					<strong id="member_tel" class="member_text">핸드폰 번호</strong> 
					<input type="text" name="join_tel_1_box" id="join_tel_1_box" class="member_info" value="${m.join_tel_1_box}" />
					-<input type="text" name="join_tel_2_box" id="join_tel_2_box" class="member_info" value="${m.join_tel_2_box}" />
					-<input type="text" name="join_tel_3_box" id="join_tel_3_box" class="member_info" value="${m.join_tel_3_box}" />
					<br/><br/>
				</div>
				<div id="admin_member_pwd_q">
					<strong id="member_pwd_q" class="member_text">가입시 선택한 질문</strong> 
					<input type="text" name="join_pw_q_box" id="join_pw_q_box" class="member_info" value="${m.join_pw_q_box}" readonly />
					<br/><br/>
					<strong id="member_pwd_q_a" class="member_text">가입시 선택한 질문의 답</strong> 
					<input type="text" name="join_pw_q_a_box" id="join_pw_q_a_box" class="member_info" value="${m.join_pw_q_a_box}" readonly />
					<br/><br/>
				</div>
				<div id="admin_member_post">
					<strong id="member_post" class="member_text">우편번호</strong> 
					<input type="text" name="join_post_box_1" id="join_post_box_1" class="member_info" value="${m.join_post_box_1}" readonly />
					<input type="button" name="join_post_btn" id="join_post_btn" value="우편번호찾기" onclick="Postcode()" />
					<br/><br/>
					<strong id="member_addr1" class="member_text">주소</strong> 
					<input type="text" name="join_post_box_2" id="join_post_box_2" class="member_info" value="${m.join_post_box_2}" readonly />
					<br/><br/>
					<strong id="member_addr2" class="member_text">상세주소</strong> 
					<input type="text" name="join_post_box_3" id="join_post_box_3" class="member_info" value="${m.join_post_box_3}" />
					<br/><br/>
				</div>
			</div>
			
				<div id="admin_member_pwd">
					<strong id="member_pwd_reset" class="admin_infoBtn">비밀번호 초기화</strong>
					<input type="checkbox" id="member_pwd_reset_info" name="resetPwd" value="1"/><br/><br/>
				</div>
				<div id="edit_info">
					<input type="submit" id="admin_member_edit" class="admin_infoBtn" value="수정" />
				</div>
			</form>
				<div id="del_member">
					<button id="admin_member_set" class="admin_infoBtn" onclick="if(confirm('정말로 탈퇴처리 하시겠습니까?') == true){location='admin_member_del?join_id_box=${m.join_id_box}&page=${page}';}else{return ;}">탈퇴</button>
				</div>
				<div id="admin_info_close">
					<button id="close" class="admin_infoBtn" onclick="location='admin?page=${page}';">X</button>
				</div>	
		</div>
	</div>
	
</body>
</html>