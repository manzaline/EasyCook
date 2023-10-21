/**
 * member.js
 */

	/* 우편번호 찾기 */
	function Postcode() {
		daum.postcode.load(function() {
			new daum.Postcode({
				oncomplete : function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
					$("#join_post_box_1").val(data.zonecode);
					$("#join_post_box_2").val(data.roadAddress);
					$("#join_post_box_3").val('').focus();
				}
			}).open();
		});
	}
	
	
	/* 회원가입 창에서 [취소]버튼 클릭시 알림창 띄우기 */
	function joinreset(){
		if(confirm("회원가입을 [취소]하시겠습니까?\n입력한 값이 모두 초기화 됩니다.")){
			form.reset();
		}else{
			return false;
		}
	}
	
	//회원가입 체크
	function join_check(){
		if($.trim($("#join_id_box").val())==""){
			alert("회원 아이디를 입력하세요!");
			$("#join_id_box").val('');
			return false;
		}
		if($.trim($("#join_email_1_box").val()) == ""){
			alert("이메일 아이디를 입력하세요!");
			$("#join_email_1_box").val('');
			return false;
		}
		if($.trim($("#join_email_2_box").val()) == ""){
			alert("이메일 주소를 선택하세요!");
			return false;
		}
		$join_pw_box=$.trim($("#join_pw_box").val());
		$join_pw_check_box=$.trim($("#join_pw_check_box").val());
		if($join_pw_box == ""){
			alert("비밀번호를 입력하세요!");
			$("#join_pw_box").val('');
			return false;
		}
		if($join_pw_check_box == ""){
			alert("비밀번호 확인을 입력하세요!");
			$("#join_pw_check_box").val('');
			return false;
		}
		if($join_pw_box != $join_pw_check_box){
			alert("비밀번호가 다릅니다!");
			$("#join_pw_box").val("");
			$("#join_pw_check_box").val("");
			return false;
		}
		if($.trim($("#join_name_box").val()) == ""){
			alert("회원 이름을 입력하세요!");
			$("#join_name_box").val('');
			return false;
		}
		if($.trim($("#join_nickname_box").val()) == ""){
			alert("닉네임을 입력하세요!");
			$("#join_nickname_box").val('');
			return false;
		}
		if($.trim($("#join_tel_1_box").val()) == ""){
			alert("첫번째 폰번호를 입력하세요!");
			$("#join_tel_1_box").val('');
			return false;
		}
		if($.trim($("#join_tel_2_box").val()) == ""){
			alert("두번째 폰번호를 입력하세요!");
			$("#join_tel_2_box").val('');
			return false;
		}
		if($.trim($("#join_tel_3_box").val()) == ""){
			alert("세번째 폰번호를 입력하세요!");
			$("#join_tel_3_box").val('');
			return false;
		}
		if($.trim($("#join_pw_q_a_box").val()) == ""){
			alert("비밀번호 확인 답을 입력하세요!");
			$("#join_pw_q_a_box").val('');
			return false;
		}
		if($.trim($("#join_post_box_1").val()) == ""){
			alert("우편번호를 입력하세요!");
			$("#join_post_box_1").val('');
			return false;
		}
		if($.trim($("#join_post_box_2").val()) == ""){
			alert("주소를 입력하세요!");
			$("#join_post_box_1").val('');
			return false;
		}
		if($.trim($("#join_post_box_3").val()) == ""){
			alert("나머지 주소를 입력하세요!");
			$("#join_post_box_3").val('');
			return false;
		}
		alert("회원가입이 완료되었습니다!\n로그인하여 사이트를 이용해보세요!");
	}

	

	//중복아이디 검색
	function id_check(){
		$join_id_box=$.trim($("#join_id_box").val());
		if($join_id_box.length < 8){
			$newtext='<font color="red" size="3"><b>아이디는 8자 이상이어야 합니다.</b></font>';
			$("#iderror").text('');
			$("#iderror").show();
			$("#iderror").append($newtext);
			return false;
		}
		if($join_id_box.length > 20){
			$newtext='<font color="red" size="3"><b>아이디는 20자 이하여야 합니다.</b></font>';
			$("#iderror").text('');
			$("#iderror").show();
			$("#iderror").append($newtext);
			$("#join_id_box").val('');
			return false;
		}
		//입력글자확인
		if(!(validate_userid($join_id_box))){
			$newtext='<font color="red" size="3"><b>영문소문자로 시작, 영문+숫자 조합 8~14자만 가능합니다.</b></font>';
			$("#iderror").text('');
			$("#iderror").show();
			$("#iderror").append($newtext);
			$("#join_id_box").val('');
			return false;
		}
		//아이디 중복 확인
		$.ajax({
			type:"POST", 
			url:"member_idcheck", 
			data: {"id":$join_id_box}, 
			datatype: "int", 
			success: function (data) {
				if(data==1){
					$newtext='<font color="red" size="3"><b>중복 아이디 입니다.</b></font>';
					$("#iderror").text('');
					$("#iderror").show();
					$("#iderror").append($newtext);
					$("#join_id_box").val('');
					return false;
				}else{
					$newtext='<font color="blue", size="3"><b>사용가능한 아이디 입니다.</b></font>';
					$("#iderror").text('');
					$("#iderror").show();
					$("#iderror").append($newtext);
					$("#join_pwd_box");
				}
			},
			error:function(){
				alert("data error");
			}
		});
	}
	//이메일 정규식 확인
	function email_check(){
		$join_email_1_box=$.trim($("#join_email_1_box").val());
		if($join_email_1_box == ""){
			$newtext='<font color="red" size="3"><b>이메일 아이디를 입력하세요!</b></font>';
			$("#emailerror").text('');
			$("#emailerror").show();
			$("#emailerror").append($newtext);
			$("#join_email_1_box").val('');
			return false;
		}
		if(!(validate_email($join_email_1_box))){
			$newtext='<font color="red" size="3"><b>영문소문자,숫자,-,_만 입력가능합니다.</b></font>';
			$("#emailerror").text('');
			$("#emailerror").show();
			$("#emailerror").append($newtext);
			$("#join_email_1_box").val('');
			return false;
		}
		
		if(validate_email($join_email_1_box)){
			$("#emailerror").text('');
			return false;
		}
	}
	
	function domain_check(){
		$join_email_3_box=$.trim($("#join_email_3_box").val());
		if($join_email_3_box == "주소를 선택하세요."){
			$newtext='<font color="red" size="3"><b>주소를 선택하세요!</b></font>';
			$("#emailerror").text('');
			$("#emailerror").show();
			$("#emailerror").append($newtext);
			$("#join_email_3_box");
			return false;
		}else{
			$("#emailerror").text('');
		}
		
	}
	
	//비밀번호 정규식 확인
	function pw_check(){
		$join_pw_box=$.trim($("#join_pw_box").val());
		if($join_pw_box.length < 8){
			$newtext='<font color="red" size="3"><b>8자 이상 입력하세요</b></font>';
			$("#pwerror").text('');
			$("#pwerror").show();
			$("#pwerror").append($newtext);
			$("#join_pw_box").val('');
			return false;
		}
		//입력글자 확인
		if(!(validate_userpw($join_pw_box))){ //비밀번호 정규식과 같지 않으면
			$newtext='<font color="red" size="3"<b>영문 소문자+대문자+숫자+특수문자 포함 8~20자만 가능합니다.</b></font>';
			$("#pwerror").text('');
			$("#pwerror").show();
			$("#pwerror").append($newtext);
			$("#join_pw_box").val('');
			return false;
		}else{ //비밀번호 정규식과 같다면
			$newtext='<font color="blue" size="3"<b>사용가능한 비밀번호입니다.</b></font>';
			$("#pwerror").text('');
			$("#pwerror").show();
			$("#pwerror").append($newtext);
		}
	}
	
	//비번확인
	function pw_check_c(){
		$join_pw_check_box=$.trim($("#join_pw_check_box").val());
		if($join_pw_check_box != $join_pw_box){
			$newtext='<font color="red" size="3"><b>비밀번호가 다릅니다!</b></font>';
			$("#pwchkerror").text('');
			$("#pwchkerror").show();
			$("#pwchkerror").append($newtext);
			$("#join_pw_check_box").val('');
			return false;
		}else{
			$("#pwchkerror").text('');
		}
	}
	
	//이름 정규식 확인
	function name_check(){
		$join_name_box=$.trim($("#join_name_box").val());
		if(!(validate_name($join_name_box))){
			$newtext='<font color="red" size="3"><b>이름은 한글이나 영문만 입력 가능합니다!</b></font>';
			$("#nameerror").text('');
			$("#nameerror").show();
			$("#nameerror").append($newtext);
			$("#join_name_box").val('');
			return false;
		}else{
			$("#nameerror").text('');
		}
	}
	
	//닉네임 정규식 확인
	function nickname_check(){
		$join_nickname_box=$.trim($("#join_nickname_box").val());
		if($join_nickname_box.length < 4){
			$newtext='<font color="red" size="3"><b>4자 이상 입력하세요!</b></font>';
			$("#nickerror").text('');
			$("#nickerror").show();
			$("#nickerror").append($newtext);
			$("#join_nickname_box").val('');
			return false;
		}
		if($join_nickname_box.length > 20){
			$newtext='<font color="red" size="3"><b>20자 이하로 입력하세요!</b></font>';
			$("#nickerror").text('');
			$("#nickerror").show();
			$("#nickerror").append($newtext);
			$("#join_nickname_box").val('');
			return false;
		}
		if(!(validate_nickname($join_nickname_box))){
			$newtext='<font color="red" size="3"><b>영문소문자로 시작, 영문+숫자 조합 4~8자리만 입력가능합니다.</b></font>';
			$("#nickerror").text('');
			$("#nickerror").show();
			$("#nickerror").append($newtext);
			$("#join_nickname_box").val('');
			return false;
		}else{
			$("#nickerror").text('');
		}
	}
	
	//전화번호 정규식 확인
	function tel_check(){
		$join_tel_1_box=$.trim($("#join_tel_1_box").val());
		$join_tel_2_box=$.trim($("#join_tel_2_box").val());
		$join_tel_3_box=$.trim($("#join_tel_3_box").val());
		//길이 체크
		if($join_tel_1_box == ""){
			$newtext='<font color="red" size="3"><b>첫번째 폰번호를 입력해주세요!</b></font>';
			$("#telerror").text('');
			$("#telerror").show();
			$("#telerror").append($newtext);
			$("#join_tel_1_box").val('');
			return false;
		}
		if($join_tel_1_box < 3){
			$newtext='<font color="red" size="3"><b>폰번호 첫번째는 3자리만 입력 가능합니다.</b></font>';
			$("#telerror").text('');
			$("#telerror").show();
			$("#telerror").append($newtext);
			$("#join_tel_1_box").val('');
			return false;
		}
		if(!(validate_tel($join_tel_1_box))){
			$newtext='<font color="red" size="3"><b>숫자만 입력 가능합니다.</b></font>';
			$("#telerror").text('');
			$("#telerror").show();
			$("#telerror").append($newtext);
			$("join_tel_1_box").val('');
			return false;
		}else{
			$("#telerror").text('');
		};
		
		if($join_tel_2_box == ""){
			$newtext='<font color="red" size="3"><b>두번째 폰번호를 입력해주세요!</b></font>';
			$("#telerror").text('');
			$("#telerror").show();
			$("#telerror").append($newtext);
			$("#join_tel_2_box").val('');
			return false;
		}
		if($join_tel_2_box < 4){
			$newtext='<font color="red" size="3"><b>폰번호 두번째는 4자리만 입력 가능합니다.</b></font>';
			$("#telerror").text('');
			$("#telerror").show();
			$("#telerror").append($newtext);
			$("#join_tel_2_box").val('');
			return false;
		}
		if(!(validate_tel($join_tel_2_box))){
			$newtext='<font color="red" size="3"><b>숫자만 입력 가능합니다.</b></font>';
			$("#telerror").text('');
			$("#telerror").show();
			$("#telerror").append($newtext);
			$("join_tel_2_box").val('');
			return false;
		}else{
			$("#telerror").text('');
		};
		
		if($join_tel_3_box == ""){
			$newtext='<font color="red" size="3"><b>세번째 폰번호를 입력해주세요!</b></font>';
			$("#telerror").text('');
			$("#telerror").show();
			$("#telerror").append($newtext);
			$("#join_tel_3_box").val('');
			return false;
		}
		if($join_tel_3_box < 4){
			$newtext='<font color="red" size="3"><b>폰번호 세번째는 4자리만 입력 가능합니다.</b></font>';
			$("#telerror").text('');
			$("#telerror").show();
			$("#telerror").append($newtext);
			$("#join_tel_3_box").val('');
			return false;
		}else if(!(validate_tel($join_tel_3_box))){
			$newtext='<font color="red" size="3"><b>숫자만 입력 가능합니다.</b></font>';
			$("#telerror").text('');
			$("#telerror").show();
			$("#telerror").append($newtext);
			$("join_tel_3_box").val('');
			return false;
		}else{
			$("#telerror").text('');
		};
	}
	
	//비밀번호 확인 질문 체크
	function pwd_Q_check(){
		$join_pw_q_box=$.trim($("#join_pw_q_box").val());
		if($join_pw_q_box == "질문을 선택하세요."){
			$newtext='<font color="red" size="3"><b>질문을 선택하세요!</b></font>';
			$("#pwdqerror").text('');
			$("#pwdqerror").show();
			$("#pwdqerror").append($newtext);
			return false;
		}else{
			$("#pwdqerror").text('');
		}
	}
	
	//비밀번호 확인 답 입력 여부 확인
	function pwd_Q_A_check(){
		$join_pw_q_a_box=$.trim($("#join_pw_q_a_box").val());
		if($join_pw_q_a_box == ""){
			$newtext='<font color="red" size="3"><b>답변을 입력하세요!</b></font>';
			$("#pwdqaerror").text('');
			$("#pwdqaerror").show();
			$("#pwdqaerror").append($newtext);
			return false;
		}else{
			$("#pwdqaerror").text('');
		}
	}
	
	//주소 입력 여부 확인
	function post_check(){
		$join_post_box_1=$.trim($("#join_post_box_1").val());
		$join_post_box_3=$.trim($("#join_post_box_3").val());
		
		if($join_post_box_1 == ""){
			$newtext='<font color="red" size="3"><b>우편번호와 주소를 입력하세요!</b></font>';
			$("#posterror").text('');
			$("#posterror").show();
			$("#posterror").append($newtext);
			return false;
		}else{
			$("#posterror").text('');
		}
		if($join_post_box_3 == ""){
			$newtext='<font color="red" size="3"><b>나머지 주소를 입력하세요!</b></font>';
			$("#posterror").text('');
			$("#posterror").show();
			$("#posterror").append($newtext);
			return false;
		}else{
			$("#posterror").text('');
		}
	}
	
 	//정규표현식 id
	function validate_userid($join_id_box){
		var pattern = new RegExp(/^[a-z]+[a-z0-9]{7,13}$/);
		return pattern.test($join_id_box);
	};
	
	//정규표현식 이메일
	function validate_email($join_email_1_box){
		var pattern = new RegExp(/^[a-z0-9_-]+$/);
		return pattern.test($join_email_1_box);
	}
	
	//정규표현식 pw
	function validate_userpw($join_pw_box){
		var pattern = new RegExp(/(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*?[#?e!@$%^&*-]).{8,20}$/);
		return pattern.test($join_pw_box);
	}
	
	//정규표현식 이름
	function validate_name($join_name_box){
		var pattern = new RegExp(/^[가-힣a-zA-Z]+$/);
		return pattern.test($join_name_box);
	}
	
	//정규표현식 닉네임
	function validate_nickname($join_nickname_box){
		var pattern = new RegExp(/^[a-z]+[a-z0-9]{3,7}$/);
		return pattern.test($join_nickname_box);
	}
	
	//정규표현식 전화번호
	function validate_tel($join_tel_1_box,$join_tel_2_box,$join_tel_3_box){
		var pattern = new RegExp(/^[0-9]+$/);
		return pattern.test($join_tel_1_box,$join_tel_2_box,$join_tel_3_box);
	}
	
	//이메일 입력방식 선택 
	function emailselect() {
		var num=m.join_email_3_box.selectedIndex;
		if(num == -1){
			return true;
		}
		if(m.join_email_3_box.value == "직접입력"){
			m.join_email_2_box.value = "";
			m.join_email_2_box.readOlny=false;
			m.join_email_2_box.focus();
		}else{
			m.join_email_2_box.value=m.join_email_3_box.options[num].value;
			m.join_email_2_box.readOnly=true;
		}
	}
	
	//member_edit.jsp 유효성 검증
	function edit_check(){
		if($.trim($("#join_email_1_box").val())==""){
			alert("이메일을 입력하세요!");
			$("#join_email_1_box").focus();
			return false;
		}
		if($.trim($("#join_email_2_box").val())==""){
			alert("이메일 주소를 선택하세요!");
			$("#join_email_3_box").focus();
			return false;
		}
		if($.trim($("#join_name_box").val()) == ""){
			alert("회원 이름을 입력하세요!");
			$("#join_name_box").val("").focus();
			return false;
		}
		if($.trim($("#join_nickname_box").val())==""){
			alert("회원 닉네임을 입력하세요!");
			$("#join_nickname_box").val("").focus();
			return false;
		}
		if($.trim($("#join_tel_1_box").val()) == ""){
			alert("첫번째 폰번호를 입력하세요!");
			$("#join_tel_1_box").focus();
			return false;
		}
		if($.trim($("#join_tel_2_box").val()) == ""){
			alert("두번째 폰번호를 입력하세요!");
			$("#join_tel_2_box").focus();
			return false;
		}
		if($.trim($("#join_tel_3_box").val()) == ""){
			alert("세번째 폰번호를 입력하세요!");
			$("#join_tel_3_box").focus();
			return false;
		}
		if($.trim($("#join_post_box_1").val()) == ""){
			alert("우편번호를 입력하세요!");
			return false;
		}
		if($.trim($("#join_post_box_2").val()) == ""){
			alert("주소를 입력하세요!");
			return false;
		}
		if($.trim($("#join_post_box_3").val()) == ""){
			alert("나머지 주소를 입력하세요!");
			return false;
		}
	}
	
	function my_edit_check(){
		if($('#join_pw_box').val() != $('#join_pw_check').val()){
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
		if($.trim($("#join_email_1_box").val())==""){
			alert("이메일을 입력하세요!");
			$("#join_email_1_box").focus();
			return false;
		}
		if($.trim($("#join_email_2_box").val())==""){
			alert("이메일 주소를 선택하세요!");
			$("#join_email_3_box").focus();
			return false;
		}
		if($.trim($("#join_name_box").val()) == ""){
			alert("회원 이름을 입력하세요!");
			$("#join_name_box").val("").focus();
			return false;
		}
		if($.trim($("#join_nickname_box").val())==""){
			alert("회원 닉네임을 입력하세요!");
			$("#join_nickname_box").val("").focus();
			return false;
		}
		if($.trim($("#join_tel_1_box").val()) == ""){
			alert("첫번째 폰번호를 입력하세요!");
			$("#join_tel_1_box").focus();
			return false;
		}
		if($.trim($("#join_tel_2_box").val()) == ""){
			alert("두번째 폰번호를 입력하세요!");
			$("#join_tel_2_box").focus();
			return false;
		}
		if($.trim($("#join_tel_3_box").val()) == ""){
			alert("세번째 폰번호를 입력하세요!");
			$("#join_tel_3_box").focus();
			return false;
		}
		if($.trim($("#join_post_box_1").val()) == ""){
			alert("우편번호를 입력하세요!");
			return false;
		}
		if($.trim($("#join_post_box_2").val()) == ""){
			alert("주소를 입력하세요!");
			return false;
		}
		if($.trim($("#join_post_box_3").val()) == ""){
			alert("나머지 주소를 입력하세요!");
			return false;
		}
	}
	
	

	//비밀번호 확인 질문 선택시 비밀번호 확인 답 입력칸으로 포커스 이동
	function joinQ(){
		$('#join_pw_q_box').change(function(){ 
			$('#join_pw_q_box').each(function () { 
				$('#join_pw_q_a_box').focus();	
			});
		});
	}