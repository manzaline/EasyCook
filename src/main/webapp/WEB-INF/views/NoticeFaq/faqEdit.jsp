<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문과답변</title>
<link rel="stylesheet" type="text/css" href="./resources/css/writefaq.css" />
<script src="./resources/js/jquery.js"></script>
<script type="text/javascript">
	function faq_check(){
		if($.trim($('#adminfaq_title').val()) == ''){
			alert('질문과답변 제목을 입력하세요!');
			$("#adminfaq_title").val("").focus();
			return false;
		}
		if($.trim($('#adminfaq_cont').val()) == ''){
			alert('질문과답변 내용을 입력하세요!');
			$("#adminfaq_cont").val("").focus();
			return false;
		}
	}
</script>
<%@ include file="../menubar/adminleftbar.jsp"%>
</head>
<body>

	<div class="search-form">
		<h3 class="hidden2">질문과 답변 관리자페이지</h3>
	</div>
	
<form method="post" action="faqEdit_ok" onsubmit="return faq_check();">
	<input type="hidden" name="adminfaq_no" value="${afaq.adminfaq_no}" />
	<input type="hidden" name="page" value="${page}" />
	<div class="board_wrap">
		<div class="board_title">
			<strong>질문과 답변 수정</strong>
		</div>
		<div class="board_write_wrap">
			<div class="board_write">
				<div class="title">
					<dl>
						<dt>제목</dt>
						<dd>
							<input name="adminfaq_title" id="adminfaq_title" value="${afaq.adminfaq_title}" />
						</dd>
					</dl>
				</div>
				<div class="cont">
					<textarea name="adminfaq_cont" id="adminfaq_cont" >${afaq.adminfaq_cont}</textarea>
				</div>
				<div class="buttonwrite">
					<input type="submit" id="save" value="수정" style="color:white" />
					<input type="reset" id="cancel" value="취소" onclick="location.href='adminfaq'" />
				</div>
			</div>
		</div>

	</div>
	</form>
</body>
</html>