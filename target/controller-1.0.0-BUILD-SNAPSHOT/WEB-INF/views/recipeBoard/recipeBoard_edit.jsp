<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<title>레시피 글쓰기</title>
<link rel="stylesheet" type="text/css" href="./resources/css/recipeBoard_write.css"/>
<script src="./resources/js/jquery.js"></script>

<script>
	//유튜브 링크를 입력하고 입력창을 빠져나오면 하단에 유튜브 영상 로드
	var link="";
	function LoadThumbnail(){
		link = $("#videoLink").val();
		var linkSplit = link.split("/");
		link = linkSplit[linkSplit.length-1];
		//링크의 watch?v= 제거
		if(link.substr(0,8) == "watch?v="){
			link = link.substr(8);
		}
		var youtubeLink = "https://www.youtube.com/embed/" + link;

		$("#thumbnail").html(""+
			"<iframe width='740' height='500' src='"+youtubeLink+"'"+
				"title='YouTube video player' frameborder='0' "+
				"allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture' "+
				"allowfullscreen>"+
			"</iframe>");
	}
	
	//문자열 치환 함수///////
	String.prototype.replaceAt=function(index, character) {
    	return this.substr(0, index) + character + this.substr(index+character.length);
	}
	////////////////////

	
	//레시피 과정 삭제 버튼 클릭
	function removeCont(node){
		var removeIndex = $(node.parentNode).find(".contImg").attr('id').substr(7);
		contExist[removeIndex] = 0;
		contImgArr[removeIndex] = -1;
		
		//수정 상태 코드 변경
		if(imgConvIndex.charAt(removeIndex-1) == "0" || imgConvIndex.charAt(removeIndex-1) == "2"){
			imgConvIndex = imgConvIndex.replaceAt(removeIndex-1, "4");
		}
		if(imgConvIndex.charAt(removeIndex-1) == "1" || imgConvIndex.charAt(removeIndex-1) == "3"){
			imgConvIndex = imgConvIndex.replaceAt(removeIndex-1, "5");
		}
		
		$(node.parentNode).remove();
		contAmount--;
	}
	//레시피 과정 이미지 추가버튼 클릭
	var changeImgIndex = 0; //바꿀 이미지 위치
	function addImg(img){
		imgFileInput.click();
		changeImgIndex = img.getAttribute('id').substr(7);
	}
	
	//이미지 업로드 시 inputfile change이벤트
	$(document).ready(function(){
		$("#imgFileInput").on("change", contImgChange);
	});
	function contImgChange(e){
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);

		filesArr.forEach(function(f){
			if(!f.type.match("image/*")){
				alert("이미지 파일이 아닙니다.");
				return;
			}
			contImgArr[changeImgIndex] = f;
			if(imgConvIndex.charAt(changeImgIndex-1) == "0"){
				imgConvIndex = imgConvIndex.replaceAt(changeImgIndex-1, "2");
			}
			if(imgConvIndex.charAt(changeImgIndex-1) == "1"){
				imgConvIndex = imgConvIndex.replaceAt(changeImgIndex-1, "3");
			}
			var reader = new FileReader();
			reader.onload = function(e){
				$("#contImg"+changeImgIndex).attr("src", e.target.result);
			}
			reader.readAsDataURL(f);
		});
	}
	
	
	//레시피 과정 추가 버튼 클릭
	var contIndex = 1; // 요소 아이디
	var contAmount = 0; // 요소 갯수
	var contExist = new Array(); // 삭제되지 않은 배열
	var contImgArr = new Array(); // 이미지 저장 배열
	function addCont(){
		if(contAmount == 20){
			alert('과정을 더이상 추가할 수 없습니다.');
			return;
		}else{
			$("#addedContWrap").append("<div class='recepeCont'>"
										+"<div class='removeContWrap' onclick='removeCont(this);'>"
										+"	<div class='removeContLabel'>"
										+"		지우기"
										+"	</div>"
										+"	<div class='removeContBtn'>"
										+"		<img src='./resources/images/minusBtn.png' width=30px height=25px>"
								  		+"	</div>"
								  		+"</div>"
								  		+"<div class='contWrap'>"
								  		+"	<img id='contImg"+contIndex+"' class='contImg'"
								  		+"		src='./resources/images/recipeBoardContThumbnail.png' onclick='addImg(this);'>"
								  		+"	<textarea id='contText"+contIndex+"' class='contText'></textarea>"
								  		+"</div>"
									  +"</div>");
			contExist[contIndex] = 1;
			contImgArr[contIndex] = -1;
			
			contIndex++;
			contAmount++;
		}
	}
	
	
	/// 폼 전송버튼 클릭 이벤트 ////
	/// 이미지 소스와 textarea 문자열을 하나씩 묶고 각 문자열의 경계를 Æ로 나눈다.
	/// 요리 과정의 전체 개수를 전달한다.
	
	/// 이미지 수정을 위한 상태 코드를 전달한다.
	var imgConvIndex = "";
	<%--
		상태 코드 :
		0 사진이 없고 변경되지 않은 상태
		1 사진이 있고 변경되지 않은 상태
		2 사진이 없고 변경된 상태
		3 사진이 있고 변경된 상태
		4 사진이 없고 삭제된 상태
		5 사진이 있고 삭제된 상태
		예시)
		기존 코드 : 100110
		이미지 저장 : 1, 2, 3
		상태 코드 : 520134
		이미지 이름 임시 변경 : a1, a2, a3
		5: a1삭제
		2: 첫번째 파일을 1.jpg로 저장, index 1
		0: index 10
		1: a2를 2.jpg로 저장, index 101
		3: 두번째 파일을 3.jpg로 저장하고 a3 삭제, index 1011
		4: 무시
	--%>
	function sendData(form){
		if(confirm("새 글을 등록하시겠습니까?") == true){
			if(form.title.value == ""){
				alert("제목을 입력하세요.");
				return false;
			}
			if(contAmount < 1){
				alert("최소한 하나 이상의 요리 과정을 추가해야 합니다.");
				return false;
			}
			var imgString = "";
			var textString = "";
			var contCount = 0;

			var formData = new FormData(form);
			var imgIndex = "";
			
			for(var i = 1; i <= contExist.length; i++){
				if(contExist[i] == 1){
					if(contImgArr[i] == -1){
						imgIndex += "0";
					}else {
						formData.append("imgFiles",contImgArr[i]);
						imgIndex += "1";
					}
					if($('#contText'+i).val() != ""){
						textString += $('#contText'+i).val();
					}else{
						textString += "*요리 과정에 대한 설명이 없습니다.";
					}
					contCount++;
				}
				if(contCount < contAmount){
					textString += "Æ";
				}
			}
			formData.append("imgIndex", imgIndex);
			formData.append("imgConvIndex", imgConvIndex);
			
			LoadThumbnail();
			formData.append("link", link);
			formData.append("textPack", textString);
			
			$.ajax({
				type: 'POST',
				url: 'recipeBoard_edit_ok',
				enctype: 'multipart/form-data',
				data: formData,
	            processData: false,
	            contentType: false,
	            async: false,
	            success:function(data){
	            	if(data == "OK"){
	                    alert("게시글이 수정되었습니다.");
	            	}
	            }
			});
			
			
		}else{
			return false;
		}
	}
	
	function cancelWrite(){
		if(confirm("게시글 수정을 취소하시겠습니까?")){
			location.href='recipeBoard_view';
		}else{
			return false;
		}
	}
