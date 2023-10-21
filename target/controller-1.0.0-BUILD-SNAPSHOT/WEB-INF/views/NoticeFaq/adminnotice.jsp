<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 관리</title>

<link rel="stylesheet" type="text/css"
	href="./resources/css/adminnotice.css" />
<script src="./resources/js/jquery.js"></script>
</head>
<%
	Date nowTime = new Date();
SimpleDateFormat sf = new SimpleDateFormat("yy.MM.dd. a. hh.mm");
%>
<body id="noticebody">
	<%@ include file="../menubar/adminleftbar.jsp"%>
	<div id="noticeheader">
		<h3
			style="font-size: 200%; text-align: center; padding: 10px; margin: 0 0 0 0;">공지사항
			관리</h3>
	</div>

	<div id="notice_panel">
		<div id="notice_search">
			<form class="table-form">
				<fieldset>
					<legend class="hidden">검색</legend>
					<label class="hidden">검색분류</label> 
					<select name="find_field">
						<option value="adminnotice_title" 
						<c:if test="${find_field=='adminnotice_title'}">${'selected'}</c:if>>제목</option>
					</select> <label class="hidden">검색어</label> 
				<input name="find_name" id="find_name" value="${find_name}" placeholder="검색어를 입력해주세요." /> 
				<input type="submit" value="검색" /> 
				<input class="write" type="button" value="공지사항등록"
						onclick="location.href='noticewrite'" />
				</fieldset>
			</form>
		</div>
			<div class="noticetitle">
			<!-- <b>제목</b> <b>작성자</b> <b>날짜</b> -->
				<div id=title1>번호</div>
				<div id=title2>제목</div>
				<div id=title3>작성자</div>
				<div id=title4>등록날짜</div>
				<div id=title5>관리</div>
			</div>

			<div id="notice_cont">
		<c:if test="${!empty anlist}">
			<c:forEach var="an" items="${anlist}">
				<div id="notice_cont_list">
					<div id="con1">${an.adminnotice_no}</div>
					<div id="con2">
					<c:if test="${fn:length(an.adminnotice_title)>=9}">
 					${fn:substring(an.adminnotice_title,0,16)}...
					</c:if>
					<c:if test="${fn:length(an.adminnotice_title)<9}">
					${an.adminnotice_title}
					</c:if>
					</div>
					<div id="con3">관리자</div>
					<div id="con4">${an.adminnotice_date}</div>
					<div id="admin_button">
						<div id="button">
							<input type="button" value="수정" onclick="location.href='noticeEdit?adminnotice_no=${an.adminnotice_no}&page=${page}';" /> 
							<input type="button" value="삭제" onclick="if(confirm('정말로 삭제할까요?') == true){
							location='noticeDelete?adminnotice_no=${an.adminnotice_no}&page=${page}';	
							}else{ return ;}" />
						</div>
					</div>
				</div>
				</c:forEach>
			</c:if>
			
			<c:if test="${empty anlist}">
				<div id="con5" style="text-align:center;margin-bottom: 100px;">공지사항이없습니다.</div>
			</c:if>

			

			<div id="admin_page_number" style="text-align: center;">
				<%-- 검색전 페이징 --%>
				<c:if test="${(empty find_field) && (empty find_name)}">
					<c:if test="${page<=1}">
     [이전]&nbsp;
    </c:if>
					<c:if test="${page>1}">
						<a href="adminnotice?page=${page-1}">[이전]</a>&nbsp;
    </c:if>

					<%--현재 쪽번호 출력--%>
					<c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
						<c:if test="${a == page}">
							<%--현재 페이지가 선택되었다면--%>
      <${a}>
     </c:if>
						<c:if test="${a != page}">
							<%--현재 페이지가 선택되지 않았
     다면 --%>
							<a href="adminnotice?page=${a}">[${a}]</a>&nbsp;
     </c:if>
					</c:forEach>

					<c:if test="${page >= maxpage}">
    [다음]
    </c:if>
					<c:if test="${page<maxpage}">
						<a href="adminnotice?page=${page+1}">[다음]</a>
					</c:if>
				</c:if>

				<%-- 검색후 페이징 --%>
				<c:if test="${(!empty find_field) || (!empty find_name)}">
					<c:if test="${page<=1}">
     [이전]&nbsp;
    </c:if>
					<c:if test="${page>1}">
						<a
							href="adminnotice?page=${page-1}&find_field=${find_field}&find_name=${find_name}">[이전]</a>&nbsp;
    </c:if>

					<%--현재 쪽번호 출력--%>
					<c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
						<c:if test="${a == page}">
							<%--현재 페이지가 선택되었다면--%>
      <${a}>
     </c:if>
						<c:if test="${a != page}">
							<%--현재 페이지가 선택되지 않았
     다면 --%>
							<a
								href="adminnotice?page=${a}&find_field=${find_field}&find_name=${find_name}">[${a}]</a>&nbsp;
     </c:if>
					</c:forEach>

					<c:if test="${page >= maxpage}">
    [다음]
    </c:if>
					<c:if test="${page<maxpage}">
						<a
							href="adminnotice?page=${page+1}&find_field=${find_field}&find_name=${find_name}">[다음]</a>
					</c:if>
				</c:if>
			</div>
			<%-- 
				<div id="admin_page" style="text-align: center;">

					<div id="admin_page_number">
						<%
							int currentPage;
						if (request.getParameter("page") == null) {
							currentPage = 1;
						} else {
							currentPage = Integer.parseInt(request.getParameter("page"));
						}

						int totalCount = 200;
						int countList = 8;
						int countPage = 7;

						int totalPage = totalCount / countList;

						if (totalCount % countList != 0) {
							totalPage++;
						}

						if (totalPage < currentPage) {
							currentPage = totalPage;
						}

						int startPage = currentPage - 3;
						int endPage = currentPage + 3;
						if (currentPage < 4) {
							startPage = 1;
							endPage = 7;
						}
						if (endPage > totalPage) {
							startPage = totalPage - 6;
							endPage = totalPage;
						}

						if (currentPage > 4) {
						%>
						<a href="adminnotice?page=<%=1%>">[FIRST]</a>
						<% }
						if (currentPage > 1) { %>
						<a href="/adminnotice?page=<%=currentPage - 1%>">[PREV]</a>
						<% }
						for (int iCount = startPage; iCount <= endPage; iCount++) { %>
						<a href="adminnotice?page=<%=iCount%>"> 
						<% if (iCount == currentPage) { %>
						<span class="CurrentPageNumber">&nbsp;<%=iCount%>&nbsp; </span> 
						<% } else {
 							%> <span class="PageNumber">&nbsp;<%=iCount%>&nbsp; </span> 
 							<% } %> </a>
						<% }
						if (currentPage < totalPage) {%>
						<a href="adminnotice?page=<%=currentPage+1%>">[NEXT]</a>
						<%}
						if (endPage < totalPage) {%>
						<a href="adminnotice?page=<%=totalPage%>">[LAST]</a>
						<%} %>

					</div>
				</div>
				--%>


		</div>
	</div>


</body>
</html>