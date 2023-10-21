<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<c:if test="${empty searchText }">
	<c:set var="searchText" value=""/>
</c:if>

<title>마이 페이지</title>
<link rel="stylesheet" type="text/css" href="./resources/css/mypage_view.css" />
<body >
<%@ include file="../menubar/top_left_menubar.jsp"%>

	<div id="mp_header">
		<b style="font-size: 200%;">마이 페이지-레시피</b>
	</div>
	
	<div id="mp_member_info">
			<img id="mp_info_img" src="./resources/images/human_icon.png" width="230" height="230"/>
			<input type="button" id="mp_info_update" value="회원정보 수정" onclick="location.href='member_edit';"/>				
			
		</div>
		
	<div id="mp_panel">
	<form name="m" method="post">
		<div id="mp_search">
			<form class="table-form">
				<fieldset>
					<legend class="hidden">검색</legend>
					<label class="hidden">검색어</label> 
					<input type="text" name="searchText" value="" placeholder="검색어를 입력해주세요." /> 
					<input class="btn btn-search" type="submit" value="검색" />
				</fieldset>				
			</form>
			
		</div>
		
			<div id="mp_title_list">
				<input type="button" id="mp_btn_recipe" value="나의 레시피" onclick="location.href='mp_recipe_list?page=1';"/>			
				<input type="button" id="mp_btn_home" value="홈으로 돌아가기" onclick="location.href='mypage_view';"/>				
				<input type="button" id="mp_btn_comment" value="나의 댓글" onclick="location.href='mp_comment_list?page=1';"/>	
			</div>
			
			<table id="mr_list" style="border-collapse:collapse">
			<tr style="	background-color:#cccdd0;">
				<th id="mr_list_no">번호</th>
				<th id="mr_list_title">제목</th>
				<th id="mr_list_visit">조회수</th>
				<th id="mr_list_date">등록날짜</th>
				<th id="mr_list_management">관리</th>
			</tr>
			
			<c:forEach var="rb" items="${ rbList }">
				<tr style="background-color:#f5f5f5;">
					<td>${ rb.no }</td>
					<td>${ rb.title }</td>
					<td>${ rb.visiter }</td>
					<td>${ rb.regdate }</td>
					<td><input type="button" value="이동" onclick="location.href='recipeBoard_view?page=1&post=${ rb.no }&cpage=1&searchType=t&searchText=${ rb.title }';"/>
				</tr>
			</c:forEach>	
		</table>	
							
			<div id="mypage_view_number" style="background-color:#f5f5f5;">
				<c:if test="${empty page}">
					<c:set var="currentPage" value="1"/>
				</c:if>
				<c:if test="${not empty page}">
					<c:set var="currentPage" value="${ page }"/>
				</c:if>
				
				<c:set var="totalCount" value="${ totalPostings }"/>
				
				<fmt:parseNumber var="totalPage" integerOnly="true" value="${ totalCount/10 }"/>
				<c:if test="${ totalCount % 10 != 0 }">
					<c:set var="totalPage" value="${ totalPage+1 }"/>
				</c:if>
				<c:if test="${ totalPage < currentPage }">
					<c:set var="currentPage" value="${ totalPage }"/>
				</c:if>
				
				<c:set var="startPage" value="${ currentPage-3 }"/>
				<c:set var="endPage" value="${ currentPage+3 }"/>
				<c:if test="${ currentPage < 4 }">
					<c:set var="startPage" value="1"/>
					<c:set var="endPage" value="7"/>
					<c:if test="${ endPage > totalPage }">
						<c:set var="endPage" value="${ totalPage }"/>
					</c:if>
				</c:if>
				<c:if test="${ currentPage+3 > totalPage }">
					<c:set var="startPage" value="${ totalPage-6 }"/>
					<c:if test="${ totalPage-6 < 1 }">
						<c:set var="startPage" value="1"/>
					</c:if>
					<c:set var="endPage" value="${ totalPage }"/>
				</c:if>
				
				<c:if test="${ currentPage > 4 }">
					<a href="mp_recipe_list?page=1&searchText=${ searchText }">[FIRST]</a>
				</c:if>
				<c:if test="${ currentPage > 1 }">
					<a href="mp_recipe_list?page=${ currentPage-1 }&searchText=${ searchText }">[PREV]</a>
				</c:if>
				
				<c:forEach var="iCount" begin="${ startPage }" end="${ endPage }">
					<a href="mp_recipe_list?page=${ iCount }&searchText=${ searchText }" >
						<c:if test="${ iCount == currentPage }">
							<b class="CurrentPageNumber">&nbsp;${ iCount }&nbsp;</b>
						</c:if>
						<c:if test="${ iCount != currentPage }">
							<span class="PageNumber">&nbsp;${ iCount }&nbsp;</span>
						</c:if>
					</a>
				</c:forEach>
				
				<c:if test="${ currentPage < totalPage }">
					<a href="mp_recipe_list?page=${ currentPage+1 }&searchText=${ searchText }">[NEXT]</a>
				</c:if>
				<c:if test="${ endPage < totalPage }">
					<a href="mp_recipe_list?page=${ totalPage }&searchText=${ searchText }">[LAST]</a>
				</c:if>
		</div>
		</form>
	</div>
	

</body>
</html>