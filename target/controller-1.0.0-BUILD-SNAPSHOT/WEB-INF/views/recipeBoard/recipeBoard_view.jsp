<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<meta charset="UTF-8">
<title>레시피 게시판</title>
<link rel="stylesheet" type="text/css" href="./resources/css/recipeBoard.css"/>
<script src="./resources/js/jquery.js"></script>

<script>
	function ScrollTop(){
		$('html, body').scrollTop(0);
	}
</script>

<c:if test="${empty searchText}">
	<c:set var="searchText" value=""/>
</c:if>
<c:if test="${empty searchType}">
	<c:set var="searchType" value=""/>
</c:if>

<%-- 하단 페이지 번호 생성을 위한 전체 게시글 수 검색 결과 --%>
<c:if test="${empty totalPostingsObj }">
	<c:set var="totalPostings" value="0"/>
</c:if>
<c:if test="${not empty totalPostingsObj }">
	<c:set var="totalPostings" value="${ totalPostingsObj }"/>
</c:if>

<%-- 현재 페이지 --%>
<c:if test="${empty page}">
	<c:set var="currentPage" value="1"/>
</c:if>
<c:if test="${not empty page}">
	<c:set var="currentPage" value="${ page }"/>
</c:if>

<%-- 현재 조회중인 게시글 정보 --%>
<%-- 게시글 번호 --%>
<c:if test="${empty post}">
	<c:set var="currentPosting" value="0"/>
</c:if>
<c:if test="${not empty post}">
	<c:set var="currentPosting" value="${ post }"/>
</c:if>

<%-- 개행문자 줄바꿈을 위한 속성 지정 --%>
<% pageContext.setAttribute("newLine", "\n"); %>



<!-- 현재 댓글 페이지 -->
<c:if test="${empty cpage}">
	<c:set var="cPage" value="1"/>
</c:if>
<c:if test="${not empty cpage}">
	<c:set var="cPage" value="${ param.cpage }"/>
</c:if>


<script>
	function removeCont(){
		if(confirm("게시글을 삭제하시겠습니까?")){
			location.href="recipeBoard_delete?post=${post}";
		}else{
			return false;
		}
	}
	
	function editCont(){
		if(confirm("게시글을 수정하시겠습니까?")){
			location.href="recipeBoard_edit?post=${post}";
		}else{
			return false;
		}
	}
	
	function commentCheck(){
		if($('#commentCont').val() == ''){
			alert('입력된 내용이 없습니다.');
			$('#commentCont').focus();
			return false;
		}
		if(confirm("댓글을 작성하시겠습니까?")){
			
		}else{
			$('#commentCont').focus();
			return false;
		}
	}
	
	function removeComment(t){
		if(!confirm("댓글을 삭제하시겠습니까?")){
			return false;
		}
		
	}
</script>


<%@ include file="../menubar/top_left_menubar.jsp"%>


<div class="board_title">레시피 게시판</div>

