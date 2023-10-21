<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EasyCook! 로그인</title>

<link rel="stylesheet" type="text/css" href="./resources/css/login.css" />
<script src="./resources/js/jquery.js"></script>
<script>
	/* 아이디 찾기  클릭시 아이디찾기 화면 띄우기 */
	function LoginFindID() {
		$('#login_find_id_text').off('click').click(function() {
			$('#login_find_pwd').hide();
			$('#login_find_id').fadeToggle();
			$('.login_find_id_control').val(''); //입력한 값 초기화
			$('#login_find_id_real').hide(); //하단부 찾은 아이디 영역 사라지기
		});
	}

	/* 비밀번호 찾기  클릭시 비밀번호찾기 화면 띄우기 */
	function LoginFindPWD() {
		$('#login_find_pwd_text').off('click').click(function() {
			$('#login_find_id').hide();
			$('#login_find_pwd').fadeToggle();
			$('.login_find_pwd_control').val('');
			$('#login_find_pwd_id_text').focus();
		});
	}

	/* 아이디 찾기 영역에서 버튼 클릭시 하단에 아이디 보여주기   // 가입시 입력한 질문과 전화번호가 일치해야 됨.(추가해야함..) // 입력한 값이 맞지않을때 나오는 영역 추가해야함..*/
	function FindViewID() {
		$('#login_find_button_id').click(function() {
			$('#login_find_id_real').show(); //하단에 아이디 알려주기
			$('.login_find_id_control').val('');
			$('#find_q').val(''); //아이디찾기 클릭시 입력값 초기화
			$('#login_id_box').focus(); //로그인 폼 아이디 입력창으로 포커스이동
		});
	}

	/* 비밀번호 재설정 영역에서 비밀번호 재설정 버튼 클릭시 알림창 띄우기 */
	function RePWD() { /*아이디와 질문 답 맞는지 확인후 맞다면 알림창 띄우고 로그인페이지로 이동하는 함수 추가해야함 */
		if(!confirm('비밀번호를 재설정하시겠습니까?')){
			return false;
		}else{
			if($('#login_find_pwd_newpwd_box').val() != $('#login_find_pwd_tel_box').val()){
				alert('비밀번호가 일치하지 않습니다.');
				return false;
			}
			return true;
		}
	}

	//아이디찾기에서 비밀번호 확인 질문 선택시 비밀번호 확인 답 입력칸으로 포커스 이동
	function loginQ() {
		$('#find_q').change(function() {
			$('#find_q').each(function() {
				$('#login_find_id_q_a').focus();
			});
		});
	}

	//비밀번호 재설정에서 비밀번호 확인 질문 선택시 비밀번호 확인 답 입력칸으로 포커스 이동
	function loginQ_pw() {
		$('#find_pw_q').change(function() {
			$('#find_pw_q').each(function() {
				$('#login_find_pwd_q_a').focus();
			});
		});
	}
