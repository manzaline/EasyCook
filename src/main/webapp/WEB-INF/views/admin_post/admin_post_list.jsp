<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script>
	function removeCont(n){
		if(confirm("게시글을 삭제하시겠습니까?")){
			location.href="recipeBoard_delete?post="+n+"&type=a";
		}else{
			return false;
		}
	}
	
	function editCont(n){
		if(confirm("게시글을 수정하시겠습니까?")){
			location.href="recipeBoard_edit?post="+n;
		}else{
			return false;
		}
	}
</script>

<meta charset="UTF-8">
<title>레시피 관리자 페이지</title>
<link rel="stylesheet" type="text/css" href="./resources/css/admin_post.css" />
</head>

<body >
	<%@ include file="../menubar/adminleftbar.jsp"%>
	<div id="ap_header">
		<b style="font-size: 200%;">레시피 리스트</b>
	</div>
	
	<div id="ap_panel">
		<div id="ap_search">
			<form class="table-form">
				<fieldset>
					<legend class="hidden">검색</legend>
					<label class="hidden">검색분류</label> 
					<select name="searchType">
						<option value="t" <c:if test="${searchType == 't'}"> ${'selected'}</c:if>>제목</option>
						<option value="w" <c:if test="${searchType == 'w'}"> ${'selected'}</c:if>>작성자</option>
					</select> 
					<label class="hidden">검색어</label> 
					<input type="text" name="searchText" value="" placeholder="검색어를 입력해주세요." /> 
					<input type="submit" value="검색" />
				</fieldset>				
			</form>
			
		</div>
				
		<table id="ap_list" style="border-collapse:collapse" >
			<tr style="	background-color:#cccdd0;">
				<th id="ap_list_no">번호</th>
				<th id="ap_list_title">제목</th>
				<th id="ap_list_writer">작성자</th>
				<th id="ap_list_date">등록날짜</th>
				<th id="ap_list_management">관리</th>
			</tr>
			<c:forEach var="rb" items="${ rbList }">
				<tr style="background-color:#f5f5f5;">
					<td>${ rb.no }</td>
					<td><div id="contents">${ rb.title }</div></td>
					<td>${ rb.writerid }</td>
					<td>${ rb.regdate }</td>
					<td>
						<input type="button" value="조회" onclick="location.href='recipeBoard_view?page=1&post=${ rb.no }&cpage=1&searchType=t&searchText=${ rb.title }';"/>
						<input type="button" value="수정" onclick="return editCont(${rb.no});"/>
						<input type="button" value="삭제" onclick="return removeCont(${rb.no});" />
					</td>
				</tr>
			</c:forEach>
		</table>
		
		
		<div id="admin_page_number" style="background-color:#f5f5f5;">
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
				<a href="admin_post_list?page=1&searchType=${ searchType }&searchText=${ searchText }">[FIRST]</a>
			</c:if>
			<c:if test="${ currentPage > 1 }">
				<a href="admin_post_list?page=${ currentPage-1 }&searchType=${ searchType }&searchText=${ searchText }">[PREV]</a>
			</c:if>
			
			<c:forEach var="iCount" begin="${ startPage }" end="${ endPage }">
				<a href="admin_post_list?page=${ iCount }&searchType=${ searchType }&searchText=${ searchText }" >
					<c:if test="${ iCount == currentPage }">
						<b class="CurrentPageNumber">&nbsp;${ iCount }&nbsp;</b>
					</c:if>
					<c:if test="${ iCount != currentPage }">
						<span class="PageNumber">&nbsp;${ iCount }&nbsp;</span>
					</c:if>
				</a>
			</c:forEach>
			
			<c:if test="${ currentPage < totalPage }">
				<a href="admin_post_list?page=${ currentPage+1 }&searchType=${ searchType }&searchText=${ searchText }">[NEXT]</a>
			</c:if>
			<c:if test="${ endPage < totalPage }">
				<a href="admin_post_list?page=${ totalPage }&searchType=${ searchType }&searchText=${ searchText }">[LAST]</a>
			</c:if>
		</div>
	</div>

</body>
</html>