<%-- 게시글 조회 영역, currentPost가 0일 경우 표시하지 않음 --%>
<c:forEach var="rb" items="${ rbList }">
	<c:if test="${ currentPosting == rb.no }">
		<div id="PostingViewPage">
			<div id="PostingTitle">
				${ rb.title }
			</div>
			
			<div id="postingInfo">
				<div id="postingWriter">작성자 : ${ rb.writerid }</div>
				<div id="postingVisiter">조회수 : ${ rb.visiter }</div>
				<div id="postingDate">등록일 : ${ rb.regdate }</div>
			</div>
			
			<div id="PostingVideo">
				<c:if test="${not empty rb.videoLink}">
					<c:set var="youtubeLink" value="https://www.youtube.com/embed/${ rb.videoLink }"/>
					<iframe width="880" height="500" src="${ youtubeLink }" 
						title="YouTube video player" frameborder="0" 
						allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
						allowfullscreen>
					</iframe>
				</c:if>
			</div>
			
			<div id="postingRecipe">
				<c:set var="imgCnt" value="1"/>
				<c:set var="recipeContSplit" value="${fn:split(rb.textPack, 'Æ')}"/>
				
				<c:forEach var="i" begin="0" end="${fn:length(rb.imgIndex) -1}">
					<div class="recipeDescriptionBox">
						<c:if test="${fn:substring(rb.imgIndex, i, i+1) == '1'}">
							<img src="./upload/${rb.imgFolder}/${ imgCnt }.jpg"/>
							<c:set var="imgCnt" value="${ imgCnt +1 }"/>
						</c:if>
						<c:if test="${fn:substring(rb.imgIndex, i, i+1) == '0'}">
							<img src="./resources/images/recipePostBasicThumbnail.jpg"/>
						</c:if>
						
						<div class="recipeDescription">
							<c:set var="listDes" value="${fn:replace(recipeContSplit[i], newLine,'<br/>')}"/>
							${ listDes }
						</div>
					</div>
				</c:forEach>
			</div>
			
			<div id="postingEditRmBtn">
				<c:if test="${ rb.writerid == id || state == 3}">
					<input type="button" value="수정" onclick="return editCont();"/>
					<input type="button" value="삭제" onclick="return removeCont();"/>
				</c:if>
			</div>
			
			<c:if test="${ totalComments > 0 }">
				<div id="commentWrap">
				
					<!-- 한 페이지에 10개의 댓글을 출력 -->
					<c:forEach var="rbc" items="${ rbcList }">
						<div class="commentBox">
							<div class="commentWriter">${ rbc.cwriterid }</div>
								<c:set var="commentDes" value="${fn:replace(rbc.cont, newLine,'<br/>')}"/>
							<div class="commentContent">${ commentDes }</div>
							<div class="commentDate">
								${ rbc.regdate }
							</div>
							<c:if test="${ rbc.cwriterid == id || state == 3  }">
								<form class="commentRemoveBtn" method="post" action="commentDelete" onsubmit="return removeComment();">
									<input type="hidden" name="page" value="${ page }"/>
									<input type="hidden" name="post" value="${ rb.no }"/>
									<input type="hidden" name="cno" value="${ rbc.cno }"/>
									<input type="hidden" name="searchText" value="${ searchText }"/>
									<input type="submit" value="삭제"/>
								</form>
							</c:if>
							
						</div>
					</c:forEach>
				</div>
				
				<%-- 댓글 페이징 --%>
				<div id="commentPage">
					<%-- 페이징 변수 지정 --%>
					
					<%-- 전체 페이지 수 --%>
					<%-- 페이지 소숫점 버림 --%>
					<fmt:parseNumber var="cPages" integerOnly="true" value="${ totalComments / 10 }"/>
					<c:if test="${ totalComments % 10 > 0}">
						<c:set var="cPages" value="${ cPages + 1 }"/>
					</c:if>
					
					<%-- 페이지 시작 번호 --%>
					<c:set var="startcPage" value="${ cPage - 2 }"/>
					
					<%-- 페이지 끝 번호 --%>
					<c:set var="lastcPage" value="${ cPage + 2 }"/>
					
					<%-- 페이지 시작, 끝 부분 처리 --%>
					<c:if test="${ cPage < 3 }">
						<c:set var="startcPage" value="1"/>
						<c:set var="lastcPage" value="5"/>
						<%-- 댓글 총 페이지 수가 5 미만일 경우 처리 --%>
						<c:if test="${ cPages < 5 }">
							<c:set var="lastcPage" value="${ cPages }"/>
						</c:if>
					</c:if>
					<c:if test="${ lastcPage > cPages }">
						<c:set var="startcPage" value="${ cPages - 4 }"/>
						<c:if test="${ cPages-4 < 1 }">
							<c:set var="startcPage" value="1"/>
						</c:if>
						<c:set var="lastcPage" value="${ cPages }"/>
					</c:if>
					
					<%-- 페이지 버튼 출력 --%>
					<a href="recipeBoard_view?page=${ currentPage }&post=${ currentPosting }&cpage=1&searchType=${searchType}&searchText=${searchText}#postingEditRmBtn">
						<span class="cPageNumber">
							<img src="./resources/images/PageMoveLeftEnd.png"/>
						</span>
					</a>
					<c:if test="${ cPage == 1 }">
						<span class="cPageNumber">
							<img src="./resources/images/PageEnd.png"/>
						</span>
					</c:if>
					<c:if test="${ cPage != 1 }">
						<a href="recipeBoard_view?page=${ currentPage }&post=${ currentPosting }&cpage=${ cPage-1 }&searchType=${searchType}&searchText=${searchText}#postingEditRmBtn">
							<span class="cPageNumber">
								<img src="./resources/images/PageMoveLeft.png"/>
							</span>
						</a>
					</c:if>
					
					<c:forEach var="i" begin="${ startcPage }" end="${ lastcPage }">
						<a href="recipeBoard_view?page=${ currentPage }&post=${ currentPosting }&cpage=${ i }&searchType=${searchType}&searchText=${searchText}#postingEditRmBtn">
							<c:if test="${ i == cPage }">
								<div class="cPageNumber" style="color: #FF6347; font-weight: bold">
									${ i }
								</div>
							</c:if>
							<c:if test="${ i != cPage }">
								<div class="cPageNumber" style="color: #252525;">
									${ i }
								</div>
							</c:if>
						</a>
					</c:forEach>
					
					<c:if test="${ cPage == cPages }">
						<span class="cPageNumber">
							<img src="./resources/images/PageEnd.png"/>
						</span>
					</c:if>
					<c:if test="${ cPage != cPages }">
						<a href="recipeBoard_view?page=${ currentPage }&post=${ currentPosting }&cpage=${ cPage+1 }&searchType=${searchType}&searchText=${searchText}#postingEditRmBtn">
							<span class="cPageNumber">
								<img src="./resources/images/PageMoveRight.png"/>
							</span>
						</a>
					</c:if>
					<a href="recipeBoard_view?page=${ currentPage }&post=${ currentPosting }&cpage=${ cPages }&searchType=${searchType}&searchText=${searchText}#postingEditRmBtn">
						<span class="cPageNumber">
							<img src="./resources/images/PageMoveRightEnd.png"/>
						</span>
					</a>
				</div>
			</c:if>
			<c:if test="${ totalComments == 0 }">
				<div id="commentWrap">
					<div class="commentBox">
						<div class="commentWriter"></div>
						<div class="commentContent">등록된 댓글이 없습니다.</div>
					</div>
				</div>
			</c:if>
			<c:if test="${not empty id}">
				<div id="commentWrite">
					<form method="post" name="commentWriteForm" action="commentWrite" onsubmit="return commentCheck();">
						<input type="hidden" name="rno" value="${ rb.no }"/>
						<input type="hidden" name="cwriterid" value="${ id }"/>
						<input type="hidden" name="page" value="${ page }"/>
						<input type="hidden" name="searchText" value="${ searchType }"/>
						<input type="hidden" name="searchText" value="${ searchText }"/>
						<div id="commentWrtier">${ id }</div>
						<div id="commentContWrite">
							<textarea id="commentCont" name="Cont"></textarea>
						</div>
						<div id="commentWriteBtn">
							<input type="submit" value="등록"/>
						</div>
					</form>
				</div>
			</c:if>
			<div id="moveTopBtn">
				<input type="button" value="▲" onclick="ScrollTop();"/>
			</div>
		</div>
	</c:if>
