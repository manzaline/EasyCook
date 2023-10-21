<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>핫뉴스 내용보기</title>
<link rel="stylesheet" type="text/css" href="./resources/css/admin_hotNewsBoard.css" />
<style>

#admin_hotnews_cont_wrap{
	margin: 100px 0 0 500px;
}
</style>
</head>
<body>
	<%@ include file="../menubar/adminleftbar.jsp"%>
	<div id="admin_header">
		<h3 style="font-size: 200%; text-align: center; padding: 10px; margin: 0 0 0 0;">핫뉴스 관리</h3>
	</div>
	<div id="admin_hotnews_cont_wrap">
	<c:set var="h" value="${hvo }" /> 
	제목 : <c:out value="${h.htitle }" /> <br>
	글쓴이 : ${h.hwriter } <br>
	내용 : ${h.hcont }<br>
	링크 : <a href="${h.hlink }" target="_blank">${h.hlink }</a><br>
	조회수 : ${h.viewcnt }<br>
	날짜 : ${h.regdate }<br>
	</div>
</body>
</html>