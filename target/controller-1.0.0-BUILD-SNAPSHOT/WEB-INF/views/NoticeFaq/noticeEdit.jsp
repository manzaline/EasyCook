<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" type="text/css" href="./resources/css/writenotice.css" />
<script src="./resources/js/jquery.js"></script>
<script type="text/javascript">
	function notice_check(){
		if($.trim($('#adminnotice_title').val()) == ''){
			alert('공지사항 제목을 입력하세요!');
			$("#adminnotice_title").val("").focus();
			return false;
		}
		if($.trim($('#adminnotice_cont').val()) == ''){
			alert('공지사항 내용을 입력하세요!');
			$("#adminnotice_cont").val("").focus();
			return false;
		}
	}
</script>
<%@ include file="../menubar/adminleftbar.jsp"%>
</head>
<body>

	<div class="search-form">
		<h3 class="hidden2">공지사항 관리자페이지</h3>
	</div>

<form method="post" action="noticeEdit_ok" onsubmit="return notice_check();">
	<input type="hidden" name="adminnotice_no" value="${anotice.adminnotice_no}" />
	<input type="hidden" name="page" value="${page}" />
	<div class="board_wrap">
		<div class="board_title">
			<strong>공지사항 수정</strong>
		</div>
		<div class="board_write_wrap">
			<div class="board_write">
				<div class="title">
					<dl>
						<dt>제목</dt>
						<dd>
							<input name="adminnotice_title" id="adminnotice_title" value="${anotice.adminnotice_title}" />
						</dd>
					</dl>
				</div>
				<div class="cont">
					<textarea name="adminnotice_cont" id="adminnotice_cont" >${anotice.adminnotice_cont}</textarea>
				</div>
				<div class="buttonwrite">
					<input type="submit" id="save" value="수정" style="color:white" />
					<input type="reset" id="cancel" value="취소" onclick="location.href='adminnotice'" />
				</div>
			</div>
		</div>

	</div>
	</form>
</body>
</html>