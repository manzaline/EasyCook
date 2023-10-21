<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" type="text/css" href="./resources/css/gong.css" />
<script src="./resources/js/jquery.js"></script>
<script>
$(function(){
	$("dd").hide();
	
	$("dt").click(function(){
		if( $(this).next().css("display")=="none"){
			
			$(this).next().slideDown("fast");
		}else
			$(this).next().slideUp("fast");
	});
});
</script>

<%@ include file="../menubar/top_left_menubar.jsp"%>
<%--
	//하단 페이지 번호 생성을 위한 전체 게시글 수 검색
int totalPages = 3;

//현재 페이지
int currentPage;
if (request.getParameter("page") == null) {
	currentPage = 1;
} else {
	currentPage = Integer.parseInt(request.getParameter("page"));
}
--%>

<div id="GongPage">
    <div class="board_title">공지사항</div>
	<div class="search-form">
		<form class="table-form">
			<fieldset style="margin-top:70px;">
				<legend class="hidden">검색</legend>
				<label class="hidden">검색분류</label> <select name="find_field">
					<option value="adminnotice_title" <c:if test="${find_field == 'adminnotice_title'}"> ${'selected'}</c:if>>제목</option>
				</select> <label class="hidden">검색어</label> 
				<input type="text" name="find_name" value="${find_name}" placeholder="검색어를 입력해주세요." />
				<input type="submit" value="검색" />
			</fieldset>
		</form>
	</div>
	<%-- <div>
		<%
		int startPosting = currentPage;
		int lastPosting = currentPage;
		if (currentPage > totalPages) {
			lastPosting = totalPages;
		}
		for (int i = startPosting; i <= lastPosting; i++) {
		%> --%>
		<c:if test="${!empty anlist}">
			<c:forEach var="an" items="${anlist}">
				<div class="gong">
					<dl>
						<dt><p class="title">${an.adminnotice_title}</p><p class="iconDiv"><img src="https://happyjung.diskn.com/data/lecture/icon_jquery_faq2_icon_arrow.png"></p></dt>
						<dd>
							<p>${an.adminnotice_cont}</p>
						</dd>
					</dl>
				</div>
			</c:forEach>
		</c:if>
			
		<c:if test="${empty anlist}">
			<div class="gong">
					<dl>
						<dt><p class="title">공지사항이 없습니다!</p><p class="iconDiv"><img src="https://happyjung.diskn.com/data/lecture/icon_jquery_faq2_icon_arrow.png"></p></dt>
						<dd>
							<p>공지사항 내용이 없습니다!</p>
						</dd>
					</dl>
				</div>
		</c:if>
		<%--<%
			}
		--%>

	</div>

	<div id="bottomPage">
   <%-- 검색 전 페이징(쪽나누기) --%>
  	 	<c:if test="${(empty find_field) && (empty find_name)}">
    	<c:if test="${page <= 1}">
     <span class="pageNum" style="color: #ffffff; font-weight: bold"><<</span>
    </c:if>
    <c:if test="${page >1}">
     <a href="Notice?page=${page-1}"><span class="pageNum" style="color: #ffffff; font-weight: bold"><<</span></a>
    </c:if>
    
    <%-- 쪽번호 출력부분 --%>
    <c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
     <c:if test="${a==page}"><span class="pageNum1" style="color: #ffffff; font-weight: bold">${a}</span></c:if>
     
     <c:if test="${a != page}">
      <a href="Notice?page=${a}"><span class="pageNum2" style="color: black; font-weight: bold">${a}</span></a>
     </c:if>
    </c:forEach>
    
    <c:if test="${page >= maxpage}"><span class="pageNum" style="color: #ffffff; font-weight: bold">>></span></c:if>
    
    <c:if test="${page < maxpage}">
       <a href="Notice?page=${page+1}"><span class="pageNum" style="color: #ffffff; font-weight: bold">>></span></a>
    </c:if>
   </c:if>
   
   <%-- 검색 후 페이징  --%>
    <c:if test="${!empty find_field}">
    <c:if test="${page <= 1}">
     <span class="pageNum" style="color: #ffffff; font-weight: bold"><<</span>
    </c:if>
    <c:if test="${page >1}">
     <a href="Notice?page=${page-1}&find_field=${find_field}&find_name=${find_name}"><span class="pageNum" style="color: #ffffff; font-weight: bold"><<</span></a>
    </c:if>
    
    <%-- 쪽번호 출력부분 --%>
    <c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
     <c:if test="${a==page}"><span class="pageNum1" style="color: #ffffff; font-weight: bold">${a}</span></c:if>
     
     <c:if test="${a != page}">
      <a href="Notice?page=${a}&find_field=${find_field}&find_name=${find_name}"><span class="pageNum2" style="color: black; font-weight: bold">${a}</span></a>
     </c:if>
    </c:forEach>
    
    <c:if test="${page >= maxpage}"><span class="pageNum" style="color: #ffffff; font-weight: bold">>></span></c:if>
    
    <c:if test="${page < maxpage}">
       <a href="Notice?page=${page+1}&find_field=${find_field}&find_name=${find_name}"><span class="pageNum" style="color: #ffffff; font-weight: bold">>></span></a>
    </c:if>
   </c:if>
  </div>
		<%--
		<%
			int pages = totalPages;
		if ((totalPages) > 0) {
			pages++;
		}
		int firstPage = currentPage - 1;
		int lastPage = currentPage;
		if ((currentPage - 8) <= 0) {
			firstPage = 1;
			lastPage = 3;
		}
		if ((currentPage ) > pages) {
			firstPage = pages;
			lastPage = pages;
		}
		%>
		
		<%
			for (int i = firstPage; i <= lastPage; i++) {
		%>
		<a href="Notice?page=<%=i%>"> <%
 	if (i == currentPage) {
 %> <span class="pageNum" style="color: #ffff00; font-weight: bold"><%=i%></span> <%
 	} else {
 %> <span class="pageNum" style="color: #ffffff;"><%=i%></span> <%
 	}
 %>
		</a>
		<%
			}
		%>	
		--%>
	</div>