</script>
</head>
<%@ include file="./menubar/top_left_menubar.jsp"%>
<body id="login_body" onLoad="$('#login_id_box').focus();">
	<div id="container_login">
		<div id="panel_login">
			<!-- 로그인폼 전체 판 껍데기 -->
			<div id="panle_body_login">
				<!-- 로그인폼 전체 판 -->
				<form action="member_login_ok" method="post" name="login_form"
					onsubmit="return login_check();">
					<!-- 로그인 폼  -->
					<div id="panel_header_login">
						<!-- 로그인폼 타이틀 -->
						<a href="/easycook"><span>EasyCook!</span></a> <span
							id="login_header_title"> 로그인</span>
					</div>
					<div id="panel_table_login">
						<!-- 로그인폼 입력 판 -->
						<div id="login_id" class="login_title">
							<!-- 로그인 폼 아이디 입력 라인 -->
							<strong><label for="login_id_box">아이디</label></strong> <input
								name="login_id_box" id="login_id_box" class="login_control"
								maxlength="14" placeholder="아이디를 입력하세요." />
						</div>

						<div id="login_pwd" class="login_title">
							<!-- 로그인 폼 비밀번호 입력 라인 -->
							<strong><label for="login_pwd_box">비밀번호</label></strong> <input
								type="password" name="login_pwd_box" id="login_pwd_box"
								class="login_control" maxlength="20" placeholder="비밀번호를 입력하세요."
								autocomplete="new-password" />
						</div>

						<div id="login_footer">
							<!-- 로그인폼 하단 로그인/회원가입 버튼 영역 -->
							<input type="submit" value="로그인" id="login_button" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" value="회원가입" id="join_button_login"
								onclick="location='join';" />
						</div>

					</div>
				</form>
				<div id="login_find">
					<a id="login_find_id_text"> <b onclick="LoginFindID()">아이디
							찾기</b>
					</a> <a id="login_find_pwd_text"> <b onclick="LoginFindPWD()">비밀번호
							재설정</b>
					</a>
				</div>
			</div>

			<div id="clear"></div>
			<!-- 아이디 찾기 영역 -->
			<div id="login_find_id">
				<div id="login_find_id_header">
					<a href="/easycook"><span>EasyCook!</span></a> <span
						id="login_find_id_title"> 아이디 찾기</span>
				</div>

				<form method="post" action="id_find" name="idfind">
					<div id="login_find_id_table">
						<div id="login_find_id_q">
							<select name="find_q" id="find_q" onclick="loginQ();">
								<option value="0">질문을 선택하세요.</option>
								<option value="1">어머니의 성함은?</option>
								<option value="2">아버지의 성함은?</option>
								<option value="3">나의 출신 초등학교는?</option>
							</select> <input type="text" name="join_pw_q_a_box" id="login_find_id_q_a"
								class="login_find_id_control" />
						</div>

						<div id="login_find_id_tel">
							<b id="find_tel"><label for="login_find_tel_1">핸드폰 번호</label></b>
							<input type="tel" name="login_find_tel_1" id="login_find_tel_1"
								class="login_find_id_control" maxlength="3" style="width: 11%;" />&nbsp;-
							<input type="tel" name="login_find_tel_2" id="login_find_tel_2"
								class="login_find_id_control" maxlength="4" style="width: 12%;" />&nbsp;-
							<input type="tel" name="login_find_tel_3" id="login_find_tel_3"
								class="login_find_id_control" maxlength="4" style="width: 12%;" />
						</div>

						<div id="login_find_button">
							<div id="login_find_button_id">
								<input type="submit" id="login_find_button_id_title"
									value="check" />
							</div>
						</div>

						<div id="login_find_id_real">
							<c:if test="${check==1}">
								<script>
									alert('아이디를 찾을 수 없습니다.');
								</script>
							</c:if>
							<c:if test="${check==0}">
								<script>
									alert('아이디는 ${findId}입니다.');
								</script>
							</c:if>
						</div>
					</div>
				</form>
			</div>

			<div id="clear"></div>

			<!-- 비밀번호 찾기 영역 -->
			<div id="login_find_pwd">
				<div id="login_find_pwd_header">
					<a href="/easycook"><span>EasyCook!</span></a> <span
						id="login_find_pwd_title"> 비밀번호 재설정</span>
				</div>

				<form method="post" name="login_update_pwd" action="pwd_update" onsubmit="return RePWD()">
					<div id="login_find_pwd_table">
						<div id="login_find_pwd_id">
							<b id="find_pwd_id_title"><label for="login_find_pwd_id_text">아이디</label></b>
							<input type="text" name="login_find_pwd_id_text"
								id="login_find_pwd_id_text" class="login_find_pwd_control" />
						</div>
	
						<div id="login_find_pwd_q">
							<!-- <b id="find_tel_pwd"><label for="login_find_pwd_tel_box">가입시 선택한 질문</label></b> -->
							<select name="find_pw_q" id="find_pw_q" onclick="loginQ_pw();">
								<option value="0">질문을 선택하세요.</option>
								<option value="1">어머니의 성함은?</option>
								<option value="2">아버지의 성함은?</option>
								<option value="3">나의 출신 초등학교는?</option>
							</select> <input type="text" name="login_find_pwd_q_a"
								id="login_find_pwd_q_a" class="login_find_pwd_control" />
						</div>
	
						<div id="login_find_pwd_newpwd">
							<b id="find_pwd_newpwd"><label for="login_find_pwd_newpwd_box">새로운
									비밀번호</label></b> <input type="password" name="login_find_pwd_newpwd_box"
								id="login_find_pwd_newpwd_box" class="login_find_pwd_control"
								autocomplete="new-password" />
						</div>
	
						<div id="login_find_pwd_newpwd_check">
							<b id="find_pwd_newpwd_check"><label
								for="login_find_pwd_tel_box">비밀번호 확인</label></b> <input
								type="password" name="login_find_pwd_tel"
								id="login_find_pwd_tel_box" class="login_find_pwd_control"
								autocomplete="new-password" />
						</div>
	
						<div id="login_find_button_pwd">
							<input type="submit" id="login_find_button_pwd_title" value="비밀번호 재설정"/>
						</div>
						
						<c:if test="${state==1}">
							<script>
								alert('아이디 정보가 일치하지 않습니다.');
							</script>
						</c:if>
						<c:if test="${state==0}">
							<script>
								alert('비밀번호 재설정이 완료되었습니다.');
							</script>
						</c:if>
						
					</div>
				</form>

			</div>

		</div>
	</div>

</body>
</html>






















