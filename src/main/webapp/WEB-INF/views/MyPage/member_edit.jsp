<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EasyCook! 회원 정보 변경</title>
<link rel="stylesheet" type="text/css" href="./resources/css/member_edit.css"/>
<script src="./resources/js/jquery.js"></script>
<script src="./resources/js/member.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>
<body>
<div id="panel">
			<div id="panel-body">
						<form name="m" method="post" action="member_edit_ok" onsubmit="return my_edit_check();" onreset="return editreset();">				
						<div id="panel-header">
						<a href="./mypage_view" id="update_header_title_1"><span>EasyCook!</span></a><span id="update_header_title_2"> 회원 정보 수정 </span>
					</div>
					
					<div id="panel-table">
						<div id="update_id" class="update_title">
							<strong><label for="join_id_box">아이디</label></strong>
							<input type="text" name="join_id_box" id="join_id_box"
							class="form-control" maxlength="14"
							value="${m.join_id_box}" readonly/><br/>
							<span class="error" id="iderror"></span>
						</div>
						
						<div id="update_email" class="update_title">
							<strong><label for="join_email_1_box">이메일</label></strong>
							<input type="text" name="join_email_1_box" id="join_email_1_box" class="form-control"
							value="${m.join_email_1_box}" />&nbsp;@
							<input type="text" name="join_email_2_box" id="join_email_2_box" class="form-control" value="${m.join_email_2_box}" />&nbsp;
							<select name="join_email_3_box" class="form-control" onchange="emailselect();" >
								<c:forEach var="mail" items="${email}">
									<option value="${mail}">${mail}</option>
								</c:forEach>
							</select>
							<br/>
							<span class="error" id="emailerror"></span>
						</div>
						
						<div id="update_name" class="update_title">
							<strong><label for="join_name_box">이름</label></strong>
							<input type="text" name="join_name_box" id="join_name_box"
							class="form-control" maxlength="6" value="${m.join_name_box}" />
							<br/>
							<span class="error" id="nameerror"></span>
						</div>
						
						<div id="update_nickname" class="update_title">
							<strong><label for="join_nickname_box">닉네임</label></strong>
							<input type="text" name="join_nickname_box" id="join_nickname_box" 
							class="form-control" maxlength="8" value="${m.join_nickname_box}" />
							<br/>
							<span class="error" id="nickerror"></span>
						</div>
						
						<div id="update_tel" class="update_title">
							<strong><label for="join_tel_1_box">핸드폰 번호</label></strong>
							<input type="tel" name="join_tel_1_box" id="join_tel_1_box"
							class="form-control" maxlength="3" value="${m.join_tel_1_box}" style="width: 10%;" />&nbsp;
							<input type="tel" name="join_tel_2_box" id="join_tel_2_box"
							class="form-control" maxlength="4" value="${m.join_tel_2_box}" style="width: 11%;" />&nbsp;
							<input type="tel" name="join_tel_3_box" id="join_tel_3_box"
							class="form-control" maxlength="4" value="${m.join_tel_3_box}" style="width: 11%;" />
							<br/>
							<span class="error" id="telerror"></span>
						</div>
						
						<div id="update_post_1" class="update_title">
							<strong>주소</strong>
							<input type="text" name="join_post_box_1" id="join_post_box_1" class="form-control" 
							value="${m.join_post_box_1}"  />&nbsp;&nbsp;
							<input type="button" id="update_post_btn" value="우편번호찾기" onclick="Postcode()" />
						</div>
						
						<div id="update_post_2" class="update_title">
							<input type="text" name="join_post_box_2" id="join_post_box_2" class="form-control" 
							value="${m.join_post_box_2}" />
						</div>
						
						<div id="clear"></div>
						
						<div id="update_post_3" class="update_title">
							<input type="text" name="join_post_box_3" id="join_post_box_3" class="form-control"  
							value="${m.join_post_box_3}"  />
							<br>
							<span class="error" id="posterror"></span>
						</div>
						
						<input type="hidden" name="join_pw_check" id="join_pw_check" value="${ m.join_pw_box }"/>
						<div id="update_pw" class="update_title">
							<strong><label for="join_pw_box">비밀번호</label></strong>
							<input type="password" name="join_pw_box" id="join_pw_box" 
							class="form-control" maxlength="20" autocomplete="new-password"/>
							<br/>
							<span class="error" id="pwerror"></span>
						</div>
						
						<div id="update_footer">
							<input type="submit" value="수정" id="update_button" />&nbsp;&nbsp;
							<input type="reset" value="취소" id="delete_button" onclick="$('#join_id_box').focus();"/>&nbsp;&nbsp;
							<input type="button" value="탈퇴" id="member_del_btn" onclick="location.href='member_del';"/>
						</div>
						</div>
						</form>
					 
			</div>
			</div>
			</body>
					</html>