</script>

<%@ include file="../menubar/top_left_menubar.jsp"%>

<div id="writeFormWrap">
	<div id="recipeInsertForm">
		<form name="dataForm" method="post" action="recipeBoard_view?post=${no}" onsubmit="return sendData(this);" enctype="multipart/form-data">
			<input type="hidden" name="editNo" value="${ no }"/>
			<div id="title">
				게시글 제목<br>
				<input type="text" id="title" name="title" value="${ title }"/>
			</div>
			<div id="video">
				유튜브 링크<br>
				<c:if test="${not empty videoLink }">
					<input type="text" id="videoLink" 
						value="https://www.youtube.com/embed/${ videoLink }" onblur="LoadThumbnail();"/><br>
					<div id="thumbnail">
						<iframe width='740' height='500' src='https://www.youtube.com/embed/${ videoLink }'
							title='YouTube video player' frameborder='0'
							allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture'
							allowfullscreen>
						</iframe>
					</div>
				</c:if>
				<c:if test="${empty videoLink }">
					<input type="text" id="videoLink" onblur="LoadThumbnail();"/><br>
					<div id="thumbnail">
						미리보기
					</div>
				</c:if>
			</div>
			<div id="recipeContWrap">
				<input type="file" id="imgFileInput" accept="image/*" style="display:none;"/>
				<div id="contTitle">
					요리 과정
				</div>
				<div id="addedContWrap">
					<c:set var="imgCnt" value="1"/>
					<c:set var="recipeContSplit" value="${fn:split(textPack, 'Æ')}"/>
					
					<c:forEach var="i" begin="1" end="${fn:length(imgIndex)}">
						<div class='recepeCont'>
							<div class='removeContWrap' onclick='removeCont(this);'>
								<div class='removeContLabel'>
									지우기
								</div>
								<div class='removeContBtn'>
									<img src='./resources/images/minusBtn.png' width=30px height=25px>
					  			</div>
					  		</div>
					  		<div class='contWrap'>
								<c:if test="${fn:substring(imgIndex, i-1, i) == '1'}">
					  				<img id='contImg${ i }' class='contImg'
					  					src='./upload/${imgFolder}/${ imgCnt }.jpg' onclick='addImg(this);'>
									<c:set var="imgCnt" value="${ imgCnt +1 }"/>
									<script>imgConvIndex += "1"</script>
								</c:if>
								<c:if test="${fn:substring(imgIndex, i-1, i) == '0'}">
					  				<img id='contImg${ i }' class='contImg'
					  					src='./resources/images/recipeBoardContThumbnail.png' onclick='addImg(this);'>
									<script>imgConvIndex += "0"</script>
								</c:if>
								<c:set var="listDes" value="${fn:replace(recipeContSplit[i-1], newLine,'<br/>')}"/>
					  			<textarea id='contText${ i }' class='contText'>${ listDes }</textarea>
					  		</div>
					  		
							<script>
								contExist[contIndex] = 1;
								contImgArr[contIndex] = -1;
								
								contIndex++;
								contAmount++;
							</script>

						</div>
					</c:forEach>
				</div>
				<div id="addContWrap" onclick="addCont();">
					<div id="addContBtn">
						<img src="./resources/images/plusBtn.png" width=30px height=25px>
					</div>
					<div id="addContLabel">
						추가하기
					</div>
				</div>
			</div>
			<div id="SendButtonWrap">
				<input type="submit" id="writeBtn" value="저장"/>
				<input type="button" id="cancelBtn" value="취소" onclick="return cancelWrite();"/>
			</div>
		</form>
	</div>
</div>