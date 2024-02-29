<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/userHeader.jsp"%>

<style>

/* 아이디/전화번호 유효성 체크 */
.id_check, .pw_check, .name_check, .nick_check, .tel_check {
	display: none;
}

#id_ok, #tel_ok {
	color: GREEN;
}

#id_no, #pw_no, #pwCk_no, #tel_no, #name_no, #name_no1, #nickname_no, #nickname_no1 {
	color: RED;
}

.userJoin_section {
	width: 50%;
	margin-left: 25%;
	margin-right: 25%;
	text-align: center;
}

.join_section {
	padding: 10px;
}

.login_input {
	width: 50%;
	height: 60px;
}

.btn_blue, .btn_gray {
	width: 25%;
	height: 40px;
}

.join_text{
	text-align: center; 
}

</style>

<c:if test="${ not empty us_id}">
	${"<script>alert('잘못된 접근입니다.');location.href='../user/userMain';</script>" }
</c:if>
<!-- 	
		<h1> /user/userJoin.jsp</h1>
		<h1> 유저 회원가입 페이지</h1>
--> 
<div>
	<br><hr><br><br>
	<div class="userJoin_section">
		<div class="join_section">
			<h1>회원가입</h1>
			<br>
			<form action="" id="us_join_form" name="us_join_form" method="POST">
				<h5 class = "join_text"> 아이디</h5>
				<input type="text" id="us_id" class="login_input" name="us_id" maxlength="8" placeholder="아이디(3~8자)">
				<p class="id_check" id="id_ok">사용 가능한 아이디입니다.</p>
				<p class="id_check" id="id_no">사용 불가능한 아이디입니다.</p>
				<br class="id_br"> <br class="id_br"> <br class="id_br">
				
				<h5 class = "join_text"> 비밀번호</h5>
				<input type="password" id="us_pw" class="login_input" name="us_pw" maxlength="8" placeholder="비밀번호(3~8자)"> <br>
				<span class="pw_check" id="pw_no"> 3자 이상 입력해주세요.</span>
				
				<input type="password" id="us_pw_check" class="login_input" name="us_pw_check" maxlength="8" placeholder="비밀번호 확인"> <br>
				<span class="pw_check" id="pwCk_no"> 비밀번호와 다릅니다.</span>
				
				<br><br>
				<h5 class = "join_text"> 이름(실명)</h5>
				<input type="text" id="us_name" class="login_input" name="us_name" placeholder="이름(실명)" maxlength="10"> <br>
				<span class="name_check" id="name_no"> 이름을 입력해주세요.</span>
				
				<br><br>
				<h5 class = "join_text"> 닉네임 </h5>
				<input type="text" id="us_nickname" class="login_input" name="us_nickname" placeholder="닉네임(1~8자)" maxlength="8"> <br>
				<span class="nick_check" id="nickname_no"> 닉네임을 입력해주세요.</span>
				
				<br><br>
				<h5 class = "join_text"> 휴대폰 번호 </h5>
				<input type="text" id="us_tel" class="login_input" name="us_tel" value="010" placeholder="휴대폰번호(-제외)" maxlength="11"> <br>
				<span class="tel_check" id="tel_ok"> 사용가능한 전화번호입니다.</span>
				<span class="tel_check" id="tel_no"> 이미 존재하는 전화번호입니다.</span><br>
				
				<br>
				<input type="button" id="us_join_btn" class="btn_blue" value="회원가입">
				<input type="button" id="back" class="btn_gray" value="돌아가기" onclick="backTo();">
			</form>
		</div>
	</div>
