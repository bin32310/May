<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userLogin</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.19.0/jquery.validate.min.js"></script>
<body>

<!-- 	
		<h1> /user/userJoin.jsp</h1>
		<h1> 유저 회원가입 페이지</h1>
-->
	<h1> 회원가입 </h1>
	<div>
		<div>
			<form action="" id="us_join_form" name="us_join_form" method="POST">
				<input type="email" id="us_id" name="us_id" placeholder="아이디">	<br>	
				<input type="password" id="us_pw" name="us_pw" placeholder="비밀번호" > <br>  
				<input type="password" id="us_pw_check" name="us_pw_check" placeholder="비밀번호 확인"> <br> 
				<input type="text" id="us_name" name="us_name" placeholder="이름"> <br> 
				<input type="text" id="us_nickname" name="us_nickname" placeholder="닉네임"> <br> 
				<input type="tel" id="us_tel" name="us_tel" placeholder="휴대폰번호"> <br><br> 
				<input type="button" id="us_join_btn" value="회원가입">
				<input type="button" id="back" value="돌아가기" onclick="back();">
			</form>
		</div>
	</div>

<script type="text/javascript">

$(document).ready(function(){
	
	//#us_join_form.validate
	$("#us_join_form").validate({
		rules:{
			us_id:{required:true, email:true},
			us_pw:{required:true, rangelength:[8,20]},
			us_pw_check:{required:true, equalTo:"#us_pw" },
			us_name:{required:true, rangelength:[2,10] },
			us_nickname:{required:true, rangelength:[2,10] },
			us_tel:{required:true, rangelength:[11,15], digits:true}
			
		},
		messages:{
			us_id:{required:"ID(이메일)를 입력해주세요.", email:"이메일형식으로 입력해주세요."},
			us_pw:{required:"비밀번호를 입력해주세요.", rangelength:"비밀번호는 {0}자 이상, {1}자 이하만 가능합니다."},
			us_pw_check:{required:"비밀번호확인을 입력해주세요.", equalTo:"비밀번호와 똑같이 입력해주세요." },
			us_name:{required:"이름을 입력해주세요.", rangelength:"이름은 {0}자 이상, {1}자 이하만 가능합니다." },
			us_nickname:{required:"닉네임을 입력해주세요.", rangelength:"닉네임은 {0}자 이상, {1}자 이하만 가능합니다." },
			us_tel:{required:"전화번호를 입력해주세요.", rangelength:"전화번호를 다시 확인해주세요", digits:"숫자만 입력 가능합니다." }
		}
	}); // #us_join_form.validate

	
	// 회원가입
	$('#us_join_btn').click(function(){
		if($("#us_join_form").valid()){
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
		} // if
	}); // #us_join_btn
	

});

//뒤로가기 
function back(){
	history.back(); 
}
</script>
</body>
</html>