<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>핫뉴스 수정</title>
<link rel="stylesheet" type="text/css" href="./resources/css/admin_hotNewsBoard.css" />
<script src="./resources/js/jquery.js"></script>
<script type="text/javascript">
function write_check(){
	 	
 	if($.trim($('#htitle').val()) == ''){
 		alert('글제목을 입력하세요!');
 		$('#htitle').val('').focus();
 		return false;
 	}
 	
 	if($.trim($('#hlink').val()) == ''){
 		alert('링크를 입력하세요!');
 		$('#hlink').val('').focus();
 		return false;
 	}
 	
 	if($.trim($('#hcont').val()) == ''){
 		alert('글내용을 입력하세요!');
 		$('#hcont').val('').focus();
 		return false;
 	} 	
 }
 
// 	function thumbnail(event) {
// 		var reader = new FileReader();
// 		reader.onload = function(event) {
// 			var img = document.createElement("img");
// 			img.setAttribute("src", event.target.result);
// 			document.querySelector("div#image_container").appendChild(img);
// 		};
// 		reader.readAsDataURL(event.target.files[0]);
// 	}
</script>
</head>

<body id="hn_admin_edit_body">
	<%@ include file="../menubar/adminleftbar.jsp"%>
	<div id="admin_header">
		<b style="font-size: 200%;">핫뉴스 수정</b>
	</div>

	<div id="admin_panel">
		<form method="post" action="admin_hotnews_edit_ok" onsubmit="return write_check();" enctype="multipart/form-data">
			<input type="hidden" name="hno" value="${hvo.hno }" >
			<input type="hidden" name="page" value="${page}" >
			
			<table id="admin_hn_write_table" style="border-collapse: collapse">
				<tr>
					<th>제목</th><td><input type="text" id="htitle" name="htitle" size="60" value="${hvo.htitle }"/></td>
				</tr>
				<tr>
					<th>내용</th><td><textarea rows="10" id="hcont" name="hcont" cols="62" style="resize: none;" >${hvo.hcont }</textarea></td>
				</tr>
				<tr>
					<th>파일첨부</th><td><input type="file" id="hfile" name="hfile" />${hvo.hfile }</td>
					
				</tr>
				<tr>
					<th>링크</th><td><input type="text" id="hlink" name="hlink" size="60" value="${hvo.hlink }"/></td>
				</tr>					
			</table>
			<div id="admin_hn_button_wrap">
						<input type="submit" id="btn_submit" value="등록" /> 
						<input type="reset" id="btn_reset" value="취소" onclick="return $('#htitle').focus();" /> 
						<input type="button" id="btn_list" value="목록보기" onclick="location.href='/easycook/admin_hotnews_list?page=${page}&find_field=${find_field }&find_name=${find_name }';">
			</div>	
			
<%--
			핫뉴스 제목 : <input type="text" id="htitle" name="htitle" size="40" value="${hvo.htitle }"/> <br> <br>
			<p>핫뉴스 내용 :&nbsp;</p><textarea rows="10" id="hcont" name="hcont" cols="40" style="resize: none;" >${hvo.hcont }</textarea> <br><br>
			썸네일(미리보기) : <input type="file" id="hfile" name="hfile" />${hvo.hfile } <br><br>
<!-- 			썸네일(미리보기) : <input type="file" id="image" accept="image/*" value="${hvo.hfile }" onchange="thumbnail(event);" /> <br><br> -->
<!-- 			<div id="image_container" ></div><br><br>  -->
			링크 : <input type="text" id="hlink" name="hlink" size="80" value="${hvo.hlink }"/> <br><br>
			<div id="admin_hn_button_wrap">
				<input type="submit" id="btn_submit" value="등록" /> 
				<input type="reset" id="btn_reset" value="취소" onclick="return $('#htitle').focus();" /> 
				<input type="button" id="btn_list" value="목록보기" onclick="location.href='/easycook/admin_hotnews_list?page=${page}&find_field=${find_field }&find_name=${find_name }';">
			</div>
 --%>			
		</form>
	</div>
</body>
</html>