</c:forEach>

<%-- 게시글 검색 영역 --%>
<div id="RecipieSearchPage">

	<div id="Board_blur"></div>

	<div id="Board_Recipies">
		<c:if test="${ totalPostings > 0 }">
			<%-- 현재 페이지를 기준으로 8개의 게시글을 로드 --%>
			<c:forEach var="rl" items="${ rbList }">
				<a href="recipeBoard_view?page=${ currentPage }&post=${ rl.no }&cpage=1&searchType=${searchType}&searchText=${searchText}">
				
					<%-- 레시피 과정 중 텍스트가 존재하는 첫번째 내용을 가져옴 --%>
					<c:set var="recipeContSplit" value="${fn:split(rl.textPack, 'Æ')}"/>
						<%-- 반복문 실행 중단을 위한 플래그 --%>
						<c:set var="loopFlag" value="true"/> 
					<c:forEach var="txt" items="${ recipeContSplit }">
						<c:if test="${ txt != '' && loopFlag }">
							<c:set var="listDes" value="${fn:replace(txt, newLine,'<br/>')}"/>
							<c:set var="loopFlag" value="false"/>
						</c:if>
					</c:forEach>
					
					<span class="BoardPostings">
						<%-- 업로드된 이미지가 있다면 섬네일을 첫번째 이미지로 변경함 --%>
						<c:if test="${fn:contains(rl.imgIndex, '1')}">
							<span class="BoardPostThumbnail" style="background-image:url('./upload/${rl.imgFolder}/1.jpg')"></span>
						</c:if>
						<c:if test="${not fn:contains(rl.imgIndex, '1')}">
							<span class="BoardPostThumbnail"></span>
						</c:if>
						<span class="BoardPostTitle">${ rl.title }</span>
						<span class="BoardPostWriter">작성자 : ${ rl.writerid }</span>
						<span class="BoardPostCont">${ listDes }</span>
						<span class="BoardVisiter">조회수 : ${ rl.visiter }</span>
					</span>
					
				</a>
			</c:forEach>
		</c:if>
	</div>
	
	<div id="bottomPageNumber">
		<%-- 전체 게시글 수를 이용한 하단 페이지 번호 생성 --%>
		<c:if test="${ totalPostings == 0 }">
			<c:set var="pages" value="1"/>
		</c:if>
		<c:if test="${ totalPostings != 0 }">
			<fmt:parseNumber var="pages" integerOnly="true" value="${ totalPostings/8 }"/>
			<c:if test="${ totalPostings%8 > 0 }">
				<c:set var="pages" value="${ pages+1 }"/>
			</c:if>
		</c:if>
		<%-- 페이지 첫번째, 마지막 번호 지정 --%>
		<c:set var="firstPage" value="${ currentPage-4 }"/>
		<c:set var="lastPage" value="${ currentPage+5 }"/>
		<c:if test="${ currentPage-4 <= 1 }">
			<c:set var="firstPage" value="1"/>
			<c:set var="lastPage" value="10"/>
			<c:if test="${ pages < 10 }">
				<c:set var="lastPage" value="${ pages }"/>
			</c:if>
		</c:if>
		<c:if test="${ currentPage+5 > pages }">
			<c:set var="firstPage" value="${ pages-9 }"/>
			<c:if test="${ pages-9 < 1 }">
				<c:set var="firstPage" value="1"/>
			</c:if>
			<c:set var="lastPage" value="${ pages }"/>
		</c:if>
		
		<a href="recipeBoard_view?page=1&post=0&cpage=1&searchType=${searchType}&searchText=${searchText}">
			<span class="PageNumber">
				<img src="./resources/images/PageMoveLeftEnd.png"/>
			</span>
		</a>
		<c:if test="${ currentPage == 1 }">
			<span class="PageNumber">
				<img src="./resources/images/PageEnd.png"/>
			</span>
		</c:if>
		<c:if test="${ currentPage != 1 }">
			<a href="recipeBoard_view?page=${ currentPage-1 }&post=0&cpage=1&searchType=${searchType}&searchText=${searchText}">
				<span class="PageNumber">
					<img src="./resources/images/PageMoveLeft.png"/>
				</span>
			</a>
		</c:if>
		<c:forEach var="i" begin="${ firstPage }" end="${ lastPage }">
			<a href="recipeBoard_view?page=${ i }&post=0&cpage=1&searchType=${searchType}&searchText=${searchText}">
				<c:if test="${ i == currentPage }">
					<span class="PageNumber" style="color: #FF6347; font-weight: bold">
						${ i }
					</span>
				</c:if>
				<c:if test="${ i != currentPage }">
					<span class="PageNumber" style="color: #252525;">
						${ i }
					</span>
				</c:if>
			</a>
		</c:forEach>
		<c:if test="${ currentPage == pages }"> 
			<span class="PageNumber">
				<img src="./resources/images/PageEnd.png"/>
			</span>
		</c:if>
		<c:if test="${ currentPage != pages }">
			<a href="recipeBoard_view?page=${ currentPage+1 }&post=0&cpage=1&searchType=${searchType}&searchText=${searchText}">
				<span class="PageNumber">
					<img src="./resources/images/PageMoveRight.png"/>
				</span>
			</a>
		</c:if>
		<a href="recipeBoard_view?page=${ pages }&post=0&cpage=1&searchType=${searchType}&searchText=${searchText}">
			<span class="PageNumber">
				<img src="./resources/images/PageMoveRightEnd.png"/>
			</span>
		</a>
	</div>
</div>

<form id="table-form" onsubmit="return searchBoard(this);">
	<fieldset style="margin-top:70px;">
		<legend class="hidden">검색</legend>
		<label class="hidden">검색분류</label> 
		<select name="searchType">
			<option value="t" <c:if test="${searchType == 't'}"> ${'selected'}</c:if>>제목</option>
			<option value="w" <c:if test="${searchType == 'w'}"> ${'selected'}</c:if>>작성자</option>
		</select> 
		<label class="hidden">검색어</label> 
		<input type="text" name="searchText" value="${searchText}" placeholder="검색어를 입력해주세요." />
		<input type="submit" value="검색" />
	</fieldset>
</form>

<div id="postWriteBtn">
	<input type="button" value="전체보기" onclick="location.href='recipeBoard_view?page=1&post=0&cpage=1'"/>
	<c:if test="${not empty id }">
		<input type="button" value="글쓰기" onclick="location.href='recipeBoard_write'"/>
	</c:if>
</div>