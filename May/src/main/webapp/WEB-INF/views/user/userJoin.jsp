<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ include file="../include/userHeader.jsp" %>
<style>

/* 아이디/전화번호 유효성 체크 */
.id_check , .tel_check{
	display : none;
}
#id_ok, #tel_ok{
	color:GREEN;
}
#id_no, #tel_no{
	color:RED;
}

	
	
	
</style>
<script type="text/javascript">

$(document).ready(function(){
	
	// 페이지 로드시 아이디에 포커스
	$('#us_id').focus();
	
	// 회원가입
	$('#us_join_btn').click(function(){
		if(true){
			
			$.ajax({
				type : "post",
				url : "/user/userJoinCheck",
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
				console.log("받아온 데이터 : " + data);
				if(data == "가능"){ // 사용가능한 아이디
					$('#id_ok').css("display","block");
					$('#id_no').css("display","none");
					$('#us_pw').focus();
				}else if(data == "입력"){	// 아이디 입력 안함
					console.log("두번째");
					$('#id_ok').css("display","none");
					$('#id_no').text('아이디를 입력해주세요.');
					$('#id_no').css("display","block");
				}
				else{ // 사용불가능한 아이디
					console.log("세번째");
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
				}else if(data = "입력"){	
					console.log('tel두번째');
					$('#tel_ok').css("display","none");
					$('#tel_no').css("display","block");
					$('#tel_no').text('전화번호를 입력해주세요.');
				}
				else{ // 전화번호 사용불가
					console.log('tel세번째');
					$('#tel_ok').css("display","none");
					$('#tel_no').css("display","block");
					$('#tel_no').text('사용할 수 없는 전화번호입니다.');
				}	
			} // success 끝	
		}); // ajax 끝
	}); // function telCheck() 끝
	
}); // document 끝 



//뒤로가기 
function backTo(){
	window.history.back(); 
}

</script>
<c:if test="${ not empty us_id}">
	${"<script>alert('잘못된 접근입니다.');location.href='../user/userMain';</script>" }
</c:if>
<!-- 	
		<h1> /user/userJoin.jsp</h1>
		<h1> 유저 회원가입 페이지</h1>
-->
	<h1> 회원가입 </h1>
	<div>
		<div>
			<form action="" id="us_join_form" name="us_join_form" method="POST">
				<input type="text" id="us_id" name="us_id" placeholder="아이디">
				<span class="id_check" id="id_ok"> 사용 가능한 아이디입니다.</span>
				<span class="id_check" id="id_no"> 사용 불가능한 아이디입니다.</span> <br>	
				
				<input type="password" id="us_pw" name="us_pw" placeholder="비밀번호"> <br>  
				<input type="password" id="us_pw_check" name="us_pw_check" placeholder="비밀번호 확인"> <br> 
				<input type="text" id="us_name" name="us_name" placeholder="이름"> <br> 
				<input type="text" id="us_nickname" name="us_nickname" placeholder="닉네임"> <br> 
				
				<input type="text" id="us_tel" name="us_tel" placeholder="휴대폰번호">
				<span class="tel_check" id="tel_ok"> 사용가능한 번호입니다.</span>
				<span class="tel_check" id="tel_no"> 이미 존재하는 전화번호입니다.</span><br><br> 
				
				<input type="button" id="us_join_btn" value="회원가입" disabled="disabled">
				<input type="button" id="back" value="돌아가기" onclick="backTo();">
			</form>
		</div>
	</div>
<%@ include file="../include/userFooter.jsp" %>

</body>
</html>