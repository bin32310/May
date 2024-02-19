<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ include file="../include/userHeader.jsp" %>
<style>

/* 아이디/전화번호 유효성 체크 */
.id_check , .pw_check, .name_check, .nick_check, .tel_check{
	display : none;
}
#id_ok, #tel_ok{
	color:GREEN;
}
#id_no, #pw_no, #pwCk_no, #tel_no, #name_no, #nickname_no{
	color:RED;
}
.userJoin_section{
	width: 50%;
	margin-left: 25%;
	margin-right: 25%;
	text-align: center;
}
.join_section{
	padding: 10px;
}

.login_input{
	width : 50%;
	height: 60px;
}

.btn_blue, .btn_gray{
	width : 25%;
	height: 40px;
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
				<h1> 회원가입 </h1><br>
				<form action="" id="us_join_form" name="us_join_form" method="POST" >
					<input type="text" id="us_id" class="login_input" name="us_id" maxlength="30" placeholder="아이디(최소 8자 , 최대 30자)">
					<p class="id_check" id="id_ok"> 사용 가능한 아이디입니다.</p>
					<p class="id_check" id="id_no"> 사용 불가능한 아이디입니다.</p> 
					
					<input type="password" id="us_pw" class="login_input" name="us_pw" maxlength="16" placeholder="비밀번호(최소 8자, 최대 16자)" > <br>  
					<span class="pw_check" id="pw_no"> 8자 이상 입력해주세요.</span> 
					
					<input type="password" id="us_pw_check" class="login_input" name="us_pw_check" maxlength="16" placeholder="비밀번호 확인" > <br> 
					<span class="pw_check" id="pwCk_no"> 비밀번호와 다릅니다.</span>	
					
					<input type="text" id="us_name" class="login_input" name="us_name" placeholder="이름(실명)" maxlength="15"> <br> 
					<span class="name_check" id="name_no"> 이름을 입력해주세요.</span>	
					
					<input type="text" id="us_nickname" class="login_input" name="us_nickname" placeholder="닉네임(8자 이하)" maxlength="8" > <br> 
					<span class="nick_check" id="nickname_no"> 닉네임을 입력해주세요.</span>	
					
					<input type="text" id="us_tel" class="login_input" name="us_tel" placeholder="휴대폰번호(-제외)" maxlength="11">
					<span class="tel_check" id="tel_ok"> 사용가능한 번호입니다.</span>
					<span class="tel_check" id="tel_no"> 이미 존재하는 전화번호입니다.</span><br><br> 
					
					<input type="button" id="us_join_btn" class="btn_blue" value="회원가입">
					<input type="button" id="back" class="btn_gray" value="돌아가기" onclick="backTo();">

				</form>
			</div>
		</div>
	</div>
<%@ include file="../include/footer.jsp" %>
<script type="text/javascript">

$(document).ready(function(){
	
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
	$('#us_join_btn').click(function(){
		
		if(!id_ok){
			alert("아이디를 입력해주세요.");
			$('#us_id').focus();
			return;
		}
		if(!pw_ok){
			alert("비밀번호를 입력해주세요.");
			$('#us_pw').focus();
			return;
		}
		if(!pw_check_ok){
			alert("비밀번호확인을 입력해주세요.");
			$('#us_pw_check').focus();
			return;
		}
		if(!name_ok){
			alert("이름을 입력해주세요.");
			$('#name_no').css("display","block");
			$('#us_name').focus();
			return;
		}
		if(!nickname_ok){
			alert("닉네임을 입력해주세요.");
			$('#nickname_no').css("display","block");
			$('#us_nickname').focus();
			return;
		}
		if(!tel_ok){
			alert("전화번호를 입력해주세요.");
			$('#us_tel').focus();
			return;
		}
			
		$.ajax({       
			type : "post",
			url : "/user/userJoin",
			data : $("#us_join_form").serialize(),
			dataType : "JSON",
			error: function(){
				alert("회원가입 에러");
			},
			success : function(data){
				if(data==1){
					alert("회원가입 완료");
					location.replace("/user/userLogin");
				}else{
					alert("회원가입 실패");
				}	
			} // success 끝	
		}); // ajax 끝
	}); // #us_join_btn
	
	// 아이디 중복체크
	$('#us_id').keyup(function(){
		var us_id = $('#us_id').val();
		if(us_id.length>=8){ // 8자 이상
			$.ajax({
				type : "post",
				url : "../user/userIdCheck",
				data : {"us_id" : us_id},
				dataType : "text",
				error: function(){
					alert("아이디 중복체크 에러");
				},
				success : function(data){
					if(data == "가능"){ // 사용가능한 아이디
						$('#id_ok').css("display","block");
						$('#id_no').css("display","none");
						id_ok = true;
					}
					else{ // 사용불가능한 아이디
						$('#id_ok').css("display","none");
						$('#id_no').text('사용할 수 없는 아이디입니다.');
						$('#id_no').css("display","block");
						id_ok = false;
					}	
				} // success 끝	
			}); // ajax 끝
		}else{
			$('#id_ok').css("display","none");
			$('#id_no').text('8자 이상 입력해주세요.');
			$('#id_no').css("display","block");
		}
	}); //('#us_id').keyup 끝

	// 전화번호 중복체크
	$('#us_tel').keyup(function(){
		var us_tel = $('#us_tel').val();
		if(us_tel.length==11){ // 11자리면
			$.ajax({
				type : "post",
				url : "../user/userTelCheck",
				data : {"us_tel" : us_tel},
				dataType : "text",
				error:function(){
					alert("전화번호 중복체크 에러");
				},
				success : function(data){
					console.log("받아온 데이터 : " + data);
					if(data == "가능"){ // 전화번호 사용가능
						$('#tel_ok').css("display","block");
						$('#tel_no').css("display","none");
						tel_ok = true;
					}
					else{ // 전화번호 사용불가
						$('#tel_ok').css("display","none");
						$('#tel_no').text('사용할 수 없는 전화번호입니다.');
						$('#tel_no').css("display","block");
						tel_ok = false;
					}	
				} // success 끝	
			}); // ajax 끝
		} // if
		else{
			$('#tel_ok').css("display","none");
			$('#tel_no').text('-를 제외한 전화번호를 입력해주세요.');
			$('#tel_no').css("display","block");
			tel_ok = false;
		}
	}); // ('#us_tel').keyup 끝
	
	// 비밀번호 체크 
	$('#us_pw').keyup(function(){
		if($('#us_pw').val().length >= 8){
			$('#pw_no').css("display","none");
			pw_ok = true;
		}else{
			$('#pw_no').css("display","block");
			pw_ok = false;
		}
	}); // (#us_pw').keyup 끝

	// 비밀번호 확인 체크 
	$('#us_pw_check').keyup(function(){
		if($('#us_pw').val() == $('#us_pw_check').val()){
			$('#pwCk_no').css("display","none");
			pw_check_ok = true;
		}else{
			$('#pwCk_no').css("display","block");
			pw_check_ok = false;
		}
	}); // ('#us_pw_check').keyup 끝

	// 이름 체크
	$('#us_name').keyup(function(){
		if($('#us_name').val().length >= 1){
			$('#name_no').css("display","none");
			name_ok = true;
		}else{
			$('#name_no').css("display","block");
			name_ok = false;
		}
	}); //('#us_name').keyup 끝
	
	// 닉네임 체크
	$('#us_nickname').keyup(function(){
		if($('#us_nickname').val().length >= 1){
			$('#nickname_no').css("display","none");
			nickname_ok = true;
		}else{
			$('#nickname_no').css("display","block");
			nickname_ok = false;
		}
	}); //('#us_nickname').keyup 끝

}); // document 끝 

//뒤로가기 
function backTo(){
	history.back(); 
}

</script>
</body>
</html>