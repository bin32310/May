<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ include file="../include/userHeader.jsp" %>
<style>

/* 아이디/전화번호 유효성 체크 */
.id_check , .pw_check, .nick_check, .tel_check{
	display : none;
}
#id_ok, #pw_ok, #tel_ok{
	color:GREEN;
}
#id_no, #pw_no, #pwCk_no, #nick_no, #tel_no{
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
				<form action="" id="us_join_form" name="us_join_form" method="POST" onsubmit="joinCheck();">
					<input type="text" id="us_id" class="login_input" name="us_id" placeholder="아이디" required="required">
					<span class="id_check" id="id_ok"> 사용 가능한 아이디입니다.</span>
					<span class="id_check" id="id_no"> 사용 불가능한 아이디입니다.</span> <br>	
					
					<input type="password" id="us_pw" class="login_input" name="us_pw" placeholder="비밀번호" required="required"> <br>  
					<span class="pw_check" id="pw_ok"> 사용 가능한 비밀번호입니다.</span>
					<span class="pw_check" id="pw_no"> 사용할 수 없는 비밀번호입니다.</span>
					
					<input type="password" id="us_pw_check" class="login_input" name="us_pw_check" placeholder="비밀번호 확인" required="required" onkeyup="pwCheck();"> <br> 
					<span class="pw_check" id="pwCk_no"> 비밀번호와 다릅니다.</span>
					
					<input type="text" id="us_name" class="login_input" name="us_name" placeholder="이름" required="required"> <br> 
					
					<input type="text" id="us_nickname" class="login_input" name="us_nickname" placeholder="닉네임" required="required" onkeyup="nicknameCheck();"> <br> 
					<span class="nick_check" id="nick_no"> 닉네임은 8자 이하만 가능합니다.</span>
					
					<input type="text" id="us_tel" class="login_input" name="us_tel" placeholder="휴대폰번호" required="required">
					<span class="tel_check" id="tel_ok"> 사용가능한 번호입니다.</span>
					<span class="tel_check" id="tel_no"> 이미 존재하는 전화번호입니다.</span><br><br> 
					
					<input type="button" id="us_join_btn" class="btn_blue" value="회원가입">
					<input type="button" id="back" class="btn_gray" value="돌아가기" onclick="backTo();">
				</form>
			</div>
		</div>
	</div>
<%@ include file="../include/userFooter.jsp" %>
<script type="text/javascript">

$(document).ready(function(){
	
	// 페이지 로드시 아이디에 포커스
	$('#us_id').focus();
	
	// 회원가입
	$('#us_join_btn').click(function(){
		
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
	$('#us_id').blur(function(){
		var us_id = $('#us_id').val();
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
					$('#us_pw').focus();
				}else if(data == "입력"){	// 아이디 입력 안함
					$('#id_ok').css("display","none");
					$('#id_no').text('아이디를 입력해주세요.');
					$('#id_no').css("display","block");
				}
				else{ // 사용불가능한 아이디
					$('#id_ok').css("display","none");
					$('#id_no').text('사용할 수 없는 아이디입니다.');
					$('#id_no').css("display","block");
				}	
			} // success 끝	
		}); // ajax 끝
	}); // 아이디 중복체크 끝

	// 전화번호 중복체크
	$('#us_tel').blur(function(){
		var us_tel = $('#us_tel').val();
		console.log("내가 입력한 전화번호 : " + us_tel);
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
				}else if(data == "입력"){	
					console.log('tel두번째');
					$('#tel_ok').css("display","none");
					$('#tel_no').text('전화번호를 입력해주세요.');
					$('#tel_no').css("display","block");
				}
				else{ // 전화번호 사용불가
					console.log('tel세번째');
					$('#tel_ok').css("display","none");
					$('#tel_no').text('사용할 수 없는 전화번호입니다.');
					$('#tel_no').css("display","block");
				}	
			} // success 끝	
		}); // ajax 끝
	}); // function telCheck() 끝
	

	
}); // document 끝 

// 비밀번호 확인 체크 
function pwCheck(){
	if($('#us_pw').val() == $('#us_pw_check').val()){
		$('#pwCk_no').css("display","none");
	}else{
		$('#pwCk_no').css("display","block");
	}
}

// 닉네임 8자 이하 체크
function nicknameCheck(){
	if($('#us_nickname').val().length > 8){
		$('#nick_no').css("display","block");
	}else{
		$('#nick_no').css("display","none");
	}
}

function joinCheck(){
	
		console.log("회원가입 할수있는지 ");

}

//뒤로가기 
function backTo(){
	window.history.back(); 
}

</script>
</body>
</html>