</div>
<%@ include file="../include/footer.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {

		//유효성 검사 통과 여부
		var id_ok = false;
		var pw_ok = false; 
		var pw_check_ok = false;
		var name_ok = false;
		var nickname_ok = false;
		var tel_ok = false;


		// 페이지 로드시 아이디에 포커스
		$('#us_id').focus();

		// 회원가입
		$('#us_join_btn').click(function() {

			if (!id_ok) {
				alert("아이디를 확인해주세요.");
				$('#us_id').focus();
				return;
			}
			if (!pw_ok) {
				alert("비밀번호를 확인해주세요.");
				$('#us_pw').focus();
				return;
			}
			if (!pw_check_ok) {
				alert("비밀번호확인을 확인해주세요.");
				$('#us_pw_check').focus();
				return;
			}
			if (!name_ok) {
				alert("이름을 확인해주세요.");
				$('#name_no').css("display", "block");
				$('#us_name').focus();
				return;
			}
			if (!nickname_ok) {
				alert("닉네임을 확인해주세요.");
				$('#nickname_no').css("display", "block");
				$('#us_nickname').focus();
				return;
			}
			if (!tel_ok) {
				alert("전화번호를 확인해주세요.");
				$('#us_tel').focus();
				return;
			}

			$.ajax({
				type : "post",
				url : "/user/userJoin",
				data : $("#us_join_form").serialize(),
				dataType : "JSON",
				error : function() {
					alert("회원가입 에러");
				},
				success : function(data) {
					if (data == 1) {
						alert("회원가입 완료");
						location.replace("/user/userLogin");
					} else {
						alert("회원가입 실패");
					}
				} // success 끝	
			}); // ajax 끝
		}); // #us_join_btn

		
		// 아이디 입력문자(영문,숫자만), 중복 체크
		$('#us_id').keyup(function() {
			
			var us_id_reg_check = /^[a-zA-Z0-9][a-zA-Z0-9]*$/; // 정규식
			var us_id = $('#us_id').val();
			if (us_id != null && us_id_reg_check.test(us_id) ){ // 압력문자 체크
				$('#id_ok').css("display", "none");
				$('#id_no').css("display", "none");
				$('.id_br').css("display", "none");
			}else{
				$('#id_ok').css("display", "none");
				$('#id_no').text('영문, 숫자만 입력 가능합니다.');
				$('#id_no').css("display", "block");
				$('.id_br').css("display", "none");
				id_ok = false;
				return;
			}
			
			if ( us_id != null && us_id.length >= 3) { // 3자 이상
				$.ajax({
					type : "post",
					url : "/user/userIdCheck",
					data : {
						"us_id" : us_id
					},
					dataType : "text",
					error : function() {
						alert("아이디 중복체크 에러");
					},
					success : function(data) {
						if (data == "가능") { // 사용가능한 아이디
							$('#id_ok').css("display", "block");
							$('#id_no').css("display", "none");
							$('.id_br').css("display", "none");
							id_ok = true;
						} else { // 사용불가능한 아이디
							$('#id_ok').css("display", "none");
							$('#id_no').text('사용할 수 없는 아이디입니다.');
							$('#id_no').css("display", "block");
							$('.id_br').css("display", "none");
							id_ok = false;
						}
					} // success 끝	
				}); // ajax 끝
			}else{
				$('#id_ok').css("display", "none");
				$('#id_no').text('3자 이상 입력해주세요.');
				$('#id_no').css("display", "block");
				id_ok = false;
			}
		}); //('#us_id').keyup 끝
		
		
		// 전화번호 010으로 시작여부, 숫자만 입력, 길이(11자), 중복 체크
		$('#us_tel').keyup(function() {
			
			var us_tel_reg_check = /^010[0-9]*$/; // 정규식
			var us_tel = $('#us_tel').val();
			if ( us_tel != null && us_tel_reg_check.test(us_tel)) {
				$('#tel_ok').css("display", "none");
				$('#tel_no').css("display", "none");
			}else{
				$('#tel_ok').css("display", "none");
				$('#tel_no').text('전화번호를 확인해주세요.');
				$('#tel_no').css("display", "block");
				tel_ok = false;
				return;
			} 
			
			if (us_tel != null && us_tel.length == 11) {
				
				$.ajax({
					type : "post",
					url : "/user/userTelCheck",
					data : {
						"us_tel" : us_tel
					},
					dataType : "text",
					error : function() {
						alert("전화번호 중복체크 에러");
					},
					success : function(data) {
						console.log("받아온 데이터 : " + data);
						if (data == "가능") { // 전화번호 사용가능
							$('#tel_ok').css("display", "block");
							$('#tel_no').css("display", "none");
							tel_ok = true;
						} else { // 전화번호 사용불가
							$('#tel_ok').css("display", "none");
							$('#tel_no').text('사용할 수 없는 전화번호입니다.');
							$('#tel_no').css("display", "block");
							tel_ok = false;
						}
					} // success 끝	
				}); // ajax 끝
			}else{

				$('#tel_ok').css("display", "none");
				$('#tel_no').text('정상적이지 않은 전화번호입니다.');
				$('#tel_no').css("display", "block");
				tel_ok = false;
			}
		}); // ('#us_tel').keyup 끝

		// 비밀번호 입력문자(영문, 숫자만) , 길이 체크 
		$('#us_pw').keyup(function() {

			var us_pw_reg_check = /^[a-zA-Z0-9][a-zA-Z0-9]*$/; // 정규식
			var us_pw = $('#us_pw').val();
			if (us_pw != null && us_pw_reg_check.test(us_pw) ){ // 압력문자 체크
				$('#pw_no').css("display", "none");
			}else{
				$('#pw_no').text('영문, 숫자만 입력 가능합니다.');
				$('#pw_no').css("display", "block");
				pw_ok = false;
				return;
			}
			
			if (us_pw != null && us_pw.length >= 3) {
				$('#pw_no').css("display", "none");
				pw_ok = true;
			}else{
				$('#pw_no').text('3자 이상 입력해주세요.');
				$('#pw_no').css("display", "block");
				pw_ok = false;
			}
		}); // (#us_pw').keyup 끝

		// 비밀번호 확인 체크 
		$('#us_pw_check').keyup(function() {
			if ($('#us_pw').val() == $('#us_pw_check').val()) {
				$('#pwCk_no').css("display", "none");
				pw_check_ok = true;
			}else{
				$('#pwCk_no').css("display", "block");
				pw_check_ok = false;
			}
		}); // ('#us_pw_check').keyup 끝
		
		
		// 이름 입력문자(한글만), 길이 체크
		$('#us_name').keyup(function() {
			
			var us_name_reg_check = /^[가-힣][가-힣]*$/; // 정규식
			var us_name = $('#us_name').val();
			if (us_name != null && us_name_reg_check.test(us_name) ){ // 압력문자 체크
				$('#name_no').css("display", "none");
			}else{
				$('#name_no').text('이름(실명)을 입력해주세요.');
				$('#name_no').css("display", "block");
				name_ok = false;
				return;
			}
			
			if (us_name != null && us_name.length >= 1 && us_name.length <= 10) {
				$('#name_no').css("display", "none");
				name_ok = true;
			}else{
				$('#name_no').text('이름을 입력해주세요.');
				$('#name_no').css("display", "block");
				name_ok = false;
			}
		}); //('#us_name').keyup 끝
		
		// 닉네임 입력문자(영어, 숫자, 한글만), 길이 체크
		$('#us_nickname').keyup(function() {
			
			var us_nickname_reg_check = /^[a-zA-Z0-9ㄱ-힣][a-zA-Z0-9ㄱ-힣]*$/; // 정규식
			var us_nickname = $('#us_nickname').val();
			if (us_nickname != null && us_nickname_reg_check.test(us_nickname) ){ // 압력문자 체크
				$('#nickname_no').css("display", "none");
			}else{
				$('#nickname_no').text('한글, 영문, 숫자만 입력 가능합니다.');
				$('#nickname_no').css("display", "block");
				nickname_ok = false;
				return;
			}
			
			if (us_nickname != null && $('#us_nickname').val().length >= 1 && $('#us_nickname').val().length <= 8) {
				$('#nickname_no').css("display", "none");
				nickname_ok = true;
			}else{
				$('#nickname_no').text("1자 이상 8자 이하로 입력해주세요.");
				$('#nickname_no').css("display", "block");
				nickname_ok = false;
			}
		}); //('#us_nickname').keyup 끝

	}); // document 끝 
 
	//뒤로가기 
	function backTo() {
		history.back();
	}
</script>
</body>
</html>