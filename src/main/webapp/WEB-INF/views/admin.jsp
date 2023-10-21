<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>

<link rel="stylesheet" type="text/css" href="./resources/css/admin.css" />
<script src="./resources/js/jquery.js"></script>
</head>
<body id="admin_body">
	<%@ include file="./menubar/adminleftbar.jsp"%>
	<div id="admin_header">
		<h3 style="font-size: 200%; text-align: center; padding: 10px; margin: 0 0 0 0;">회원 관리</h3>
	</div>

	<div id="admin_panel">
		<form method="get" class="table-form" action="admin">
			<div id="admin_search">
				<fieldset>
					<legend class="hidden">검색</legend>
					<label class="hidden">검색분류</label> 
					<select name="find_field">
					<option value="join_id_box" <c:if test="${find_field=='join_id_box'}">${'selected'}</c:if>>회원아이디</option>
					<option value="join_name_box" <c:if test="${find_field=='join_name_box'}">${'selected'}</c:if>>회원이름</option>
					</select> 
					<label class="hidden">검색어</label> 
					<input type="text" name="find_name"	id="find_name" value="${find_name}"placeholder="검색어를 입력해주세요." /> 
					<input class="btn btn-search" type="submit" value="검색" />&nbsp;
					<input type="button" value="전체회원목록" onclick="location='admin?page=${page}';" />&nbsp;
					<b>전체 회원수 : ${listcount} 명</b>
				</fieldset>
			</div>
			</form>

			<div class="admintitle">
				<!-- <b>제목</b> <b>작성자</b> <b>날짜</b> -->
				
				<div id=title2>아이디</div>
				<div id=title3>회원이름</div>
				<div id=title4>회원상태</div>
				<div id=title5>가입날짜</div>
				<div id=title6>관리</div>
			</div>
	
			<div id="admin_cont">
				
				<div id="admin_cont_list">
				<c:if test="${!empty blist}">
					<c:forEach var="m" items="${blist}">
					<div id="admin_member_list">
						
						<div id="con2">${m.join_id_box}</div>
						<div id="con3">${m.join_name_box}</div>
						<div id="con4"><c:if test="${m.join_state == 1}">가입</c:if><c:if test="${m.join_state == 3}">관리자</c:if></div>
						<div id="con5">${fn:substring(m.join_date,0,10)}</div>
						<input type="button" value="관리" onclick="location='admin_member_edit?join_id_box=${m.join_id_box}&page=${page}&state=edit';" />
						<br>
					</div>
					</c:forEach>
				</c:if>
				<c:if test="${empty blist}">
					<b>회원 목록이 없습니다!</b>
				</c:if>
				</div>
					
					<div id="admin_page" style="text-align: center;">
	
						<div id="admin_page_number">
							<c:if test="${(empty find_field) && (empty find_name)}">
								<c:if test="${page<=1}">[이전]&nbsp;</c:if>
								<c:if test="${page>1}">
									<a href="admin?page=${page-1}">[이전]</a>&nbsp;
		    					</c:if>
		
								<%--현재 쪽번호 출력--%>
								<c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
									<c:if test="${a == page}">
									<%--현재 페이지가 선택되었다면--%>
		      							<${a}>
		     						</c:if>
								<c:if test="${a != page}">
									<%--현재 페이지가 선택되지 않았 다면 --%>
									<a href="admin?page=${a}">[${a}]</a>&nbsp;
		     						</c:if>
								</c:forEach>
		
								<c:if test="${page >= maxpage}">[다음]</c:if>
								<c:if test="${page<maxpage}">
									<a href="admin?page=${page+1}">[다음]</a>
								</c:if>
							</c:if>
	
							<%-- 검색후 페이징 --%>
							<c:if test="${(!empty find_field) || (!empty find_name)}">
								<c:if test="${page<=1}">[이전]&nbsp;</c:if>
								<c:if test="${page>1}">
									<a href="admin?page=${page-1}&find_field=${find_field}&find_name=${find_name}">[이전]</a>&nbsp;
	    						</c:if>
	
								<%--현재 쪽번호 출력--%>
								<c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
								<c:if test="${a == page}">
									<%--현재 페이지가 선택되었다면--%>
		      						<${a}>
		     					</c:if>
								<c:if test="${a != page}">
									<%--현재 페이지가 선택되지 않았 다면 --%>
									<a href="admin?page=${a}&find_field=${find_field}&find_name=${find_name}">[${a}]</a>&nbsp;
		     					</c:if>
								</c:forEach>
		
								<c:if test="${page >= maxpage}">[다음]</c:if>
								<c:if test="${page<maxpage}">
									<a	href="admin?page=${page+1}&find_field=${find_field}&find_name=${find_name}">[다음]</a>
								</c:if>
							</c:if>
						</div>
					</div>
				</div>
			
		</div>
</body>
</html>